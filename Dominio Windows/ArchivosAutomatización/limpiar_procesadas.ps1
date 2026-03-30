. "$PSScriptRoot\funciones.ps1"
Import-Module SimplySql

try {
    Conectar-BD

    Invoke-SqlUpdate "DELETE FROM auditoria WHERE solicitud_id IN (SELECT id FROM solicitudes WHERE estado='PROCESADO' AND fecha_procesado < NOW() - INTERVAL 24 HOUR)"

    $borradas = Invoke-SqlUpdate "DELETE FROM solicitudes WHERE estado='PROCESADO' AND fecha_procesado < NOW() - INTERVAL 24 HOUR"

    Write-Host "Limpieza completada - Solicitudes borradas: $borradas"

} finally {
    Close-SqlConnection
}
