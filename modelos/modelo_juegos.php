<?php
class ModeloJuegos
{

    private $db;

    // Una sola conexión inyectada en el constructor
    public function __construct()
    {
        global $db;
        $this->db = $db;
    }


    public function buscarJuegos($termino)
    {

        $filt = $this->db->prepare("SELECT id, titulo, desarrollador, fecha_lanzamiento 
                              FROM juegos 
                              WHERE titulo LIKE CONCAT('%', ?, '%') 
                                 OR desarrollador LIKE CONCAT('%', ?, '%')
                              ORDER BY titulo");
        $filt->bind_param("ss", $termino, $termino);
        $filt->execute();
        $res = $filt->get_result();
        $juegos = [];
        while ($row = $res->fetch_assoc()) {
            $juegos[] = $row;
        }
        return $juegos;
    }

    public function obtenerJuegoCompleto($id)
    {

        // Datos generales del juego
        $filt = $this->db->prepare("SELECT * FROM juegos WHERE id = ?");
        $filt->bind_param("i", $id);
        $filt->execute();
        $res = $filt->get_result();
        $juego = $res->fetch_assoc();

        if (!$juego)
            return null;

        // Elementos del juego
        $filt = $this->db->prepare("SELECT * FROM elementos WHERE id_juego = ? ORDER BY nombre");
        $filt->bind_param("i", $id);
        $filt->execute();
        $res = $filt->get_result();
        $juego['elementos'] = $res->fetch_all(MYSQLI_ASSOC);

        // Personajes del juego
        $filt = $this->db->prepare("SELECT * FROM personajes WHERE id_juego = ? ORDER BY nombre");
        $filt->bind_param("i", $id);
        $filt->execute();
        $res = $filt->get_result();
        $juego['personajes'] = $res->fetch_all(MYSQLI_ASSOC);

        // Puntos de mapa del juego
        $filt = $this->db->prepare("SELECT * FROM mapas WHERE id_juego = ? ORDER BY nombre");
        $filt->bind_param("i", $id);
        $filt->execute();
        $res = $filt->get_result();
        $juego['mapas'] = $res->fetch_all(MYSQLI_ASSOC);

        // Datos del creador
        if (!empty($juego['creador_id'])) {
            $filt = $this->db->prepare("SELECT id, user, nombre FROM usuarios WHERE id = ?");
            $filt->bind_param("i", $juego['creador_id']);
            $filt->execute();
            $res = $filt->get_result();
            $juego['creador'] = $res->fetch_assoc();
        }

        return $juego;
    }

    // ========== VALORACIONES ==========
    public function obtenerValoracionUsuario($id_juego, $id_usuario)
    {

        $filt = $this->db->prepare("SELECT puntuacion FROM valoraciones WHERE id_juego = ? AND id_usuario = ?");
        $filt->bind_param("ii", $id_juego, $id_usuario);
        $filt->execute();
        $res = $filt->get_result();
        return $res->fetch_assoc()['puntuacion'] ?? 0;
    }

    public function valorarJuego($id_juego, $id_usuario, $puntuacion)
    {

        $filt = $this->db->prepare("INSERT INTO valoraciones (id_juego, id_usuario, puntuacion) VALUES (?, ?, ?) 
                          ON DUPLICATE KEY UPDATE puntuacion = VALUES(puntuacion)");
        $filt->bind_param("iii", $id_juego, $id_usuario, $puntuacion);
        return $filt->execute();
    }

    public function obtenerMediaValoraciones($id_juego)
    {

        $filt = $this->db->prepare("SELECT AVG(puntuacion) as media, COUNT(*) as total FROM valoraciones WHERE id_juego = ?");
        $filt->bind_param("i", $id_juego);
        $filt->execute();
        return $filt->get_result()->fetch_assoc();
    }

    // ========== FAVORITOS ==========
    public function esFavorito($id_juego, $id_usuario)
    {

        $filt = $this->db->prepare("SELECT 1 FROM favoritos WHERE id_juego = ? AND id_usuario = ?");
        $filt->bind_param("ii", $id_juego, $id_usuario);
        $filt->execute();
        return $filt->get_result()->num_rows > 0;
    }

    public function toggleFavorito($id_juego, $id_usuario)
    {

        if ($this->esFavorito($id_juego, $id_usuario)) {
            $filt = $this->db->prepare("DELETE FROM favoritos WHERE id_juego = ? AND id_usuario = ?");
            $filt->bind_param("ii", $id_juego, $id_usuario);
            $filt->execute();
            return false; // Ya no es favorito
        } else {
            $filt = $this->db->prepare("INSERT INTO favoritos (id_juego, id_usuario) VALUES (?, ?)");
            $filt->bind_param("ii", $id_juego, $id_usuario);
            $filt->execute();
            return true; // Ahora es favorito
        }
    }

    public function obtenerFavoritos($id_usuario)
    {

        $filt = $this->db->prepare("SELECT j.* FROM juegos j INNER JOIN favoritos f ON j.id = f.id_juego WHERE f.id_usuario = ? ORDER BY f.fecha DESC");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        return $filt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function buscarJuegosFiltrados($termino, $genero, $desarrollador, $anyo)
    {

        $sql = "SELECT id, titulo, desarrollador, fecha_lanzamiento FROM juegos WHERE 1=1";
        $params = [];
        $tipos = "";

        if (!empty($termino)) {
            $sql .= " AND (titulo LIKE CONCAT('%', ?, '%') OR desarrollador LIKE CONCAT('%', ?, '%'))";
            $params[] = $termino;
            $params[] = $termino;
            $tipos .= "ss";
        }
        if (!empty($genero)) {
            $sql .= " AND genero = ?";
            $params[] = $genero;
            $tipos .= "s";
        }
        if (!empty($desarrollador)) {
            $sql .= " AND desarrollador LIKE CONCAT('%', ?, '%')";
            $params[] = $desarrollador;
            $tipos .= "s";
        }
        if (!empty($anyo)) {
            $sql .= " AND YEAR(fecha_lanzamiento) = ?";
            $params[] = $anyo;
            $tipos .= "i";
        }
        $sql .= " ORDER BY titulo";

        $filt = $this->db->prepare($sql);
        if ($tipos) {
            $filt->bind_param($tipos, ...$params);
        }
        $filt->execute();
        return $filt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function obtenerComentarios($id_juego)
    {
        $stmt = $this->db->prepare("
        SELECT c.id, c.comentario, c.fecha, u.nombre, u.user, u.avatar, u.id AS id_usuario
        FROM comentarios c
        JOIN usuarios u ON c.id_usuario = u.id
        WHERE c.id_juego = ?
        ORDER BY c.fecha DESC
    ");
        $stmt->bind_param("i", $id_juego);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function añadirComentario($id_juego, $id_usuario, $comentario)
    {
        $stmt = $this->db->prepare("
        INSERT INTO comentarios (id_juego, id_usuario, comentario) VALUES (?, ?, ?)
    ");
        $stmt->bind_param("iis", $id_juego, $id_usuario, $comentario);
        return $stmt->execute();
    }

    public function eliminarComentario($id_comentario, $id_usuario, $level)
    {
        // Admin puede borrar cualquiera, usuario solo el suyo
        if ($level == 0) {
            $stmt = $this->db->prepare("DELETE FROM comentarios WHERE id = ?");
            $stmt->bind_param("i", $id_comentario);
        } else {
            $stmt = $this->db->prepare("DELETE FROM comentarios WHERE id = ? AND id_usuario = ?");
            $stmt->bind_param("ii", $id_comentario, $id_usuario);
        }
        return $stmt->execute();
    }

    public function verificarYOtorgarLogros($id_usuario)
    {

        // Obtener estadísticas del usuario
        $stats = [];

        // Juegos añadidos
        $filt = $this->db->prepare("SELECT COUNT(*) as total FROM juegos WHERE creador_id = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $stats['juegos'] = $filt->get_result()->fetch_assoc()['total'];

        // Valoraciones emitidas
        $filt = $this->db->prepare("SELECT COUNT(*) as total FROM valoraciones WHERE id_usuario = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $stats['valoraciones'] = $filt->get_result()->fetch_assoc()['total'];

        // Favoritos
        $filt = $this->db->prepare("SELECT COUNT(*) as total FROM favoritos WHERE id_usuario = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $stats['favoritos'] = $filt->get_result()->fetch_assoc()['total'];

        // Colaboradores (amigos)
        $filt = $this->db->prepare("SELECT amigos FROM usuarios WHERE id = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $amigos = $filt->get_result()->fetch_assoc()['amigos'];
        $stats['amigos'] = count(array_filter(explode('#', $amigos ?? '')));

        // Mensajes enviados (global + privado)
        $totalMensajes = 0;
        $filt = $this->db->prepare("SELECT COUNT(*) as total FROM mensajes_grupales WHERE emisor = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $totalMensajes += $filt->get_result()->fetch_assoc()['total'];
        $filt = $this->db->prepare("SELECT COUNT(*) as total FROM mensajes_privados WHERE emisor = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $totalMensajes += $filt->get_result()->fetch_assoc()['total'];
        $stats['mensajes'] = $totalMensajes;

        // Visitas a juegos
        $filt = $this->db->prepare("SELECT COUNT(*) as total FROM visitas_juegos WHERE id_usuario = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $stats['visitas'] = $filt->get_result()->fetch_assoc()['total'];

        // Valoraciones recibidas en juegos propios
        $filt = $this->db->prepare("SELECT COUNT(*) as total FROM valoraciones v JOIN juegos j ON v.id_juego = j.id WHERE j.creador_id = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $stats['valoraciones_recibidas'] = $filt->get_result()->fetch_assoc()['total'];

        // Antigüedad (días desde registro)
        $filt = $this->db->prepare("SELECT DATEDIFF(NOW(), ultima_conexion) as dias FROM usuarios WHERE id = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $stats['antiguedad'] = $filt->get_result()->fetch_assoc()['dias'] ?? 0;

        // Obtener logros no obtenidos
        $logrosOtorgados = [];
        $filt = $this->db->prepare("SELECT id_logro FROM logros_usuarios WHERE id_usuario = ?");
        $filt->bind_param("i", $id_usuario);
        $filt->execute();
        $res = $filt->get_result();
        while ($row = $res->fetch_assoc()) {
            $logrosOtorgados[] = $row['id_logro'];
        }

        // Comprobar criterios
        $criterios = [
            1 => function ($s) {
                return $s['juegos'] >= 1;
            },
            2 => function ($s) {
                return $s['juegos'] >= 5;
            },
            3 => function ($s) {
                return $s['valoraciones'] >= 10;
            },
            4 => function ($s) {
                return $s['valoraciones'] >= 1;
            },
            5 => function ($s) {
                return $s['amigos'] >= 5;
            },
            6 => function ($s) {
                return $s['mensajes'] >= 10;
            },
            7 => function ($s) {
                return $s['favoritos'] >= 1;
            },
            8 => function ($s) {
                return $s['visitas'] >= 10;
            },
            9 => function ($s) {
                return $s['valoraciones_recibidas'] >= 5;
            },
            10 => function ($s) {
                return $s['antiguedad'] >= 30;
            },
        ];

        foreach ($criterios as $idLogro => $criterioFunc) {
            if (!in_array($idLogro, $logrosOtorgados) && $criterioFunc($stats)) {
                $filt = $this->db->prepare("INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?)");
                $filt->bind_param("ii", $id_usuario, $idLogro);
                $filt->execute();
            }
        }

        return true;
    }

}
?>