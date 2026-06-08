<?php
include "../sec/bdd.php";
include "../sec/sec.php";
include "../modelos/modelo_juegos.php";

$paginaActiva = ''; // No pertenece a una sección principal del nav
$idioma = simplexml_load_file("../assets/locales/" . $_SESSION["idioma"] . ".xml");

// Obtener datos completos del usuario
$stmt = $db->prepare("SELECT id, user, nombre, email, avatar, bio, level, amigos, conectado FROM usuarios WHERE id = ?");
$stmt->bind_param("i", $_SESSION['id']);
$stmt->execute();
$usuario = $stmt->get_result()->fetch_assoc();

// Obtener colaboradores (amigos)
$colaboradores = [];
if (!empty($usuario['amigos'])) {
    $ids = array_filter(explode('#', $usuario['amigos']));
    if (count($ids) > 0) {
        $placeholders = implode(',', array_fill(0, count($ids), '?'));
        $stmt = $db->prepare("SELECT id, user, nombre, avatar, conectado FROM usuarios WHERE id IN ($placeholders)");
        $stmt->bind_param(str_repeat('i', count($ids)), ...$ids);
        $stmt->execute();
        $colaboradores = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }
}

// Obtener juegos añadidos por el usuario (si es admin o editor)
$juegos = [];
if ($_SESSION['level'] <= 1) {
    $stmt = $db->prepare("SELECT id, titulo, fecha_creacion FROM juegos WHERE creador_id = ? ORDER BY fecha_creacion DESC");
    $stmt->bind_param("i", $_SESSION['id']);
    $stmt->execute();
    $juegos = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

include "../sec/header.php";
?>

<div class="main-container">
    <div class="perfil-header">
        <img src="../assets/img/avatars/<?php echo htmlspecialchars($usuario['avatar'] ?: 'default.jpg'); ?>"
            alt="Avatar" class="perfil-avatar" onerror="this.src='../assets/img/avatars/default.jpg'">
        <div class="perfil-info">
            <h1><?php echo htmlspecialchars($usuario['nombre']); ?></h1>
            <p class="text-muted">@<?php echo htmlspecialchars($usuario['user']); ?></p>
            <?php if (!empty($usuario['bio'])): ?>
                <p class="perfil-bio"><?php echo nl2br(htmlspecialchars($usuario['bio'])); ?></p>
            <?php else: ?>
                <p class="text-muted"><em><?= $idioma->palabras->perfil_sinBio ?></em></p>
            <?php endif; ?>
            <p class="text-muted">
                <i class="fas fa-envelope"></i> <?php echo htmlspecialchars($usuario['email']); ?>
            </p>
        </div>
    </div>

    <div class="perfil-secciones">

        <!-- Colaboradores -->
        <div class="card" style="flex: 1;">
            <div class="card-body">
                <h2><i class="fas fa-users"></i> <?= $idioma->palabras->perfil_misColaboradores ?>
                    (<?php echo count($colaboradores); ?>)</h2>
                <?php if (count($colaboradores) > 0): ?>
                    <div class="lista-colaboradores">
                        <?php foreach ($colaboradores as $col): ?>
                            <div class="colaborador-item">
                                <img src="../assets/img/avatars/<?php echo htmlspecialchars($col['avatar'] ?: 'default.jpg'); ?>"
                                    alt="Avatar" class="mini-avatar" onerror="this.src='../assets/img/avatars/default.jpg'">
                                <span>
                                    <?php echo htmlspecialchars($col['nombre']); ?>
                                    (@<?php echo htmlspecialchars($col['user']); ?>)
                                    <?php if ($col['conectado'] == 1): ?>
                                        <span style="color: var(--success);"><i class="fas fa-circle"></i>
                                            <?= $idioma->palabras->fecha7 ?></span>
                                    <?php else: ?>
                                        <span class="text-muted"><i class="far fa-circle"></i>
                                            <?= $idioma->palabras->perfil_desconectado ?></span>
                                    <?php endif; ?>
                                </span>
                            </div>
                        <?php endforeach; ?>
                    </div>
                <?php else: ?>
                    <p class="text-muted"><?= $idioma->palabras->perfil_sinColaboradores ?></p>
                <?php endif; ?>
            </div>
        </div>

        <!-- Juegos añadidos (solo admin/editor) -->
        <?php if ($_SESSION['level'] <= 1): ?>
            <div class="card" style="flex: 1;">
                <div class="card-body">
                    <h2><i class="fas fa-gamepad"></i> <?= $idioma->palabras->perfil_misJuegos ?>
                        (<?php echo count($juegos); ?>)</h2>
                    <?php if (count($juegos) > 0): ?>
                        <div class="table-container">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th><?= $idioma->palabras->wiki_th1 ?></th>
                                        <th><?= $idioma->palabras->perfil_fecha ?></th>
                                        <th><?= $idioma->palabras->wiki_th5 ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($juegos as $juego): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($juego['titulo']); ?></td>
                                            <td><?php echo date('d/m/Y', strtotime($juego['fecha_creacion'])); ?></td>
                                            <td><a href="ficha_juego.php?id=<?php echo $juego['id']; ?>"
                                                    class="btn btn-sm btn-primary"><?= $idioma->palabras->perfil_ver ?></a></td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    <?php else: ?>
                        <p class="text-muted"><?= $idioma->palabras->perfil_sinJuegos ?></p>
                    <?php endif; ?>
                </div>
            </div>
        <?php endif; ?>

        <!-- Juegos Favoritos -->
        <div class="card" style="flex: 1;">
            <div class="card-body">
                <h2><i class="fas fa-heart"></i> <?= $idioma->palabras->perfil_misFavoritos ?></h2>
                <?php
                $modeloJuegos = new ModeloJuegos();
                $favoritos = $modeloJuegos->obtenerFavoritos($_SESSION['id']);
                if (count($favoritos) > 0):
                    ?>
                    <div class="lista-colaboradores">
                        <?php foreach ($favoritos as $fav): ?>
                            <div class="colaborador-item">
                                <i class="fas fa-gamepad"></i>
                                <span><?= htmlspecialchars($fav['titulo']) ?></span>
                                <a href="ficha_juego.php?id=<?= $fav['id'] ?>" class="btn btn-sm btn-primary"
                                    style="margin-left: auto;"><?= $idioma->palabras->perfil_ver ?></a>
                            </div>
                        <?php endforeach; ?>
                    </div>
                <?php else: ?>
                    <p class="text-muted"><?= $idioma->palabras->perfil_sinFavoritos ?></p>
                <?php endif; ?>
            </div>
        </div>

        <!-- Logros -->
        <div class="card" style="flex: 1;">
            <div class="card-body">
                <h2><i class="fas fa-trophy"></i> <?= $idioma->palabras->perfil_misLogros ?></h2>
                <?php
                $modeloJuegos = new ModeloJuegos();
                $modeloJuegos->verificarYOtorgarLogros($_SESSION['id']);

                $stmtLogros = $db->prepare("SELECT l.id as id_logro, l.nombre, l.descripcion, l.icono, lu.fecha_obtencion 
                            FROM logros_usuarios lu 
                            JOIN logros l ON lu.id_logro = l.id 
                            WHERE lu.id_usuario = ? 
                            ORDER BY lu.fecha_obtencion DESC");
                $stmtLogros->bind_param("i", $_SESSION['id']);
                $stmtLogros->execute();
                $logrosObtenidos = $stmtLogros->get_result()->fetch_all(MYSQLI_ASSOC);

                $logrosObtenidosIds = array_column($logrosObtenidos, 'id_logro');

                if (count($logrosObtenidos) > 0): ?>
                    <div class="logros-grid"
                        style="display: grid; grid-template-columns: repeat(auto-fill, minmax(80px, 1fr)); gap: var(--spacing-sm); margin-top: var(--spacing-md);">
                        <?php foreach ($logrosObtenidos as $logro): ?>
                            <div class="logro-item" style="text-align: center; padding: var(--spacing-sm);"
                                title="<?= htmlspecialchars($logro['descripcion']) ?>">
                                <i class="fas fa-<?= htmlspecialchars($logro['icono']) ?>"
                                    style="font-size: 24px; color: var(--warning); display: block; margin-bottom: 4px;"></i>
                                <span style="font-size: 11px; display: block; line-height: 1.2;">
                                    <?= htmlspecialchars($logro['nombre']) ?>
                                </span>
                                <span style="font-size: 10px; color: var(--text-secondary);">
                                    <?= date('d/m/Y', strtotime($logro['fecha_obtencion'])) ?>
                                </span>
                            </div>
                        <?php endforeach; ?>
                    </div>
                    <!-- Todos los logros disponibles -->
                    <details style="margin-top: var(--spacing-md);">
                        <summary style="cursor: pointer; color: var(--text-secondary); font-size: 14px;">
                            <?= $idioma->palabras->perfil_verLogros ?>
                        </summary>
                        <div class="logros-grid"
                            style="display: grid; grid-template-columns: repeat(auto-fill, minmax(80px, 1fr)); gap: var(--spacing-sm); margin-top: var(--spacing-sm);">
                            <?php
                            $stmtTodos = $db->query("SELECT * FROM logros ORDER BY id");
                            while ($logro = $stmtTodos->fetch_assoc()):
                                $obtenido = in_array($logro['id'], $logrosObtenidosIds);
                                ?>
                                <div class="logro-item"
                                    style="text-align: center; padding: var(--spacing-sm); opacity: <?= $obtenido ? 1 : 0.3 ?>;"
                                    title="<?= htmlspecialchars($logro['descripcion']) ?>">
                                    <i class="fas fa-<?= htmlspecialchars($logro['icono']) ?>"
                                        style="font-size: 24px; color: var(--warning); display: block; margin-bottom: 4px;"></i>
                                    <span style="font-size: 11px; display: block; line-height: 1.2;">
                                        <?= htmlspecialchars($logro['nombre']) ?>
                                    </span>
                                </div>
                            <?php endwhile; ?>
                        </div>
                    </details>
                <?php else: ?>
                    <p class="text-muted"><?= $idioma->palabras->perfil_sinLogros ?></p>
                <?php endif; ?>
            </div>
        </div>

    </div>
</div>

<?php include "../sec/footer.php"; ?>