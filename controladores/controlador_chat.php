<?php
include "../sec/sec.php";
include "../modelos/modelo_chat.php";

// ✅ SEGURIDAD: Verificar sesión activa
if (!isset($_SESSION['id'])) {
    http_response_code(403);
    echo json_encode(["error" => "Acceso denegado"]);
    exit;
}

$chat = new ModeloChat();
$opt = filter_input(INPUT_POST, 'opt', FILTER_VALIDATE_INT);

if (!$opt) {
    echo json_encode(["error" => "Opción no válida"]);
    exit;
}

switch ($opt) {

    // ========== CHAT GLOBAL ==========

    case 1: // Obtener mensajes globales
        $mensajes = $chat->obtenerMensajesGlobales();
        echo json_encode($mensajes);
        break;

    case 2: // Enviar mensaje global

        $mensaje = trim(filter_input(INPUT_POST, 'mensaje', FILTER_DEFAULT) ?? '');
        //Limitar longitud del mensaje
        if (empty($mensaje) || mb_strlen($mensaje) > 500) {
            echo "error";
            exit;
        }
        $chat->enviarMensajeGlobal($_SESSION['id'], $mensaje);
        echo "ok";
        break;

    // ========== CHAT PRIVADO ==========

    case 3: // Obtener mensajes privados
        $otro = filter_input(INPUT_POST, 'otro', FILTER_VALIDATE_INT);
        if (!$otro) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        $mensajes = $chat->obtenerMensajesPrivados($_SESSION['id'], $otro);
        $chat->marcarComoLeidos($otro, $_SESSION['id']);
        echo json_encode($mensajes);
        break;

    case 4: // Enviar mensaje privado
        $receptor = filter_input(INPUT_POST, 'receptor', FILTER_VALIDATE_INT);
        $mensaje = trim(filter_input(INPUT_POST, 'mensaje', FILTER_DEFAULT) ?? '');
        if (!$receptor || empty($mensaje) || mb_strlen($mensaje) > 500) {
            echo "error";
            exit;
        }
        //No permitir enviarse mensajes a uno mismo
        if ($receptor === $_SESSION['id']) {
            echo "error";
            exit;
        }
        $chat->enviarMensajePrivado($_SESSION['id'], $receptor, $mensaje);
        echo "ok";
        break;

    case 5: // Contar no leídos
        $total = $chat->contarNoLeidos($_SESSION['id']);
        echo (int) $total;
        break;

    case 6: // ✅ Solo mensajes nuevos desde un ID dado
        $desde_id = filter_input(INPUT_POST, 'desde_id', FILTER_VALIDATE_INT) ?? 0;
        $mensajes = $chat->obtenerMensajesDesde($desde_id);
        echo json_encode($mensajes);
        break;

    case 7: // ✅ Solo mensajes privados nuevos desde un ID (polling inteligente)
        $otro = filter_input(INPUT_POST, 'otro', FILTER_VALIDATE_INT);
        $desde_id = filter_input(INPUT_POST, 'desde_id', FILTER_VALIDATE_INT) ?? 0;
        if (!$otro) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        $mensajes = $chat->obtenerMensajesPrivadosDesde($_SESSION['id'], $otro, $desde_id);
        $chat->marcarComoLeidos($otro, $_SESSION['id']);
        echo json_encode($mensajes);
        break;

    default:
        http_response_code(400);
        echo json_encode(["error" => "Opción no válida"]);
}
?>