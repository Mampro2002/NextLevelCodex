<?php
class ModeloChat
{

    private $db;

    // Una sola conexión inyectada en el constructor
    public function __construct()
    {
        global $db;
        $this->db = $db;
    }

    // ========== CHAT GLOBAL ==========

    public function obtenerMensajesGlobales($limite = 50)
    {
        $sql = "SELECT * FROM (
                    SELECT m.id, m.mensaje, m.fecha, u.user, u.nombre 
                    FROM mensajes_grupales m 
                    JOIN usuarios u ON m.emisor = u.id 
                    ORDER BY m.fecha DESC 
                    LIMIT ?
                ) AS ultimos ORDER BY fecha ASC";
        $filt = $this->db->prepare($sql);
        $filt->bind_param("i", $limite);
        $filt->execute();
        return $filt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    // Solo mensajes nuevos desde un ID dado
    public function obtenerMensajesDesde($desde_id)
    {
        $sql = "SELECT m.id, m.mensaje, m.fecha, u.user, u.nombre
                FROM mensajes_grupales m
                JOIN usuarios u ON m.emisor = u.id
                WHERE m.id > ?
                ORDER BY m.fecha ASC";
        $filt = $this->db->prepare($sql);
        $filt->bind_param("i", $desde_id);
        $filt->execute();
        return $filt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function enviarMensajeGlobal($emisor, $mensaje)
    {
        $filt = $this->db->prepare("INSERT INTO mensajes_grupales (emisor, mensaje, fecha) VALUES (?, ?, NOW())");
        $filt->bind_param("is", $emisor, $mensaje);
        return $filt->execute();
    }

    // ========== CHAT PRIVADO ==========

    public function obtenerMensajesPrivados($usuario1, $usuario2, $limite = 50)
    {
        $sql = "SELECT * FROM (
                    SELECT m.id, m.mensaje, m.fecha, m.leido, 
                           u_emisor.user AS emisor_user, u_emisor.nombre AS emisor_nombre,
                           u_receptor.user AS receptor_user, u_receptor.nombre AS receptor_nombre
                    FROM mensajes_privados m 
                    JOIN usuarios u_emisor ON m.emisor = u_emisor.id
                    JOIN usuarios u_receptor ON m.receptor = u_receptor.id
                    WHERE (m.emisor = ? AND m.receptor = ?) 
                       OR (m.emisor = ? AND m.receptor = ?)
                    ORDER BY m.fecha DESC 
                    LIMIT ?
                ) AS ultimos ORDER BY fecha ASC";
        $filt = $this->db->prepare($sql);
        $filt->bind_param("iiiii", $usuario1, $usuario2, $usuario2, $usuario1, $limite);
        $filt->execute();
        return $filt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    // Solo mensajes privados nuevos desde un ID (para polling inteligente)
    public function obtenerMensajesPrivadosDesde($usuario1, $usuario2, $desde_id)
    {
        $sql = "SELECT m.id, m.mensaje, m.fecha, m.leido,
                       u_emisor.user AS emisor_user, u_emisor.nombre AS emisor_nombre,
                       u_receptor.user AS receptor_user, u_receptor.nombre AS receptor_nombre
                FROM mensajes_privados m
                JOIN usuarios u_emisor ON m.emisor = u_emisor.id
                JOIN usuarios u_receptor ON m.receptor = u_receptor.id
                WHERE ((m.emisor = ? AND m.receptor = ?)
                    OR (m.emisor = ? AND m.receptor = ?))
                  AND m.id > ?
                ORDER BY m.fecha ASC";
        $filt = $this->db->prepare($sql);
        $filt->bind_param("iiiii", $usuario1, $usuario2, $usuario2, $usuario1, $desde_id);
        $filt->execute();
        return $filt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function enviarMensajePrivado($emisor, $receptor, $mensaje)
    {
        $filt = $this->db->prepare("INSERT INTO mensajes_privados (emisor, receptor, mensaje, fecha, leido) VALUES (?, ?, ?, NOW(), 0)");
        $filt->bind_param("iis", $emisor, $receptor, $mensaje);
        return $filt->execute();
    }

    public function marcarComoLeidos($emisor, $receptor)
    {
        $filt = $this->db->prepare("UPDATE mensajes_privados SET leido = 1 WHERE emisor = ? AND receptor = ? AND leido = 0");
        $filt->bind_param("ii", $emisor, $receptor);
        return $filt->execute();
    }

    public function contarNoLeidos($usuario)
    {
        $filt = $this->db->prepare("SELECT COUNT(*) AS total FROM mensajes_privados WHERE receptor = ? AND leido = 0");
        $filt->bind_param("i", $usuario);
        $filt->execute();
        return (int) $filt->get_result()->fetch_assoc()['total'];
    }
}
?>