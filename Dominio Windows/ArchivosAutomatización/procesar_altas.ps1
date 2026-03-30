. "$PSScriptRoot\funciones.ps1"
Import-Module SimplySql
Import-Module ActiveDirectory

try {
    Conectar-BD

    $solicitudes = Invoke-SqlQuery "SELECT id, tipo, nombre, apellidos, username, email, departamento, rol FROM solicitudes WHERE estado='PENDIENTE' AND tipo='ALTA'"

    if (-not $solicitudes) {
        Write-Host "No hay solicitudes de ALTA pendientes."
        exit
    }

    foreach ($s in $solicitudes) {
        Write-Host "Procesando ALTA para: $($s.nombre) $($s.apellidos)"
        try {
            $nombre    = [string]$s.nombre
            $apellidos = [string]$s.apellidos

            if ($nombre -eq "" -or $null -eq $nombre) {
                Write-Host "ERROR: nombre vacio, saltando solicitud"
                continue
            }

$baseUsername = ($nombre.Substring(0,1) + $apellidos.Split(" ")[0]).ToLower()

            $username = $baseUsername
            $password    = Generar-Password
            $securePass  = ConvertTo-SecureString $password -AsPlainText -Force
            $ou          = Obtener-OU $s.departamento
            $displayName = "$nombre $apellidos"

            Write-Host "DEBUG - username: '$username' | ou: '$ou'"

            New-ADUser -Name $displayName -GivenName $s.nombre -Surname $s.apellidos -SamAccountName $username -UserPrincipalName "$username@$($global:AD_Domain)" -EmailAddress $s.email -Path $ou -AccountPassword $securePass -Enabled $true -ChangePasswordAtLogon $true

            $dept = [string]$s.departamento
            if ($dept -and $dept -ne "") {
                Add-ADGroupMember -Identity $dept -Members $username
            }

            $sqlInsert = "INSERT INTO usuarios_activos (username, nombre_completo, email, departamento) VALUES (@u, @n, @e, @d)"
            Invoke-SqlUpdate $sqlInsert -Parameters @{ u = $username; n = $displayName; e = $s.email; d = $dept }

            Invoke-SqlUpdate "UPDATE solicitudes SET username=@u WHERE id=@id" -Parameters @{ u = $username; id = $s.id }

            Registrar-Log -SolicitudId $s.id -Accion "Creacion usuario AD: $username" -Resultado "OK" -Detalle "Creado en OU: $ou"
            Marcar-Solicitud -Id $s.id -Estado "PROCESADO"

            Write-Host "OK - Usuario $username creado correctamente"

        } catch {
            Registrar-Log -SolicitudId $s.id -Accion "Intento creacion usuario" -Resultado "ERROR" -Detalle $_.Exception.Message
            Marcar-Solicitud -Id $s.id -Estado "ERROR"
            Write-Host "ERROR con $($s.nombre): $($_.Exception.Message)"
        }
    }
} finally {
    Close-SqlConnection
}
