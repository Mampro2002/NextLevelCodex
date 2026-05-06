<?php
include "../sec/sec.php";
include "../modelos/modelo_juegos.php";

$juegos = new ModeloJuegos();
$opt = filter_input(INPUT_POST, 'opt', FILTER_SANITIZE_NUMBER_INT);

switch ($opt) {
    case 1: // Buscar juegos con filtros
        $termino = filter_input(INPUT_POST, 'query', FILTER_SANITIZE_SPECIAL_CHARS);
        $genero = filter_input(INPUT_POST, 'genero', FILTER_SANITIZE_SPECIAL_CHARS);
        $desarrollador = filter_input(INPUT_POST, 'desarrollador', FILTER_SANITIZE_SPECIAL_CHARS);
        $anyo = filter_input(INPUT_POST, 'anyo', FILTER_VALIDATE_INT);

        $resultados = $juegos->buscarJuegosFiltrados($termino, $genero, $desarrollador, $anyo);

        // Añadir media de valoraciones a cada juego
        foreach ($resultados as &$juego) {
            $media = $juegos->obtenerMediaValoraciones($juego['id']);
            $juego['media'] = $media['media'] ?? null;
            $juego['total'] = $media['total'] ?? 0;
        }
        echo json_encode($resultados);
        break;
    // ========== VALORACIONES ==========
    case 10: // Obtener valoración del usuario actual
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $puntuacion = $juegos->obtenerValoracionUsuario($id_juego, $_SESSION['id']);
        echo json_encode(['puntuacion' => $puntuacion]);
        break;

    case 11: // Valorar juego
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $puntuacion = filter_input(INPUT_POST, 'puntuacion', FILTER_VALIDATE_INT);
        if ($puntuacion >= 1 && $puntuacion <= 5) {
            $juegos->valorarJuego($id_juego, $_SESSION['id'], $puntuacion);
            $media = $juegos->obtenerMediaValoraciones($id_juego);
            echo json_encode(['success' => true, 'media' => round($media['media'], 1), 'total' => $media['total']]);
        } else {
            echo json_encode(['success' => false]);
        }
        break;

    // ========== FAVORITOS ==========
    case 20: // Toggle favorito
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $resultado = $juegos->toggleFavorito($id_juego, $_SESSION['id']);
        echo json_encode(['favorito' => $resultado]);
        break;

    case 21: // Verificar si es favorito
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $esFav = $juegos->esFavorito($id_juego, $_SESSION['id']);
        echo json_encode(['favorito' => $esFav]);
        break;

    case 30: // Obtener comentarios
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        if (!$id_juego) {
            echo json_encode([]);
            exit;
        }
        echo json_encode($juegos->obtenerComentarios($id_juego));
        break;

    case 31: // Añadir comentario
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $comentario = trim(filter_input(INPUT_POST, 'comentario', FILTER_DEFAULT) ?? '');
        if (!$id_juego || empty($comentario) || mb_strlen($comentario) > 1000) {
            echo json_encode(["success" => false]);
            exit;
        }
        $resultado = $juegos->añadirComentario($id_juego, $_SESSION['id'], $comentario);
        echo json_encode(["success" => $resultado]);
        break;

    case 32: // Eliminar comentario
        $id_comentario = filter_input(INPUT_POST, 'id_comentario', FILTER_VALIDATE_INT);
        if (!$id_comentario) {
            echo json_encode(["success" => false]);
            exit;
        }
        $resultado = $juegos->eliminarComentario($id_comentario, $_SESSION['id'], $_SESSION['level']);
        echo json_encode(["success" => $resultado]);
        break;
    default:
        echo json_encode(["error" => "Opción no válida"]);
}
?>