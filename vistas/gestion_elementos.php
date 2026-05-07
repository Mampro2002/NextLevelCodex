<?php
include "../sec/bdd.php";
include "../sec/sec.php";

$id_juego = isset($_GET['id_juego']) ? (int) $_GET['id_juego'] : 0;
if ($id_juego <= 0) {
    header("location: admin_juegos.php");
    exit;
}

$stmt = $db->prepare("SELECT titulo, nombre_items FROM juegos WHERE id = ?");
$stmt->bind_param("i", $id_juego);
$stmt->execute();
$juego = $stmt->get_result()->fetch_assoc();

if (!$juego) {
    header("location: admin_juegos.php");
    exit;
}

$nombre_items = $juego['nombre_items'] ?? 'Elementos';

// ✅ Verificar que el usuario es el creador o admin
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
    .elementos-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
        gap: var(--spacing-lg);
        margin-top: var(--spacing-lg);
    }

    .elemento-card {
        background: var(--bg-secondary);
        border-radius: var(--border-radius-lg);
        overflow: hidden;
        cursor: pointer;
        transition: transform 0.2s, box-shadow 0.2s;
        position: relative;
        border: 2px solid transparent;
    }

    .elemento-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
    }

    /* Colores por rareza */
    .elemento-card.rareza-comun {
        border-color: #888;
    }

    .elemento-card.rareza-raro {
        border-color: #4a9eff;
    }

    .elemento-card.rareza-epico {
        border-color: #a855f7;
    }

    .elemento-card.rareza-legendario {
        border-color: #f59e0b;
    }

    .elemento-card-icon {
        width: 100%;
        height: 140px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: var(--bg-tertiary);
        font-size: 48px;
    }

    .elemento-card-info {
        padding: var(--spacing-sm) var(--spacing-md);
    }

    .elemento-card-nombre {
        font-weight: 600;
        font-size: 14px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .elemento-card-tipo {
        font-size: 12px;
        color: var(--text-secondary);
        margin-bottom: 4px;
    }

    .elemento-card-rareza {
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .elemento-card-acciones {
        position: absolute;
        top: var(--spacing-xs);
        right: var(--spacing-xs);
        display: flex;
        gap: 4px;
        opacity: 0;
        transition: opacity 0.2s;
    }

    .elemento-card:hover .elemento-card-acciones {
        opacity: 1;
    }

    .detalle-row {
        display: flex;
        gap: var(--spacing-sm);
        margin-bottom: var(--spacing-sm);
        align-items: flex-start;
    }

    .detalle-label {
        font-weight: 600;
        color: var(--text-secondary);
        min-width: 100px;
        font-size: 13px;
    }

    .detalle-valor {
        font-size: 14px;
    }
</style>

<div class="main-container">
    <a href="admin_juegos.php" class="btn"><i class="fas fa-arrow-left"></i> Volver</a>
    <div style="display:flex; justify-content:space-between; align-items:center; margin-top: var(--spacing-md);">
        <h1><?= htmlspecialchars($nombre_items) ?> de: <?= htmlspecialchars($juego['titulo']) ?></h1>
        <button class="btn btn-primary" onclick="abrirModalElemento()">
            <i class="fas fa-plus"></i> Añadir <?= htmlspecialchars($nombre_items) ?>
        </button>
    </div>

    <!-- Grid de elementos -->
    <div class="elementos-grid" id="gridElementos">
        <p class="text-muted">Cargando...</p>
    </div>
</div>

<!-- Modal detalle elemento (solo lectura) -->
<div id="modalDetalle" class="modal-overlay" style="display:none;">
    <div class="modal" style="max-width:480px;">
        <div class="modal-header">
            <h3 class="modal-title" id="detalleNombre"></h3>
            <button class="modal-close" onclick="$('#modalDetalle').hide()">&times;</button>
        </div>
        <div class="modal-body">
            <div style="text-align:center; font-size:64px; margin-bottom: var(--spacing-md);" id="detalleIcono"></div>
            <div class="detalle-row">
                <span class="detalle-label">Tipo</span>
                <span class="detalle-valor" id="detalleTipo"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label" id="detalleLabel1">Valor 1</span>
                <span class="detalle-valor" id="detalleValor1"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label" id="detalleLabel2">Valor 2</span>
                <span class="detalle-valor" id="detalleValor2"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label">Rareza</span>
                <span class="detalle-valor" id="detalleRareza"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label">Descripción</span>
                <span class="detalle-valor" id="detalleDescripcion"></span>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="$('#modalDetalle').hide()">Cerrar</button>
            <button class="btn btn-primary" id="btnEditarDesdeDetalle">
                <i class="fas fa-edit"></i> Editar
            </button>
        </div>
    </div>
</div>

<!-- Modal editar/crear elemento -->
<div id="modalElemento" class="modal-overlay" style="display:none;">
    <div class="modal" style="max-width:500px;">
        <div class="modal-header">
            <h3 class="modal-title" id="modalElementoTitulo">Nuevo <?= htmlspecialchars($nombre_items) ?></h3>
            <button class="modal-close" onclick="$('#modalElemento').hide()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="formElemento">
                <input type="hidden" id="elementoId" name="id">
                <div class="form-group">
                    <label>Nombre *</label>
                    <input type="text" id="elemNombre" name="nombre" class="input" required>
                </div>
                <div class="form-group">
                    <label>Tipo</label>
                    <select id="elemTipo" name="tipo" class="input" onchange="cambiarLabels()">
                        <option value="">Seleccionar tipo...</option>
                        <option value="Arma">Arma</option>
                        <option value="Carta">Carta</option>
                        <option value="Hechizo">Hechizo</option>
                        <option value="Objeto">Objeto</option>
                        <option value="Otro">Otro</option>
                    </select>
                </div>
                <div class="form-group">
                    <label id="labelValor1">Valor 1</label>
                    <input type="text" id="elemValor1" name="valor1" class="input">
                </div>
                <div class="form-group">
                    <label id="labelValor2">Valor 2</label>
                    <input type="text" id="elemValor2" name="valor2" class="input">
                </div>
                <div class="form-group">
                    <label>Rareza</label>
                    <select id="elemRareza" name="rareza" class="input">
                        <option value="">Sin rareza</option>
                        <option value="Común">Común</option>
                        <option value="Raro">Raro</option>
                        <option value="Épico">Épico</option>
                        <option value="Legendario">Legendario</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Descripción</label>
                    <textarea id="elemDescripcion" name="descripcion" class="input" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label>Imagen</label>
                    <input type="file" id="elemImagen" name="imagen" class="input" accept="image/*">
                    <small class="text-muted">Dejar vacío para mantener la actual.</small>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="$('#modalElemento').hide()">Cancelar</button>
            <button class="btn btn-primary" onclick="guardarElemento()">Guardar</button>
        </div>
    </div>
</div>

<?php include "../sec/footer.php"; ?>

<script>
    var idJuego = <?= (int) $id_juego ?>;
    var nombreItems = '<?= addslashes(htmlspecialchars($nombre_items)) ?>';
    var elementosData = [];

    function escapeHtml(text) {
        if (!text) return '';
        return $('<div>').text(String(text)).html();
    }

    // Icono por tipo
    function iconoPorTipo(tipo) {
        var iconos = {
            'Arma': '⚔️',
            'Carta': '🃏',
            'Hechizo': '✨',
            'Objeto': '🎒',
            'Otro': '📦'
        };
        return iconos[tipo] || '📦';
    }

    // Clase CSS por rareza
    function clasePorRareza(rareza) {
        if (!rareza) return '';
        var r = rareza.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
        var clases = { 'comun': 'rareza-comun', 'raro': 'rareza-raro', 'epico': 'rareza-epico', 'legendario': 'rareza-legendario' };
        return clases[r] || '';
    }

    // Color por rareza
    function colorPorRareza(rareza) {
        if (!rareza) return 'var(--text-secondary)';
        var r = rareza.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
        var colores = { 'comun': '#888', 'raro': '#4a9eff', 'epico': '#a855f7', 'legendario': '#f59e0b' };
        return colores[r] || 'var(--text-secondary)';
    }

    function cambiarLabels() {
        var tipo = $("#elemTipo").val();
        var labels = {
            'Arma': { v1: 'Daño', v2: 'Munición' },
            'Carta': { v1: 'Puntos', v2: 'Coste' },
            'Hechizo': { v1: 'Poder', v2: 'Maná' },
            'Objeto': { v1: 'Efecto', v2: 'Duración' },
            'Otro': { v1: 'Valor 1', v2: 'Valor 2' }
        };
        var lbl = labels[tipo] || labels['Otro'];
        $("#labelValor1").text(lbl.v1);
        $("#labelValor2").text(lbl.v2);
    }

    function cargarElementos() {
        $.post("../controladores/controlador_admin.php", { opt: 10, id_juego: idJuego }, function (elementos) {
            elementosData = Array.isArray(elementos) ? elementos : [];
            var html = "";

            if (elementosData.length === 0) {
                html = '<p class="text-muted">No hay ' + nombreItems + '. ¡Añade el primero!</p>';
            } else {
                elementosData.forEach(function (e) {
                    var rareza = e.rareza || '';
                    var claseRareza = clasePorRareza(rareza);
                    var color = colorPorRareza(rareza);
                    var icono = iconoPorTipo(e.tipo);

                    html += '<div class="elemento-card ' + claseRareza + '" onclick="verDetalle(' + e.id + ')">' +
                        '<div class="elemento-card-icon">' + icono + '</div>' +
                        '<div class="elemento-card-acciones">' +
                        '<button class="btn btn-sm btn-primary" onclick="event.stopPropagation(); editarElemento(' + e.id + ')">' +
                        '<i class="fas fa-edit"></i>' +
                        '</button>' +
                        '<button class="btn btn-sm btn-danger" onclick="event.stopPropagation(); eliminarElemento(' + e.id + ')">' +
                        '<i class="fas fa-trash"></i>' +
                        '</button>' +
                        '</div>' +
                        '<div class="elemento-card-info">' +
                        '<div class="elemento-card-nombre">' + escapeHtml(e.nombre) + '</div>' +
                        '<div class="elemento-card-tipo">' + escapeHtml(e.tipo || 'Sin tipo') + '</div>' +
                        (rareza ? '<div class="elemento-card-rareza" style="color:' + color + '">' + escapeHtml(rareza) + '</div>' : '') +
                        '</div>' +
                        '</div>';
                });
            }

            $("#gridElementos").html(html);
        }, "json");
    }

    function verDetalle(id) {
        var e = elementosData.find(function (x) { return x.id == id; });
        if (!e) return;

        var labels = {
            'Arma': { v1: 'Daño', v2: 'Munición' },
            'Carta': { v1: 'Puntos', v2: 'Coste' },
            'Hechizo': { v1: 'Poder', v2: 'Maná' },
            'Objeto': { v1: 'Efecto', v2: 'Duración' },
            'Otro': { v1: 'Valor 1', v2: 'Valor 2' }
        };
        var lbl = labels[e.tipo] || labels['Otro'];
        var color = colorPorRareza(e.rareza);

        // Mostrar imagen o icono
        var $iconoContainer = $("#detalleIcono");
        $iconoContainer.empty(); // Limpiar contenido anterior

        if (e.imagen) {
            // Si tiene imagen, mostrarla
            $iconoContainer.html('<img src="../assets/img/elementos/' + e.imagen + '" style="width:120px;height:120px;object-fit:contain;border-radius:8px;" onerror="this.style.display=\'none\';$iconoContainer.text(\'' + iconoPorTipo(e.tipo) + '\')">');
        } else {
            // Si no tiene imagen, mostrar el icono por defecto
            $iconoContainer.text(iconoPorTipo(e.tipo));
        }
        $("#detalleNombre").text(e.nombre);
        $("#detalleTipo").text(e.tipo || '-');
        $("#detalleLabel1").text(lbl.v1);
        $("#detalleValor1").text(e.valor1 || '-');
        $("#detalleLabel2").text(lbl.v2);
        $("#detalleValor2").text(e.valor2 || '-');
        $("#detalleRareza").text(e.rareza || '-').css('color', color).css('font-weight', '600');
        $("#detalleDescripcion").text(e.descripcion || '-');

        $("#btnEditarDesdeDetalle").off("click").on("click", function () {
            $("#modalDetalle").hide();
            editarElemento(id);
        });

        $("#modalDetalle").show();
    }

    function abrirModalElemento() {
        $("#modalElementoTitulo").text("Nuevo " + nombreItems);
        $("#formElemento")[0].reset();
        $("#elementoId").val("");
        cambiarLabels();
        $("#modalElemento").show();
    }

    function editarElemento(id) {
        $.post("../controladores/controlador_admin.php", { opt: 11, id: id }, function (e) {
            $("#modalElementoTitulo").text("Editar " + nombreItems);
            $("#elementoId").val(e.id);
            $("#elemNombre").val(e.nombre);
            $("#elemTipo").val(e.tipo);
            $("#elemValor1").val(e.valor1);
            $("#elemValor2").val(e.valor2);
            $("#elemRareza").val(e.rareza);
            $("#elemDescripcion").val(e.descripcion);
            cambiarLabels();
            $("#modalElemento").show();
        }, "json");
    }

    function guardarElemento() {
        var id = $("#elementoId").val();
        var formData = new FormData($("#formElemento")[0]);
        formData.append("opt", id ? 13 : 12);
        formData.append("id_juego", idJuego);
        if (id) formData.append("id", id);

        $.ajax({
            type: "post",
            url: "../controladores/controlador_admin.php",
            data: formData,
            processData: false,
            contentType: false,
            dataType: "json",
            success: function (res) {
                if (res.success) {
                    $("#modalElemento").hide();
                    cargarElementos();
                } else {
                    alert("Error: " + (res.error || "No se pudo guardar"));
                }
            }
        });
    }

    function eliminarElemento(id) {
        if (!confirm("¿Eliminar este " + nombreItems + "?")) return;
        $.post("../controladores/controlador_admin.php", { opt: 14, id: id }, function (res) {
            if (res.success) cargarElementos();
        }, "json");
    }

    $(document).ready(function () {
        cargarElementos();
    });
</script>