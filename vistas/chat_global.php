<?php
include "../sec/bdd.php";
include "../sec/sec.php";
$paginaActiva = 'chat';

include "../sec/header.php";

?>

<link rel="stylesheet" href="../assets/css/chat.css">

<div class="main-container">
    <h1><i class="fas fa-globe"></i> Chat Global</h1>

    <div class="chat-container">
        <div class="chat-messages" id="chatMessages">
            <p class="text-muted" style="text-align:center;">Cargando mensajes...</p>
        </div>
        <div class="chat-input">
            <input type="text" id="mensajeInput" class="input" placeholder="Escribe un mensaje..." maxlength="500">
            <button class="btn btn-primary" id="enviarMensaje">
                <i class="fas fa-paper-plane"></i> Enviar
            </button>
        </div>
    </div>
</div>

<?php include "../sec/footer.php"; ?>

<script>
$(document).ready(function() {

    function escapeHtml(text) {
        return $('<div>').text(text).html();
    }

    var usuarioActual = '<?php echo htmlspecialchars($_SESSION["user"]); ?>';
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

    // Carga inicial — todos los mensajes
    function cargarTodo() {
        $.ajax({
            type: "post",
            url: "../controladores/controlador_chat.php",
            data: { opt: 1 },
            dataType: "json",
            success: function(mensajes) {
                if (!Array.isArray(mensajes) || mensajes.length === 0) return;
                var html = "";
                mensajes.forEach(function(msg) {
                    html += mensajeHtml(msg);
                    ultimoId = Math.max(ultimoId, parseInt(msg.id));
                });
                $("#chatMessages").html(html);
                var chatDiv = document.getElementById("chatMessages");
                chatDiv.scrollTop = chatDiv.scrollHeight;
            }
        });
    }

    // Polling — solo mensajes nuevos
    function cargarNuevos() {
        // ✅ Pausar si la pestaña no está visible
        if (document.visibilityState === 'hidden') {
            programarSiguiente(intervalo);
            return;
        }

        $.ajax({
            type: "post",
            url: "../controladores/controlador_chat.php",
            data: { opt: 6, desde_id: ultimoId },
            dataType: "json",
            success: function(mensajes) {
                if (!Array.isArray(mensajes)) return;

                if (mensajes.length > 0) {
                    // Hay mensajes nuevos — resetear intervalo a 3s
                    intervalo = 3000;
                    var chatDiv = document.getElementById("chatMessages");
                    var estaAbajo = chatDiv.scrollTop + chatDiv.clientHeight >= chatDiv.scrollHeight - 10;

                    mensajes.forEach(function(msg) {
                        $("#chatMessages").append(mensajeHtml(msg));
                        ultimoId = Math.max(ultimoId, parseInt(msg.id));
                    });

                    if (estaAbajo) chatDiv.scrollTop = chatDiv.scrollHeight;
                } else {
                    // Sin mensajes — aumentar intervalo hasta 10s
                    intervalo = Math.min(intervalo + 1000, 10000);
                }

                programarSiguiente(intervalo);
            },
            error: function() {
                programarSiguiente(10000); // En caso de error esperar 10s
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
            success: function(data) {
                if (data === "ok") {
                    $("#mensajeInput").val("");
                    // ✅ Tras enviar, cargar nuevos inmediatamente y resetear intervalo
                    intervalo = 3000;
                    clearTimeout(timer);
                    cargarNuevos();
                }
            },
            complete: function() {
                $("#enviarMensaje").prop("disabled", false);
                $("#mensajeInput").focus();
            }
        });
    }

    $("#enviarMensaje").click(enviarMensaje);
    $("#mensajeInput").keypress(function(e) {
        if (e.which === 13) enviarMensaje();
    });

    // ✅ Reanudar polling al volver a la pestaña
    document.addEventListener('visibilitychange', function() {
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