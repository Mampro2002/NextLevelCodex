<?php
include "../sec/bdd.php";
include "../sec/sec.php";
$paginaActiva = 'colaboradores';
$idioma = simplexml_load_file("../assets/locales/" . $_SESSION["idioma"] . ".xml");

// ✅ RENDIMIENTO: Obtener solicitudes pendientes con JOIN en una sola query
$stmtSol = $db->prepare("
    SELECT d.id_sol, d.fecha, u.user, u.nombre
    FROM domingueros d
    JOIN usuarios u ON d.id_sol = u.id
    WHERE d.id_rec = ? AND d.statu = 1
");
$stmtSol->bind_param("i", $_SESSION['id']);
$stmtSol->execute();
$solicitudes = $stmtSol->get_result()->fetch_all(MYSQLI_ASSOC);

// ✅ RENDIMIENTO: Obtener amigos con una sola query IN en lugar de N queries
$colaboradores = [];
$stmtAmigos = $db->prepare("SELECT amigos FROM usuarios WHERE id = ?");
$stmtAmigos->bind_param("i", $_SESSION['id']);
$stmtAmigos->execute();
$rowAmigos = $stmtAmigos->get_result()->fetch_assoc();
$vecAmigos = !empty($rowAmigos['amigos']) ? array_filter(explode('#', $rowAmigos['amigos'])) : [];

if (count($vecAmigos) > 0) {
    $placeholders = implode(',', array_fill(0, count($vecAmigos), '?'));
    $stmtAmigosData = $db->prepare("SELECT id, user, nombre, avatar, conectado FROM usuarios WHERE id IN ($placeholders)");
    $stmtAmigosData->bind_param(str_repeat('i', count($vecAmigos)), ...$vecAmigos);
    $stmtAmigosData->execute();
    $colaboradores = $stmtAmigosData->get_result()->fetch_all(MYSQLI_ASSOC);
}

// ✅ RENDIMIENTO: Obtener bloqueados con JOIN en una sola query
$stmtBlock = $db->prepare("
    SELECT b.id_block, u.user, u.nombre
    FROM bloqueados b
    JOIN usuarios u ON b.id_block = u.id
    WHERE b.id_recep = ?
");
$stmtBlock->bind_param("i", $_SESSION['id']);
$stmtBlock->execute();
$bloqueados = $stmtBlock->get_result()->fetch_all(MYSQLI_ASSOC);

include "../sec/header.php";
?>

<link rel="stylesheet" href="../assets/css/colaboradores.css">

<div class="main-container">
    <h1><i class="fas fa-users"></i> Centro de Colaboradores</h1>

    <!-- Pestañas -->
    <div class="tabs-container" style="margin-bottom: var(--spacing-lg);">
        <button class="tab-button active" data-tab="buscar"><i class="fas fa-search"></i> Buscar Colaboradores</button>
        <button class="tab-button" data-tab="solicitudes">
            <i class="fas fa-envelope"></i> Solicitudes Pendientes
            <?php if (count($solicitudes) > 0): ?>
                <span class="badge"><?php echo count($solicitudes); ?></span>
            <?php endif; ?>
        </button>
        <button class="tab-button" data-tab="lista"><i class="fas fa-user-friends"></i> Mis Colaboradores
            (<?php echo count($colaboradores); ?>)</button>
        <button class="tab-button" data-tab="block"><i class="fas fa-ban"></i> Bloqueados
            (<?php echo count($bloqueados); ?>)</button>
    </div>

    <!-- Pestaña: Buscar -->
    <div id="tab-buscar" class="tab-pane active">
        <div class="search-box" style="display: flex; gap: var(--spacing-sm); margin-bottom: var(--spacing-lg);">
            <input type="text" id="queryBusqueda" class="input" placeholder="Buscar por nombre o usuario..."
                style="flex: 1;">
            <button class="btn btn-primary" id="ejecutarBusqueda"><i class="fas fa-search"></i> Buscar</button>
        </div>
        <div id="status-busqueda" style="margin-bottom: var(--spacing-md);"></div>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Usuario</th>
                        <th>Nombre</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody id="cuerpoResultados"></tbody>
            </table>
        </div>
    </div>

    <!-- Pestaña: Solicitudes -->
    <div id="tab-solicitudes" class="tab-pane" style="display: none;">
        <h2><i class="fas fa-envelope"></i> Solicitudes Pendientes</h2>
        <?php if (count($solicitudes) > 0): ?>
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Usuario</th>
                            <th>Nombre</th>
                            <th>Fecha</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($solicitudes as $sol): ?>
                            <tr>
                                <td><a
                                        href="perfil_publico.php?id=<?php echo (int) $sol['id_sol']; ?>">@<?php echo htmlspecialchars($sol['user']); ?></a>
                                </td>
                                <td><?php echo htmlspecialchars($sol['nombre']); ?></td>
                                <td><?php echo date('d/m/Y H:i', $sol['fecha']); ?></td>
                                <td>
                                    <button class="btn btn-sm btn-success Aceptar"
                                        data-id="<?php echo (int) $sol['id_sol']; ?>"><i class="fas fa-check"></i>
                                        Aceptar</button>
                                    <button class="btn btn-sm btn-danger Rechazar"
                                        data-id="<?php echo (int) $sol['id_sol']; ?>"><i class="fas fa-times"></i>
                                        Rechazar</button>
                                    <button class="btn btn-sm btn-warning Bloquear"
                                        data-id="<?php echo (int) $sol['id_sol']; ?>"><i class="fas fa-ban"></i>
                                        Bloquear</button>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php else: ?>
            <p class="text-muted">No hay solicitudes pendientes.</p>
        <?php endif; ?>
    </div>

    <!-- Pestaña: Mis Colaboradores -->
    <div id="tab-lista" class="tab-pane" style="display: none;">
        <h2><i class="fas fa-user-friends"></i> Mis Colaboradores</h2>
        <?php if (count($colaboradores) > 0): ?>
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Usuario</th>
                            <th>Nombre</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($colaboradores as $col): ?>
                            <tr>
                                <td>
                                    <a href="perfil_publico.php?id=<?php echo (int) $col['id']; ?>">
                                        @<?php echo htmlspecialchars($col['user']); ?>
                                    </a>
                                </td>
                                <td><?php echo htmlspecialchars($col['nombre']); ?></td>
                                <td>
                                    <?php if ($col['conectado'] == 1): ?>
                                        <span style="color: var(--success);"><i class="fas fa-circle"></i> Conectado</span>
                                    <?php else: ?>
                                        <span class="text-muted"><i class="far fa-circle"></i> Desconectado</span>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <a href="chat_privado.php?id=<?php echo (int) $col['id']; ?>"
                                        class="btn btn-sm btn-primary"><i class="fas fa-comment"></i> Chat</a>
                                    <button class="btn btn-sm btn-danger Eliminar" data-id="<?php echo (int) $col['id']; ?>"><i
                                            class="fas fa-user-minus"></i> Eliminar</button>
                                    <button class="btn btn-sm btn-warning Bloquear" data-id="<?php echo (int) $col['id']; ?>"><i
                                            class="fas fa-ban"></i> Bloquear</button>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php else: ?>
            <p class="text-muted">Aún no tienes colaboradores.</p>
        <?php endif; ?>
    </div>

    <!-- Pestaña: Bloqueados -->
    <div id="tab-block" class="tab-pane" style="display: none;">
        <h2><i class="fas fa-ban"></i> Usuarios Bloqueados</h2>
        <?php if (count($bloqueados) > 0): ?>
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Usuario</th>
                            <th>Nombre</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($bloqueados as $block): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($block['user']); ?></td>
                                <td><?php echo htmlspecialchars($block['nombre']); ?></td>
                                <td>
                                    <button class="btn btn-sm btn-success DesBloquear"
                                        data-id="<?php echo (int) $block['id_block']; ?>"><i class="fas fa-unlock"></i>
                                        Desbloquear</button>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php else: ?>
            <p class="text-muted">No hay usuarios bloqueados.</p>
        <?php endif; ?>
    </div>
</div>

<?php include "../sec/footer.php"; ?>

<script>
    $(document).ready(function () {

        // Cambio de pestañas
        $('.tab-button').click(function () {
            var tabId = $(this).data('tab');
            $('.tab-button').removeClass('active');
            $(this).addClass('active');
            $('.tab-pane').hide();
            $('#tab-' + tabId).show();
        });

        // Buscar usuarios
        function buscar() {
            var texto = $("#queryBusqueda").val().trim();
            if (texto === "") return;
            $("#status-busqueda").html('<p class="text-muted"><i class="fas fa-spinner fa-spin"></i> Buscando...</p>');
            $.ajax({
                type: "post",
                url: "Busqueda.php",
                data: { query: texto },
                success: function (data) {
                    $("#status-busqueda").empty();
                    $("#cuerpoResultados").html(data);
                },
                error: function () {
                    $("#status-busqueda").html('<p class="text-danger">Error al buscar.</p>');
                }
            });
        }

        $("#ejecutarBusqueda").click(buscar);
        $("#queryBusqueda").keypress(function (e) {
            if (e.which === 13) buscar();
        });

        // ✅ SEGURIDAD: id_rec siempre desde PHP/sesión, nunca manipulable desde JS
        var miId = <?php echo (int) $_SESSION['id']; ?>;

        // Aceptar solicitud
        $(document).on("click", ".Aceptar", function () {
            var id_sol = $(this).data('id');
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_sol: id_sol, options: 3 },
                dataType: "text",
                success: function () { location.reload(); }
            });
        });

        // Rechazar solicitud
        $(document).on("click", ".Rechazar", function () {
            var id_sol = $(this).data('id');
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_sol: id_sol, options: 4 },
                dataType: "text",
                success: function () { location.reload(); }
            });
        });

        // Bloquear usuario
        $(document).on("click", ".Bloquear", function () {
            var id_sol = $(this).data('id');
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_sol: id_sol, options: 5 },
                dataType: "text",
                success: function () { location.reload(); }
            });
        });

        // Desbloquear usuario
        $(document).on("click", ".DesBloquear", function () {
            var id_block = $(this).data('id');
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_block: id_block, options: 7 },
                dataType: "text",
                success: function () { location.reload(); }
            });
        });

        // Eliminar colaborador
        $(document).on("click", ".Eliminar", function () {
            var id_sol = $(this).data('id');
            if (!confirm('¿Eliminar a este colaborador?')) return;
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_sol: id_sol, options: 6 },
                dataType: "text",
                success: function () { location.reload(); }
            });
        });

        // Enviar solicitud
        $(document).on("click", ".btn-send", function () {
            var id_rec = $(this).data('id');
            var btn = $(this);
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_rec: id_rec, options: 2 },
                dataType: "text",
                success: function (data) {
                    if (data.trim() === "enviada") {
                        btn.removeClass('btn-primary btn-send')
                            .addClass('btn-warning btn-cancelar')
                            .html('<i class="fas fa-times"></i> Cancelar solicitud');
                    } else {
                        alert("Error al enviar la solicitud.");
                    }
                }
            });
        });

        // Cancelar solicitud
        $(document).on("click", ".btn-cancelar", function () {
            var id_rec = $(this).data('id');
            var btn = $(this);
            $.ajax({
                type: "post",
                url: "../controladores/amigos_solicitudes.php",
                data: { id_rec: id_rec, options: 8 },
                dataType: "text",
                success: function (data) {
                    if (data.trim() === "cancelada") {
                        btn.removeClass('btn-warning btn-cancelar')
                            .addClass('btn-primary btn-send')
                            .html('<i class="fas fa-paper-plane"></i> Enviar solicitud');
                    } else if (data.trim() === "bloqueada") {
                        alert("No puedes cancelar una solicitud rechazada hasta pasados 15 días.");
                    } else {
                        alert("Error al cancelar la solicitud.");
                    }
                }
            });
        });
    });
</script>