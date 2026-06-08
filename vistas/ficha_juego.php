<?php
include "../sec/bdd.php";
include "../sec/sec.php";
include "../modelos/modelo_juegos.php";
$paginaActiva = 'biblioteca';

$idioma = simplexml_load_file("../assets/locales/" . $_SESSION["idioma"] . ".xml");

$id_juego = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if (!$id_juego) {
    header("location: ../index.php");
    exit;
}

$modelo = new ModeloJuegos();
$juego = $modelo->obtenerJuegoCompleto($id_juego);

// ✅ CORREGIDO: SQL Injection en registro de visitas
$stmt = $db->prepare("INSERT INTO visitas_juegos (id_juego, id_usuario) VALUES (?, ?)");
$stmt->bind_param("ii", $id_juego, $_SESSION['id']);
$stmt->execute();

if (!$juego) {
    echo "<p>" . $idioma->palabras->ficha_no_encontrado . "</p>";
    exit;
}

include "../sec/header.php";

// Preparar arrays de labels para JavaScript
$labelsJS = [
    'Arma' => ['v1' => (string) $idioma->palabras->elem_label_dano, 'v2' => (string) $idioma->palabras->elem_label_municion],
    'Carta' => ['v1' => (string) $idioma->palabras->elem_label_puntos, 'v2' => (string) $idioma->palabras->elem_label_coste],
    'Hechizo' => ['v1' => (string) $idioma->palabras->elem_label_poder, 'v2' => (string) $idioma->palabras->elem_label_mana],
    'Objeto' => ['v1' => (string) $idioma->palabras->elem_label_efecto, 'v2' => (string) $idioma->palabras->elem_label_duracion],
    'Armadura/Traje' => ['v1' => (string) $idioma->palabras->elem_label_defensa, 'v2' => (string) $idioma->palabras->elem_label_resistencia],
    'Otro' => ['v1' => (string) $idioma->palabras->elem_valor1_default, 'v2' => (string) $idioma->palabras->elem_valor2_default]
];
?>

<div class="main-container">
    <a href="wiki_home.php" class="btn" style="margin-bottom:var(--spacing-md);">
        <i class="fas fa-arrow-left"></i> <?= $idioma->palabras->ficha_volver ?>
    </a>

    <!-- Cabecera -->
    <div class="game-header">
        <div class="game-cover">
            <img src="../assets/img/games/<?= htmlspecialchars($juego['portada'] ?: 'default_game.jpg') ?>"
                alt="<?= htmlspecialchars($juego['titulo']) ?>"
                onerror="this.src='../assets/img/games/default_game.jpg'">
        </div>
        <div class="game-info">
            <h1 class="game-title"><?= htmlspecialchars($juego['titulo']) ?></h1>
            <div class="game-meta">
                <span class="meta-item"><i class="fas fa-code"></i>
                    <?= htmlspecialchars($juego['desarrollador'] ?: $idioma->palabras->ini_desconocido) ?></span>
                <span class="meta-item"><i class="fas fa-building"></i>
                    <?= htmlspecialchars($juego['distribuidora'] ?: $idioma->palabras->ini_desconocido) ?></span>
                <span class="meta-item"><i class="fas fa-calendar"></i>
                    <?= $juego['fecha_lanzamiento'] ? date('d/m/Y', strtotime($juego['fecha_lanzamiento'])) : 'TBA' ?></span>
                <span class="meta-item"><i class="fas fa-tag"></i>
                    <?= htmlspecialchars($juego['genero'] ?: $idioma->palabras->ficha_sin_genero) ?></span>

                <?php if ($juego['en_desarrollo'] && strtotime($juego['fecha_lanzamiento']) > time()): ?>
                    <div class="countdown-container"
                        style="margin:var(--spacing-md) 0;background:var(--bg-secondary);border-radius:var(--border-radius-lg);padding:var(--spacing-md);">
                        <h4 style="margin-bottom:var(--spacing-xs);color:var(--warning);">
                            <i class="fas fa-clock"></i> <?= $idioma->palabras->ficha_proximo_lanzamiento ?>
                        </h4>
                        <div id="countdown" style="display:flex;gap:var(--spacing-md);font-size:24px;font-weight:700;">
                            <div><span id="dias">00</span><small
                                    style="display:block;font-size:12px;color:var(--text-secondary);"><?= $idioma->palabras->ficha_dias ?></small>
                            </div>
                            <div><span id="horas">00</span><small
                                    style="display:block;font-size:12px;color:var(--text-secondary);"><?= $idioma->palabras->ficha_horas ?></small>
                            </div>
                            <div><span id="minutos">00</span><small
                                    style="display:block;font-size:12px;color:var(--text-secondary);"><?= $idioma->palabras->ficha_min ?></small>
                            </div>
                            <div><span id="segundos">00</span><small
                                    style="display:block;font-size:12px;color:var(--text-secondary);"><?= $idioma->palabras->ficha_seg ?></small>
                            </div>
                        </div>
                    </div>
                    <script>
                        (function () {
                            var msgDisponible = '<?= addslashes($idioma->palabras->ficha_ya_disponible) ?>';
                            function actualizarCountdown() {
                                var d = new Date("<?= $juego['fecha_lanzamiento'] ?>T00:00:00").getTime() - new Date().getTime();
                                if (d <= 0) { document.getElementById("countdown").innerHTML = msgDisponible; return; }
                                document.getElementById("dias").textContent = String(Math.floor(d / 86400000)).padStart(2, '0');
                                document.getElementById("horas").textContent = String(Math.floor((d % 86400000) / 3600000)).padStart(2, '0');
                                document.getElementById("minutos").textContent = String(Math.floor((d % 3600000) / 60000)).padStart(2, '0');
                                document.getElementById("segundos").textContent = String(Math.floor((d % 60000) / 1000)).padStart(2, '0');
                            }
                            actualizarCountdown();
                            setInterval(actualizarCountdown, 1000);
                        })();
                    </script>
                <?php endif; ?>
            </div>

            <p class="text-muted" style="line-height:1.7;">
                <?= nl2br(htmlspecialchars($juego['descripcion'] ?: $idioma->palabras->ficha_sin_descripcion)) ?>
            </p>

            <?php if (!empty($juego['creador'])): ?>
                <div style="margin-top:var(--spacing-md);">
                    <span class="creator-badge">
                        <i class="fas fa-user-pen"></i> <?= $idioma->palabras->ficha_anadido_por ?>:
                        <a href="perfil_publico.php?id=<?= (int) $juego['creador']['id'] ?>">
                            <?= htmlspecialchars($juego['creador']['nombre']) ?>
                            (@<?= htmlspecialchars($juego['creador']['user']) ?>)
                        </a>
                    </span>
                </div>
            <?php endif; ?>

            <?php
            $enlace = !empty($juego['enlace_compra'])
                ? $juego['enlace_compra']
                : 'https://store.steampowered.com/search/?term=' . urlencode($juego['titulo']);
            ?>
            <a href="<?= htmlspecialchars($enlace) ?>" target="_blank" class="buy-button">
                <i class="fab fa-steam"></i>
                <?= !empty($juego['enlace_compra']) ? $idioma->palabras->ficha_comprar_tienda : $idioma->palabras->ficha_buscar_steam ?>
            </a>

            <button id="btnFavorito" class="btn btn-warning" onclick="toggleFavorito()"
                style="margin-left:var(--spacing-sm);">
                <i class="far fa-heart"></i> <span
                    id="textoFavorito"><?= $idioma->palabras->ficha_marcar_favorito ?></span>
            </button>
        </div>
    </div>

    <!-- Valoraciones -->
    <div style="margin:var(--spacing-md) 0;">
        <div style="display:flex;align-items:center;gap:var(--spacing-sm);">
            <div id="estrellasMedia"></div>
            <span id="textoMedia" class="text-muted"></span>
        </div>
        <div style="margin-top:var(--spacing-xs);">
            <span class="text-muted"><?= $idioma->palabras->ficha_tu_valoracion ?> </span>
            <span id="estrellasUsuario">
                <?php for ($i = 1; $i <= 5; $i++): ?>
                    <i class="far fa-star estrella-votar" data-valor="<?= $i ?>"
                        style="cursor:pointer;color:var(--warning);"></i>
                <?php endfor; ?>
            </span>
        </div>
    </div>

    <!-- Pestañas -->
    <div class="tabs-container">
        <button class="tab-button active" data-tab="tab-general"><i class="fas fa-info-circle"></i>
            <?= $idioma->palabras->ficha_general ?></button>

        <?php if ($juego['tiene_items'] && count($juego['elementos']) > 0): ?>
            <button class="tab-button" data-tab="tab-elementos">
                <i class="fas fa-box-open"></i>
                <?= htmlspecialchars($juego['nombre_items'] ?: $idioma->palabras->ficha_elementos) ?>
                (<?= count($juego['elementos']) ?>)
            </button>
        <?php endif; ?>

        <?php if ($juego['tiene_personajes'] && count($juego['personajes']) > 0): ?>
            <button class="tab-button" data-tab="tab-personajes">
                <i class="fas fa-users"></i> <?= $idioma->palabras->ficha_personajes ?> (<?= count($juego['personajes']) ?>)
            </button>
        <?php endif; ?>

        <?php if ($juego['tiene_mapa'] && !empty($juego['mapa_imagen'])): ?>
            <button class="tab-button" data-tab="tab-mapa">
                <i class="fas fa-map"></i> <?= $idioma->palabras->ficha_mapa_interactivo ?>
            </button>
        <?php endif; ?>

        <button class="tab-button" data-tab="tab-comentarios">
            <i class="fas fa-comments"></i> <?= $idioma->palabras->ficha_comentarios ?>
        </button>
        <?php if (!empty($juego['trailer'])): ?>
            <button class="tab-button" data-tab="tab-trailer">
                <i class="fab fa-youtube"></i> <?= $idioma->palabras->ficha_trailer ?>
            </button>
        <?php endif; ?>
    </div>

    <div class="tab-content">

        <!-- General -->
        <div id="tab-general" class="tab-pane active">
            <h3><?= $idioma->palabras->ficha_info_general ?></h3>
            <table class="table" style="max-width:600px;">
                <tr>
                    <th style="width:150px;"><?= $idioma->palabras->wiki_th1 ?></th>
                    <td><?= htmlspecialchars($juego['titulo']) ?></td>
                </tr>
                <tr>
                    <th><?= $idioma->palabras->wiki_th2 ?></th>
                    <td><?= htmlspecialchars($juego['desarrollador'] ?: '-') ?></td>
                </tr>
                <tr>
                    <th><?= $idioma->palabras->ficha_distribuidora ?></th>
                    <td><?= htmlspecialchars($juego['distribuidora'] ?: '-') ?></td>
                </tr>
                <tr>
                    <th><?= $idioma->palabras->wiki_th3 ?></th>
                    <td><?= $juego['fecha_lanzamiento'] ? date('d/m/Y', strtotime($juego['fecha_lanzamiento'])) : '-' ?>
                    </td>
                </tr>
                <tr>
                    <th><?= $idioma->palabras->ficha_genero_tabla ?></th>
                    <td><?= htmlspecialchars($juego['genero'] ?: '-') ?></td>
                </tr>
            </table>
        </div>

        <!-- Elementos -->
        <?php if ($juego['tiene_items'] && count($juego['elementos']) > 0): ?>
            <div id="tab-elementos" class="tab-pane" style="display:none;">
                <h3><?= htmlspecialchars($juego['nombre_items'] ?: $idioma->palabras->ficha_elementos) ?></h3>
                <div class="elementos-grid" id="gridElementos">
                    <?php foreach ($juego['elementos'] as $elem):
                        $rareza = strtolower($elem['rareza'] ?? '');
                        $rareza_norm = strtolower(str_replace(
                            ['á', 'é', 'í', 'ó', 'ú', 'Á', 'É', 'Í', 'Ó', 'Ú'],
                            ['a', 'e', 'i', 'o', 'u', 'a', 'e', 'i', 'o', 'u'],
                            $elem['rareza'] ?? ''
                        ));
                        $clase_rareza = in_array($rareza_norm, ['comun', 'raro', 'epico', 'legendario']) ? 'rareza-' . $rareza_norm : '';
                        $iconos = [
                            'Arma' => '⚔️',
                            'Carta' => '🃏',
                            'Hechizo' => '✨',
                            'Objeto' => '🎒',
                            'Armadura/Traje' => '🛡️',
                            'Otro' => '📦'
                        ];
                        $icono = $iconos[$elem['tipo']] ?? '📦';
                        $colores = ['comun' => '#888', 'raro' => '#4a9eff', 'epico' => '#a855f7', 'legendario' => '#f59e0b'];
                        $color = $colores[$rareza_norm] ?? 'var(--text-secondary)';
                        ?>
                        <div class="elemento-card <?= $clase_rareza ?>"
                            onclick="verDetalleElemento(<?= htmlspecialchars(json_encode($elem)) ?>)">
                            <?php if (!empty($elem['imagen'])): ?>
                                <img src="../assets/img/elementos/<?= htmlspecialchars($elem['imagen']) ?>"
                                    style="width:100%;height:120px;object-fit:cover;"
                                    alt="<?= htmlspecialchars($elem['nombre']) ?>">
                            <?php else: ?>
                                <div class="elemento-card-icon"><?= $icono ?></div>
                            <?php endif; ?>
                            <div class="elemento-card-info">
                                <div class="elemento-card-nombre"><?= htmlspecialchars($elem['nombre']) ?></div>
                                <div class="elemento-card-tipo">
                                    <?= htmlspecialchars($elem['tipo'] ?: $idioma->palabras->elem_sin_tipo) ?></div>
                                <?php if (!empty($elem['rareza'])): ?>
                                    <div class="elemento-card-rareza" style="color:<?= $color ?>">
                                        <?= htmlspecialchars($elem['rareza']) ?>
                                    </div>
                                <?php endif; ?>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        <?php endif; ?>

        <!-- Personajes -->
        <?php if ($juego['tiene_personajes'] && count($juego['personajes']) > 0): ?>
            <div id="tab-personajes" class="tab-pane" style="display:none;">
                <h3><?= $idioma->palabras->ficha_personajes ?></h3>
                <div class="personajes-grid">
                    <?php foreach ($juego['personajes'] as $pj):
                        $img = !empty($pj['imagen'])
                            ? '../assets/img/personajes/' . htmlspecialchars($pj['imagen'])
                            : '../assets/img/avatars/default.jpg';
                        ?>
                        <div class="personaje-card" onclick="verDetallePersonaje(<?= htmlspecialchars(json_encode($pj)) ?>)">
                            <img src="<?= $img ?>" alt="<?= htmlspecialchars($pj['nombre']) ?>"
                                onerror="this.src='../assets/img/avatars/default.jpg'">
                            <div class="personaje-card-info">
                                <div class="personaje-card-nombre"><?= htmlspecialchars($pj['nombre']) ?></div>
                                <div class="personaje-card-rol">
                                    <?= htmlspecialchars($pj['rol'] ?: $idioma->palabras->pj_sin_rol) ?></div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        <?php endif; ?>

        <!-- Mapa -->
        <?php if ($juego['tiene_mapa'] && !empty($juego['mapa_imagen'])): ?>
            <div id="tab-mapa" class="tab-pane" style="display:none;">
                <h3><?= $idioma->palabras->ficha_mapa_interactivo ?></h3>
                <p class="text-muted" style="margin-bottom:var(--spacing-md);">
                    <?= $idioma->palabras->ficha_mapa_instruccion ?>
                </p>
                <div style="position:relative; display:inline-block; max-width:100%;">
                    <img src="../assets/img/maps/<?= htmlspecialchars($juego['mapa_imagen']) ?>"
                        style="display:block; max-width:100%; border-radius:var(--border-radius-lg);"
                        alt="Mapa de <?= htmlspecialchars($juego['titulo']) ?>">
                    <?php foreach ($juego['mapas'] as $punto): ?>
                        <?php if ($punto['pos_x'] && $punto['pos_y']): ?>
                            <div class="pin-ficha" style="left:<?= $punto['pos_x'] ?>%;top:<?= $punto['pos_y'] ?>%;">
                                <?= htmlspecialchars($punto['icono'] ?? '📍') ?>
                                <div class="pin-tooltip-ficha">
                                    <strong><?= htmlspecialchars($punto['nombre']) ?></strong>
                                    <?php if ($punto['tipo']): ?><br><em><?= htmlspecialchars($punto['tipo']) ?></em><?php endif; ?>
                                    <?php if ($punto['descripcion']): ?><br><?= htmlspecialchars($punto['descripcion']) ?><?php endif; ?>
                                </div>
                            </div>
                        <?php endif; ?>
                    <?php endforeach; ?>
                </div>
            </div>
        <?php endif; ?>

        <!-- Comentarios -->
        <div id="tab-comentarios" class="tab-pane" style="display:none;">
            <h3><?= $idioma->palabras->ficha_comentarios ?></h3>
            <div class="card" style="margin-bottom:var(--spacing-lg);">
                <div class="card-body">
                    <textarea id="nuevoComentario" class="input" rows="3"
                        placeholder="<?= $idioma->palabras->ficha_placeholder_comentario ?>"
                        maxlength="1000"></textarea>
                    <button class="btn btn-primary" style="margin-top:var(--spacing-sm);" id="enviarComentario">
                        <i class="fas fa-paper-plane"></i> <?= $idioma->palabras->ficha_publicar ?>
                    </button>
                </div>
            </div>
            <div id="listaComentarios"></div>
        </div>

        <?php if (!empty($juego['trailer'])): ?>
            <div id="tab-trailer" class="tab-pane" style="display:none;">
                <h3><?= $idioma->palabras->ficha_trailer ?></h3>
                <?php
                $trailer_url = $juego['trailer'];
                $video_id = '';
                if (preg_match('/(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})/', $trailer_url, $match)) {
                    $video_id = $match[1];
                }
                ?>
                <?php if ($video_id): ?>
                    <div style="position:relative;padding-bottom:56.25%;height:0;overflow:hidden;max-width:100%;">
                        <iframe src="https://www.youtube.com/embed/<?= $video_id ?>"
                            style="position:absolute;top:0;left:0;width:100%;height:100%;" frameborder="0"
                            allowfullscreen></iframe>
                    </div>
                <?php else: ?>
                    <a href="<?= htmlspecialchars($trailer_url) ?>" target="_blank" class="btn btn-primary">
                        <i class="fas fa-external-link-alt"></i> <?= $idioma->palabras->ficha_ver_trailer ?>
                    </a>
                <?php endif; ?>
            </div>
        <?php endif; ?>

    </div>
</div>

<!-- Modal detalle elemento -->
<div id="modalDetalleElemento" class="modal-overlay" style="display:none;">
    <div class="modal" style="max-width:460px;">
        <div class="modal-header">
            <h3 class="modal-title" id="elemDetalleNombre"></h3>
            <button class="modal-close" onclick="$('#modalDetalleElemento').hide()">&times;</button>
        </div>
        <div class="modal-body">
            <div style="text-align:center;font-size:64px;margin-bottom:var(--spacing-md);" id="elemDetalleIcono"></div>
            <div class="detalle-row"><span class="detalle-label"><?= $idioma->palabras->elem_detalle_tipo ?></span><span
                    class="detalle-valor" id="elemDetalleTipo"></span></div>
            <div class="detalle-row"><span class="detalle-label"
                    id="elemDetalleLabel1"><?= $idioma->palabras->elem_valor1_default ?></span><span
                    class="detalle-valor" id="elemDetalleValor1"></span></div>
            <div class="detalle-row"><span class="detalle-label"
                    id="elemDetalleLabel2"><?= $idioma->palabras->elem_valor2_default ?></span><span
                    class="detalle-valor" id="elemDetalleValor2"></span></div>
            <div class="detalle-row"><span
                    class="detalle-label"><?= $idioma->palabras->elem_detalle_rareza ?></span><span
                    class="detalle-valor" id="elemDetalleRareza"></span></div>
            <div class="detalle-row"><span
                    class="detalle-label"><?= $idioma->palabras->elem_detalle_descripcion ?></span><span
                    class="detalle-valor" id="elemDetalleDesc"></span></div>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="$('#modalDetalleElemento').hide()"><?= $idioma->palabras->Cerrar ?></button>
        </div>
    </div>
</div>

<!-- Modal detalle personaje -->
<div id="modalDetallePersonaje" class="modal-overlay" style="display:none;">
    <div class="modal" style="max-width:460px;">
        <div class="modal-header">
            <h3 class="modal-title" id="pjDetalleNombre"></h3>
            <button class="modal-close" onclick="$('#modalDetallePersonaje').hide()">&times;</button>
        </div>
        <div class="modal-body">
            <img id="pjDetalleImg" src="" alt="" class="modal-detalle-img"
                onerror="this.src='../assets/img/avatars/default.jpg'">
            <div class="detalle-row"><span class="detalle-label"><?= $idioma->palabras->pj_rol ?></span><span
                    class="detalle-valor" id="pjDetalleRol"></span></div>
            <div class="detalle-row"><span class="detalle-label"><?= $idioma->palabras->pj_ubicacion ?></span><span
                    class="detalle-valor" id="pjDetalleUbicacion"></span></div>
            <div class="detalle-row"><span class="detalle-label"><?= $idioma->palabras->pj_descripcion ?></span><span
                    class="detalle-valor" id="pjDetalleDesc"></span></div>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="$('#modalDetallePersonaje').hide()"><?= $idioma->palabras->Cerrar ?></button>
        </div>
    </div>
</div>

<?php include "../sec/footer.php"; ?>

<script>
    // Traducciones pasadas desde PHP
    var fichaLabelsJS = <?= json_encode($labelsJS) ?>;
    var fichaVotosTexto = '<?= addslashes($idioma->palabras->ficha_votos) ?>';
    var fichaPrimerComentario = '<?= addslashes($idioma->palabras->ficha_primer_comentario) ?>';
    var fichaConfirmarEliminar = '<?= addslashes($idioma->palabras->ficha_confirmar_eliminar_comentario) ?>';
    var fichaErrorPublicar = '<?= addslashes($idioma->palabras->ficha_error_publicar) ?>';
    var fichaMarcarFav = '<?= addslashes($idioma->palabras->ficha_marcar_favorito) ?>';
    var fichaQuitarFav = '<?= addslashes($idioma->palabras->ficha_quitar_favorito) ?>';

    var iconosElem = { 'Arma': '⚔️', 'Carta': '🃏', 'Hechizo': '✨', 'Objeto': '🎒', 'Armadura/Traje': '🛡️', 'Otro': '📦' };
    var coloresRareza = { 'comun': '#888', 'raro': '#4a9eff', 'epico': '#a855f7', 'legendario': '#f59e0b' };

    function escapeHtml(text) {
        if (text === null || text === undefined) return '';
        return $('<div>').text(String(text)).html();
    }

    function verDetalleElemento(e) {
        var lbl = fichaLabelsJS[e.tipo] || fichaLabelsJS['Otro'];
        var rareza_norm = e.rareza ? e.rareza.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "") : '';
        var color = coloresRareza[rareza_norm] || 'var(--text-secondary)';
        var $iconoContainer = $('#elemDetalleIcono');
        $iconoContainer.empty();

        if (e.imagen) {
            $iconoContainer.html('<img src="../assets/img/elementos/' + e.imagen + '" style="width:120px;height:120px;object-fit:contain;border-radius:8px;" onerror="this.style.display=\'none\';$(\'#elemDetalleIcono\').text(\'' + (iconosElem[e.tipo] || '📦') + '\')">');
        } else {
            $iconoContainer.text(iconosElem[e.tipo] || '📦');
        }
        $('#elemDetalleNombre').text(e.nombre);
        $('#elemDetalleTipo').text(e.tipo || '-');
        $('#elemDetalleLabel1').text(lbl.v1);
        $('#elemDetalleValor1').text(e.valor1 || '-');
        $('#elemDetalleLabel2').text(lbl.v2);
        $('#elemDetalleValor2').text(e.valor2 || '-');
        $('#elemDetalleRareza').text(e.rareza || '-').css({ 'color': color, 'font-weight': '600' });
        $('#elemDetalleDesc').text(e.descripcion || '-');
        $('#modalDetalleElemento').show();
    }

    function verDetallePersonaje(p) {
        var img = p.imagen
            ? '../assets/img/personajes/' + p.imagen
            : '../assets/img/avatars/default.jpg';
        $('#pjDetalleImg').attr('src', img);
        $('#pjDetalleNombre').text(p.nombre);
        $('#pjDetalleRol').text(p.rol || '-');
        $('#pjDetalleUbicacion').text(p.ubicacion || '-');
        $('#pjDetalleDesc').text(p.descripcion || '-');
        $('#modalDetallePersonaje').show();
    }

    $(document).ready(function () {
        var idJuego = <?= (int) $id_juego ?>;
        var miId = <?= (int) $_SESSION['id'] ?>;
        var miLevel = <?= (int) $_SESSION['level'] ?>;

        $('.tab-button').click(function () {
            var tabId = $(this).data('tab');
            $('.tab-button').removeClass('active');
            $(this).addClass('active');
            $('.tab-pane').hide();
            $('#' + tabId).show();
            if (tabId === 'tab-comentarios') cargarComentarios();
        });

        function cargarMedia() {
            $.ajax({
                type: "post", url: "../controladores/controlador_admin.php",
                data: { opt: 90, id_juego: idJuego }, dataType: "json",
                success: function (data) {
                    if (!data || data.media === undefined) return;
                    var media = parseFloat(data.media) || 0;
                    var html = '';
                    for (var i = 1; i <= 5; i++) html += i <= Math.round(media)
                        ? '<i class="fas fa-star" style="color:var(--warning);"></i>'
                        : '<i class="far fa-star" style="color:var(--warning);"></i>';
                    $('#estrellasMedia').html(html);
                    $('#textoMedia').text(media.toFixed(1) + ' (' + data.total + ' ' + fichaVotosTexto + ')');
                }
            });
        }

        function cargarValoracionUsuario() {
            $.ajax({
                type: "post", url: "../controladores/controlador_wiki.php",
                data: { opt: 10, id_juego: idJuego }, dataType: "json",
                success: function (data) { if (data.puntuacion > 0) marcarEstrellas(data.puntuacion); }
            });
        }

        function marcarEstrellas(valor) {
            $('.estrella-votar').each(function () {
                $(this).toggleClass('fas', $(this).data('valor') <= valor)
                    .toggleClass('far', $(this).data('valor') > valor);
            });
        }

        $('.estrella-votar').click(function () {
            var valor = $(this).data('valor');
            $.ajax({
                type: "post", url: "../controladores/controlador_wiki.php",
                data: { opt: 11, id_juego: idJuego, puntuacion: valor }, dataType: "json",
                success: function (data) { if (data.success) { marcarEstrellas(valor); cargarMedia(); } }
            });
        });

        function cargarEstadoFavorito() {
            $.ajax({
                type: "post", url: "../controladores/controlador_wiki.php",
                data: { opt: 21, id_juego: idJuego }, dataType: "json",
                success: function (data) { actualizarBotonFavorito(data.favorito); }
            });
        }

        window.toggleFavorito = function () {
            $.ajax({
                type: "post", url: "../controladores/controlador_wiki.php",
                data: { opt: 20, id_juego: idJuego }, dataType: "json",
                success: function (data) { actualizarBotonFavorito(data.favorito); }
            });
        };

        function actualizarBotonFavorito(esFavorito) {
            $('#btnFavorito i').toggleClass('fas', esFavorito).toggleClass('far', !esFavorito);
            $('#textoFavorito').text(esFavorito ? fichaQuitarFav : fichaMarcarFav);
        }

        function cargarComentarios() {
            $.ajax({
                type: "post", url: "../controladores/controlador_wiki.php",
                data: { opt: 30, id_juego: idJuego }, dataType: "json",
                success: function (comentarios) {
                    if (!Array.isArray(comentarios) || comentarios.length === 0) {
                        $("#listaComentarios").html('<p class="text-muted">' + fichaPrimerComentario + '</p>');
                        return;
                    }
                    var html = "";
                    comentarios.forEach(function (c) {
                        var esMio = (c.id_usuario == miId);
                        var esAdmin = (miLevel == 0);
                        var btnBorrar = (esMio || esAdmin)
                            ? '<button class="btn btn-sm btn-danger" style="margin-left:auto;" onclick="eliminarComentario(' + c.id + ')"><i class="fas fa-trash"></i></button>'
                            : '';
                        html += '<div class="card" style="margin-bottom:var(--spacing-md);">' +
                            '<div class="card-body">' +
                            '<div style="display:flex;align-items:center;gap:var(--spacing-sm);margin-bottom:var(--spacing-sm);">' +
                            '<img src="../assets/img/avatars/' + escapeHtml(c.avatar || 'default.jpg') + '" ' +
                            'style="width:35px;height:35px;border-radius:50%;object-fit:cover;" ' +
                            'onerror="this.src=\'../assets/img/avatars/default.jpg\'">' +
                            '<div><a href="perfil_publico.php?id=' + c.id_usuario + '"><strong>' + escapeHtml(c.nombre) + '</strong></a> ' +
                            '<span class="text-muted">@' + escapeHtml(c.user) + '</span><br>' +
                            '<small class="text-muted">' + escapeHtml(c.fecha) + '</small></div>' +
                            btnBorrar + '</div>' +
                            '<p style="margin:0;">' + escapeHtml(c.comentario) + '</p>' +
                            '</div></div>';
                    });
                    $("#listaComentarios").html(html);
                }
            });
        }

        window.eliminarComentario = function (id) {
            if (!confirm(fichaConfirmarEliminar)) return;
            $.ajax({
                type: "post", url: "../controladores/controlador_wiki.php",
                data: { opt: 32, id_comentario: id }, dataType: "json",
                success: function (res) { if (res.success) cargarComentarios(); }
            });
        };

        $("#enviarComentario").click(function () {
            var texto = $("#nuevoComentario").val().trim();
            if (!texto) return;
            $(this).prop("disabled", true);
            $.ajax({
                type: "post", url: "../controladores/controlador_wiki.php",
                data: { opt: 31, id_juego: idJuego, comentario: texto }, dataType: "json",
                success: function (res) {
                    if (res.success) { $("#nuevoComentario").val(""); cargarComentarios(); }
                    else alert(fichaErrorPublicar);
                },
                complete: function () { $("#enviarComentario").prop("disabled", false); }
            });
        });

        cargarMedia();
        cargarValoracionUsuario();
        cargarEstadoFavorito();
    });
</script>