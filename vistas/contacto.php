<?php
$paginaActiva = '';
include "../sec/sec.php";
include "../sec/header.php";
?>

<div class="main-container" style="text-align: center; padding: 60px 20px;">
    <h1><i class="fas fa-envelope"></i> Contacto</h1>

    <div class="card" style="max-width: 600px; margin: var(--spacing-xl) auto; text-align: left;">
        <div class="card-body">
            <h2 style="margin-bottom: var(--spacing-md);">Información de contacto</h2>

            <p class="text-muted" style="margin-bottom: var(--spacing-md);">
                Si tienes sugerencias, quieres colaborar en el proyecto o simplemente quieres ponerte en contacto con el
                desarrollador, puedes utilizar los siguientes medios:
            </p>

            <div style="display: flex; flex-direction: column; gap: var(--spacing-md);">
                <div>
                    <i class="fas fa-user"></i> <strong>Desarrollador:</strong>
                    Manuel Acevedo Marín
                </div>
                <div>
                    <i class="fas fa-envelope"></i> <strong>Email:</strong>
                    <a href="mailto:admin@codex.com">admin@codex.com</a>
                </div>
                <div>
                    <i class="fab fa-github"></i> <strong>GitHub:</strong>
                    <a href="https://github.com/manuelacevedo" target="_blank">manuelacevedo</a>
                </div>
                <div>
                    <i class="fas fa-graduation-cap"></i> <strong>Proyecto:</strong>
                    Proyecto de Fin de Ciclo – Desarrollo de Aplicaciones Web (DAW)
                </div>
            </div>
        </div>
    </div>

    <a href="../index.php" class="btn btn-primary btn-lg" style="margin-top: var(--spacing-lg);">
        <i class="fas fa-home"></i> Volver al inicio
    </a>
</div>

<?php include "../sec/footer.php"; ?>