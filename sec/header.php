<?php
/**
 * header.php — Navbar unificado
 * Guardar en: sec/header.php
 * Incluir con: include "sec/header.php";        (desde raíz)
 *              include "../sec/header.php";      (desde vistas/)
 *
 * La variable $paginaActiva debe definirse ANTES de incluir este archivo.
 * Valores posibles: 'inicio' | 'biblioteca' | 'colaboradores' | 'chat'
 */

// Normalizar separadores para compatibilidad Windows/Linux
$scriptPath = str_replace('\\', '/', $_SERVER['SCRIPT_FILENAME']);
$enRaiz = (strpos($scriptPath, '/vistas/') === false);
$base = $enRaiz ? '' : '../';

if (!isset($paginaActiva))
    $paginaActiva = '';

// Mensajes privados no leídos
$noLeidos = 0;
if (isset($db)) {
    $stmtNL = $db->prepare("SELECT COUNT(*) AS total FROM mensajes_privados WHERE receptor = ? AND leido = 0");
    $stmtNL->bind_param("i", $_SESSION["id"]);
    $stmtNL->execute();
    $noLeidos = (int) $stmtNL->get_result()->fetch_assoc()['total'];
}

// Solicitudes de amistad pendientes
$solicitudesPendientes = 0;
if (isset($db)) {
    $stmtSol = $db->prepare("SELECT COUNT(*) AS total FROM domingueros WHERE id_rec = ? AND statu = 1");
    $stmtSol->bind_param("i", $_SESSION["id"]);
    $stmtSol->execute();
    $solicitudesPendientes = (int) $stmtSol->get_result()->fetch_assoc()['total'];
}
?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Next Level Codex</title>

    <!-- Hojas de estilo -->
    <link rel="stylesheet" href="<?= $base ?>assets/css/main.css">
    <link rel="stylesheet" href="<?= $base ?>assets/css/components.css">
    <link rel="stylesheet" href="<?= $base ?>assets/css/layout.css">
    <link rel="stylesheet" href="<?= $base ?>assets/css/perfil.css">
    <link rel="stylesheet" href="<?= $base ?>assets/css/colaboradores.css">
    <link rel="stylesheet" href="<?= $base ?>assets/css/admin_panel.css">
    <link rel="stylesheet" href="<?= $base ?>assets/css/game.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Chart.js para gráficos -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <!-- Tema claro/oscuro -->
    <script src="<?= $base ?>assets/js/tema.js"></script>
</head>

<body>
    <header class="app-header">
        <div class="logo" onclick="window.location.href='<?= $base ?>index.php'" style="cursor:pointer;">
            Next Level <span>Codex</span>
        </div>

        <nav class="nav-menu">
            <a href="<?= $base ?>index.php"
                class="nav-item <?= $paginaActiva === 'inicio' ? 'active' : '' ?>">Inicio</a>
            <a href="<?= $base ?>vistas/wiki_home.php"
                class="nav-item <?= $paginaActiva === 'biblioteca' ? 'active' : '' ?>">Biblioteca</a>
            <a href="<?= $base ?>vistas/centro_colaboradores.php"
                class="nav-item <?= $paginaActiva === 'colaboradores' ? 'active' : '' ?>">
                <?= 'Colaboradores' . ($solicitudesPendientes > 0 ? ' <span class="badge">' . $solicitudesPendientes . '</span>' : '') ?>
            </a>
            <a href="<?= $base ?>vistas/chat_global.php"
                class="nav-item <?= $paginaActiva === 'chat' ? 'active' : '' ?>">
                <?= 'Chat' . ($noLeidos > 0 ? ' <span class="badge">' . $noLeidos . '</span>' : '') ?>
            </a>
        </nav>

        <div class="user-menu">
            <button class="theme-toggle" onclick="toggleTheme()">
                <i class="fas fa-sun"></i>
            </button>

            <div class="dropdown">
                <div class="dropdown-toggle"
                    onclick="document.querySelector('.dropdown-menu').classList.toggle('show')">
                    <?php $avatarSesion = $_SESSION['avatar'] ?? 'default.jpg'; ?>
                    <img src="<?= $base ?>assets/img/avatars/<?= htmlspecialchars($avatarSesion) ?>" alt="Avatar"
                        class="avatar" onerror="this.src='<?= $base ?>assets/img/avatars/default.jpg'">
                    <span><?= htmlspecialchars($_SESSION["nombre"]) ?></span>
                    <i class="fas fa-chevron-down" style="font-size:12px;"></i>
                </div>

                <div class="dropdown-menu">
                    <a href="<?= $base ?>vistas/perfil.php" class="dropdown-item">
                        <i class="fas fa-user"></i> Mi Perfil
                    </a>
                    <a href="<?= $base ?>vistas/ajustes.php" class="dropdown-item">
                        <i class="fas fa-cog"></i> Ajustes
                    </a>

                    <?php if ($_SESSION["level"] == 0): ?>
                        <div class="dropdown-divider"></div>
                        <a href="#" onclick="abrirPanelAdmin()" class="dropdown-item">
                            <i class="fas fa-shield-alt"></i> Panel Admin
                        </a>
                        <a href="#" onclick="abrirEstadisticas()" class="dropdown-item">
                            <i class="fas fa-chart-bar"></i> Estadísticas
                        </a>
                    <?php endif; ?>

                    <?php if ($_SESSION["level"] <= 1): ?>
                        <a href="<?= $base ?>vistas/admin_juegos.php" class="dropdown-item">
                            <i class="fas fa-gamepad"></i> Gestionar Juegos
                        </a>
                    <?php endif; ?>

                    <div class="dropdown-divider"></div>
                    <a href="<?= $base ?>sec/log_out.php" class="dropdown-item" style="color:var(--danger);">
                        <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                    </a>
                </div>
            </div>
        </div>
    </header>

    <?php if ($_SESSION["level"] == 0): ?>
        <!-- Modal Panel Admin -->
        <div id="modalAdmin" class="modal-overlay" style="display:none;">
            <div class="modal" style="max-width:90%;width:1200px;">
                <div class="modal-header">
                    <h3 class="modal-title">Panel de Administración</h3>
                    <button class="modal-close" onclick="$('#modalAdmin').hide();">&times;</button>
                </div>
                <div class="modal-body" id="modalAdminBody">Cargando...</div>
            </div>
        </div>

        <!-- Modal Estadísticas -->
        <div id="modalEstadisticas" class="modal-overlay" style="display: none;">
            <div class="modal" style="max-width: 1000px; width: 95%; max-height: 90vh; overflow-y: auto;">
                <div class="modal-header">
                    <h3 class="modal-title">Estadísticas de Next Level Codex</h3>
                    <button class="modal-close" onclick="$('#modalEstadisticas').hide();">&times;</button>
                </div>
                <div class="modal-body" id="contenedorEstadisticas">Cargando...</div>
            </div>
        </div>

        <script>
            function abrirPanelAdmin() {
                document.querySelector('.dropdown-menu').classList.remove('show');
                document.getElementById('modalAdmin').style.display = 'flex';
                fetch('<?= $base ?>vistas/tablaAdmin.php')
                    .then(r => r.text())
                    .then(html => {
                        const modalBody = document.getElementById('modalAdminBody');
                        modalBody.innerHTML = html;

                        // Ejecutar scripts dentro del modal
                        const scripts = modalBody.querySelectorAll('script');
                        scripts.forEach(oldScript => {
                            const newScript = document.createElement('script');
                            newScript.textContent = oldScript.textContent;
                            document.body.appendChild(newScript);
                            oldScript.remove();
                        });
                    });
            }

            function abrirEstadisticas() {
                $('.dropdown-menu').removeClass('show');
                $('#modalEstadisticas').show();
                $.ajax({
                    url: '<?= $base ?>vistas/estadisticas.php',
                    success: function (data) {
                        var $contenedor = $('#contenedorEstadisticas');
                        $contenedor.html(data);
                        // Ejecutar scripts dentro del modal
                        $contenedor.find('script').each(function () {
                            var nuevoScript = document.createElement('script');
                            nuevoScript.textContent = $(this).text();
                            document.body.appendChild(nuevoScript);
                        });
                    }
                });
            }
        </script>
    <?php else: ?>
        <script>
            function abrirPanelAdmin() { }
            function abrirEstadisticas() { }
        </script>
    <?php endif; ?>

    <script>
        // Cerrar dropdown al hacer clic fuera
        document.addEventListener('click', function (e) {
            if (!e.target.closest('.dropdown')) {
                document.querySelectorAll('.dropdown-menu').forEach(m => m.classList.remove('show'));
            }
        });

        // ── Tooltips del mapa ────────────────────────────────────────
        $(document).on('mouseenter', '.pin-ficha', function () {
            $(this).find('.pin-tooltip-ficha').show();
        }).on('mouseleave', '.pin-ficha', function () {
            $(this).find('.pin-tooltip-ficha').hide();
        });
    </script>
</body>

</html>