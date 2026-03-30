. "$PSScriptRoot\funciones.ps1"
Import-Module SimplySql
Import-Module ActiveDirectory

try {
    Conectar-BD

    $solicitudes = Invoke-SqlQuery "SELECT id, tipo, nombre, apellidos, username, email, departamento FROM solicitudes WHERE tipo='BAJA' AND estado='PENDIENTE'"

    if (-not $solicitudes) {
        Write-Host "No hay solicitudes de BAJA pendientes."
        exit
    }

    foreach ($s in $solicitudes) {

        $nombre    = [string]$s.nombre
        $apellidos = [string]$s.apellidos
        $username  = [string]$s.username

        Write-Host "Procesando BAJA para: $nombre $apellidos (usuario: $username)"

        try {
            # Verificar que el usuario existe en AD
            $usuarioAD = Get-ADUser -LDAPFilter "(sAMAccountName=$username)" -ErrorAction SilentlyContinue

            if (-not $usuarioAD) {
                Write-Host "AVISO: El usuario $username no existe en AD, marcando como ERROR"
                Registrar-Log -SolicitudId $s.id -Accion "Intento baja: $username" -Resultado "ERROR" -Detalle "Usuario no encontrado en AD"
                Marcar-Solicitud -Id $s.id -Estado "ERROR"
                continue
            }

            # Deshabilitar cuenta en AD
            Disable-ADAccount -Identity $username

            # Mover a OU de Deshabilitados
            $ouBajas = "OU=Deshabilitados,DC=nacho,DC=local"
            Get-ADUser -LDAPFilter "(sAMAccountName=$username)" | Move-ADObject -TargetPath $ouBajas

            # Marcar como inactivo en BD
            Invoke-SqlUpdate "UPDATE usuarios_activos SET activo=FALSE WHERE username=@u" -Parameters @{ u = $username }

            Registrar-Log -SolicitudId $s.id -Accion "Baja usuario AD: $username" -Resultado "OK" -Detalle "Cuenta deshabilitada y movida a OU Deshabilitados"
            Marcar-Solicitud -Id $s.id -Estado "PROCESADO"

            Write-Host "OK - Baja de $username procesada correctamente"

        } catch {
            Registrar-Log -SolicitudId $s.id -Accion "Intento baja usuario" -Resultado "ERROR" -Detalle $_.Exception.Message
            Marcar-Solicitud -Id $s.id -Estado "ERROR"
            Write-Host "ERROR con $username $($_.Exception.Message)"
        }
    }

} finally {
    Close-SqlConnection
}
