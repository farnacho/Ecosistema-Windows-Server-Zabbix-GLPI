<?php
// insertar_solicitud.php


header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// ─── Configuración de la BD ───────────────────────────────────
$DB_HOST = 'localhost';
$DB_PORT = 3306;
$DB_NAME = 'gestion_usuarios';
$DB_USER = 'root';
$DB_PASS = 'Server22.';

// ─── Leer JSON del formulario ─────────────────────────────────
$input = json_decode(file_get_contents('php://input'), true);

if (!$input) {
    echo json_encode(['ok' => false, 'error' => 'No se recibieron datos']);
    exit;
}

// ─── Validación básica ────────────────────────────────────────
$tipo         = $input['tipo']         ?? '';
$nombre       = trim($input['nombre']       ?? '');
$apellidos    = trim($input['apellidos']    ?? '');
$email        = trim($input['email']        ?? '');
$departamento = trim($input['departamento'] ?? '');
$rol          = trim($input['rol']          ?? '');
$username     = trim($input['username']     ?? '');
$notas        = trim($input['notas']        ?? '');

$tipos_validos = ['ALTA', 'BAJA', 'MODIFICACION'];
$depts_validos = ['Direccion_Administracion', 'Desarrollo', 'Hardware', 'Comercial_Soporte'];

if (!in_array($tipo, $tipos_validos)) {
    echo json_encode(['ok' => false, 'error' => 'Tipo de solicitud no válido']);
    exit;
}

if (empty($nombre) || empty($apellidos) || empty($departamento)) {
    echo json_encode(['ok' => false, 'error' => 'Faltan campos obligatorios']);
    exit;
}

if (!in_array($departamento, $depts_validos)) {
    echo json_encode(['ok' => false, 'error' => 'Departamento no válido']);
    exit;
}

if ($tipo === 'BAJA' && empty($username)) {
    echo json_encode(['ok' => false, 'error' => 'El username es obligatorio para solicitudes de baja']);
    exit;
}

// ─── Conexión a MariaDB ───────────────────────────────────────
try {
    $dsn = "mysql:host=$DB_HOST;port=$DB_PORT;dbname=$DB_NAME;charset=utf8mb4";
    $pdo = new PDO($dsn, $DB_USER, $DB_PASS, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    echo json_encode(['ok' => false, 'error' => 'Error de conexión a la BD: ' . $e->getMessage()]);
    exit;
}

// ─── Insertar solicitud ───────────────────────────────────────
try {
    $sql = "INSERT INTO solicitudes 
                (tipo, nombre, apellidos, username, email, departamento, rol, notas, estado)
            VALUES 
                (:tipo, :nombre, :apellidos, :username, :email, :departamento, :rol, :notas, 'PENDIENTE')";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        ':tipo'         => $tipo,
        ':nombre'       => $nombre,
        ':apellidos'    => $apellidos,
        ':username'     => $username ?: null,
        ':email'        => $email    ?: null,
        ':departamento' => $departamento,
        ':rol'          => $rol      ?: null,
        ':notas'        => $notas    ?: null,
    ]);

    $id = $pdo->lastInsertId();
    echo json_encode(['ok' => true, 'id' => $id]);

} catch (PDOException $e) {
    echo json_encode(['ok' => false, 'error' => 'Error al insertar: ' . $e->getMessage()]);
}
?>