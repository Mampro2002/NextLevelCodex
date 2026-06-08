<?php

class Users
{
    function update($id, $name, $pass, $level, $email)
    {
        include "../sec/bdd.php";

        if ($pass !== null) {
            $filt = $db->prepare("UPDATE usuarios SET nombre = ?, email = ?, pass = ?, level = ? WHERE id = ?");
            $filt->bind_param('sssii', $name, $email, $pass, $level, $id);
        } else {
            $filt = $db->prepare("UPDATE usuarios SET nombre = ?, email = ?, level = ? WHERE id = ?");
            $filt->bind_param('ssii', $name, $email, $level, $id);
        }
        $filt->execute();
    }

    function delete($id)
    {
        include "../sec/bdd.php";
        include "../modelos/clase_amigos.php";

        $claseAmigos = new Amigos();

        // Obtener datos del usuario a borrar
        $filt = $db->prepare("SELECT user, amigos FROM usuarios WHERE id = ?");
        $filt->bind_param('i', $id);
        $filt->execute();
        $res = $filt->get_result();
        $vec = $res->fetch_assoc();

        if (!$vec)
            return;

        $userName = $vec['user'];
        $amigos = !empty($vec["amigos"]) ? explode('#', $vec["amigos"]) : [];

        // Eliminar al usuario de la lista de amigos de sus amigos
        for ($i = 0; $i < count($amigos); $i++) {
            if (empty($amigos[$i]))
                continue;
            $claseAmigos->eliminarAmigo($id, $amigos[$i]);
        }

        // Borrar de bloqueados
        $filt = $db->prepare("DELETE FROM bloqueados WHERE id_recep = ? OR id_block = ?");
        $filt->bind_param('ii', $id, $id);
        $filt->execute();

        // Borrar de domingueros
        $filt = $db->prepare("DELETE FROM domingueros WHERE id_sol = ? OR id_rec = ?");
        $filt->bind_param('ii', $id, $id);
        $filt->execute();

        // Borrar el usuario
        $filt = $db->prepare("DELETE FROM usuarios WHERE id = ?");
        $filt->bind_param('i', $id);
        $filt->execute();
    }

    function añadir($user_new, $name, $email, $pass, $level, $options)
    {
        include "../sec/bdd.php";
        $hash = password_hash($pass, PASSWORD_DEFAULT);
        $filt = $db->prepare("INSERT INTO usuarios (user, nombre, email, pass, level) VALUES (?, ?, ?, ?, ?)");
        $filt->bind_param('ssssi', $user_new, $name, $email, $hash, $level);

        if ($filt->execute()) {
            if ($options == 3) {
                // Registro: iniciar sesión automáticamente
                if (session_status() === PHP_SESSION_NONE) {
                    session_start();
                }
                $filt2 = $db->prepare("SELECT * FROM usuarios WHERE user = ?");
                $filt2->bind_param('s', $user_new);
                $filt2->execute();
                $res = $filt2->get_result();
                $vec = $res->fetch_assoc();

                $_SESSION["id"] = $vec["id"];
                $_SESSION["user"] = $vec["user"];
                $_SESSION["email"] = $vec["email"];
                $_SESSION["level"] = $vec["level"];
                $_SESSION["idioma"] = filter_input(INPUT_POST, 'idioma', FILTER_SANITIZE_SPECIAL_CHARS);
                $_SESSION["nombre"] = $vec["nombre"];

                $conectado = 1;
                $upd = $db->prepare("UPDATE usuarios SET ultima_conexion = NOW(), conectado = ? WHERE id = ?");
                $upd->bind_param("ii", $conectado, $vec["id"]);
                $upd->execute();

                return "ok";
            } else {
                // Añadir desde admin: solo devolvemos éxito
                return "añadir";
            }
        } else {
            // Error en la inserción
            return "error: " . $db->error;
        }
    }

    function banear($id, $minutos)
    {
        include "../sec/bdd.php";
        $ban_hasta = date('Y-m-d H:i:s', time() + ($minutos * 60));
        $filt = $db->prepare("UPDATE usuarios SET ban_hasta = ? WHERE id = ?");
        $filt->bind_param("si", $ban_hasta, $id);
        $filt->execute();
        echo "baneado";
    }

    function desbanear($id)
    {
        include "../sec/bdd.php";
        $filt = $db->prepare("UPDATE usuarios SET ban_hasta = NULL WHERE id = ?");
        $filt->bind_param("i", $id);
        $filt->execute();
        echo "desbaneado";
    }
}
?>