<?php
$paginaActiva = '';
include "../sec/sec.php";
include "../sec/header.php";
// $idioma ya está cargado desde header.php
?>

<style>
    .doc-card {
        transition: transform 0.2s, box-shadow 0.2s;
        border: 1px solid var(--bg-tertiary);
        width: 280px;
        text-align: center;
        padding: var(--spacing-xl);
    }

    .doc-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
    }

    .doc-card .btn {
        width: 100%;
        margin-top: var(--spacing-sm);
    }

    .doc-card i {
        font-size: 64px;
        margin-bottom: var(--spacing-md);
    }
</style>

<div class="main-container" style="text-align: center; padding: 60px 20px;">
    <h1><i class="fas fa-book"></i>
        <?= $idioma->palabras->footer_documentacion ?>
    </h1>
    <p class="text-muted" style="margin-bottom: var(--spacing-xl);">
        <?= $idioma->palabras->doc_elegir_formato ?>
    </p>

    <div class="document-options"
        style="display: flex; gap: var(--spacing-xl); justify-content: center; flex-wrap: wrap; margin-top: var(--spacing-xl);">
        <!-- Tarjeta PDF -->
        <div class="card doc-card">
            <i class="fas fa-file-pdf" style="color: var(--danger);"></i>
            <h3>
                <?= $idioma->palabras->doc_ver_pdf ?>
            </h3>
            <p class="text-muted">
                <?= $idioma->palabras->doc_pdf_desc ?>
            </p>
            <a href="../assets/docs/memoria.pdf" class="btn btn-primary" target="_blank">
                <i class="fas fa-eye"></i>
                <?= $idioma->palabras->doc_abrir ?>
            </a>
            <a href="../assets/docs/memoria.pdf" class="btn btn-secondary" download>
                <i class="fas fa-download"></i>
                <?= $idioma->palabras->doc_descargar ?>
            </a>
        </div>

        <!-- Tarjeta PowerPoint -->
        <div class="card doc-card">
            <i class="fas fa-file-powerpoint" style="color: var(--warning);"></i>
            <h3>
                <?= $idioma->palabras->doc_ver_pptx ?>
            </h3>
            <p class="text-muted">
                <?= $idioma->palabras->doc_pptx_desc ?>
            </p>
            <a href="../assets/docs/presentacion.pptx" class="btn btn-primary" download>
                <i class="fas fa-download"></i>
                <?= $idioma->palabras->doc_descargar ?>
            </a>
        </div>
    </div>

    <a href="../index.php" class="btn btn-primary btn-lg" style="margin-top: var(--spacing-xl);">
        <i class="fas fa-home"></i>
        <?= $idioma->palabras->contacto_volver ?>
    </a>
</div>

<?php include "../sec/footer.php"; ?>