<?php
include "../sec/bdd.php";
include "../sec/sec.php";
$paginaActiva = 'chat';

// ✅ SEGURIDAD: Validar ID del otro usuario
$otro_id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if (!$otro_id || $otro_id === $_SESSION['id']) {
    header("location: centro_colaboradores.php");
    exit;
}

$filt = $db->prepare("SELECT id, user, nombre FROM usuarios WHERE id = ?");
$filt->bind_param("i", $otro_id);
$filt->execute();
$otro = $filt->get_result()->fetch_assoc();

if (!$otro) {
    header("location: centro_colaboradores.php");
    exit;
}

include "../sec/header.php";

?>

<!-- CSS específico del chat -->
<link rel="stylesheet" href="../assets/css/chat.css">

<div class="main-container">
    <a href="centro_colaboradores.php" class="btn" style="margin-bottom: var(--spacing-md);">
        <i class="fas fa-arrow-left"></i> <?= $idioma->palabras->pj_volver ?>
    </a>
    <h1><i class="fas fa-comment"></i> <?= $idioma->palabras->chat_privado_con ?>
        <?= htmlspecialchars($otro['nombre']) ?>
    </h1>

    <div class="chat-container">
        <div class="chat-messages" id="chatMessages">
            <p class="text-muted" style="text-align:center;"><?= $idioma->palabras->pj_cargando ?></p>
        </div>
        <div class="chat-input">
            <input type="text" id="mensajeInput" class="input"
                placeholder="<?= $idioma->palabras->chat_privado_placeholder ?>" maxlength="500">
            <button class="btn btn-primary" id="enviarMensaje">
                <i class="fas fa-paper-plane"></i> <?= $idioma->palabras->chat_privado_enviar ?>
            </button>
        </div>
    </div>
</div>

<?php include "../sec/footer.php"; ?>

<script>
    // Traducciones pasadas desde PHP
    var chatPrivadoMsg = {
        tu: '<?= addslashes($idioma->palabras->chat_privado_tu) ?>',
        sinMensajes: '<?= addslashes($idioma->palabras->chat_privado_sin_mensajes) ?>',
        errorCargar: '<?= addslashes($idioma->palabras->chat_privado_error_cargar) ?>',
        errorEnviar: '<?= addslashes($idioma->palabras->chat_privado_error_enviar) ?>'
    };

    $(document).ready(function () {

        function escapeHtml(text) {
            return $('<div>').text(text).html();
        }

        var otroId = <?= (int) $otro_id; ?>;
        var usuarioActual = '<?= htmlspecialchars($_SESSION["user"]); ?>';
        var ultimoId = 0;
        var intervalo = 3000;
        var timer = null;

        function mensajeHtml(msg) {
            var esPropio = (msg.emisor_user === usuarioActual);
            return '<div class="message ' + (esPropio ? 'own' : '') + '">' +
                '<div class="message-header">' +
                '<span class="message-user">' + (esPropio ? chatPrivadoMsg.tu : escapeHtml(msg.emisor_nombre)) + '</span>' +
                '<span class="message-time">' + escapeHtml(msg.fecha) + '</span>' +
                '</div>' +
                '<div class="message-text">' + escapeHtml(msg.mensaje) + '</div>' +
                '</div>';
        }

        function cargarTodo() {
            $.ajax({
                type: "post",
                url: "../controladores/controlador_chat.php",
                data: { opt: 3, otro: otroId },
                dataType: "json",
                success: function (mensajes) {
                    if (!Array.isArray(mensajes)) return;
                    var html = "";
                    mensajes.forEach(function (msg) {
                        html += mensajeHtml(msg);
                        ultimoId = Math.max(ultimoId, parseInt(msg.id));
                    });
                    $("#chatMessages").html(html || '<p class="text-muted" style="text-align:center;">' + chatPrivadoMsg.sinMensajes + '</p>');
                    var chatDiv = document.getElementById("chatMessages");
                    chatDiv.scrollTop = chatDiv.scrollHeight;
                },
                error: function () {
                    $("#chatMessages").html('<p class="text-danger" style="text-align:center;">' + chatPrivadoMsg.errorCargar + '</p>');
                }
            });
        }

        function cargarNuevos() {
            if (document.visibilityState === 'hidden') {
                programarSiguiente(intervalo);
                return;
            }

            $.ajax({
                type: "post",
                url: "../controladores/controlador_chat.php",
                data: { opt: 7, otro: otroId, desde_id: ultimoId },
                dataType: "json",
                success: function (mensajes) {
                    if (!Array.isArray(mensajes)) return;

                    if (mensajes.length > 0) {
                        intervalo = 3000;
                        var chatDiv = document.getElementById("chatMessages");
                        var estaAbajo = chatDiv.scrollTop + chatDiv.clientHeight >= chatDiv.scrollHeight - 10;

                        mensajes.forEach(function (msg) {
                            $("#chatMessages").append(mensajeHtml(msg));
                            ultimoId = Math.max(ultimoId, parseInt(msg.id));
                        });

                        if (estaAbajo) chatDiv.scrollTop = chatDiv.scrollHeight;
                    } else {
                        intervalo = Math.min(intervalo + 1000, 10000);
                    }

                    programarSiguiente(intervalo);
                },
                error: function () {
                    programarSiguiente(10000);
                }
            });
        }

        function programarSiguiente(ms) {
            clearTimeout(timer);
            timer = setTimeout(cargarNuevos, ms);
        }

        function enviarMensaje() {
            var mensaje = $("#mensajeInput").val().trim();
            if (mensaje === "") return;

            $("#enviarMensaje").prop("disabled", true);

            $.ajax({
                type: "post",
                url: "../controladores/controlador_chat.php",
                data: { opt: 4, receptor: otroId, mensaje: mensaje },
                success: function (data) {
                    if (data === "ok") {
                        $("#mensajeInput").val("");
                        intervalo = 3000;
                        clearTimeout(timer);
                        cargarNuevos();
                    }
                },
                error: function () {
                    alert(chatPrivadoMsg.errorEnviar);
                },
                complete: function () {
                    $("#enviarMensaje").prop("disabled", false);
                    $("#mensajeInput").focus();
                }
            });
        }

        $("#enviarMensaje").click(enviarMensaje);

        $("#mensajeInput").keypress(function (e) {
            if (e.which === 13) enviarMensaje();
        });

        document.addEventListener('visibilitychange', function () {
            if (document.visibilityState === 'visible') {
                intervalo = 3000;
                clearTimeout(timer);
                cargarNuevos();
            }
        });

        cargarTodo();
        programarSiguiente(intervalo);
    });
</script>