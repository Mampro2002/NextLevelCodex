<?php
include "../sec/bdd.php";
include "../sec/sec.php";

$id_usuario_actual = $_SESSION["id"];
$termino = trim(filter_input(INPUT_POST, 'query', FILTER_DEFAULT) ?? '');
$query = "%" . $termino . "%";

// Obtener lista de amigos del usuario actual
$filt = $db->prepare("SELECT amigos FROM usuarios WHERE id = ?");
$filt->bind_param("i", $id_usuario_actual);
$filt->execute();
$res = $filt->get_result();
$row = $res->fetch_assoc();
$amigos_ids = !empty($row['amigos']) ? array_filter(explode('#', $row['amigos'])) : [];

// Buscar usuarios que coincidan con el término, excluyendo al propio usuario
$sql = "SELECT id, user, nombre 
        FROM usuarios 
        WHERE (user LIKE CONCAT('%', ?, '%') OR nombre LIKE CONCAT('%', ?, '%')) 
          AND id != ?";
$filt = $db->prepare($sql);
$filt->bind_param("ssi", $termino, $termino, $id_usuario_actual);
$filt->execute();
$resultado = $filt->get_result();

if ($resultado->num_rows > 0) {
    while ($usuario = $resultado->fetch_assoc()) {
        // Saltar si ya es amigo
        if (in_array($usuario['id'], $amigos_ids)) {
            continue;
        }

        // Verificar si está bloqueado (en cualquier dirección)
        $filt_bloqueo = $db->prepare("SELECT * FROM bloqueados WHERE (id_recep = ? AND id_block = ?) OR (id_recep = ? AND id_block = ?)");
        $filt_bloqueo->bind_param("iiii", $id_usuario_actual, $usuario['id'], $usuario['id'], $id_usuario_actual);
        $filt_bloqueo->execute();
        $res_bloqueo = $filt_bloqueo->get_result();
        if ($res_bloqueo->num_rows > 0) {
            continue; // Está bloqueado, no mostrar
        }

        // Verificar si ya existe una solicitud enviada por el usuario actual
        $filt_solicitud = $db->prepare("SELECT statu, fecha FROM domingueros WHERE id_sol = ? AND id_rec = ?");
        $filt_solicitud->bind_param("ii", $id_usuario_actual, $usuario['id']);
        $filt_solicitud->execute();
        $res_solicitud = $filt_solicitud->get_result();
        $solicitud = $res_solicitud->fetch_assoc();
        $solicitud_existe = ($res_solicitud->num_rows > 0);
        ?>
        <tr>
            <td>
                <a href="perfil_publico.php?id=<?php echo (int) $usuario['id']; ?>">
                    @<?php echo htmlspecialchars($usuario['user']); ?>
                </a>
            </td>
            <td><?php echo htmlspecialchars($usuario['nombre']); ?></td>
            <td>
                <?php if ($solicitud_existe): ?>
                    <?php if ($solicitud['statu'] == 0): ?>
                        <?php
                        // Solicitud rechazada: calcular tiempo restante
                        $diff = time() - $solicitud['fecha'];
                        $segundos_15_dias = 15 * 24 * 60 * 60;
                        if ($diff <= $segundos_15_dias) {
                            $tiempo_restante = $segundos_15_dias - $diff;
                            $dias = floor($tiempo_restante / (24 * 60 * 60));
                            $horas = floor(($tiempo_restante % (24 * 60 * 60)) / 3600);
                            ?>
                            <span class="text-muted" style="font-size: 12px;">
                                Rechazada<br>disponible en <?= $dias ?>d <?= $horas ?>h
                            </span>
                        <?php } else { ?>
                            <button class="btn btn-sm btn-primary btn-send" data-id="<?= $usuario['id'] ?>">
                                <i class="fas fa-paper-plane"></i> Enviar solicitud
                            </button>
                        <?php } ?>
                    <?php else: ?>
                        <button class="btn btn-sm btn-warning btn-cancelar" data-id="<?= $usuario['id'] ?>">
                            <i class="fas fa-times"></i> Cancelar solicitud
                        </button>
                    <?php endif; ?>
                <?php else: ?>
                    <button class="btn btn-sm btn-primary btn-send" data-id="<?= $usuario['id'] ?>">
                        <i class="fas fa-paper-plane"></i> Enviar solicitud
                    </button>
                <?php endif; ?>
            </td>
        </tr>
        <?php
    }
} else {
    echo '<tr><td colspan="4" class="text-muted" style="text-align: center;">No se encontraron usuarios.</td></tr>';
}
?>