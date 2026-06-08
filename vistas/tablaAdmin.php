<?php
include "../sec/bdd.php";
include "../sec/sec.php";

if (!isset($_SESSION["user"]) || !isset($_SESSION["level"])) {
    echo "Acceso no autorizado";
    exit;
}

$idioma = simplexml_load_file("../assets/locales/" . $_SESSION["idioma"] . ".xml");

// Variables de idioma para JavaScript
$js_minutosBan = addslashes((string) $idioma->palabras->admin_minutosBan);
$js_baneado = addslashes((string) $idioma->palabras->admin_baneado);
$js_desbaneado = addslashes((string) $idioma->palabras->admin_desbaneado);

if ($_SESSION["level"] == 0) {
    ?>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../../assets/css/admin_panel.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <title><?php echo $idioma->palabras->caption ?></title>
    </head>

    <body>
        <div class="admin-panel">
            <table>
                <caption><?php echo $idioma->palabras->caption ?></caption>
                <thead>
                    <tr>
                        <th><?php echo $idioma->palabras->th1 ?></th>
                        <th><?php echo $idioma->palabras->th2 ?></th>
                        <th><?php echo $idioma->palabras->th3 ?></th>
                        <th><?php echo $idioma->palabras->th4 ?></th>
                        <th><?php echo $idioma->palabras->th5 ?></th>
                        <th><?php echo $idioma->palabras->th6 ?></th>
                        <th>Email</th>
                        <th><?php echo $idioma->palabras->th7 ?></th>
                        <th><?php echo $idioma->palabras->baneo2 ?></th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $filt = $db->prepare("SELECT * FROM usuarios");
                    $filt->execute();
                    $res = $filt->get_result();
                    for ($i = 0; $i < $res->num_rows; $i++) {
                        $vec = $res->fetch_assoc();
                        ?>
                        <tr>
                            <td><input type="checkbox" laId="<?php echo $vec["id"] ?>" class="check"></td>
                            <td><?php echo $vec["id"]; ?></td>
                            <td><?php echo $vec["user"]; ?></td>
                            <td>
                                <input type="password" value=""
                                    placeholder="<?php echo htmlspecialchars((string) $idioma->palabras->admin_dejarVacio) ?>"
                                    id="pass_<?php echo $vec["id"] ?>">
                            </td>
                            <td><input value="<?php echo $vec["nombre"] ?>" id="nombre_<?php echo $vec["id"] ?>"></td>
                            <td><input type="number" value="<?php echo $vec["level"] ?>" id="level_<?php echo $vec["id"] ?>">
                            </td>
                            <td><input type="email" value="<?php echo $vec["email"] ?>" id="email_<?php echo $vec["id"] ?>">
                            </td>
                            <td>
                                <button type="submit" laId="<?php echo $vec["id"] ?>" class="btn_update">
                                    <?php echo $idioma->palabras->boton1 ?>
                                </button>
                            </td>
                            <td>
                                <?php if ($vec["ban_hasta"] && strtotime($vec["ban_hasta"]) > time()): ?>
                                    <button class="btn_desban" laId="<?php echo $vec["id"] ?>">
                                        <a><?php echo $idioma->palabras->baneo ?></a>
                                    </button>
                                <?php else: ?>
                                    <button class="btn_ban" laId="<?php echo $vec["id"] ?>">
                                        <a><?php echo $idioma->palabras->baneo2 ?></a>
                                    </button>
                                <?php endif; ?>
                            </td>
                        </tr>
                    <?php } ?>
                </tbody>
            </table>

            <div class="actions-bar">
                <button id="Borrar" type="submit"><a><?php echo $idioma->palabras->boton2 ?></a></button>
                <button id="Añadir" type="submit"><a><?php echo $idioma->palabras->boton3 ?></a></button>
            </div>
        </div>

    <?php } ?>

</body>

<script>
    $("#Borrar").click(function () {
        let ids = [];
        let options = 2;
        $(".check").each(function () {
            if ($(this).is(":checked")) {
                ids.push($(this).attr("laId"));
            }
        });
        if (!confirm("<?php echo $idioma->palabras->t1 ?>")) return;
        for (var i = 0; i < ids.length; i++) {
            $.ajax({
                type: "post",
                url: "/NextLevelCodex/controladores/control_users.php",
                data: { laId: ids[i], options },
                success: function (data) {
                    if (data == "level 0") alert("<?php echo $idioma->palabras->t2 ?>");
                    if (data == "admin") alert("<?php echo $idioma->palabras->t3 ?>");
                    if (data == "borrado") alert("<?php echo $idioma->palabras->t4 ?>");
                    location.reload();
                }
            });
        }
    });

    $(".btn_update").click(function () {
        let laId = $(this).attr("laId");
        let name = $("#nombre_" + laId).val();
        let pass = $("#pass_" + laId).val();
        let level = $("#level_" + laId).val();
        let email = $("#email_" + laId).val();
        let options = 1;
        $.ajax({
            type: "post",
            url: "/NextLevelCodex/controladores/control_users.php",
            data: { options, id: laId, nombre: name, pass: pass, level: level, email: email },
            success: function (data) {
                if (data == "0 level") alert("<?php echo $idioma->palabras->t5 ?>");
                if (data == "rellenos") alert("<?php echo $idioma->palabras->t6 ?>");
                if (data == "solo") alert("<?php echo $idioma->palabras->t7 ?>");
                if (data == "extenso") alert("<?php echo $idioma->palabras->t8 ?>");
                location.reload();
            }
        });
    });

    $("#Añadir").click(function () {
        let user = prompt("<?php echo $idioma->palabras->t9 ?>");
        let name = prompt("<?php echo $idioma->palabras->t10 ?>");
        let pass = prompt("<?php echo $idioma->palabras->t11 ?>");
        let level = prompt("<?php echo $idioma->palabras->t12 ?>");
        let email = prompt("<?php echo $idioma->palabras->t13 ?>");
        let options = 4;
        $.ajax({
            type: "post",
            url: "/NextLevelCodex/controladores/control_users.php",
            data: { options, user: user, nombre: name, pass: pass, level: level, email: email },
            success: function (data) {
                if (data == "rellenos") alert("<?php echo $idioma->palabras->t6 ?>");
                if (data == "añadir") alert("<?php echo $idioma->palabras->t14 ?>");
                if (data == "solo") alert("<?php echo $idioma->palabras->t7 ?>");
                if (data == "existe") alert("<?php echo $idioma->palabras->t15 ?>");
                if (data == "extenso") alert("<?php echo $idioma->palabras->t16 ?>");
                if (data == "email") alert("<?php echo $idioma->palabras->t17 ?>");
                location.reload();
            }
        });
    });

    $(".btn_ban").click(function () {
        let laId = $(this).attr("laId");
        let minutos = prompt('<?= $js_minutosBan ?>');
        if (!minutos || isNaN(minutos)) return;
        $.ajax({
            type: "post",
            url: "/NextLevelCodex/controladores/control_users.php",
            data: { laId: laId, minutos: minutos, options: 5 },
            success: function (data) {
                if (data == "baneado") alert('<?= $js_baneado ?>');
                location.reload();
            }
        });
    });

    $(".btn_desban").click(function () {
        let laId = $(this).attr("laId");
        $.ajax({
            type: "post",
            url: "/NextLevelCodex/controladores/control_users.php",
            data: { laId: laId, options: 6 },
            success: function (data) {
                if (data == "desbaneado") alert('<?= $js_desbaneado ?>');
                location.reload();
            }
        });
    });
</script>

</html>