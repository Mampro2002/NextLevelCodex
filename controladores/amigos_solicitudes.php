<?php
include "../sec/sec.php";
include "../modelos/clase_amigos.php";

// Verificar sesión activa
if (!isset($_SESSION['id'])) {
    http_response_code(403);
    echo "error";
    exit;
}

$solicitud = new Amigos();
$options = filter_input(INPUT_POST, 'options', FILTER_VALIDATE_INT);

if (!$options) {
    echo "error";
    exit;
}

switch ($options) {

    case 2: // Enviar solicitud
        $id_rec = filter_input(INPUT_POST, 'id_rec', FILTER_VALIDATE_INT);
        if (!$id_rec || $id_rec === $_SESSION['id']) {
            echo "error";
            exit;
        }
        $fecha = time();
        // id_sol siempre desde sesión
        $solicitud->solicitud($_SESSION['id'], $id_rec, $fecha);
        break;

    case 3: // Aceptar solicitud
        $id_sol = filter_input(INPUT_POST, 'id_sol', FILTER_VALIDATE_INT);
        if (!$id_sol) {
            echo "error";
            exit;
        }
        // id_rec siempre desde sesión, nunca del POST
        $solicitud->aceptar($id_sol, $_SESSION['id']);
        break;

    case 4: // Rechazar solicitud
        $id_sol = filter_input(INPUT_POST, 'id_sol', FILTER_VALIDATE_INT);
        if (!$id_sol) {
            echo "error";
            exit;
        }
        $solicitud->rechazar($id_sol, $_SESSION['id']);
        break;

    case 5: // Bloquear usuario
        $id_sol = filter_input(INPUT_POST, 'id_sol', FILTER_VALIDATE_INT);
        if (!$id_sol || $id_sol === $_SESSION['id']) {
            echo "error";
            exit;
        }
        $solicitud->bloquear($id_sol, $_SESSION['id']);
        break;

    case 6: // Eliminar amigo
        $id_sol = filter_input(INPUT_POST, 'id_sol', FILTER_VALIDATE_INT);
        if (!$id_sol || $id_sol === $_SESSION['id']) {
            echo "error";
            exit;
        }
        // Eliminar en ambas direcciones con id_rec desde sesión
        $solicitud->eliminarAmigo($id_sol, $_SESSION['id']);
        $solicitud->eliminarAmigo($_SESSION['id'], $id_sol);
        break;

    case 7: // Desbloquear usuario
        $id_block = filter_input(INPUT_POST, 'id_block', FILTER_VALIDATE_INT);
        if (!$id_block) {
            echo "error";
            exit;
        }
        // id_recep siempre desde sesión
        $solicitud->desbloquear($_SESSION['id'], $id_block);
        break;

    case 8: // Cancelar solicitud enviada
        $id_rec = filter_input(INPUT_POST, 'id_rec', FILTER_VALIDATE_INT);
        if (!$id_rec) {
            echo "error";
            exit;
        }
        $solicitud->cancelarSolicitud($_SESSION['id'], $id_rec);
        break;

    default:
        http_response_code(400);
        echo "error";
}
?>