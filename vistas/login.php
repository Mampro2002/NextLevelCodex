<?php
$minutosBan = isset($_GET['ban']) ? (int)$_GET['ban'] : 0;
$errorLogin = isset($_GET['error']) ? (int)$_GET['error'] : 0;
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Next Level Codex - Login</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Poppins:wght@600;700&family=Roboto+Mono&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../assets/css/main.css">
    <link rel="stylesheet" href="../assets/css/components.css">
    <link rel="stylesheet" href="../assets/css/layout.css">
    <script src="../assets/js/tema.js"></script>

    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        .login-container {
            max-width: 400px;
            width: 100%;
        }
        .card {
            padding: var(--spacing-xl);
        }
        .form-group {
            margin-bottom: var(--spacing-md);
        }
        .form-group label {
            display: block;
            margin-bottom: var(--spacing-xs);
            color: var(--text-secondary);
            font-size: 14px;
        }
        .theme-toggle-container {
            position: fixed;
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body>
    <div class="theme-toggle-container">
        <button class="theme-toggle" onclick="toggleTheme()">
            <i class="fas fa-sun"></i>
        </button>
    </div>

    <div class="login-container">
        <div class="logo" style="text-align: center; margin-bottom: var(--spacing-lg);">
            Next Level <span>Codex</span>
        </div>

        <!-- ✅ Feedback de ban -->
        <?php if ($minutosBan > 0): ?>
            <div class="card" style="margin-bottom: var(--spacing-md); background-color: var(--danger); color: white;">
                ⛔ Usuario baneado. Tiempo restante: <?php echo $minutosBan; ?> minutos.
            </div>
        <?php endif; ?>

        <!-- ✅ Feedback de error de login -->
        <?php if ($errorLogin): ?>
            <div class="card" style="margin-bottom: var(--spacing-md); background-color: var(--danger); color: white;">
                ❌ Usuario o contraseña incorrectos.
            </div>
        <?php endif; ?>

        <!-- Formulario Login -->
        <div id="log" class="card">
            <h2 style="margin-bottom: var(--spacing-lg);">Iniciar Sesión</h2>
            <form method="post" action="../index.php">
                <div class="form-group">
                    <label>Usuario o Email</label>
                    <input type="text" name="user" class="input" required autocomplete="username">
                </div>
                <div class="form-group">
                    <label>Contraseña</label>
                    <input type="password" name="password" class="input" required autocomplete="current-password">
                </div>
                <div class="form-group">
                    <label>Idioma</label>
                    <select name="idioma" class="input">
                        <option value="es" selected>Español</option>
                        <option value="en">English</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%;">Iniciar Sesión</button>
            </form>
        </div>

        <!-- Botón Registro -->
        <div id="registroButton" style="margin-top: var(--spacing-md); text-align: center;">
            <button class="btn" id="btnMostrarRegistro">Crear una cuenta</button>
        </div>

        <!-- Formulario Registro -->
        <div id="registro" class="card" style="display: none;">
            <h2 style="margin-bottom: var(--spacing-lg);">Registrarse</h2>
            <div id="errorRegistro" style="display:none; color: var(--danger); margin-bottom: var(--spacing-md);"></div>
            <form id="formRegistro">
                <div class="form-group">
                    <label>Nombre</label>
                    <input type="text" id="nombre" class="input" required maxlength="20">
                </div>
                <div class="form-group">
                    <label>Usuario</label>
                    <input type="text" id="usuario" class="input" required maxlength="20">
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" id="email" class="input" required maxlength="100">
                </div>
                <div class="form-group">
                    <label>Contraseña (mín. 8 caracteres)</label>
                    <!-- ✅ SEGURIDAD: mínimo 8 caracteres -->
                    <input type="password" id="pass" class="input" required minlength="8">
                </div>
                <div class="form-group">
                    <label>Idioma</label>
                    <select id="idioma_registro" class="input">
                        <option value="es" selected>Español</option>
                        <option value="en">English</option>
                    </select>
                </div>
                <button type="button" id="enviarRegistro" class="btn btn-primary" style="width: 100%;">Registrarse</button>
            </form>
        </div>

        <!-- Botón Atrás -->
        <div id="Atras" style="display: none; margin-top: var(--spacing-md); text-align: center;">
            <button class="btn" id="btnAtras">← Volver al login</button>
        </div>
    </div>

    <!-- ✅ jQuery al final del body, no en el head -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
    $(document).ready(function() {

        // Mostrar formulario de registro
        $("#btnMostrarRegistro").click(function() {
            $("#log").hide();
            $("#registro").show();
            $("#registroButton").hide();
            $("#Atras").show();
        });

        // Volver al login
        $("#btnAtras").click(function() {
            $("#log").show();
            $("#registro").hide();
            $("#Atras").hide();
            $("#registroButton").show();
            $("#errorRegistro").hide();
        });

        // Enviar registro
        $("#enviarRegistro").click(function() {
            var nombre  = $("#nombre").val().trim();
            var usuario = $("#usuario").val().trim();
            var email   = $("#email").val().trim();
            var pass    = $("#pass").val();
            var idioma  = $("#idioma_registro").val();

            // ✅ Validación en el cliente antes de enviar
            if (!nombre || !usuario || !email || !pass) {
                $("#errorRegistro").text("Todos los campos son obligatorios.").show();
                return;
            }
            if (pass.length < 8) {
                $("#errorRegistro").text("La contraseña debe tener al menos 8 caracteres.").show();
                return;
            }

            $("#enviarRegistro").prop("disabled", true);

            $.ajax({
                type: "post",
                url: "../controladores/control_users.php",
                data: { options: 3, nombre, usuario, email, pass, idioma },
                success: function(data) {
                    data = data.trim();
                    if (data === "rellenos")  $("#errorRegistro").text("Todos los datos deben estar rellenos.").show();
                    else if (data === "existe")   $("#errorRegistro").text("Este usuario o email ya existe.").show();
                    else if (data === "extenso")  $("#errorRegistro").text("Máximo 20 caracteres por campo.").show();
                    else if (data === "ok")        window.location.href = "../index.php";
                    else $("#errorRegistro").text("Error inesperado. Inténtalo de nuevo.").show();
                },
                error: function() {
                    $("#errorRegistro").text("Error de conexión con el servidor.").show();
                },
                complete: function() {
                    $("#enviarRegistro").prop("disabled", false);
                }
            });
        });
    });
    </script>
</body>
</html>