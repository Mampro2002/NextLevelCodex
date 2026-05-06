<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

include "bdd.php";

if (!isset($_SESSION["user"])) {

    $user = trim(filter_input(INPUT_POST, 'user', FILTER_DEFAULT) ?? '');
    $pass = filter_input(INPUT_POST, 'password', FILTER_DEFAULT) ?? '';

    if (empty($user) || empty($pass)) {
        header("location: ../vistas/login.php");
        exit;
    }

    $filt = $db->prepare("SELECT * FROM usuarios WHERE user = ? OR email = ?");
    $filt->bind_param('ss', $user, $user);
    $filt->execute();
    $vec = $filt->get_result()->fetch_assoc();

    
    if (!$vec || !password_verify($pass, $vec['pass'])) {
        header("location: ../vistas/login.php?error=1");
        exit;
    }

    if ($vec['ban_hasta'] && strtotime($vec['ban_hasta']) > time()) {
        $minutos = ceil((strtotime($vec['ban_hasta']) - time()) / 60);
        header("location: ../vistas/login.php?ban=" . $minutos);
        exit;
    }

    // ✅ Guardar todos los datos necesarios en sesión, incluyendo avatar e idioma
    $_SESSION["id"]            = $vec["id"];
    $_SESSION["user"]          = $vec["user"];
    $_SESSION["email"]         = $vec["email"];
    $_SESSION["level"]         = $vec["level"];
    $_SESSION["nombre"]        = $vec["nombre"];
    $_SESSION["avatar"]        = $vec["avatar"] ?? 'default.jpg';
    $_SESSION["idioma"]        = $vec["idioma"] ?? 'es';
    $_SESSION["ultimo_acceso"] = time();

    // Actualizar última conexión
    $conectado = 1;
    $upd = $db->prepare("UPDATE usuarios SET ultima_conexion = NOW(), conectado = ? WHERE id = ?");
    $upd->bind_param("ii", $conectado, $vec["id"]);
    $upd->execute();
}

if (!isset($_SESSION["id"]) || !isset($_SESSION["level"])) {
    session_destroy();
    header("location: ../vistas/login.php");
    exit;
}
?>