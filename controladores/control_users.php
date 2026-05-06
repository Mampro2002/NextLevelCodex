<?php
// Includes al principio (no dentro de los cases)
include "../modelos/clase_users.php";
include "../sec/bdd.php";
include "../sec/sec.php";

$user = new Users();
$options = filter_input(INPUT_POST, 'options', FILTER_SANITIZE_NUMBER_INT);

switch ($options) {
    case 1: { // Actualizar usuario
        // Solo el admin (level 0) puede actualizar
        if ($_SESSION['level'] != 0) {
            echo "error";
            exit;
        }

        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        $name = filter_input(INPUT_POST, 'nombre', FILTER_SANITIZE_SPECIAL_CHARS);
        $email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);
        $pass = filter_input(INPUT_POST, 'pass', FILTER_UNSAFE_RAW);
        $level = filter_input(INPUT_POST, 'level', FILTER_VALIDATE_INT);

        if (empty($name)) {
            echo "rellenos";
            exit;
        }

        // Si se proporciona contraseña, hashearla
        if (!empty($pass)) {
            $pass = password_hash($pass, PASSWORD_DEFAULT);
        } else {
            $pass = null; // Para que el modelo no modifique la contraseña
        }

        if ($level == 0 || $level == 1) {
            $user->update($id, $name, $pass, $level, $email);
            echo "ok";
        } else {
            echo "solo";
            exit;
        }
        break;
    }

    case 2: { // Borrar usuario
        // Solo el admin (level 0) puede borrar
        if ($_SESSION['level'] != 0) {
            echo "error";
            exit;
        }

        $id_user = filter_input(INPUT_POST, 'laId', FILTER_VALIDATE_INT);

        // No puede borrarse a sí mismo
        if ($_SESSION["id"] == $id_user) {
            echo "admin";
            exit;
        }

        // Verificar que el usuario a borrar no sea otro administrador
        $filt = $db->prepare("SELECT level FROM usuarios WHERE id = ?");
        $filt->bind_param("i", $id_user);
        $filt->execute();
        $resultado = $filt->get_result();
        $nivel_usuario = $resultado->fetch_assoc()['level'] ?? 1;

        if ($nivel_usuario == 0) {
            echo "level 0";
        } else {
            echo "borrado";
            $user->delete($id_user);
        }
        break;
    }

    case 3: { // Registro (auto-login)
        $user_new = filter_input(INPUT_POST, 'usuario', FILTER_SANITIZE_SPECIAL_CHARS);
        $name = filter_input(INPUT_POST, 'nombre', FILTER_SANITIZE_SPECIAL_CHARS);
        $pass = filter_input(INPUT_POST, 'pass', FILTER_UNSAFE_RAW);
        $level = 2; // Por defecto, usuario normal
        $email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);

        if (empty($user_new) || empty($name) || empty($pass)) {
            echo "rellenos";
            exit;
        }

        if (strlen($user_new) > 20 || strlen($name) > 20 || strlen($pass) > 20) {
            echo "extenso";
            exit;
        }

        // Hashear la contraseña
        $pass = password_hash($pass, PASSWORD_DEFAULT);

        $user->añadir($user_new, $name, $email, $pass, $level, $options);
        // El modelo ya hace echo "ok" si $options == 3
        break;
    }

    case 4: { // Añadir usuario (desde panel admin)
        // Solo el admin puede añadir usuarios
        if ($_SESSION['level'] != 0) {
            echo "error";
            exit;
        }

        $user_new = filter_input(INPUT_POST, 'user', FILTER_SANITIZE_SPECIAL_CHARS);
        $name = filter_input(INPUT_POST, 'nombre', FILTER_SANITIZE_SPECIAL_CHARS);
        $pass = filter_input(INPUT_POST, 'pass', FILTER_UNSAFE_RAW);
        $level = filter_input(INPUT_POST, 'level', FILTER_VALIDATE_INT);
        $email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);

        if (empty($user_new) || empty($name) || empty($pass)) {
            echo "rellenos";
            exit;
        }
        if (empty($email)) {
            echo "email";
            exit;
        }
        if (strlen($user_new) > 20 || strlen($name) > 20 || strlen($pass) > 20) {
            echo "extenso";
            exit;
        }

        // Hashear la contraseña
        $pass = password_hash($pass, PASSWORD_DEFAULT);

        if ($level == 0 || $level == 1 || $level == 2) {
            $user->añadir($user_new, $name, $email, $pass, $level, $options);
            echo "añadir";
        } else {
            echo "solo";
            exit;
        }
        break;
    }

    case 5: { // Banear usuario
        // Solo el admin puede banear
        if ($_SESSION['level'] != 0) {
            echo "error";
            exit;
        }

        $laId = filter_input(INPUT_POST, 'laId', FILTER_VALIDATE_INT);
        $minutos = filter_input(INPUT_POST, 'minutos', FILTER_VALIDATE_INT);
        $user->banear($laId, $minutos);
        break;
    }

    case 6: { // Desbanear usuario
        // Solo el admin puede desbanear
        if ($_SESSION['level'] != 0) {
            echo "error";
            exit;
        }

        $laId = filter_input(INPUT_POST, 'laId', FILTER_VALIDATE_INT);
        $user->desbanear($laId);
        break;
    }

    default: {
        header("location: ../vistas/login.php");
        break;
    }
}
?>