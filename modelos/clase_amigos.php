<?php

class Amigos
{

    function buscar()
    {

        include "../sec/bdd.php";
        /* 
                $filt = $db->prepare("SELECT id FROM usuarios WHERE user = ?");
                $filt->bind_param("s", $_SESSION["user"]);
                $filt->execute();
                $res_session = $filt->get_result();
                $user_data = $res_session->fetch_assoc(); */


    }

    function solicitud($id_sol, $id_rec, $fecha)
    {

        include "../sec/bdd.php";
        $statu = 1;

        $filt = $db->prepare("INSERT INTO domingueros (id_sol, id_rec, fecha, statu) VALUES (?, ?, ?, ?)");
        $filt->bind_param("iiii", $id_sol, $id_rec, $fecha, $statu);
        $filt->execute();
        echo "enviada";


    }

    function aceptar($id_sol, $id_rec)
    {
        include "../sec/bdd.php";

        // Preparar los IDs con el formato #id#
        $id_soli = '#' . $id_sol . '#';
        $id_recip = '#' . $id_rec . '#';

        // Actualizar el campo 'amigos' del usuario que recibió la solicitud (id_rec)
        $filt = $db->prepare("UPDATE usuarios SET amigos = CONCAT(COALESCE(amigos, ''), ?) WHERE id = ?");
        $filt->bind_param("si", $id_soli, $id_rec);
        $filt->execute();

        // Actualizar el campo 'amigos' del usuario que envió la solicitud (id_sol)
        $filt = $db->prepare("UPDATE usuarios SET amigos = CONCAT(COALESCE(amigos, ''), ?) WHERE id = ?");
        $filt->bind_param("si", $id_recip, $id_sol);
        $filt->execute();

        // Eliminar la solicitud de la tabla domingueros
        $filt = $db->prepare("DELETE FROM domingueros WHERE id_sol = ? AND id_rec = ?");
        $filt->bind_param('ii', $id_sol, $id_rec);
        $filt->execute();

        echo "aceptada";
    }
    function rechazar($id_sol, $id_rec)
    {

        include "../sec/bdd.php";

        $filt3 = $db->prepare("SELECT * FROM domingueros WHERE id_sol = ? AND id_rec = ?");
        $filt3->bind_param("ii", $id_sol, $id_rec);
        $filt3->execute();
        $resSolicitud = $filt3->get_result();
        $vec = $resSolicitud->fetch_assoc();
        $diff = time() - $vec["fecha"];

        $status = 0;

        $filt = $db->prepare("UPDATE domingueros SET statu = ? WHERE id_sol = ? AND id_rec = ?");
        $filt->bind_param("iii", $status, $id_sol, $id_rec);
        $filt->execute();

        if ($diff > (15 * 60 * 60 * 24)) {

            $filt = $db->prepare("DELETE FROM domingueros WHERE id_sol = ? AND id_rec = ?");
            $filt->bind_param('ii', $id_sol, $id_rec);
            $filt->execute();

        }

        echo "rechazado";


    }

    function bloquear($id_sol, $id_rec)
    {

        include "../sec/bdd.php";

        $filt = $db->prepare("INSERT INTO bloqueados (id_recep, id_block) VALUES (?, ?)");
        $filt->bind_param("ii", $id_rec, $id_sol);
        $filt->execute();
        echo "bloqueado";

        $filt = $db->prepare("DELETE FROM domingueros WHERE id_sol = ? AND id_rec = ?");
        $filt->bind_param('ii', $id_sol, $id_rec);
        $filt->execute();

        $this->eliminarAmigo($id_sol, $id_rec);
        $this->eliminarAmigo($id_rec, $id_sol);

    }
    function desbloquear($id_recep, $id_block)
    {

        include "../sec/bdd.php";

        $filt = $db->prepare("DELETE FROM bloqueados WHERE id_recep = ? AND id_block = ?");
        $filt->bind_param('ii', $id_recep, $id_block);
        $filt->execute();

        echo "desbloqueado";

    }

    function eliminarAmigo($id_sol, $id_rec)
    {

        include "../sec/bdd.php";

        $filt = $db->prepare("SELECT amigos FROM usuarios WHERE id = ?");
        $filt->bind_param('i', $id_rec);
        $filt->execute();
        $res = $filt->get_result();

        if ($res->num_rows > 0) {

            $Amigos = $res->fetch_assoc();
            $stringAmigos = $Amigos['amigos'];
            $vecAmigos = explode('#', $stringAmigos);

            if (in_array($id_sol, $vecAmigos)) {

                $amigo = array_diff($vecAmigos, [$id_sol]);

                $nuevoStringAmigos = implode('#', $amigo);

                $filt = $db->prepare("UPDATE usuarios SET amigos = ? WHERE id = ?");
                $filt->bind_param('si', $nuevoStringAmigos, $id_rec);
                $filt->execute();

            }

        }

    }

    function cancelarSolicitud($id_sol, $id_rec)
    {
        include "../sec/bdd.php";

        // Obtener la solicitud para verificar su estado
        $filt = $db->prepare("SELECT statu, fecha FROM domingueros WHERE id_sol = ? AND id_rec = ?");
        $filt->bind_param("ii", $id_sol, $id_rec);
        $filt->execute();
        $res = $filt->get_result();
        $solicitud = $res->fetch_assoc();

        if ($solicitud) {
            // Si la solicitud está rechazada (statu = 0) y no han pasado 15 días, bloquear cancelación
            if ($solicitud['statu'] == 0) {
                $diff = time() - $solicitud['fecha'];
                if ($diff <= (15 * 24 * 60 * 60)) {
                    echo "bloqueada";
                    return;
                }
            }
        }

        // Si no hay restricción, eliminar la solicitud
        $filt = $db->prepare("DELETE FROM domingueros WHERE id_sol = ? AND id_rec = ?");
        $filt->bind_param('ii', $id_sol, $id_rec);
        $filt->execute();

        echo "cancelada";
    }


}

?>