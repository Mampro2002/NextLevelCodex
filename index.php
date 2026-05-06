<?php
include "sec/sec.php";
$paginaActiva = 'inicio';
$idioma = simplexml_load_file("assets/locales/" . $_SESSION["idioma"] . ".xml");

// ✅ RENDIMIENTO: Una sola consulta para totalJuegos y solicitudes pendientes
$filt = $db->prepare("SELECT COUNT(*) AS total FROM juegos");
$filt->execute();
$totalJuegos = $filt->get_result()->fetch_assoc()['total'];

// Colaboradores desde campo amigos
$filt = $db->prepare("SELECT amigos FROM usuarios WHERE id = ?");
$filt->bind_param("i", $_SESSION["id"]);
$filt->execute();
$vec = $filt->get_result()->fetch_assoc();
$totalColaboradores = !empty($vec["amigos"]) ? count(array_filter(explode('#', $vec["amigos"]))) : 0;

// Solicitudes pendientes
$filt = $db->prepare("SELECT COUNT(*) AS total FROM domingueros WHERE id_rec = ? AND statu = 1");
$filt->bind_param("i", $_SESSION["id"]);
$filt->execute();
$totalSolicitudes = $filt->get_result()->fetch_assoc()['total'];

// Juegos recientes
$stmt = $db->prepare("SELECT id, titulo, desarrollador, portada, fecha_lanzamiento, en_desarrollo  
                      FROM juegos 
                      ORDER BY fecha_creacion DESC 
                      LIMIT 6");
$stmt->execute();
$juegosRecientes = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Next Level Codex</title>

    <!-- Fuentes -->
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Poppins:wght@600;700&family=Roboto+Mono&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- CSS -->
    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/components.css">
    <link rel="stylesheet" href="assets/css/layout.css">
    <link rel="stylesheet" href="assets/css/perfil.css">

    <!-- ✅ RENDIMIENTO: tema.js en el head para evitar flash de tema incorrecto -->
    <script src="assets/js/tema.js"></script>
    <!-- ✅ jQuery se carga solo en footer.php, eliminado de aquí -->
</head>

<body>

    <?php include "sec/header.php"; ?>

    <div class="main-container">

        <!-- Bienvenida -->
        <section class="welcome-section">

            <h1 class="welcome-title">¡Bienvenido, <?php echo htmlspecialchars($_SESSION["nombre"]); ?>!</h1>
            <p class="welcome-subtitle">Explora la biblioteca, conecta con colaboradores y descubre nuevos juegos.</p>

            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-value"><?php echo (int) $totalJuegos; ?></div>
                    <div class="stat-label">Juegos en la Wiki</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value"><?php echo (int) $totalColaboradores; ?></div>
                    <div class="stat-label">Colaboradores</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value"><?php echo (int) $totalSolicitudes; ?></div>
                    <div class="stat-label">Solicitudes pendientes</div>
                </div>
            </div>
        </section>

        <!-- Juegos Recientes -->
        <section>
            <h2>🕹️ Juegos Recientes</h2>

            <?php if (count($juegosRecientes) > 0): ?>
                <div class="grid">
                    <?php foreach ($juegosRecientes as $juego): ?>
                        <div class="card">
                            <?php
                            $portada = !empty($juego['portada'])
                                ? 'assets/img/games/' . htmlspecialchars($juego['portada'])
                                : 'assets/img/games/default_game.jpg';
                            ?>
                            <img src="<?php echo $portada; ?>" alt="<?php echo htmlspecialchars($juego['titulo']); ?>"
                                class="card-img" onerror="this.src='assets/img/games/default_game.jpg'">
                            <div class="card-body">
                                <h3 class="card-title"><?php echo htmlspecialchars($juego['titulo']); ?></h3>
                                <p class="card-subtitle">
                                    <?php echo htmlspecialchars($juego['desarrollador'] ?: 'Desconocido'); ?>
                                </p>
                                <?php if ($juego['en_desarrollo']): ?>
                                    <span class="badge" style="background: var(--warning); color: #000;">Próximamente</span>
                                <?php else: ?>
                                    <p class="text-muted" style="font-size: 13px; margin-bottom: var(--spacing-sm);">
                                        📅 <?php echo date('Y', strtotime($juego['fecha_lanzamiento'])); ?>
                                    </p>
                                <?php endif; ?>
                                <a href="vistas/ficha_juego.php?id=<?php echo (int) $juego['id']; ?>"
                                    class="btn btn-primary btn-sm" style="width: 100%;">
                                    Ver Ficha
                                </a>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <div class="card" style="padding: var(--spacing-xl); text-align: center;">
                    <p class="text-muted" style="font-size: 18px;">📭 Aún no hay juegos en la biblioteca.</p>
                    <?php if ($_SESSION['level'] <= 1): ?>
                        <p class="text-muted" style="margin-top: var(--spacing-sm);">
                            ¿Eres editor o administrador?
                            <a href="vistas/admin_juegos.php">Añade el primer juego</a>.
                        </p>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </section>
    </div>

    <?php include "sec/footer.php"; ?>

</body>

</html>