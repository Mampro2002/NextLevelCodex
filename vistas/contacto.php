<?php
$paginaActiva = '';
include "../sec/sec.php";
include "../sec/header.php";

?>

<div class="main-container" style="text-align: center; padding: 60px 20px;">
    <h1><i class="fas fa-envelope"></i> <?= $idioma->palabras->contacto_titulo ?></h1>

    <div class="card" style="max-width: 600px; margin: var(--spacing-xl) auto; text-align: left;">
        <div class="card-body">
            <h2 style="margin-bottom: var(--spacing-md);"><?= $idioma->palabras->contacto_info ?></h2>

            <p class="text-muted" style="margin-bottom: var(--spacing-md);">
                <?= $idioma->palabras->contacto_texto ?>
            </p>

            <div style="display: flex; flex-direction: column; gap: var(--spacing-md);">
                <div>
                    <i class="fas fa-user"></i> <strong><?= $idioma->palabras->contacto_desarrollador ?>:</strong>
                    Manuel Acevedo Marín
                </div>
                <div>
                    <i class="fas fa-envelope"></i> <strong><?= $idioma->palabras->contacto_email ?>:</strong>
                    <a href="mailto:admin@codex.com">admin@codex.com</a>
                </div>
                <div>
                    <i class="fab fa-github"></i> <strong>GitHub:</strong>
                    <a href="https://github.com/Mampro2002" target="_blank">Mampro2002</a>
                </div>
                <div>
                    <i class="fas fa-graduation-cap"></i> <strong><?= $idioma->palabras->contacto_proyecto ?>:</strong>
                    <?= $idioma->palabras->contacto_desc_proyecto ?>
                </div>
            </div>
        </div>
    </div>

    <a href="../index.php" class="btn btn-primary btn-lg" style="margin-top: var(--spacing-lg);">
        <i class="fas fa-home"></i> <?= $idioma->palabras->contacto_volver ?>
    </a>
</div>

<?php include "../sec/footer.php"; ?>