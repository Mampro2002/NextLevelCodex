<?php
include "../sec/bdd.php";
include "../sec/sec.php";
$paginaActiva = 'chat';

include "../sec/header.php";

?>

<link rel="stylesheet" href="../assets/css/chat.css">

<div class="main-container">
    <h1><i class="fas fa-globe"></i> <?= $idioma->palabras->chat_global_titulo ?></h1>

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
    var chatGlobalMsg = {
        errorEnviar: '<?= addslashes($idioma->palabras->chat_privado_error_enviar) ?>'
    };

    $(document).ready(function () {

        function escapeHtml(text) {
            return $('<div>').text(text).html();
        }

        var usuarioActual = '<?= htmlspecialchars($_SESSION["user"]); ?>';
        var ultimoId = 0;
        var intervalo = 3000;
        var timer = null;

        function mensajeHtml(msg) {
            var esPropio = (msg.user === usuarioActual);
            return '<div class="message ' + (esPropio ? 'own' : '') + '">' +
                '<div class="message-header">' +
                '<span class="message-user">' + escapeHtml(msg.nombre) + ' (@' + escapeHtml(msg.user) + ')</span>' +
                '<span class="message-time">' + escapeHtml(msg.fecha) + '</span>' +
                '</div>' +
                '<div class="message-text">' + escapeHtml(msg.mensaje) + '</div>' +
                '</div>';
        }

        function cargarTodo() {
            $.ajax({
                type: "post",
                url: "../controladores/controlador_chat.php",
                data: { opt: 1 },
                dataType: "json",
                success: function (mensajes) {
                    if (!Array.isArray(mensajes) || mensajes.length === 0) return;
                    var html = "";
                    mensajes.forEach(function (msg) {
                        html += mensajeHtml(msg);
                        ultimoId = Math.max(ultimoId, parseInt(msg.id));
                    });
                    $("#chatMessages").html(html);
                    var chatDiv = document.getElementById("chatMessages");
                    chatDiv.scrollTop = chatDiv.scrollHeight;
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
                data: { opt: 6, desde_id: ultimoId },
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
                data: { opt: 2, mensaje: mensaje },
                success: function (data) {
                    if (data === "ok") {
                        $("#mensajeInput").val("");
                        intervalo = 3000;
                        clearTimeout(timer);
                        cargarNuevos();
                    }
                },
                error: function () {
                    alert(chatGlobalMsg.errorEnviar);
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