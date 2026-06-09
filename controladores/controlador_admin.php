<?php
include "../sec/sec.php";
include "../modelos/modelo_admin.php";


if (!isset($_SESSION['id']) || $_SESSION['level'] > 1) {
    http_response_code(403);
    echo json_encode(["error" => "Acceso denegado"]);
    exit;
}

$admin = new ModeloAdmin();
$opt = filter_input(INPUT_POST, 'opt', FILTER_VALIDATE_INT);

if (!$opt) {
    echo json_encode(["error" => "Opción no válida"]);
    exit;
}


function validarImagen($fileKey)
{
    if (!isset($_FILES[$fileKey]) || $_FILES[$fileKey]['error'] !== 0) {
        return null;
    }

    $extensionesPermitidas = ['jpg', 'jpeg', 'png', 'webp'];
    $tiposMimePermitidos = ['image/jpeg', 'image/png', 'image/webp'];

    $ext = strtolower(pathinfo($_FILES[$fileKey]['name'], PATHINFO_EXTENSION));
    $mime = mime_content_type($_FILES[$fileKey]['tmp_name']);

    if (!in_array($ext, $extensionesPermitidas) || !in_array($mime, $tiposMimePermitidos)) {
        return false; // Formato no permitido
    }

    return $ext;
}

switch ($opt) {

    // ========== JUEGOS ==========

    case 1:
        $juegos = $admin->obtenerJuegos();
        echo json_encode($juegos);
        break;

    case 2:
        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        $juego = $admin->obtenerJuego($id);
        echo json_encode($juego);
        break;

    case 3:
        $titulo = trim(filter_input(INPUT_POST, 'titulo', FILTER_DEFAULT) ?? '');
        if (empty($titulo)) {
            echo json_encode(["success" => false, "error" => "El título es obligatorio."]);
            exit;
        }
        $desarrollador = trim(filter_input(INPUT_POST, 'desarrollador', FILTER_DEFAULT) ?? '');
        $distribuidora = trim(filter_input(INPUT_POST, 'distribuidora', FILTER_DEFAULT) ?? '');
        $fecha = filter_input(INPUT_POST, 'fecha', FILTER_DEFAULT) ?? null;
        $genero = trim(filter_input(INPUT_POST, 'genero', FILTER_DEFAULT) ?? '');
        $descripcion = trim(filter_input(INPUT_POST, 'descripcion', FILTER_DEFAULT) ?? '');
        $enlace_compra = trim(filter_input(INPUT_POST, 'enlace_compra', FILTER_SANITIZE_URL) ?? '');
        $en_desarrollo = filter_input(INPUT_POST, 'en_desarrollo', FILTER_VALIDATE_INT) ? 1 : 0;
        $trailer = trim(filter_input(INPUT_POST, 'trailer', FILTER_SANITIZE_URL) ?? '');

        $portada = null;
        if (isset($_FILES['portada']) && $_FILES['portada']['error'] === 0) {
            $ext = validarImagen('portada');
            if ($ext === false) {
                echo json_encode(["success" => false, "error" => "Formato de imagen no permitido."]);
                exit;
            }
            $portada = 'game_' . time() . '.' . $ext;
            move_uploaded_file($_FILES['portada']['tmp_name'], "../assets/img/games/" . $portada);
        }

        $admin->insertarJuego($titulo, $desarrollador, $distribuidora, $fecha, $genero, $descripcion, $portada, $_SESSION['id'], $enlace_compra, $trailer, $en_desarrollo);
        echo json_encode(["success" => true]);
        break;

    case 4:
        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }

        // Verificar que es el creador o admin
        $check = $db->prepare("SELECT creador_id FROM juegos WHERE id = ?");
        $check->bind_param("i", $id);
        $check->execute();
        $creador_id = $check->get_result()->fetch_assoc()['creador_id'];

        if ($_SESSION['level'] != 0 && $creador_id != $_SESSION['id']) {
            http_response_code(403);
            echo json_encode(["error" => "No tienes permiso para modificar este juego"]);
            exit;
        }

        $titulo = trim(filter_input(INPUT_POST, 'titulo', FILTER_DEFAULT) ?? '');
        if (empty($titulo)) {
            echo json_encode(["success" => false, "error" => "El título es obligatorio."]);
            exit;
        }
        $desarrollador = trim(filter_input(INPUT_POST, 'desarrollador', FILTER_DEFAULT) ?? '');
        $distribuidora = trim(filter_input(INPUT_POST, 'distribuidora', FILTER_DEFAULT) ?? '');
        $fecha = filter_input(INPUT_POST, 'fecha', FILTER_DEFAULT) ?? null;
        $genero = trim(filter_input(INPUT_POST, 'genero', FILTER_DEFAULT) ?? '');
        $descripcion = trim(filter_input(INPUT_POST, 'descripcion', FILTER_DEFAULT) ?? '');
        $enlace_compra = trim(filter_input(INPUT_POST, 'enlace_compra', FILTER_SANITIZE_URL) ?? '');
        $en_desarrollo = filter_input(INPUT_POST, 'en_desarrollo', FILTER_VALIDATE_INT) ? 1 : 0;
        $trailer = trim(filter_input(INPUT_POST, 'trailer', FILTER_SANITIZE_URL) ?? '');

        $portada = null;
        if (isset($_FILES['portada']) && $_FILES['portada']['error'] === 0) {
            $ext = validarImagen('portada');
            if ($ext === false) {
                echo json_encode(["success" => false, "error" => "Formato de imagen no permitido."]);
                exit;
            }
            $portada = 'game_' . time() . '.' . $ext;
            move_uploaded_file($_FILES['portada']['tmp_name'], "../assets/img/games/" . $portada);
        }

        $admin->actualizarJuego($id, $titulo, $desarrollador, $distribuidora, $fecha, $genero, $descripcion, $portada, $enlace_compra, $trailer, $en_desarrollo);
        echo json_encode(["success" => true]);
        break;

    case 5:
        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }

        // Verificar que es el creador o admin
        $check = $db->prepare("SELECT creador_id FROM juegos WHERE id = ?");
        $check->bind_param("i", $id);
        $check->execute();
        $creador_id = $check->get_result()->fetch_assoc()['creador_id'];

        if ($_SESSION['level'] != 0 && $creador_id != $_SESSION['id']) {
            http_response_code(403);
            echo json_encode(["error" => "No tienes permiso para eliminar este juego"]);
            exit;
        }

        $admin->eliminarJuego($id);
        echo json_encode(["success" => true]);
        break;



    // ========== ELEMENTOS ==========

    case 10:
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        if (!$id_juego) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        echo json_encode($admin->obtenerElementos($id_juego));
        break;

    case 11:
        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        echo json_encode($admin->obtenerElemento($id));
        break;

    case 12:
        $nombre = trim(filter_input(INPUT_POST, 'nombre', FILTER_DEFAULT) ?? '');
        if (empty($nombre)) {
            echo json_encode(["success" => false, "error" => "El nombre es obligatorio."]);
            exit;
        }
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $tipo = trim(filter_input(INPUT_POST, 'tipo', FILTER_DEFAULT) ?? '');
        $valor1 = trim(filter_input(INPUT_POST, 'valor1', FILTER_DEFAULT) ?? '');
        $valor2 = trim(filter_input(INPUT_POST, 'valor2', FILTER_DEFAULT) ?? '');
        $rareza = trim(filter_input(INPUT_POST, 'rareza', FILTER_DEFAULT) ?? '');
        $descripcion = trim(filter_input(INPUT_POST, 'descripcion', FILTER_DEFAULT) ?? '');
        $imagen = null;
        if (isset($_FILES['imagen']) && $_FILES['imagen']['error'] === 0) {
            $ext = validarImagen('imagen');
            if ($ext === false) {
                echo json_encode(["success" => false, "error" => "Formato de imagen no permitido."]);
                exit;
            }
            $imagen = 'elem_' . time() . '.' . $ext;
            move_uploaded_file($_FILES['imagen']['tmp_name'], "../assets/img/elementos/" . $imagen);
        }

        $resultado = $admin->insertarElemento($id_juego, $nombre, $tipo, $valor1, $valor2, $rareza, $descripcion, $imagen);
        echo json_encode($resultado
            ? ["success" => true]
            : ["success" => false, "error" => "No se pudo guardar el elemento."]);
        break;

    case 13:
        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }

        $nombre = trim(filter_input(INPUT_POST, 'nombre', FILTER_DEFAULT) ?? '');
        if (empty($nombre)) {
            echo json_encode(["success" => false, "error" => "El nombre es obligatorio."]);
            exit;
        }
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $tipo = trim(filter_input(INPUT_POST, 'tipo', FILTER_DEFAULT) ?? '');
        $valor1 = trim(filter_input(INPUT_POST, 'valor1', FILTER_DEFAULT) ?? '');
        $valor2 = trim(filter_input(INPUT_POST, 'valor2', FILTER_DEFAULT) ?? '');
        $rareza = trim(filter_input(INPUT_POST, 'rareza', FILTER_DEFAULT) ?? '');
        $descripcion = trim(filter_input(INPUT_POST, 'descripcion', FILTER_DEFAULT) ?? '');
        $imagen = null;
        if (isset($_FILES['imagen']) && $_FILES['imagen']['error'] === 0) {
            $ext = validarImagen('imagen');
            if ($ext === false) {
                echo json_encode(["success" => false, "error" => "Formato de imagen no permitido."]);
                exit;
            }
            $imagen = 'elem_' . time() . '.' . $ext;
            move_uploaded_file($_FILES['imagen']['tmp_name'], "../assets/img/elementos/" . $imagen);
        }

        $resultado = $admin->actualizarElemento($id, $nombre, $tipo, $valor1, $valor2, $rareza, $descripcion, $imagen);
        echo json_encode($resultado
            ? ["success" => true]
            : ["success" => false, "error" => "No se pudo actualizar el elemento."]);
        break;

    case 14:

        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        $admin->eliminarElemento($id);
        echo json_encode(["success" => true]);
        break;


    // ========== PERSONAJES ==========

    case 20:
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        if (!$id_juego) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        echo json_encode($admin->obtenerPersonajes($id_juego));
        break;

    case 21:
        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        echo json_encode($admin->obtenerPersonaje($id));
        break;

    case 22:
        $nombre = trim(filter_input(INPUT_POST, 'nombre', FILTER_DEFAULT) ?? '');
        if (empty($nombre)) {
            echo json_encode(["success" => false, "error" => "El nombre del personaje es obligatorio."]);
            exit;
        }
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $rol = trim(filter_input(INPUT_POST, 'rol', FILTER_DEFAULT) ?? '');
        $ubicacion = trim(filter_input(INPUT_POST, 'ubicacion', FILTER_DEFAULT) ?? '');
        $descripcion = trim(filter_input(INPUT_POST, 'descripcion', FILTER_DEFAULT) ?? '');

        $imagen = null;
        if (isset($_FILES['imagen']) && $_FILES['imagen']['error'] === 0) {
            $ext = validarImagen('imagen');
            if ($ext === false) {
                echo json_encode(["success" => false, "error" => "Formato de imagen no permitido."]);
                exit;
            }
            $imagen = 'pj_' . time() . '.' . $ext;
            move_uploaded_file($_FILES['imagen']['tmp_name'], "../assets/img/personajes/" . $imagen);
        }

        $resultado = $admin->insertarPersonaje($id_juego, $nombre, $rol, $ubicacion, $descripcion, $imagen);
        echo json_encode($resultado
            ? ["success" => true]
            : ["success" => false, "error" => "No se pudo guardar el personaje."]);
        break;

    case 23:
        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }

        $nombre = trim(filter_input(INPUT_POST, 'nombre', FILTER_DEFAULT) ?? '');
        if (empty($nombre)) {
            echo json_encode(["success" => false, "error" => "El nombre del personaje es obligatorio."]);
            exit;
        }
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $rol = trim(filter_input(INPUT_POST, 'rol', FILTER_DEFAULT) ?? '');
        $ubicacion = trim(filter_input(INPUT_POST, 'ubicacion', FILTER_DEFAULT) ?? '');
        $descripcion = trim(filter_input(INPUT_POST, 'descripcion', FILTER_DEFAULT) ?? '');

        $imagen = null;
        if (isset($_FILES['imagen']) && $_FILES['imagen']['error'] === 0) {
            $ext = validarImagen('imagen');
            if ($ext === false) {
                echo json_encode(["success" => false, "error" => "Formato de imagen no permitido."]);
                exit;
            }
            $imagen = 'pj_' . time() . '.' . $ext;
            move_uploaded_file($_FILES['imagen']['tmp_name'], "../assets/img/personajes/" . $imagen);
        }

        $resultado = $admin->actualizarPersonaje($id, $nombre, $rol, $ubicacion, $descripcion, $imagen);
        echo json_encode($resultado
            ? ["success" => true]
            : ["success" => false, "error" => "No se pudo actualizar el personaje."]);
        break;

    case 24:

        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        $admin->eliminarPersonaje($id);
        echo json_encode(["success" => true]);
        break;


    // ========== MAPA ==========

    case 30:
        $ext = validarImagen('mapa_imagen');
        if ($ext === false) {
            echo json_encode(["success" => false, "error" => "Formato de imagen no permitido."]);
            exit;
        }
        if ($ext === null) {
            echo json_encode(["success" => false, "error" => "No se recibió la imagen."]);
            exit;
        }

        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        if (!$id_juego) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }

        $nombre = 'map_' . time() . '.' . $ext;
        $ruta = "../assets/img/maps/" . $nombre;

        if (move_uploaded_file($_FILES['mapa_imagen']['tmp_name'], $ruta)) {
            $admin->actualizarMapaImagen($id_juego, $nombre);
            echo json_encode(["success" => true]);
        } else {

            error_log("Error al mover imagen de mapa para juego $id_juego");
            echo json_encode(["success" => false, "error" => "Error al guardar la imagen."]);
        }
        break;

    case 31:
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        if (!$id_juego) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        echo json_encode($admin->obtenerPuntosMapa($id_juego));
        break;

    case 32:
        $nombre = trim(filter_input(INPUT_POST, 'nombre', FILTER_DEFAULT) ?? '');
        if (empty($nombre)) {
            echo json_encode(["success" => false, "error" => "El nombre del punto es obligatorio."]);
            exit;
        }
        $pos_x = filter_input(INPUT_POST, 'pos_x', FILTER_VALIDATE_FLOAT);
        $pos_y = filter_input(INPUT_POST, 'pos_y', FILTER_VALIDATE_FLOAT);
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $icono = trim(filter_input(INPUT_POST, 'icono', FILTER_DEFAULT) ?? '📍');

        if ($pos_x === false || $pos_y === false || !$id_juego) {
            echo json_encode(["success" => false, "error" => "Datos inválidos."]);
            exit;
        }
        $tipo = trim(filter_input(INPUT_POST, 'tipo', FILTER_DEFAULT) ?? '');
        $descripcion = trim(filter_input(INPUT_POST, 'descripcion', FILTER_DEFAULT) ?? '');

        $resultado = $admin->insertarPuntoMapa($id_juego, $nombre, $pos_x, $pos_y, $tipo, $descripcion, $icono);
        if ($resultado) {
            echo json_encode(["success" => true]);
        } else {

            error_log("Error al insertar punto de mapa para juego $id_juego");
            echo json_encode(["success" => false, "error" => "Error al guardar el punto."]);
        }
        break;

    case 33:

        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if (!$id) {
            echo json_encode(["error" => "ID inválido"]);
            exit;
        }
        $admin->eliminarPuntoMapa($id);
        echo json_encode(["success" => true]);
        break;

    case 90: // Obtener media de valoraciones
        include "../modelos/modelo_juegos.php";
        $modeloJuegos = new ModeloJuegos();
        $media = $modeloJuegos->obtenerMediaValoraciones($_POST['id_juego']);
        echo json_encode($media);
        break;

    case 91: // Toggle "en desarrollo"
        $id_juego = filter_input(INPUT_POST, 'id_juego', FILTER_VALIDATE_INT);
        $estado = filter_input(INPUT_POST, 'estado', FILTER_VALIDATE_INT);
        if ($id_juego && ($estado === 0 || $estado === 1)) {
            $admin->toggleEnDesarrollo($id_juego, $estado);
            echo json_encode(["success" => true]);
        } else {
            echo json_encode(["success" => false]);
        }
        break;

    default:
        http_response_code(400);
        echo json_encode(["error" => "Opción no válida"]);
}
?>