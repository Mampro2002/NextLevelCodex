<?php
include "../sec/bdd.php";
include "../sec/sec.php";

$id_juego = isset($_GET['id_juego']) ? (int) $_GET['id_juego'] : 0;
if ($id_juego <= 0) {
    header("location: admin_juegos.php");
    exit;
}

$stmt = $db->prepare("SELECT titulo FROM juegos WHERE id = ?");
$stmt->bind_param("i", $id_juego);
$stmt->execute();
$juego = $stmt->get_result()->fetch_assoc();

if (!$juego) {
    header("location: admin_juegos.php");
    exit;
}

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
    .personajes-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
        gap: var(--spacing-lg);
        margin-top: var(--spacing-lg);
    }

    .personaje-card {
        background: var(--bg-secondary);
        border-radius: var(--border-radius-lg);
        overflow: hidden;
        cursor: pointer;
        transition: transform 0.2s, box-shadow 0.2s;
        position: relative;
    }

    .personaje-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
    }

    .personaje-card img {
        width: 100%;
        height: 220px;
        object-fit: cover;
        display: block;
    }

    .personaje-card-info {
        padding: var(--spacing-sm) var(--spacing-md);
    }

    .personaje-card-nombre {
        font-weight: 600;
        font-size: 15px;
        margin-bottom: 2px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .personaje-card-rol {
        font-size: 12px;
        color: var(--text-secondary);
    }

    .personaje-card-acciones {
        position: absolute;
        top: var(--spacing-xs);
        right: var(--spacing-xs);
        display: flex;
        gap: 4px;
        opacity: 0;
        transition: opacity 0.2s;
    }

    .personaje-card:hover .personaje-card-acciones {
        opacity: 1;
    }

    /* Modal detalle */
    .modal-detalle-img {
        width: 100%;
        max-height: 300px;
        object-fit: cover;
        border-radius: var(--border-radius);
        margin-bottom: var(--spacing-md);
    }

    .detalle-row {
        display: flex;
        gap: var(--spacing-sm);
        margin-bottom: var(--spacing-sm);
    }

    .detalle-label {
        font-weight: 600;
        color: var(--text-secondary);
        min-width: 90px;
        font-size: 13px;
    }

    .detalle-valor {
        font-size: 14px;
    }
</style>

<div class="main-container">
    <a href="admin_juegos.php" class="btn"><i class="fas fa-arrow-left"></i> <?= $idioma->palabras->pj_volver ?></a>
    <div style="display:flex; justify-content:space-between; align-items:center; margin-top: var(--spacing-md);">
        <h1><i class="fas fa-users"></i> <?= $idioma->palabras->pj_titulo ?> <?= htmlspecialchars($juego['titulo']) ?>
        </h1>
        <button class="btn btn-primary" onclick="abrirModalPersonaje()">
            <i class="fas fa-plus"></i> <?= $idioma->palabras->pj_añadir ?>
        </button>
    </div>

    <!-- Grid de personajes -->
    <div class="personajes-grid" id="gridPersonajes">
        <p class="text-muted"><?= $idioma->palabras->pj_cargando ?></p>
    </div>
</div>

<!-- Modal detalle personaje (solo lectura) -->
<div id="modalDetalle" class="modal-overlay" style="display:none;">
    <div class="modal" style="max-width:500px;">
        <div class="modal-header">
            <h3 class="modal-title" id="detalleNombre"></h3>
            <button class="modal-close" onclick="$('#modalDetalle').hide()">&times;</button>
        </div>
        <div class="modal-body">
            <img id="detalleImg" src="" alt="" class="modal-detalle-img"
                onerror="this.src='../assets/img/avatars/default.jpg'">
            <div class="detalle-row">
                <span class="detalle-label"><?= $idioma->palabras->pj_rol ?></span>
                <span class="detalle-valor" id="detalleRol"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label"><?= $idioma->palabras->pj_ubicacion ?></span>
                <span class="detalle-valor" id="detalleUbicacion"></span>
            </div>
            <div class="detalle-row">
                <span class="detalle-label"><?= $idioma->palabras->pj_descripcion ?></span>
                <span class="detalle-valor" id="detalleDescripcion"></span>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="$('#modalDetalle').hide()"><?= $idioma->palabras->Cerrar ?></button>
            <button class="btn btn-primary" id="btnEditarDesdeDetalle"><i class="fas fa-edit"></i>
                <?= $idioma->palabras->pj_editar ?></button>
        </div>
    </div>
</div>

<!-- Modal editar/crear personaje -->
<div id="modalPersonaje" class="modal-overlay" style="display:none;">
    <div class="modal" style="max-width:500px;">
        <div class="modal-header">
            <h3 class="modal-title" id="modalPersonajeTitulo"><?= $idioma->palabras->pj_nuevo_personaje ?></h3>
            <button class="modal-close" onclick="$('#modalPersonaje').hide()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="formPersonaje" enctype="multipart/form-data">
                <input type="hidden" id="personajeId" name="id">
                <div class="form-group">
                    <label><?= $idioma->palabras->pj_nombre ?></label>
                    <input type="text" id="pjNombre" name="nombre" class="input" required>
                </div>
                <div class="form-group">
                    <label><?= $idioma->palabras->pj_rol ?></label>
                    <input type="text" id="pjRol" name="rol" class="input"
                        placeholder="<?= $idioma->palabras->pj_placeholder_rol ?>">
                </div>
                <div class="form-group">
                    <label><?= $idioma->palabras->pj_ubicacion ?></label>
                    <input type="text" id="pjUbicacion" name="ubicacion" class="input">
                </div>
                <div class="form-group">
                    <label><?= $idioma->palabras->pj_descripcion ?></label>
                    <textarea id="pjDescripcion" name="descripcion" class="input" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label><?= $idioma->palabras->pj_imagen ?></label>
                    <input type="file" id="pjImagen" name="imagen" class="input" accept=".jpg,.jpeg,.png,.webp">
                    <small class="text-muted"><?= $idioma->palabras->pj_imagen_info ?></small>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="$('#modalPersonaje').hide()"><?= $idioma->palabras->Cerrar ?></button>
            <button class="btn btn-primary" onclick="guardarPersonaje()"><?= $idioma->palabras->pj_guardar ?></button>
        </div>
    </div>
</div>

<?php include "../sec/footer.php"; ?>

<script>
    var idJuego = <?= (int) $id_juego ?>;
    var personajesData = [];

    function escapeHtml(text) {
        if (!text) return '';
        return $('<div>').text(String(text)).html();
    }

    function cargarPersonajes() {
        $.post("../controladores/controlador_admin.php", { opt: 20, id_juego: idJuego }, function (personajes) {
            personajesData = Array.isArray(personajes) ? personajes : [];
            var html = "";

            if (personajesData.length === 0) {
                html = '<p class="text-muted"><?= $idioma->palabras->pj_sin_personajes ?></p>';
            } else {
                personajesData.forEach(function (p) {
                    var img = p.imagen ? '../assets/img/personajes/' + escapeHtml(p.imagen) : '../assets/img/avatars/default.jpg';
                    html += '<div class="personaje-card" onclick="verDetalle(' + p.id + ')">' +
                        '<img src="' + img + '" alt="' + escapeHtml(p.nombre) + '" ' +
                        'onerror="this.src=\'../assets/img/avatars/default.jpg\'">' +
                        '<div class="personaje-card-acciones">' +
                        '<button class="btn btn-sm btn-primary" onclick="event.stopPropagation(); editarPersonaje(' + p.id + ')">' +
                        '<i class="fas fa-edit"></i>' +
                        '</button>' +
                        '<button class="btn btn-sm btn-danger" onclick="event.stopPropagation(); eliminarPersonaje(' + p.id + ')">' +
                        '<i class="fas fa-trash"></i>' +
                        '</button>' +
                        '</div>' +
                        '<div class="personaje-card-info">' +
                        '<div class="personaje-card-nombre">' + escapeHtml(p.nombre) + '</div>' +
                        '<div class="personaje-card-rol">' + escapeHtml(p.rol || '<?= $idioma->palabras->pj_sin_rol ?>') + '</div>' +
                        '</div>' +
                        '</div>';
                });
            }

            $("#gridPersonajes").html(html);
        }, "json");
    }

    function verDetalle(id) {
        var p = personajesData.find(function (x) { return x.id == id; });
        if (!p) return;

        var img = p.imagen ? '../assets/img/personajes/' + p.imagen : '../assets/img/avatars/default.jpg';
        $("#detalleImg").attr("src", img);
        $("#detalleNombre").text(p.nombre);
        $("#detalleRol").text(p.rol || '-');
        $("#detalleUbicacion").text(p.ubicacion || '-');
        $("#detalleDescripcion").text(p.descripcion || '-');
        $("#btnEditarDesdeDetalle").off("click").on("click", function () {
            $("#modalDetalle").hide();
            editarPersonaje(id);
        });

        $("#modalDetalle").show();
    }

    function abrirModalPersonaje() {
        $("#modalPersonajeTitulo").text("<?= $idioma->palabras->pj_nuevo_personaje ?>");
        $("#formPersonaje")[0].reset();
        $("#personajeId").val("");
        $("#modalPersonaje").show();
    }

    function editarPersonaje(id) {
        $.post("../controladores/controlador_admin.php", { opt: 21, id: id }, function (p) {
            $("#modalPersonajeTitulo").text("<?= $idioma->palabras->pj_editar_personaje ?>");
            $("#personajeId").val(p.id);
            $("#pjNombre").val(p.nombre);
            $("#pjRol").val(p.rol);
            $("#pjUbicacion").val(p.ubicacion);
            $("#pjDescripcion").val(p.descripcion);
            $("#modalPersonaje").show();
        }, "json");
    }

    function guardarPersonaje() {
        var id = $("#personajeId").val();
        var formData = new FormData($("#formPersonaje")[0]);
        formData.append("opt", id ? 23 : 22);
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
                    $("#modalPersonaje").hide();
                    cargarPersonajes();
                } else {
                    alert("<?= $idioma->palabras->pj_error_guardar ?> " + (res.error || ""));
                }
            }
        });
    }

    function eliminarPersonaje(id) {
        if (!confirm("<?= $idioma->palabras->pj_confirmar_eliminar ?>")) return;
        $.post("../controladores/controlador_admin.php", { opt: 24, id: id }, function (res) {
            if (res.success) cargarPersonajes();
        }, "json");
    }

    $(document).ready(function () {
        cargarPersonajes();
    });
</script>