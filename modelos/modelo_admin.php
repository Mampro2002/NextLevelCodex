<?php
class ModeloAdmin
{

    // ========== JUEGOS ==========
    public function obtenerJuegos()
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("SELECT id, titulo, desarrollador, fecha_lanzamiento, portada 
                              FROM juegos ORDER BY titulo");
        $filt->execute();
        $res = $filt->get_result();
        return $res->fetch_all(MYSQLI_ASSOC);
    }

    public function obtenerJuego($id)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("SELECT * FROM juegos WHERE id = ?");
        $filt->bind_param("i", $id);
        $filt->execute();
        $res = $filt->get_result();
        return $res->fetch_assoc();
    }

    public function insertarJuego($titulo, $desarrollador, $distribuidora, $fecha, $genero, $descripcion, $portada, $creador_id, $enlace_compra, $trailer, $en_desarrollo)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("INSERT INTO juegos (titulo, desarrollador, distribuidora, fecha_lanzamiento, genero, descripcion, portada, creador_id, enlace_compra, trailer, en_desarrollo) 
                          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $filt->bind_param("sssssssissi", $titulo, $desarrollador, $distribuidora, $fecha, $genero, $descripcion, $portada, $creador_id, $enlace_compra, $trailer, $en_desarrollo);
        return $filt->execute();
    }

    public function actualizarJuego($id, $titulo, $desarrollador, $distribuidora, $fecha, $genero, $descripcion, $portada, $enlace_compra, $trailer, $en_desarrollo)
    {
        include "../sec/bdd.php";

        // Si se proporciona una nueva portada, eliminar la anterior (si no es la default)
        if ($portada) {
            $filt = $db->prepare("SELECT portada FROM juegos WHERE id = ?");
            $filt->bind_param("i", $id);
            $filt->execute();
            $anterior = $filt->get_result()->fetch_assoc()['portada'];
            if ($anterior && $anterior != 'default_game.jpg' && file_exists("../assets/img/games/" . $anterior)) {
                unlink("../assets/img/games/" . $anterior);
            }

            $filt = $db->prepare("UPDATE juegos SET titulo=?, desarrollador=?, distribuidora=?, fecha_lanzamiento=?, genero=?, descripcion=?, portada=?, enlace_compra=?, trailer=?, en_desarrollo=? WHERE id=?");
            $filt->bind_param("sssssssssii", $titulo, $desarrollador, $distribuidora, $fecha, $genero, $descripcion, $portada, $enlace_compra, $trailer, $en_desarrollo, $id);
        } else {
            $filt = $db->prepare("UPDATE juegos SET titulo=?, desarrollador=?, distribuidora=?, fecha_lanzamiento=?, genero=?, descripcion=?, enlace_compra=?, trailer=?, en_desarrollo=? WHERE id=?");
            $filt->bind_param("ssssssssii", $titulo, $desarrollador, $distribuidora, $fecha, $genero, $descripcion, $enlace_compra, $trailer, $en_desarrollo, $id);
        }
        return $filt->execute();
    }

    public function eliminarJuego($id)
    {
        include "../sec/bdd.php";

        // Obtener portada para borrar archivo
        $filt = $db->prepare("SELECT portada FROM juegos WHERE id = ?");
        $filt->bind_param("i", $id);
        $filt->execute();
        $res = $filt->get_result();
        $juego = $res->fetch_assoc();

        if ($juego && $juego['portada'] && $juego['portada'] != 'default_game.jpg') {
            $ruta = "../assets/img/games/" . $juego['portada'];
            if (file_exists($ruta))
                unlink($ruta);
        }

        $filt = $db->prepare("DELETE FROM juegos WHERE id = ?");
        $filt->bind_param("i", $id);
        return $filt->execute();
    }

    // ========== ELEMENTOS ==========
    public function obtenerElementos($id_juego)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("SELECT * FROM elementos WHERE id_juego = ? ORDER BY nombre");
        $filt->bind_param("i", $id_juego);
        $filt->execute();
        return $filt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function obtenerElemento($id)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("SELECT * FROM elementos WHERE id = ?");
        $filt->bind_param("i", $id);
        $filt->execute();
        return $filt->get_result()->fetch_assoc();
    }

    public function insertarElemento($id_juego, $nombre, $tipo, $valor1, $valor2, $rareza, $descripcion, $imagen)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("INSERT INTO elementos (id_juego, nombre, tipo, valor1, valor2, rareza, descripcion, imagen) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $filt->bind_param("isssssss", $id_juego, $nombre, $tipo, $valor1, $valor2, $rareza, $descripcion, $imagen);
        $resultado = $filt->execute();
        if ($resultado) {
            $filt2 = $db->prepare("UPDATE juegos SET tiene_items = 1 WHERE id = ?");
            $filt2->bind_param("i", $id_juego);
            $filt2->execute();
        }
        return $resultado;
    }

    public function actualizarElemento($id, $nombre, $tipo, $valor1, $valor2, $rareza, $descripcion, $imagen)
    {
        include "../sec/bdd.php";

        // Si se proporciona una nueva imagen, eliminar la anterior
        if ($imagen) {
            $filt = $db->prepare("SELECT imagen FROM elementos WHERE id = ?");
            $filt->bind_param("i", $id);
            $filt->execute();
            $anterior = $filt->get_result()->fetch_assoc()['imagen'];
            if ($anterior && file_exists("../assets/img/elementos/" . $anterior)) {
                unlink("../assets/img/elementos/" . $anterior);
            }

            $filt = $db->prepare("UPDATE elementos SET nombre=?, tipo=?, valor1=?, valor2=?, rareza=?, descripcion=?, imagen=? WHERE id=?");
            $filt->bind_param("sssssssi", $nombre, $tipo, $valor1, $valor2, $rareza, $descripcion, $imagen, $id);
        } else {
            $filt = $db->prepare("UPDATE elementos SET nombre=?, tipo=?, valor1=?, valor2=?, rareza=?, descripcion=? WHERE id=?");
            $filt->bind_param("ssssssi", $nombre, $tipo, $valor1, $valor2, $rareza, $descripcion, $id);
        }
        return $filt->execute();
    }

    public function eliminarElemento($id)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("DELETE FROM elementos WHERE id = ?");
        $filt->bind_param("i", $id);
        return $filt->execute();
    }

    // ========== PERSONAJES ==========
    public function obtenerPersonajes($id_juego)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("SELECT * FROM personajes WHERE id_juego = ? ORDER BY nombre");
        $filt->bind_param("i", $id_juego);
        $filt->execute();
        return $filt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function obtenerPersonaje($id)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("SELECT * FROM personajes WHERE id = ?");
        $filt->bind_param("i", $id);
        $filt->execute();
        return $filt->get_result()->fetch_assoc();
    }

    public function insertarPersonaje($id_juego, $nombre, $rol, $ubicacion, $descripcion, $imagen)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("INSERT INTO personajes (id_juego, nombre, rol, ubicacion, descripcion, imagen) VALUES (?, ?, ?, ?, ?, ?)");
        $filt->bind_param("isssss", $id_juego, $nombre, $rol, $ubicacion, $descripcion, $imagen);
        $resultado = $filt->execute();

        if ($resultado) {
            $filt2 = $db->prepare("UPDATE juegos SET tiene_personajes = 1 WHERE id = ?");
            $filt2->bind_param("i", $id_juego);
            $filt2->execute();
        }

        return $resultado;
    }

    public function actualizarPersonaje($id, $nombre, $rol, $ubicacion, $descripcion, $imagen)
    {
        include "../sec/bdd.php";

        // Si se proporciona una nueva imagen, eliminar la anterior
        if ($imagen) {
            $filt = $db->prepare("SELECT imagen FROM personajes WHERE id = ?");
            $filt->bind_param("i", $id);
            $filt->execute();
            $anterior = $filt->get_result()->fetch_assoc()['imagen'];
            if ($anterior && file_exists("../assets/img/personajes/" . $anterior)) {
                unlink("../assets/img/personajes/" . $anterior);
            }

            $filt = $db->prepare("UPDATE personajes SET nombre=?, rol=?, ubicacion=?, descripcion=?, imagen=? WHERE id=?");
            $filt->bind_param("sssssi", $nombre, $rol, $ubicacion, $descripcion, $imagen, $id);
        } else {
            $filt = $db->prepare("UPDATE personajes SET nombre=?, rol=?, ubicacion=?, descripcion=? WHERE id=?");
            $filt->bind_param("ssssi", $nombre, $rol, $ubicacion, $descripcion, $id);
        }
        return $filt->execute();
    }

    public function eliminarPersonaje($id)
    {
        include "../sec/bdd.php";
        // Obtener imagen para borrar
        $filt = $db->prepare("SELECT imagen FROM personajes WHERE id = ?");
        $filt->bind_param("i", $id);
        $filt->execute();
        $p = $filt->get_result()->fetch_assoc();
        if ($p && $p['imagen'] && file_exists("../assets/img/personajes/" . $p['imagen'])) {
            unlink("../assets/img/personajes/" . $p['imagen']);
        }
        $filt = $db->prepare("DELETE FROM personajes WHERE id = ?");
        $filt->bind_param("i", $id);
        return $filt->execute();
    }

    // ========== MAPA ==========
    public function actualizarMapaImagen($id_juego, $imagen)
    {
        include "../sec/bdd.php";

        // Obtener y eliminar la imagen de mapa anterior
        $filt = $db->prepare("SELECT mapa_imagen FROM juegos WHERE id = ?");
        $filt->bind_param("i", $id_juego);
        $filt->execute();
        $anterior = $filt->get_result()->fetch_assoc()['mapa_imagen'];
        if ($anterior && file_exists("../assets/img/maps/" . $anterior)) {
            unlink("../assets/img/maps/" . $anterior);
        }

        // Actualizar con la nueva imagen y activar el flag
        $filt = $db->prepare("UPDATE juegos SET mapa_imagen=?, tiene_mapa = 1 WHERE id=?");
        $filt->bind_param("si", $imagen, $id_juego);
        return $filt->execute();
    }

    public function insertarPuntoMapa($id_juego, $nombre, $pos_x, $pos_y, $tipo, $descripcion, $icono)
    {

        include "../sec/bdd.php";
        $filt = $db->prepare("INSERT INTO mapas (id_juego, nombre, pos_x, pos_y, tipo, descripcion, icono) VALUES (?, ?, ?, ?, ?, ?, ?)");

        $filt->bind_param("isddsss", $id_juego, $nombre, $pos_x, $pos_y, $tipo, $descripcion, $icono);

        return $filt->execute();

    }

    public function obtenerPuntosMapa($id_juego)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("SELECT * FROM mapas WHERE id_juego = ? ORDER BY nombre");
        $filt->bind_param("i", $id_juego);
        $filt->execute();
        return $filt->get_result()->fetch_all(MYSQLI_ASSOC);
    }
    public function eliminarPuntoMapa($id)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("DELETE FROM mapas WHERE id = ?");
        $filt->bind_param("i", $id);
        return $filt->execute();
    }

    public function toggleEnDesarrollo($id_juego, $estado)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("UPDATE juegos SET en_desarrollo = ? WHERE id = ?");
        $filt->bind_param("ii", $estado, $id_juego);
        return $filt->execute();
    }
}
?>