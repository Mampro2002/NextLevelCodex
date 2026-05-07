<?php
include "../sec/bdd.php";
include "../sec/sec.php";
$paginaActiva = '';

// ✅ Obtener ID del usuario a ver
$id_visto = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if (!$id_visto) {
    header("location: ../index.php");
    exit;
}

// ✅ Si intenta ver su propio perfil, redirigir a perfil.php
if ($id_visto === $_SESSION['id']) {
    header("location: perfil.php");
    exit;
}

// ✅ Obtener datos del usuario a ver
$stmt = $db->prepare("SELECT id, user, nombre, avatar, bio, conectado, perfil_publico, level, amigos FROM usuarios WHERE id = ?");
$stmt->bind_param("i", $id_visto);
$stmt->execute();
$usuario = $stmt->get_result()->fetch_assoc();

if (!$usuario) {
    header("location: ../index.php");
    exit;
}

// ✅ Determinar relación entre el visitante y el perfil
$esAdmin = ($_SESSION['level'] == 0);

// Obtener amigos actualizados desde BD
$stmtAmigos = $db->prepare("SELECT amigos FROM usuarios WHERE id = ?");
$stmtAmigos->bind_param("i", $_SESSION['id']);
$stmtAmigos->execute();
$rowAmigos = $stmtAmigos->get_result()->fetch_assoc();
$misAmigos = !empty($rowAmigos['amigos']) ? array_filter(explode('#', $rowAmigos['amigos'])) : [];
$esColaborador = in_array($id_visto, $misAmigos);

if ($usuario['level'] == 0 && !$esColaborador) {
    header("location: ../index.php");
    exit;
}

// ✅ Consulta de solicitud enviada (con estado y fecha)
$stmtSolEnviada = $db->prepare("SELECT statu, fecha FROM domingueros WHERE id_sol = ? AND id_rec = ?");
$stmtSolEnviada->bind_param("ii", $_SESSION['id'], $id_visto);
$stmtSolEnviada->execute();
$solicitudResult = $stmtSolEnviada->get_result();
$solicitudData = $solicitudResult->fetch_assoc();
$solicitudEnviada = ($solicitudResult->num_rows > 0 && $solicitudData['statu'] == 1);
$solicitudRechazada = ($solicitudResult->num_rows > 0 && $solicitudData['statu'] == 0);

// ¿Hay solicitud pendiente de él hacia mí?
$stmtSolRecibida = $db->prepare("SELECT COUNT(*) AS total FROM domingueros WHERE id_sol = ? AND id_rec = ? AND statu = 1");
$stmtSolRecibida->bind_param("ii", $id_visto, $_SESSION['id']);
$stmtSolRecibida->execute();
$solicitudRecibida = $stmtSolRecibida->get_result()->fetch_assoc()['total'] > 0;

// ✅ ¿Puede ver el perfil completo?
$puedeVer = $esAdmin || $esColaborador || $usuario['perfil_publico'] == 1;

// ✅ Obtener datos extra solo si puede ver
$favoritos = [];
$juegosAnadidos = [];

if ($puedeVer) {
    // Juegos favoritos
    $stmtFav = $db->prepare("
    SELECT j.id, j.titulo, j.portada, j.desarrollador
    FROM favoritos f
    JOIN juegos j ON f.id_juego = j.id
    WHERE f.id_usuario = ?
    ORDER BY f.fecha DESC
    LIMIT 6
    ");
    $stmtFav->bind_param("i", $id_visto);
    $stmtFav->execute();
    $favoritos = $stmtFav->get_result()->fetch_all(MYSQLI_ASSOC);

    // Juegos añadidos
    $stmtJuegos = $db->prepare("
        SELECT id, titulo, portada, desarrollador, fecha_creacion
        FROM juegos
        WHERE creador_id = ?
        ORDER BY fecha_creacion DESC
        LIMIT 6
    ");
    $stmtJuegos->bind_param("i", $id_visto);
    $stmtJuegos->execute();
    $juegosAnadidos = $stmtJuegos->get_result()->fetch_all(MYSQLI_ASSOC);
}

include "../sec/header.php";
?>

<div class="main-container">

    <!-- Cabecera del perfil -->
    <div class="perfil-header">
        <img src="../assets/img/avatars/<?php echo htmlspecialchars($usuario['avatar'] ?: 'default.jpg'); ?>"
            alt="Avatar" class="perfil-avatar" onerror="this.src='../assets/img/avatars/default.jpg'">
        <div class="perfil-info">
            <h1>
                <?php echo htmlspecialchars($usuario['nombre']); ?>
            </h1>
            <p class="text-muted">@
                <?php echo htmlspecialchars($usuario['user']); ?>
            </p>

            <!-- Estado de conexión -->
            <?php if ($usuario['conectado'] == 1): ?>
                <span style="color: var(--success);"><i class="fas fa-circle"></i> Conectado</span>
            <?php else: ?>
                <span class="text-muted"><i class="far fa-circle"></i> Desconectado</span>
            <?php endif; ?>

            <!-- Bio (solo si puede ver) -->
            <?php if ($puedeVer): ?>
                <?php if (!empty($usuario['bio'])): ?>
                    <p class="perfil-bio" style="margin-top: var(--spacing-sm);">
                        <?php echo nl2br(htmlspecialchars($usuario['bio'])); ?>
                    </p>
                <?php else: ?>
                    <p class="text-muted"><em>Sin biografía.</em></p>
                <?php endif; ?>
            <?php else: ?>
                <p class="text-muted" style="margin-top: var(--spacing-sm);">
                    <i class="fas fa-lock"></i> Este perfil es privado.
                </p>
            <?php endif; ?>

            <!-- Botones de acción -->
            <div style="margin-top: var(--spacing-md); display: flex; gap: var(--spacing-sm); flex-wrap: wrap;">
                <?php if ($esColaborador): ?>
                    <a href="chat_privado.php?id=<?php echo $id_visto; ?>" class="btn btn-primary">
                        <i class="fas fa-comment"></i> Chat privado
                    </a>
                    <button class="btn btn-danger" onclick="eliminarColaborador(<?php echo $id_visto; ?>)">
                        <i class="fas fa-user-minus"></i> Eliminar colaborador
                    </button>
                <?php elseif ($solicitudRecibida): ?>
                    <button class="btn btn-success" onclick="aceptarSolicitud(<?php echo $id_visto; ?>)">
                        <i class="fas fa-check"></i> Aceptar solicitud
                    </button>
                    <button class="btn btn-danger" onclick="rechazarSolicitud(<?php echo $id_visto; ?>)">
                        <i class="fas fa-times"></i> Rechazar
                    </button>
                <?php elseif ($solicitudRechazada): ?>
                    <?php
                    $diff = time() - $solicitudData['fecha'];
                    $segundos_15_dias = 15 * 24 * 60 * 60;
                    if ($diff <= $segundos_15_dias) {
                        $tiempo_restante = $segundos_15_dias - $diff;
                        $dias = floor($tiempo_restante / (24 * 60 * 60));
                        $horas = floor(($tiempo_restante % (24 * 60 * 60)) / 3600);
                        ?>
                        <span class="text-muted" style="font-size: 14px;">
                            <i class="fas fa-clock"></i> Solicitud rechazada<br>
                            Disponible en <?= $dias ?>d <?= $horas ?>h
                        </span>
                    <?php } else { ?>
                        <button class="btn btn-primary" id="btnSolicitud" onclick="enviarSolicitud(<?php echo $id_visto; ?>)">
                            <i class="fas fa-user-plus"></i> Enviar solicitud
                        </button>
                    <?php } ?>
                <?php elseif ($solicitudEnviada): ?>
                    <button class="btn btn-warning" id="btnSolicitud" onclick="cancelarSolicitud(<?php echo $id_visto; ?>)">
                        <i class="fas fa-clock"></i> Solicitud enviada (cancelar)
                    </button>
                <?php else: ?>
                    <button class="btn btn-primary" id="btnSolicitud" onclick="enviarSolicitud(<?php echo $id_visto; ?>)">
                        <i class="fas fa-user-plus"></i> Enviar solicitud
                    </button>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <?php if ($puedeVer): ?>

        <!-- Juegos favoritos -->
        <section style="margin-top: var(--spacing-xl);">
            <h2><i class="fas fa-heart"></i> Juegos Favoritos</h2>
            <?php if (count($favoritos) > 0): ?>
                <div class="grid">
                    <?php foreach ($favoritos as $juego): ?>
                        <div class="card">
                            <img src="../assets/img/games/<?php echo htmlspecialchars($juego['portada'] ?: 'default_game.jpg'); ?>"
                                alt="<?php echo htmlspecialchars($juego['titulo']); ?>" class="card-img"
                                onerror="this.src='../assets/img/games/default_game.jpg'">
                            <div class="card-body">
                                <h3 class="card-title">
                                    <?php echo htmlspecialchars($juego['titulo']); ?>
                                </h3>
                                <p class="card-subtitle">
                                    <?php echo htmlspecialchars($juego['desarrollador'] ?: 'Desconocido'); ?>
                                </p>
                                <a href="ficha_juego.php?id=<?php echo (int) $juego['id']; ?>" class="btn btn-primary btn-sm"
                                    style="width:100%;">Ver Ficha</a>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <p class="text-muted">No tiene juegos favoritos aún.</p>
            <?php endif; ?>
        </section>

        <!-- Juegos añadidos -->
        <section style="margin-top: var(--spacing-xl);">
            <h2><i class="fas fa-gamepad"></i> Juegos Añadidos</h2>
            <?php if (count($juegosAnadidos) > 0): ?>
                <div class="grid">
                    <?php foreach ($juegosAnadidos as $juego): ?>
                        <div class="card">
                            <img src="../assets/img/games/<?php echo htmlspecialchars($juego['portada'] ?: 'default_game.jpg'); ?>"
                                alt="<?php echo htmlspecialchars($juego['titulo']); ?>" class="card-img"
                                onerror="this.src='../assets/img/games/default_game.jpg'">
                            <div class="card-body">
                                <h3 class="card-title">
                                    <?php echo htmlspecialchars($juego['titulo']); ?>
                                </h3>
                                <p class="card-subtitle">
                                    <?php echo htmlspecialchars($juego['desarrollador'] ?: 'Desconocido'); ?>
                                </p>
                                <a href="ficha_juego.php?id=<?php echo (int) $juego['id']; ?>" class="btn btn-primary btn-sm"
                                    style="width:100%;">Ver Ficha</a>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <p class="text-muted">No ha añadido ningún juego aún.</p>
            <?php endif; ?>
        </section>

    <?php else: ?>
        <!-- Perfil privado sin ser colaborador -->
        <div class="card" style="margin-top: var(--spacing-xl); text-align: center; padding: var(--spacing-xl);">
            <i class="fas fa-lock"
                style="font-size: 48px; color: var(--text-secondary); margin-bottom: var(--spacing-md);"></i>
            <h3>Este perfil es privado</h3>
            <p class="text-muted">Envía una solicitud de colaboración para ver su contenido.</p>
        </div>
    <?php endif; ?>

</div>

<?php include "../sec/footer.php"; ?>

<script>
    $(document).ready(function () {

        var miId = <?php echo (int) $_SESSION['id']; ?>;

        function enviarSolicitud(id_rec) {
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_sol: miId, id_rec: id_rec, options: 2 },
                dataType: "text",
                success: function (data) {
                    if (data.trim() === "enviada") {
                        location.reload();
                    } else {
                        alert("Error al enviar la solicitud.");
                    }
                }
            });
        }

        function cancelarSolicitud(id_rec) {
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_sol: miId, id_rec: id_rec, options: 8 },
                dataType: "text",
                success: function (data) {
                    if (data.trim() === "cancelada") {
                        $('#btnSolicitud')
                            .removeClass('btn-warning')
                            .addClass('btn-primary')
                            .attr('onclick', 'enviarSolicitud(' + id_rec + ')')
                            .html('<i class="fas fa-user-plus"></i> Enviar solicitud');
                    } else if (data.trim() === "bloqueada") {
                        alert("No puedes cancelar una solicitud rechazada hasta pasados 15 días.");
                        location.reload();
                    } else {
                        alert("Error al cancelar la solicitud.");
                    }
                }
            });
        }

        function aceptarSolicitud(id_sol) {
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_sol: id_sol, id_rec: miId, options: 3 },
                dataType: "text",
                success: function () { location.reload(); }
            });
        }

        function rechazarSolicitud(id_sol) {
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_sol: id_sol, id_rec: miId, options: 4 },
                dataType: "text",
                success: function () { location.reload(); }
            });
        }

        function eliminarColaborador(id_sol) {
            if (!confirm('¿Eliminar a este colaborador?')) return;
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_sol: id_sol, id_rec: miId, options: 6 },
                dataType: "text",
                success: function () { location.reload(); }
            });
        }

        // Exponer funciones globalmente para los onclick del HTML
        window.enviarSolicitud = enviarSolicitud;
        window.cancelarSolicitud = cancelarSolicitud;
        window.aceptarSolicitud = aceptarSolicitud;
        window.rechazarSolicitud = rechazarSolicitud;
        window.eliminarColaborador = eliminarColaborador;
    });
</script>