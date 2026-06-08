<?php
// estadisticas.php — Solo accesible para admins
// Incluir desde tablaAdmin.php via AJAX o directamente
include "../sec/bdd.php";
include "../sec/sec.php";

if ($_SESSION['level'] != 0) {
    echo json_encode(["error" => "Acceso denegado"]);
    exit;
}

$idioma = simplexml_load_file("../assets/locales/" . $_SESSION["idioma"] . ".xml");

// ── 1. KPIs rápidos ──────────────────────────────────────────────
$totalUsuarios = $db->query("SELECT COUNT(*) FROM usuarios")->fetch_row()[0];
$usuariosConectados = $db->query("SELECT COUNT(*) FROM usuarios WHERE conectado = 1")->fetch_row()[0];
$totalJuegos = $db->query("SELECT COUNT(*) FROM juegos")->fetch_row()[0];
$totalComentarios = $db->query("SELECT COUNT(*) FROM comentarios")->fetch_row()[0];
$totalMensajes = $db->query("SELECT COUNT(*) FROM mensajes_grupales")->fetch_row()[0] +
    $db->query("SELECT COUNT(*) FROM mensajes_privados")->fetch_row()[0];
$totalFavoritos = $db->query("SELECT COUNT(*) FROM favoritos")->fetch_row()[0];
$valoracionMedia = $db->query("SELECT ROUND(AVG(puntuacion),1) FROM valoraciones")->fetch_row()[0] ?? 0;

// ── 2. Juegos añadidos por mes (últimos 6 meses) ──────────────────
$juegosPorMes = $db->query("
    SELECT DATE_FORMAT(fecha_creacion, '%Y-%m') AS mes,
           DATE_FORMAT(fecha_creacion, '%b %Y')  AS mes_label,
           COUNT(*) AS total
    FROM juegos
    WHERE fecha_creacion >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
    GROUP BY mes, mes_label
    ORDER BY mes ASC
")->fetch_all(MYSQLI_ASSOC);

// ── 3. Usuarios registrados por mes (últimos 6 meses) ─────────────
$usuariosPorMes = $db->query("
    SELECT DATE_FORMAT(ultima_conexion, '%Y-%m') AS mes,
           DATE_FORMAT(ultima_conexion, '%b %Y')  AS mes_label,
           COUNT(*) AS total
    FROM usuarios
    WHERE ultima_conexion >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
    GROUP BY mes, mes_label
    ORDER BY mes ASC
")->fetch_all(MYSQLI_ASSOC);

// ── 4. Top 5 juegos más visitados ────────────────────────────────
$topVisitados = $db->query("
    SELECT j.titulo, COUNT(v.id) AS visitas
    FROM visitas_juegos v
    JOIN juegos j ON v.id_juego = j.id
    GROUP BY j.id, j.titulo
    ORDER BY visitas DESC
    LIMIT 5
")->fetch_all(MYSQLI_ASSOC);

if (empty($topVisitados)) {
    $topVisitados = $db->query("
        SELECT j.titulo, COUNT(f.id_juego) AS visitas
        FROM favoritos f
        JOIN juegos j ON f.id_juego = j.id
        GROUP BY j.id, j.titulo
        ORDER BY visitas DESC
        LIMIT 5
    ")->fetch_all(MYSQLI_ASSOC);
}

// ── 5. Top 5 juegos mejor valorados ──────────────────────────────
$topValorados = $db->query("
    SELECT j.titulo, ROUND(AVG(v.puntuacion), 1) AS media, COUNT(v.id) AS votos
    FROM valoraciones v
    JOIN juegos j ON v.id_juego = j.id
    GROUP BY j.id, j.titulo
    HAVING votos >= 1
    ORDER BY media DESC, votos DESC
    LIMIT 5
")->fetch_all(MYSQLI_ASSOC);

// ── 6. Actividad del chat (mensajes por día, últimos 7 días) ──────
$actividadChat = $db->query("
    SELECT DATE_FORMAT(fecha, '%d/%m') AS dia, COUNT(*) AS total
    FROM (
        SELECT fecha FROM mensajes_grupales
        WHERE fecha >= DATE_SUB(NOW(), INTERVAL 7 DAY)
        UNION ALL
        SELECT fecha FROM mensajes_privados
        WHERE fecha >= DATE_SUB(NOW(), INTERVAL 7 DAY)
    ) AS todos
    GROUP BY dia
    ORDER BY MIN(fecha) ASC
")->fetch_all(MYSQLI_ASSOC);

// ── 7. Distribución de niveles de usuario ────────────────────────
$niveles = $db->query("
    SELECT 
        SUM(level = 0) AS admins,
        SUM(level = 1) AS usuarios
    FROM usuarios
")->fetch_assoc();

// ── 8. Usuarios más activos (más comentarios + valoraciones) ──────
$masActivos = $db->query("
    SELECT u.nombre, u.user,
           COUNT(DISTINCT c.id) AS comentarios,
           COUNT(DISTINCT v.id) AS valoraciones
    FROM usuarios u
    LEFT JOIN comentarios c ON c.id_usuario = u.id
    LEFT JOIN valoraciones v ON v.id_usuario = u.id
    GROUP BY u.id, u.nombre, u.user
    ORDER BY (COUNT(DISTINCT c.id) + COUNT(DISTINCT v.id)) DESC
    LIMIT 5
")->fetch_all(MYSQLI_ASSOC);
?>

<div class="stats-dashboard">
    <h3 style="margin-bottom: 16px; font-size: 18px;">
        <i class="fas fa-chart-line"></i> <?= $idioma->palabras->estad_titulo ?>
    </h3>

    <!-- KPIs -->
    <div class="kpi-grid">
        <div class="kpi-card">
            <div class="kpi-icon"><i class="fas fa-users"></i></div>
            <div class="kpi-value"><?= $totalUsuarios ?></div>
            <div class="kpi-label"><?= $idioma->palabras->estad_kpi_usuarios ?></div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon"><i class="fas fa-circle" style="color:var(--success)"></i></div>
            <div class="kpi-value" style="color:var(--success)"><?= $usuariosConectados ?></div>
            <div class="kpi-label"><?= $idioma->palabras->estad_kpi_conectados ?></div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon"><i class="fas fa-gamepad"></i></div>
            <div class="kpi-value"><?= $totalJuegos ?></div>
            <div class="kpi-label"><?= $idioma->palabras->estad_kpi_juegos ?></div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon"><i class="fas fa-comments"></i></div>
            <div class="kpi-value"><?= $totalComentarios ?></div>
            <div class="kpi-label"><?= $idioma->palabras->estad_kpi_comentarios ?></div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon"><i class="fas fa-paper-plane"></i></div>
            <div class="kpi-value"><?= $totalMensajes ?></div>
            <div class="kpi-label"><?= $idioma->palabras->estad_kpi_mensajes ?></div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon"><i class="fas fa-heart"></i></div>
            <div class="kpi-value"><?= $totalFavoritos ?></div>
            <div class="kpi-label"><?= $idioma->palabras->estad_kpi_favoritos ?></div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon"><i class="fas fa-star"></i></div>
            <div class="kpi-value" style="color:var(--warning)"><?= $valoracionMedia ?></div>
            <div class="kpi-label"><?= $idioma->palabras->estad_kpi_valoracion ?></div>
        </div>
    </div>

    <!-- Gráficas fila 1 -->
    <div class="charts-grid">
        <div class="chart-card">
            <h4><i class="fas fa-gamepad"></i> <?= $idioma->palabras->estad_chart_juegos_mes ?></h4>
            <canvas id="chartJuegosMes"></canvas>
        </div>
        <div class="chart-card">
            <h4><i class="fas fa-user-clock"></i> <?= $idioma->palabras->estad_chart_usuarios_mes ?></h4>
            <canvas id="chartUsuariosMes"></canvas>
        </div>
    </div>

    <!-- Gráficas fila 2 -->
    <div class="charts-grid">
        <div class="chart-card">
            <h4><i class="fas fa-fire"></i> <?= $idioma->palabras->estad_chart_populares ?></h4>
            <canvas id="chartTopJuegos"></canvas>
        </div>
        <div class="chart-card">
            <h4><i class="fas fa-comment-dots"></i> <?= $idioma->palabras->estad_chart_chat ?></h4>
            <canvas id="chartChat"></canvas>
        </div>
    </div>

    <!-- Gráficas fila 3 -->
    <div class="charts-grid">
        <div class="chart-card">
            <h4><i class="fas fa-star"></i> <?= $idioma->palabras->estad_chart_valorados ?></h4>
            <canvas id="chartValorados"></canvas>
        </div>
        <div class="chart-card">
            <h4><i class="fas fa-user-shield"></i> <?= $idioma->palabras->estad_chart_niveles ?></h4>
            <canvas id="chartNiveles"></canvas>
        </div>
    </div>

    <!-- Tabla usuarios más activos -->
    <div class="chart-card" style="margin-top: 0;">
        <h4><i class="fas fa-trophy"></i> <?= $idioma->palabras->estad_tabla_activos ?></h4>
        <table class="tabla-activos">
            <thead>
                <tr>
                    <th><?= $idioma->palabras->estad_tabla_num ?></th>
                    <th><?= $idioma->palabras->estad_tabla_usuario ?></th>
                    <th><?= $idioma->palabras->estad_tabla_comentarios ?></th>
                    <th><?= $idioma->palabras->estad_tabla_valoraciones ?></th>
                    <th><?= $idioma->palabras->estad_tabla_total ?></th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($masActivos as $i => $u): ?>
                    <tr>
                        <td><?= $i + 1 ?></td>
                        <td><?= htmlspecialchars($u['nombre']) ?> <span
                                style="color:var(--text-secondary)">@<?= htmlspecialchars($u['user']) ?></span></td>
                        <td><?= $u['comentarios'] ?></td>
                        <td><?= $u['valoraciones'] ?></td>
                        <td><strong><?= $u['comentarios'] + $u['valoraciones'] ?></strong></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>

<script>
    // Traducciones para datasets de Chart.js
    var estadLabels = {
        juegos: '<?= addslashes($idioma->palabras->estad_dataset_juegos) ?>',
        usuarios: '<?= addslashes($idioma->palabras->estad_dataset_usuarios) ?>',
        popularidad: '<?= addslashes($idioma->palabras->estad_dataset_popularidad) ?>',
        mensajes: '<?= addslashes($idioma->palabras->estad_dataset_mensajes) ?>',
        valoracion: '<?= addslashes($idioma->palabras->estad_dataset_valoracion) ?>',
        administradores: '<?= addslashes($idioma->palabras->estad_dataset_admins) ?>',
        usuariosNormales: '<?= addslashes($idioma->palabras->estad_dataset_usuarios_normales) ?>'
    };

    (function () {
        var graficosAnteriores = [
            'chartJuegosMes', 'chartUsuariosMes', 'chartTopJuegos',
            'chartChat', 'chartValorados', 'chartNiveles'
        ];
        graficosAnteriores.forEach(function (nombre) {
            if (window[nombre] && typeof window[nombre].destroy === 'function') {
                window[nombre].destroy();
            }
        });

        var azul = 'rgba(26, 159, 255, 0.8)';
        var azulB = 'rgba(26, 159, 255, 0.2)';
        var verde = 'rgba(164, 208, 7, 0.8)';
        var verdeB = 'rgba(164, 208, 7, 0.2)';
        var naranja = 'rgba(233, 183, 65, 0.8)';
        var rojo = 'rgba(217, 65, 65, 0.8)';
        var colores = [azul, verde, naranja, rojo, 'rgba(180,100,255,0.8)'];

        var textColor = getComputedStyle(document.documentElement)
            .getPropertyValue('--text-secondary').trim() || '#acb4bc';

        Chart.defaults.color = textColor;
        Chart.defaults.borderColor = 'rgba(255,255,255,0.05)';

        var jMes = <?= json_encode($juegosPorMes) ?>;
        window.chartJuegosMes = new Chart(document.getElementById('chartJuegosMes'), {
            type: 'bar',
            data: {
                labels: jMes.map(r => r.mes_label),
                datasets: [{
                    label: estadLabels.juegos,
                    data: jMes.map(r => r.total),
                    backgroundColor: azul,
                    borderRadius: 6
                }]
            },
            options: { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } } }
        });

        var uMes = <?= json_encode($usuariosPorMes) ?>;
        window.chartUsuariosMes = new Chart(document.getElementById('chartUsuariosMes'), {
            type: 'line',
            data: {
                labels: uMes.map(r => r.mes_label),
                datasets: [{
                    label: estadLabels.usuarios,
                    data: uMes.map(r => r.total),
                    borderColor: verde,
                    backgroundColor: verdeB,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 4
                }]
            },
            options: { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } } }
        });

        var topJ = <?= json_encode($topVisitados) ?>;
        window.chartTopJuegos = new Chart(document.getElementById('chartTopJuegos'), {
            type: 'bar',
            data: {
                labels: topJ.map(r => r.titulo),
                datasets: [{
                    label: estadLabels.popularidad,
                    data: topJ.map(r => r.visitas),
                    backgroundColor: colores,
                    borderRadius: 6
                }]
            },
            options: {
                indexAxis: 'y',
                plugins: { legend: { display: false } },
                scales: { x: { beginAtZero: true, ticks: { stepSize: 1 } } }
            }
        });

        var chat = <?= json_encode($actividadChat) ?>;
        window.chartChat = new Chart(document.getElementById('chartChat'), {
            type: 'line',
            data: {
                labels: chat.map(r => r.dia),
                datasets: [{
                    label: estadLabels.mensajes,
                    data: chat.map(r => r.total),
                    borderColor: naranja,
                    backgroundColor: 'rgba(233,183,65,0.15)',
                    fill: true,
                    tension: 0.4,
                    pointRadius: 4
                }]
            },
            options: { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } } }
        });

        var topV = <?= json_encode($topValorados) ?>;
        window.chartValorados = new Chart(document.getElementById('chartValorados'), {
            type: 'bar',
            data: {
                labels: topV.map(r => r.titulo),
                datasets: [{
                    label: estadLabels.valoracion,
                    data: topV.map(r => r.media),
                    backgroundColor: 'rgba(233,183,65,0.8)',
                    borderRadius: 6
                }]
            },
            options: {
                indexAxis: 'y',
                plugins: { legend: { display: false } },
                scales: { x: { beginAtZero: true, max: 5, ticks: { stepSize: 1 } } }
            }
        });

        var niv = <?= json_encode($niveles) ?>;
        window.chartNiveles = new Chart(document.getElementById('chartNiveles'), {
            type: 'doughnut',
            data: {
                labels: [estadLabels.administradores, estadLabels.usuariosNormales],
                datasets: [{
                    data: [niv.admins, niv.usuarios],
                    backgroundColor: [rojo, azul],
                    borderWidth: 0
                }]
            },
            options: {
                plugins: {
                    legend: { position: 'bottom', labels: { padding: 16, font: { size: 12 } } }
                },
                cutout: '65%'
            }
        });
    })();
</script>