<?php
$db = new mysqli("localhost", "root", "", "nextlevelcodex", 3306);
mysqli_query($db, "SET NAMES 'utf8mb4'");
$base = mysqli_select_db($db, "nextlevelcodex");
?>