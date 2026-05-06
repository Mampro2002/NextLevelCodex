<?php
include "../sec/bdd.php";
include "../sec/sec.php";

$id_juego = isset($_GET['id_juego']) ? (int) $_GET['id_juego'] : 0;
if ($id_juego <= 0) {
    header("location: admin_juegos.php");
    exit;
}

$stmt = $db->prepare("SELECT titulo, mapa_imagen FROM juegos WHERE id = ?");
$stmt->bind_param("i", $id_juego);
$stmt->execute();
$juego = $stmt->get_result()->fetch_assoc();

if (!$juego) {
    header("location: admin_juegos.php");
    exit;
}

// Verificar que es el creador o admin
$check = $db->prepare("SELECT creador_id FROM juegos WHERE id = ?");
$check->bind_param("i", $id_juego);
$check->execute();
$creador_id = $check->get_result()->fetch_assoc()['creador_id'];
if ($_SESSION['level'] != 0 && $creador_id != $_SESSION['id']) {
    header("location: admin_juegos.php");
    exit;
}

include "../sec/header.php";
?>

<style>
    .mapa-wrapper {
        position: relative;
        display: inline-block;
        cursor: crosshair;
        max-width: 100%;
        user-select: none;
    }

    .mapa-wrapper img {
        display: block;
        max-width: 100%;
        border-radius: var(--border-radius-lg);
    }

    .pin {
        position: absolute;
        transform: translate(-50%, -100%);
        font-size: 28px;
        cursor: pointer;
        filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.6));
        transition: transform 0.15s;
        z-index: 10;
        line-height: 1;
    }

    .pin:hover {
        transform: translate(-50%, -100%) scale(1.3);
    }

    .pin-tooltip {
        display: none;
        position: absolute;
        bottom: 110%;
        left: 50%;
        transform: translateX(-50%);
        background: var(--bg-secondary);
        border: 1px solid var(--bg-tertiary);
        border-radius: var(--border-radius);
        padding: 6px 10px;
        font-size: 12px;
        white-space: nowrap;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
        color: var(--text-primary);
        z-index: 20;
        pointer-events: none;
    }

    .pin:hover .pin-tooltip {
        display: block;
    }

    .pin-delete {
        display: none;
        position: absolute;
        top: -8px;
        right: -8px;
        background: var(--danger);
        color: white;
        border: none;
        border-radius: 50%;
        width: 18px;
        height: 18px;
        font-size: 10px;
        cursor: pointer;
        align-items: center;
        justify-content: center;
        z-index: 30;
        line-height: 1;
    }

    .pin:hover .pin-delete {
        display: flex;
    }

    .instruccion {
        background: var(--bg-tertiary);
        border-radius: var(--border-radius);
        padding: var(--spacing-sm) var(--spacing-md);
        margin-bottom: var(--spacing-md);
        font-size: 14px;
        color: var(--text-secondary);
        display: flex;
        align-items: center;
        gap: var(--spacing-sm);
    }
</style>

<div class="main-container">
    <a href="admin_juegos.php" class="btn"><i class="fas fa-arrow-left"></i> Volver</a>
    <h1 style="margin-top:var(--spacing-md);"><i class="fas fa-map"></i> Mapa de:
        <?= htmlspecialchars($juego['titulo']) ?>
    </h1>

    <!-- Subir imagen -->
    <div class="card" style="margin-top:var(--spacing-lg); margin-bottom:var(--spacing-lg);">
        <div class="card-body" style="display:flex; align-items:center; gap:var(--spacing-lg); flex-wrap:wrap;">
            <div>
                <h4 style="margin-bottom:var(--spacing-sm);">Imagen del mapa</h4>
                <small class="text-muted">Sube la imagen del mapa del juego (jpg, png, webp)</small>
            </div>
            <form id="formMapaImagen" enctype="multipart/form-data"
                style="display:flex; gap:var(--spacing-sm); align-items:center; flex:1; min-width:250px;">
                <input type="hidden" name="id_juego" value="<?= $id_juego ?>">
                <input type="file" name="mapa_imagen" class="input" accept="image/*" style="flex:1;">
                <button type="button" class="btn btn-primary" onclick="subirMapaImagen()">
                    <i class="fas fa-upload"></i> Subir
                </button>
            </form>
        </div>
    </div>

    <?php if (!empty($juego['mapa_imagen'])): ?>

        <!-- Instrucción -->
        <div class="instruccion">
            <i class="fas fa-info-circle" style="color:var(--accent-primary);"></i>
            Haz <strong>clic en la imagen</strong> para añadir un punto de interés en esa posición.
        </div>

        <!-- Mapa interactivo -->
        <div class="mapa-wrapper" id="mapaWrapper">
            <img src="../assets/img/maps/<?= htmlspecialchars($juego['mapa_imagen']) ?>" id="imagenMapa"
                alt="Mapa de <?= htmlspecialchars($juego['titulo']) ?>"
                onerror="this.src='../assets/img/games/default_game.jpg'">
            <!-- Los pins se insertan aquí por JS -->
        </div>

        <div style="margin-top:var(--spacing-lg);">
            <h4><i class="fas fa-map-marker-alt"></i> Puntos de interés</h4>
            <div class="table-container" style="margin-top:var(--spacing-sm);">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Icono</th>
                            <th>Nombre</th>
                            <th>Tipo</th>
                            <th>Pos X (%)</th>
                            <th>Pos Y (%)</th>
                            <th>Descripción</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody id="cuerpoPuntos"></tbody>
                </table>
            </div>
        </div>

    <?php else: ?>
        <div class="card" style="text-align:center; padding:var(--spacing-xl);">
            <i class="fas fa-map" style="font-size:48px; color:var(--text-secondary); margin-bottom:var(--spacing-md);"></i>
            <p class="text-muted">Sube primero la imagen del mapa para poder añadir puntos de interés.</p>
        </div>
    <?php endif; ?>
</div>

<!-- Modal: datos del nuevo punto -->
<div id="modalPunto" class="modal-overlay" style="display:none;">
    <div class="modal" style="max-width:400px;">
        <div class="modal-header">
            <h3 class="modal-title"><i class="fas fa-map-marker-alt"></i> Nuevo Punto de Interés</h3>
            <button class="modal-close" onclick="cancelarPin()">&times;</button>
        </div>
        <div class="modal-body">
            <p class="text-muted" style="margin-bottom:var(--spacing-md);">
                Posición: <strong id="txtPosicion"></strong>
            </p>
            <form id="formPunto">
                <input type="hidden" id="puntoX" name="pos_x">
                <input type="hidden" id="puntoY" name="pos_y">
                <div class="form-group">
                    <label>Nombre *</label>
                    <input type="text" id="puntoNombre" name="nombre" class="input" required
                        placeholder="Ej: Ciudad de Mondstadt">
                </div>
                <div class="form-group">
                    <label>Tipo</label>
                    <input type="text" id="puntoTipo" name="tipo" class="input"
                        placeholder="Ciudad, Mazmorra, Jefe, Tienda...">
                </div>
                <div class="form-group">
                    <label>Descripción</label>
                    <textarea id="puntoDescripcion" name="descripcion" class="input" rows="2"
                        placeholder="Descripción opcional del punto..."></textarea>
                </div>
                <div class="form-group">
                    <label>Icono del punto</label>
                    <div class="icono-selector" style="display: flex; gap: 8px; flex-wrap: wrap; margin-top: 5px;">
                        <?php
                        $iconos = ['📍', '🏰', '🏔️', '🌊', '🏕️', '🏚️', '🗼', '⛩️', '🛖', '🏠', '⭐', '💎', '⚔️', '🛡️', '❤️', '🔥', '💀', '🎯', '🗝️', '📜'];
                        foreach ($iconos as $emoji):
                            ?>
                            <span class="icono-opcion" data-icono="<?= $emoji ?>"
                                style="font-size: 24px; cursor: pointer; padding: 4px; border: 2px solid transparent; border-radius: 4px; transition: border-color 0.2s;"
                                onclick="seleccionarIcono('<?= $emoji ?>', this)">
                                <?= $emoji ?>
                            </span>
                        <?php endforeach; ?>
                    </div>
                    <input type="hidden" id="puntoIcono" name="icono" value="📍">
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="cancelarPin()">Cancelar</button>
            <button class="btn btn-primary" onclick="guardarPunto()">
                <i class="fas fa-save"></i> Guardar punto
            </button>
        </div>
    </div>
</div>

<?php include "../sec/footer.php"; ?>

<script>
    var idJuego = <?= (int) $id_juego ?>;
    var pinTempX = null;
    var pinTempY = null;
    var pinTempEl = null;

    // ── Resaltar icono por defecto al cargar ───────────────────────
    $(document).ready(function () {
        $(".icono-opcion[data-icono='📍']").css("border-color", "var(--accent-primary)");
        cargarPuntosMapa();
        // Limpiar pin temporal cuando el modal se oculta por cualquier motivo
        $('#modalPunto').on('click', '.modal-close', function () {
            if (pinTempEl) { pinTempEl.remove(); pinTempEl = null; }
        });

        // También al hacer clic fuera del modal (opcional)
        $('#modalPunto').on('click', function (e) {
            if ($(e.target).is('#modalPunto')) {
                if (pinTempEl) { pinTempEl.remove(); pinTempEl = null; }
                $(this).hide();
            }
        });
    });

    // ── Subir imagen del mapa ───────────────────────────────────────
    function subirMapaImagen() {
        var formData = new FormData($("#formMapaImagen")[0]);
        formData.append("opt", 30);
        $.ajax({
            type: "post",
            url: "../controladores/controlador_admin.php",
            data: formData,
            processData: false,
            contentType: false,
            dataType: "json",
            success: function (res) {
                if (res.success) {
                    location.reload();
                } else {
                    alert("Error al subir imagen: " + (res.error || ""));
                }
            }
        });
    }

    // ── Seleccionar icono del selector visual ──────────────────────
    function seleccionarIcono(emoji, elemento) {
        $("#puntoIcono").val(emoji);
        $(".icono-opcion").css("border-color", "transparent");
        $(elemento).css("border-color", "var(--accent-primary)");
    }

    // ── Clic en la imagen → colocar pin temporal ───────────────────
    $("#mapaWrapper").on("click", function (e) {
        if ($(e.target).closest('.pin').length) return;

        var wrapper = document.getElementById("mapaWrapper");
        var rect = wrapper.getBoundingClientRect();

        var posX = ((e.clientX - rect.left) / rect.width * 100).toFixed(2);
        var posY = ((e.clientY - rect.top) / rect.height * 100).toFixed(2);

        pinTempX = posX;
        pinTempY = posY;

        if (pinTempEl) { pinTempEl.remove(); pinTempEl = null; }

        pinTempEl = $('<div class="pin" style="left:' + posX + '%;top:' + posY + '%;opacity:0.6;">📍</div>');
        $("#mapaWrapper").append(pinTempEl);

        $("#puntoX").val(posX);
        $("#puntoY").val(posY);
        $("#txtPosicion").text("X: " + posX + "% — Y: " + posY + "%");
        $("#formPunto")[0].reset();
        $("#puntoX").val(posX);
        $("#puntoY").val(posY);
        $("#puntoIcono").val("📍");
        $(".icono-opcion").css("border-color", "transparent");
        $(".icono-opcion[data-icono='📍']").css("border-color", "var(--accent-primary)");
        $("#modalPunto").show();
        $("#puntoNombre").focus();
    });

    function cancelarPin() {
        if (pinTempEl) { pinTempEl.remove(); pinTempEl = null; }
        $("#modalPunto").hide();
    }

    // ── Guardar punto (CON ICONO) ──────────────────────────────────
    function guardarPunto() {
        var nombre = $("#puntoNombre").val().trim();
        if (!nombre) { alert("El nombre es obligatorio."); return; }

        var datos = {
            opt: 32,
            id_juego: idJuego,
            nombre: nombre,
            tipo: $("#puntoTipo").val(),
            pos_x: $("#puntoX").val(),
            pos_y: $("#puntoY").val(),
            descripcion: $("#puntoDescripcion").val(),
            icono: $("#puntoIcono").val()
        };

        $.post("../controladores/controlador_admin.php", datos, function (res) {
            if (res.success) {
                $("#modalPunto").hide();
                pinTempEl = null;
                cargarPuntosMapa();
            } else {
                alert("Error al guardar: " + (res.error || ""));
            }
        }, "json");
    }

    // ── Eliminar punto ──────────────────────────────────────────────
    function eliminarPunto(id) {
        if (!confirm("¿Eliminar este punto?")) return;

        // Eliminar visualmente
        $('.pin-real[data-pin-id="' + id + '"]').remove();

        // Eliminar en base de datos y refrescar tabla
        $.post("../controladores/controlador_admin.php", { opt: 33, id: id }, function (res) {
            if (res.success) {
                cargarPuntosMapa(); // Solo refresca la tabla (el pin ya no está)
            } else {
                alert("Error al eliminar el punto");
                cargarPuntosMapa(); // Reconstruye todo si falla
            }
        }, "json");
    }

    // ── Cargar puntos (tabla + pins en mapa, CON ICONO) ────────────
    function cargarPuntosMapa() {
        $.post("../controladores/controlador_admin.php", { opt: 31, id_juego: idJuego }, function (puntos) {

            $("#mapaWrapper").find(".pin").not(".pin-temp").remove();

            var html = "";
            if (Array.isArray(puntos) && puntos.length > 0) {
                puntos.forEach(function (p) {
                    var iconoPin = p.icono || '📍';
                    var pin = $(
                        '<div class="pin pin-real" data-pin-id="' + p.id + '" style="left:' + p.pos_x + '%;top:' + p.pos_y + '%;">' +
                        iconoPin +
                        '<div class="pin-tooltip">' +
                        '<strong>' + escapeHtml(p.nombre) + '</strong>' +
                        (p.tipo ? '<br><em>' + escapeHtml(p.tipo) + '</em>' : '') +
                        (p.descripcion ? '<br>' + escapeHtml(p.descripcion) : '') +
                        '</div>' +
                        '<button class="pin-delete" onclick="eliminarPunto(' + p.id + ')" title="Eliminar">✕</button>' +
                        '</div>'
                    );
                    $("#mapaWrapper").append(pin);

                    html += '<tr>' +
                        '<td style="font-size:20px;">' + iconoPin + '</td>' +
                        '<td><strong>' + escapeHtml(p.nombre) + '</strong></td>' +
                        '<td>' + escapeHtml(p.tipo || '-') + '</td>' +
                        '<td>' + p.pos_x + '%</td>' +
                        '<td>' + p.pos_y + '%</td>' +
                        '<td>' + escapeHtml(p.descripcion || '-') + '</td>' +
                        '<td><button class="btn btn-sm btn-danger" onclick="eliminarPunto(' + p.id + ')"><i class="fas fa-trash"></i></button></td>' +
                        '</tr>';
                });

            } else {
                html = '<tr><td colspan="7" class="text-muted" style="text-align:center;">No hay puntos de interés. Haz clic en la imagen para añadir.</td></tr>';
            }

            $("#cuerpoPuntos").html(html);
        }, "json");
    }

    function escapeHtml(text) {
        if (!text) return '';
        return $('<div>').text(String(text)).html();
    }

    // ── Cerrar modal con Escape ─────────────────────────────────────
    $(document).on('keydown', function (e) {
        if (e.key === 'Escape') cancelarPin();
    });
</script>