. "$PSScriptRoot\config.ps1"

function Conectar-BD {
    $securePass = ConvertTo-SecureString $global:DB_Pass -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($global:DB_User, $securePass)
    
    Open-MySqlConnection -Server $global:DB_Server `
                         -Port $global:DB_Port `
                         -Database $global:DB_Name `
                         -Credential $credential `
                         -SSLMode None
}

function Registrar-Log {
    param(
        [int]$SolicitudId,
        [string]$Accion,
        [string]$Resultado,
        [string]$Detalle
    )
    $sql = "INSERT INTO auditoria (solicitud_id, accion, resultado, detalle)
            VALUES (@id, @accion, @resultado, @detalle)"
    Invoke-SqlUpdate $sql -Parameters @{
        id        = $SolicitudId
        accion    = $Accion
        resultado = $Resultado
        detalle   = $Detalle
    }
}

function Marcar-Solicitud {
    param([int]$Id, [string]$Estado)
    $sql = "UPDATE solicitudes SET estado=@estado, fecha_procesado=NOW() WHERE id=@id"
    Invoke-SqlUpdate $sql -Parameters @{ id = $Id; estado = $Estado }
}

function Obtener-OU {
    param([string]$Departamento)
    switch ($Departamento) {
        "Direccion_Administracion" { return "OU=Direccion_Administracion,DC=nacho,DC=local" }
        "Desarrollo"               { return "OU=Desarrollo,DC=nacho,DC=local" }
        "Hardware"                 { return "OU=Hardware,DC=nacho,DC=local" }
        "Comercial_Soporte"        { return "OU=Comercial_Soporte,DC=nacho,DC=local" }
        default                    { return "CN=Users,DC=nacho,DC=local" }
    }
}

function Generar-Password {
    $chars = "abcdefghijkmnpqrstuvwxyz"
    $upper = "ABCDEFGHJKLMNPQRSTUVWXYZ"
    $nums  = "23456789"
    $syms  = "!@#$%&*"
    $pwd   = ($chars.ToCharArray() | Get-Random) + `
             ($upper.ToCharArray() | Get-Random) + `
             ($nums.ToCharArray()  | Get-Random) + `
             ($syms.ToCharArray()  | Get-Random)
    $all   = ($chars + $upper + $nums + $syms).ToCharArray()
    for ($i = 0; $i -lt 8; $i++) { $pwd += $all | Get-Random }
    return ($pwd.ToCharArray() | Sort-Object { Get-Random }) -join ""
}