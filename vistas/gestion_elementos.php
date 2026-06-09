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

// Verificar que el usuario es el creador o admin
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
    <a href="admin_juegos.php" class="btn"><i class="fas fa-arrow-left"></i> <?= $idioma->palabras->pj_volver ?></a>
    <div style="display:flex; justify-content:space-between; align-items:center; margin-top: var(--spacing-md);">
        <h1><?= htmlspecialchars($nombre_items) ?> de: <?= htmlspecialchars($juego['titulo']) ?></h1>
        <button class="btn btn-primary" onclick="abrirModalElemento()">
            <i class="fas fa-plus"></i> <?= $idioma->palabras->elem_añadir ?> <?= htmlspecialchars($nombre_items) ?>
        </button>
    </div>

    <!-- Grid de elementos -->
    <div class="elementos-grid" id="gridElementos">
        <p class="text-muted"><?= $idioma->palabras->pj_cargando ?></p>
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
                <span class="detalle-label"><?= $idioma->palabras->elem_detalle_tipo ?></span>
                <span class="detalle-valor" id="detalleTipo"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label" id="detalleLabel1"><?= $idioma->palabras->elem_valor1_default ?></span>
                <span class="detalle-valor" id="detalleValor1"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label" id="detalleLabel2"><?= $idioma->palabras->elem_valor2_default ?></span>
                <span class="detalle-valor" id="detalleValor2"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label"><?= $idioma->palabras->elem_detalle_rareza ?></span>
                <span class="detalle-valor" id="detalleRareza"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label"><?= $idioma->palabras->elem_detalle_descripcion ?></span>
                <span class="detalle-valor" id="detalleDescripcion"></span>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="$('#modalDetalle').hide()"><?= $idioma->palabras->Cerrar ?></button>
            <button class="btn btn-primary" id="btnEditarDesdeDetalle">
                <i class="fas fa-edit"></i> <?= $idioma->palabras->pj_editar ?>
            </button>
        </div>
    </div>
</div>

<!-- Modal editar/crear elemento -->
<div id="modalElemento" class="modal-overlay" style="display:none;">
    <div class="modal" style="max-width:500px;">
        <div class="modal-header">
            <h3 class="modal-title" id="modalElementoTitulo"><?= $idioma->palabras->elem_nuevo ?>
                <?= htmlspecialchars($nombre_items) ?>
            </h3>
            <button class="modal-close" onclick="$('#modalElemento').hide()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="formElemento">
                <input type="hidden" id="elementoId" name="id">
                <div class="form-group">
                    <label><?= $idioma->palabras->elem_nombre_label ?></label>
                    <input type="text" id="elemNombre" name="nombre" class="input" required>
                </div>
                <div class="form-group">
                    <label><?= $idioma->palabras->elem_tipo_label ?></label>
                    <select id="elemTipo" name="tipo" class="input" onchange="cambiarLabels()">
                        <option value=""><?= $idioma->palabras->elem_tipo_placeholder ?></option>
                        <option value="Arma"><?= $idioma->palabras->elem_tipo_arma ?></option>
                        <option value="Carta"><?= $idioma->palabras->elem_tipo_carta ?></option>
                        <option value="Hechizo"><?= $idioma->palabras->elem_tipo_hechizo ?></option>
                        <option value="Objeto"><?= $idioma->palabras->elem_tipo_objeto ?></option>
                        <option value="Armadura/Traje"><?= $idioma->palabras->elem_tipo_armadura ?></option>
                        <option value="Otro"><?= $idioma->palabras->elem_tipo_otro ?></option>
                    </select>
                    <input type="text" id="elemTipoCustom" name="tipo_custom" class="input"
                        placeholder="<?= $idioma->palabras->elem_tipo_custom_placeholder ?>"
                        style="display:none; margin-top:5px;">
                </div>
                <div class="form-group">
                    <label id="labelValor1"><?= $idioma->palabras->elem_valor1_default ?></label>
                    <input type="text" id="elemValor1" name="valor1" class="input">
                </div>
                <div class="form-group">
                    <label id="labelValor2"><?= $idioma->palabras->elem_valor2_default ?></label>
                    <input type="text" id="elemValor2" name="valor2" class="input">
                </div>
                <div class="form-group">
                    <label><?= $idioma->palabras->elem_rareza_label ?></label>
                    <select id="elemRareza" name="rareza" class="input">
                        <option value=""><?= $idioma->palabras->elem_rareza_sin ?></option>
                        <option value="Común"><?= $idioma->palabras->elem_rareza_comun ?></option>
                        <option value="Raro"><?= $idioma->palabras->elem_rareza_raro ?></option>
                        <option value="Épico"><?= $idioma->palabras->elem_rareza_epico ?></option>
                        <option value="Legendario"><?= $idioma->palabras->elem_rareza_legendario ?></option>
                    </select>
                </div>
                <div class="form-group">
                    <label><?= $idioma->palabras->elem_descripcion_label ?></label>
                    <textarea id="elemDescripcion" name="descripcion" class="input" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label><?= $idioma->palabras->elem_imagen_label ?></label>
                    <input type="file" id="elemImagen" name="imagen" class="input" accept="image/*">
                    <small class="text-muted"><?= $idioma->palabras->pj_imagen_info ?></small>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="$('#modalElemento').hide()"><?= $idioma->palabras->Cerrar ?></button>
            <button class="btn btn-primary" onclick="guardarElemento()"><?= $idioma->palabras->pj_guardar ?></button>
        </div>
    </div>
</div>

<?php include "../sec/footer.php"; ?>

<script>
    // Traducciones pasadas desde PHP
    var nombreItems = '<?= addslashes(htmlspecialchars($nombre_items)) ?>';
    var msgNoHay = '<?= addslashes($idioma->palabras->elem_no_hay) ?>';
    var msgEliminar = '<?= addslashes($idioma->palabras->elem_confirmar_eliminar) ?>';
    var msgErrorTipo = '<?= addslashes($idioma->palabras->elem_error_tipo_obligatorio) ?>';
    var msgErrorGuardar = '<?= addslashes($idioma->palabras->elem_error_guardar) ?>';
    var labelSinTipo = '<?= addslashes($idioma->palabras->elem_sin_tipo) ?>';
    var labelEditar = '<?= addslashes($idioma->palabras->elem_editar) ?>';
    var labelNuevo = '<?= addslashes($idioma->palabras->elem_nuevo) ?>';

    var labelsJS = {
        'Arma': { v1: '<?= addslashes($idioma->palabras->elem_label_dano) ?>', v2: '<?= addslashes($idioma->palabras->elem_label_municion) ?>' },
        'Carta': { v1: '<?= addslashes($idioma->palabras->elem_label_puntos) ?>', v2: '<?= addslashes($idioma->palabras->elem_label_coste) ?>' },
        'Hechizo': { v1: '<?= addslashes($idioma->palabras->elem_label_poder) ?>', v2: '<?= addslashes($idioma->palabras->elem_label_mana) ?>' },
        'Objeto': { v1: '<?= addslashes($idioma->palabras->elem_label_efecto) ?>', v2: '<?= addslashes($idioma->palabras->elem_label_duracion) ?>' },
        'Armadura/Traje': { v1: '<?= addslashes($idioma->palabras->elem_label_defensa) ?>', v2: '<?= addslashes($idioma->palabras->elem_label_resistencia) ?>' },
        'Otro': { v1: '<?= addslashes($idioma->palabras->elem_valor1_default) ?>', v2: '<?= addslashes($idioma->palabras->elem_valor2_default) ?>' }
    };

    var idJuego = <?= (int) $id_juego ?>;
    var elementosData = [];

    function escapeHtml(text) {
        if (!text) return '';
        return $('<div>').text(String(text)).html();
    }

    function iconoPorTipo(tipo) {
        var iconos = {
            'Arma': '⚔️',
            'Carta': '🃏',
            'Hechizo': '✨',
            'Objeto': '🎒',
            'Armadura/Traje': '🛡️',
            'Otro': '📦'
        };
        return iconos[tipo] || '📦';
    }

    function clasePorRareza(rareza) {
        if (!rareza) return '';
        var r = rareza.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
        var clases = { 'comun': 'rareza-comun', 'raro': 'rareza-raro', 'epico': 'rareza-epico', 'legendario': 'rareza-legendario' };
        return clases[r] || '';
    }

    function colorPorRareza(rareza) {
        if (!rareza) return 'var(--text-secondary)';
        var r = rareza.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
        var colores = { 'comun': '#888', 'raro': '#4a9eff', 'epico': '#a855f7', 'legendario': '#f59e0b' };
        return colores[r] || 'var(--text-secondary)';
    }

    function cambiarLabels() {
        var tipo = $("#elemTipo").val();
        if (tipo === 'Otro') {
            $("#elemTipoCustom").show().focus();
            var defLabels = labelsJS['Otro'];
            $("#labelValor1").text(defLabels.v1);
            $("#labelValor2").text(defLabels.v2);
        } else {
            $("#elemTipoCustom").hide().val('');
            var lbl = labelsJS[tipo] || labelsJS['Otro'];
            $("#labelValor1").text(lbl.v1);
            $("#labelValor2").text(lbl.v2);
        }
    }

    function cargarElementos() {
        $.post("../controladores/controlador_admin.php", { opt: 10, id_juego: idJuego }, function (elementos) {
            elementosData = Array.isArray(elementos) ? elementos : [];
            var html = "";

            if (elementosData.length === 0) {
                html = '<p class="text-muted">' + msgNoHay.replace('{nombre}', nombreItems) + '</p>';
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
                        '<div class="elemento-card-tipo">' + escapeHtml(e.tipo || labelSinTipo) + '</div>' +
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

        var lbl = labelsJS[e.tipo] || labelsJS['Otro'];
        var color = colorPorRareza(e.rareza);

        var $iconoContainer = $("#detalleIcono");
        $iconoContainer.empty();

        if (e.imagen) {
            $iconoContainer.html('<img src="../assets/img/elementos/' + e.imagen + '" style="width:120px;height:120px;object-fit:contain;border-radius:8px;" onerror="this.style.display=\'none\';$iconoContainer.text(\'' + iconoPorTipo(e.tipo) + '\')">');
        } else {
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
        $("#modalElementoTitulo").text(labelNuevo + " " + nombreItems);
        $("#formElemento")[0].reset();
        $("#elementoId").val("");
        $("#elemTipoCustom").hide().val('');
        cambiarLabels();
        $("#modalElemento").show();
    }

    function editarElemento(id) {
        $.post("../controladores/controlador_admin.php", { opt: 11, id: id }, function (e) {
            $("#modalElementoTitulo").text(labelEditar + " " + nombreItems);
            $("#elementoId").val(e.id);
            $("#elemNombre").val(e.nombre);

            var tiposFijos = ["Arma", "Carta", "Hechizo", "Objeto", "Armadura/Traje", ""];
            if (tiposFijos.includes(e.tipo)) {
                $("#elemTipo").val(e.tipo);
                $("#elemTipoCustom").hide().val('');
            } else {
                $("#elemTipo").val('Otro');
                $("#elemTipoCustom").show().val(e.tipo);
            }

            $("#elemSubtipo").val(e.subtipo || '');
            $("#elemValor1").val(e.valor1 || '');
            $("#elemValor2").val(e.valor2 || '');
            $("#elemRareza").val(e.rareza || '');
            $("#elemDescripcion").val(e.descripcion || '');
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

        var tipo = $("#elemTipo").val();
        if (tipo === 'Otro') {
            tipo = $("#elemTipoCustom").val().trim();
            if (!tipo) {
                alert(msgErrorTipo);
                return;
            }
        }
        formData.set("tipo", tipo);

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
                    alert(msgErrorGuardar + " " + (res.error || ""));
                }
            }
        });
    }

    function eliminarElemento(id) {
        if (!confirm(msgEliminar.replace('{nombre}', nombreItems))) return;
        $.post("../controladores/controlador_admin.php", { opt: 14, id: id }, function (res) {
            if (res.success) cargarElementos();
        }, "json");
    }

    $(document).ready(function () {
        cargarElementos();
    });
</script>