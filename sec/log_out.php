<?php

session_start();

include "bdd.php";

// AÑADIR — marcar como desconectado antes de destruir la sesión
if (isset($_SESSION["id"])) {
    $conectado = 0;
    $filt = $db->prepare("UPDATE usuarios SET conectado = ? WHERE id = ?");
    $filt->bind_param("ii", $conectado, $_SESSION["id"]);
    $filt->execute();
}

session_unset();
session_destroy();

header("location: ../vistas/login.php");

exit;

?>