<?php
include "../sec/bdd.php";
include "../sec/sec.php";

$paginaActiva = '';
$mensaje = '';
$error = '';

// Función reutilizable para validar imágenes
function validarImagenAvatar($fileKey)
{
    $extensionesPermitidas = ['jpg', 'jpeg', 'png', 'webp'];
    $tiposMime = ['image/jpeg', 'image/png', 'image/webp'];
    $ext = strtolower(pathinfo($_FILES[$fileKey]['name'], PATHINFO_EXTENSION));
    $mime = mime_content_type($_FILES[$fileKey]['tmp_name']);
    if (!in_array($ext, $extensionesPermitidas) || !in_array($mime, $tiposMime)) {
        return false;
    }
    return $ext;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // FILTER_DEFAULT en lugar de FILTER_SANITIZE_SPECIAL_CHARS (deprecado)
    $accion = trim(filter_input(INPUT_POST, 'accion', FILTER_DEFAULT) ?? '');

    if ($accion === 'actualizar_perfil') {
        $nuevo_nombre = trim(filter_input(INPUT_POST, 'nombre', FILTER_DEFAULT) ?? '');
        $nueva_bio = trim(filter_input(INPUT_POST, 'bio', FILTER_DEFAULT) ?? '');

        if (!empty($nuevo_nombre)) {
            $stmt = $db->prepare("UPDATE usuarios SET nombre = ?, bio = ? WHERE id = ?");
            $stmt->bind_param("ssi", $nuevo_nombre, $nueva_bio, $_SESSION['id']);
            $stmt->execute();
            $_SESSION['nombre'] = $nuevo_nombre;
            $mensaje = "Perfil actualizado correctamente.";
        } else {
            $error = "El nombre no puede estar vacío.";
        }
    } elseif ($accion === 'cambiar_password') {
        $pass_actual = filter_input(INPUT_POST, 'pass_actual', FILTER_DEFAULT) ?? '';
        $pass_nueva = filter_input(INPUT_POST, 'pass_nueva', FILTER_DEFAULT) ?? '';
        $pass_confirmar = filter_input(INPUT_POST, 'pass_confirmar', FILTER_DEFAULT) ?? '';

        $stmt = $db->prepare("SELECT pass FROM usuarios WHERE id = ?");
        $stmt->bind_param("i", $_SESSION['id']);
        $stmt->execute();
        $hash_actual = $stmt->get_result()->fetch_assoc()['pass'];

        if (!password_verify($pass_actual, $hash_actual)) {
            $error = "La contraseña actual es incorrecta.";
        } elseif ($pass_nueva !== $pass_confirmar) {
            $error = "Las contraseñas nuevas no coinciden.";
            // Mínimo 8 caracteres
        } elseif (strlen($pass_nueva) < 8) {
            $error = "La contraseña debe tener al menos 8 caracteres.";
        } else {
            $nuevo_hash = password_hash($pass_nueva, PASSWORD_DEFAULT);
            $stmt = $db->prepare("UPDATE usuarios SET pass = ? WHERE id = ?");
            $stmt->bind_param("si", $nuevo_hash, $_SESSION['id']);
            $stmt->execute();
            $mensaje = "Contraseña cambiada correctamente.";
        }
    } elseif ($accion === 'cambiar_avatar') {
        if (isset($_FILES['avatar']) && $_FILES['avatar']['error'] === 0) {
            // Validar extensión Y tipo MIME real
            $ext = validarImagenAvatar('avatar');
            if ($ext === false) {
                $error = "Formato de imagen no permitido. Usa JPG, PNG o WEBP.";
            } else {
                $nombre_archivo = 'avatar_' . $_SESSION['id'] . '_' . time() . '.' . $ext;
                $ruta_destino = "../assets/img/avatars/" . $nombre_archivo;

                if (move_uploaded_file($_FILES['avatar']['tmp_name'], $ruta_destino)) {
                    // Borrar avatar anterior si no es el default
                    $stmt = $db->prepare("SELECT avatar FROM usuarios WHERE id = ?");
                    $stmt->bind_param("i", $_SESSION['id']);
                    $stmt->execute();
                    $avatar_anterior = $stmt->get_result()->fetch_assoc()['avatar'];
                    if ($avatar_anterior && $avatar_anterior !== 'default.jpg' && file_exists("../assets/img/avatars/" . $avatar_anterior)) {
                        unlink("../assets/img/avatars/" . $avatar_anterior);
                    }

                    $stmt = $db->prepare("UPDATE usuarios SET avatar = ? WHERE id = ?");
                    $stmt->bind_param("si", $nombre_archivo, $_SESSION['id']);
                    $stmt->execute();
                    $_SESSION['avatar'] = $nombre_archivo;
                    $mensaje = "Avatar actualizado correctamente.";
                } else {
                    $error = "Error al subir la imagen.";
                }
            }
        } else {
            $error = "No se recibió ninguna imagen.";
        }
    } elseif ($accion === 'cambiar_idioma') {
        $nuevo_idioma = trim(filter_input(INPUT_POST, 'idioma', FILTER_DEFAULT) ?? '');
        if (in_array($nuevo_idioma, ['es', 'en'])) {
            $_SESSION['idioma'] = $nuevo_idioma;
            $stmt = $db->prepare("UPDATE usuarios SET idioma = ? WHERE id = ?");
            $stmt->bind_param("si", $nuevo_idioma, $_SESSION['id']);
            $stmt->execute();
            $mensaje = "Idioma cambiado correctamente.";
        } else {
            $error = "Idioma no válido.";
        }
    } elseif ($accion === 'toggle_perfil_publico') {
        // Admin no puede tener perfil público
        if ($_SESSION['level'] == 0) {
            $error = "Los administradores no pueden tener perfil público.";
        } else {
            $valor = isset($_POST['perfil_publico']) ? 1 : 0;
            $stmt = $db->prepare("UPDATE usuarios SET perfil_publico = ? WHERE id = ?");
            $stmt->bind_param("ii", $valor, $_SESSION['id']);
            $stmt->execute();
            $mensaje = $valor ? "Tu perfil ahora es público." : "Tu perfil ahora es privado.";
        }
    }
}

// SELECT solo campos necesarios, sin traer la contraseña
$stmt = $db->prepare("SELECT nombre, email, avatar, bio, idioma, perfil_publico FROM usuarios WHERE id = ?");
$stmt->bind_param("i", $_SESSION['id']);
$stmt->execute();
$usuario = $stmt->get_result()->fetch_assoc();

include "../sec/header.php";
?>

<div class="main-container">
    <h1><i class="fas fa-cog"></i> <?= $idioma->palabras->header_ajustes ?></h1>

    <?php if ($mensaje): ?>
        <div class="alert alert-success"><?= htmlspecialchars($mensaje) ?></div>
    <?php endif; ?>
    <?php if ($error): ?>
        <div class="alert alert-danger"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>

    <div class="ajustes-grid">

        <!-- Perfil -->
        <div class="card">
            <div class="card-body">
                <h3><i class="fas fa-user-edit"></i> <?= $idioma->palabras->ajustes_perfil_titulo ?></h3>
                <form method="post">
                    <input type="hidden" name="accion" value="actualizar_perfil">
                    <div class="form-group">
                        <label><?= $idioma->palabras->ajustes_nombre ?></label>
                        <input type="text" name="nombre" class="input"
                            value="<?= htmlspecialchars($usuario['nombre']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label><?= $idioma->palabras->ajustes_bio ?></label>
                        <textarea name="bio" class="input"
                            rows="3"><?= htmlspecialchars($usuario['bio'] ?? '') ?></textarea>
                    </div>
                    <button type="submit"
                        class="btn btn-primary"><?= $idioma->palabras->ajustes_guardar_cambios ?></button>
                </form>
            </div>
        </div>

        <!-- Contraseña -->
        <div class="card">
            <div class="card-body">
                <h3><i class="fas fa-lock"></i> <?= $idioma->palabras->ajustes_pass_titulo ?></h3>
                <form method="post">
                    <input type="hidden" name="accion" value="cambiar_password">
                    <div class="form-group">
                        <label><?= $idioma->palabras->ajustes_pass_actual ?></label>
                        <input type="password" name="pass_actual" class="input" required>
                    </div>
                    <div class="form-group">
                        <label><?= $idioma->palabras->ajustes_pass_nueva ?></label>
                        <input type="password" name="pass_nueva" class="input" required minlength="8">
                    </div>
                    <div class="form-group">
                        <label><?= $idioma->palabras->ajustes_pass_confirmar ?></label>
                        <input type="password" name="pass_confirmar" class="input" required minlength="8">
                    </div>
                    <button type="submit"
                        class="btn btn-primary"><?= $idioma->palabras->ajustes_pass_cambiar ?></button>
                </form>
            </div>
        </div>

        <!-- Avatar -->
        <div class="card">
            <div class="card-body">
                <h3><i class="fas fa-image"></i> <?= $idioma->palabras->ajustes_avatar_titulo ?></h3>
                <p><?= $idioma->palabras->ajustes_avatar_actual ?>:</p>
                <img src="../assets/img/avatars/<?= htmlspecialchars($usuario['avatar'] ?? 'default.jpg') ?>"
                    alt="Avatar" style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover;"
                    onerror="this.src='../assets/img/avatars/default.jpg'">
                <form method="post" enctype="multipart/form-data" style="margin-top: 15px;">
                    <input type="hidden" name="accion" value="cambiar_avatar">
                    <div class="form-group">
                        <input type="file" name="avatar" class="input" accept=".jpg,.jpeg,.png,.webp">
                    </div>
                    <button type="submit"
                        class="btn btn-primary"><?= $idioma->palabras->ajustes_avatar_subir ?></button>
                </form>
            </div>
        </div>

        <!-- Idioma -->
        <div class="card">
            <div class="card-body">
                <h3><i class="fas fa-language"></i> <?= $idioma->palabras->ajustes_idioma_titulo ?></h3>
                <form method="post">
                    <input type="hidden" name="accion" value="cambiar_idioma">
                    <div class="form-group">
                        <label><?= $idioma->palabras->ajustes_idioma_seleccionar ?></label>
                        <select name="idioma" class="input">
                            <option value="es" <?= ($_SESSION['idioma'] ?? 'es') === 'es' ? 'selected' : '' ?>>Español
                            </option>
                            <option value="en" <?= ($_SESSION['idioma'] ?? 'es') === 'en' ? 'selected' : '' ?>>English
                            </option>
                        </select>
                    </div>
                    <button type="submit"
                        class="btn btn-primary"><?= $idioma->palabras->ajustes_idioma_cambiar ?></button>
                </form>
            </div>
        </div>

        <!-- Privacidad -->
        <?php if ($_SESSION['level'] != 0): ?>
            <div class="card">
                <div class="card-body">
                    <h3><i class="fas fa-eye"></i> <?= $idioma->palabras->ajustes_privacidad_titulo ?></h3>
                    <form method="post">
                        <input type="hidden" name="accion" value="toggle_perfil_publico">
                        <div class="form-group" style="display:flex; align-items:center; gap: var(--spacing-md);">
                            <input type="checkbox" name="perfil_publico" id="perfilPublico" <?= $usuario['perfil_publico'] ? 'checked' : '' ?>>
                            <label for="perfilPublico" style="margin:0;">
                                <?= $idioma->palabras->ajustes_perfil_publico_label ?>
                            </label>
                        </div>
                        <button type="submit"
                            class="btn btn-primary"><?= $idioma->palabras->ajustes_guardar_cambios ?></button>
                    </form>
                </div>
            </div>
        <?php endif; ?>
    </div>
</div>

<?php include "../sec/footer.php"; ?>