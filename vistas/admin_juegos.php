<?php
include "../sec/bdd.php";
include "../sec/sec.php";

$paginaActiva = '';

if ($_SESSION['level'] > 1) {
    header("location: ../index.php");
    exit;
}

// Obtener lista de juegos para la tabla
if ($_SESSION['level'] == 0) {
    $stmt = $db->prepare("SELECT id, titulo, desarrollador, fecha_lanzamiento, creador_id FROM juegos ORDER BY titulo");
    $stmt->execute();
} else {
    $stmt = $db->prepare("SELECT id, titulo, desarrollador, fecha_lanzamiento, creador_id FROM juegos WHERE creador_id = ? ORDER BY titulo");
    $stmt->bind_param("i", $_SESSION['id']);
    $stmt->execute();
}
$juegos = $stmt->get_result()->fetch_all(MYSQLI_ASSOC) ?? [];

include "../sec/header.php";
?>

<div class="main-container">
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h1><i class="fas fa-gamepad"></i> Gestión de Juegos</h1>
        <button class="btn btn-primary" onclick="abrirModalJuego()"><i class="fas fa-plus"></i> Nuevo Juego</button>
    </div>

    <!-- Tabla de juegos -->
    <div class="table-container" style="margin-top: var(--spacing-lg);">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Título</th>
                    <th>Desarrollador</th>
                    <th>Lanzamiento</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($juegos as $j): ?>
                    <tr>
                        <td><?= $j['id'] ?></td>
                        <td><?= htmlspecialchars($j['titulo']) ?></td>
                        <td><?= htmlspecialchars($j['desarrollador'] ?? '-') ?></td>
                        <td><?= $j['fecha_lanzamiento'] ? date('d/m/Y', strtotime($j['fecha_lanzamiento'])) : '-' ?></td>
                        <td>
                            <button class="btn btn-sm btn-primary" onclick="editarJuego(<?= $j['id'] ?>)"><i
                                    class="fas fa-edit"></i></button>
                            <button class="btn btn-sm btn-danger" onclick="eliminarJuego(<?= $j['id'] ?>)"><i
                                    class="fas fa-trash"></i></button>
                            <a href="gestion_elementos.php?id_juego=<?= $j['id'] ?>" class="btn btn-sm btn-secondary"><i
                                    class="fas fa-gun"></i> Elementos</a>
                            <a href="gestion_personajes.php?id_juego=<?= $j['id'] ?>" class="btn btn-sm btn-secondary"><i
                                    class="fas fa-users"></i> Personajes</a>
                            <a href="gestion_mapa.php?id_juego=<?= $j['id'] ?>" class="btn btn-sm btn-secondary"><i
                                    class="fas fa-map"></i> Mapa</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal Juego (Nuevo/Editar) -->
<div id="modalJuego" class="modal-overlay" style="display: none;">
    <div class="modal" style="max-width: 600px;">
        <div class="modal-header">
            <h3 class="modal-title" id="modalJuegoTitulo">Nuevo Juego</h3>
            <button class="modal-close" onclick="$('#modalJuego').hide()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="formJuego" enctype="multipart/form-data">
                <input type="hidden" id="juegoId" name="id">
                <div class="form-group">
                    <label>Título *</label>
                    <input type="text" id="juegoTitulo" name="titulo" class="input" required>
                </div>
                <div class="form-group">
                    <label>Desarrollador</label>
                    <input type="text" id="juegoDesarrollador" name="desarrollador" class="input">
                </div>
                <div class="form-group">
                    <label>Distribuidora</label>
                    <input type="text" id="juegoDistribuidora" name="distribuidora" class="input">
                </div>
                <div class="form-group">
                    <label>Fecha de lanzamiento</label>
                    <input type="date" id="juegoFecha" name="fecha" class="input">
                </div>
                <div class="form-group">
                    <label>Género</label>
                    <input type="text" id="juegoGenero" name="genero" class="input">
                </div>
                <div class="form-group">
                    <label>Descripción</label>
                    <textarea id="juegoDescripcion" name="descripcion" class="input" rows="4"></textarea>
                </div>
                <div class="form-group">
                    <label>Enlace de compra (Steam, GOG...)</label>
                    <input type="url" id="juegoEnlace" name="enlace_compra" class="input"
                        placeholder="https://store.steampowered.com/app/...">
                </div>
                <div class="form-group">
                    <label>Portada</label>
                    <input type="file" id="juegoPortada" name="portada" class="input" accept="image/*">
                    <small class="text-muted">Dejar vacío para mantener la actual.</small>
                </div>
                <div class="form-group">
                    <label>
                        <input type="checkbox" id="juegoEnDesarrollo" name="en_desarrollo" value="1">
                        Marcar como "En desarrollo" (próximo lanzamiento)
                    </label>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="$('#modalJuego').hide()">Cancelar</button>
            <button class="btn btn-primary" onclick="guardarJuego()">Guardar</button>
        </div>
    </div>
</div>

<script>
    // Funciones para manejar el CRUD de juegos

    function abrirModalJuego() {
        $("#modalJuegoTitulo").text("Nuevo Juego");
        $("#formJuego")[0].reset();
        $("#juegoId").val("");
        $("#modalJuego").show();
    }

    function editarJuego(id) {
        $.post("../controladores/controlador_admin.php", { opt: 2, id: id }, function (j) {
            $("#modalJuegoTitulo").text("Editar Juego");
            $("#juegoId").val(j.id);
            $("#juegoTitulo").val(j.titulo);
            $("#juegoDesarrollador").val(j.desarrollador);
            $("#juegoDistribuidora").val(j.distribuidora);
            $("#juegoFecha").val(j.fecha_lanzamiento);
            $("#juegoGenero").val(j.genero);
            $("#juegoDescripcion").val(j.descripcion);
            $("#modalJuego").show();
            $("#juegoEnDesarrollo").prop("checked", j.en_desarrollo == 1);
        }, "json");
    }

    function guardarJuego() {
        var id = $("#juegoId").val();
        var formData = new FormData($("#formJuego")[0]);
        formData.append("opt", id ? 4 : 3);
        formData.append("en_desarrollo", $("#juegoEnDesarrollo").is(":checked") ? 1 : 0);
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
                    $("#modalJuego").hide();
                    location.reload();
                } else {
                    alert("Error al guardar");
                }
            }
        });
    }

    function eliminarJuego(id) {
        if (!confirm("¿Eliminar este juego y todo su contenido?")) return;
        $.post("../controladores/controlador_admin.php", { opt: 5, id: id }, function (res) {
            if (res.success) location.reload();
        }, "json");
    }
</script>

<?php include "../sec/footer.php"; ?>