<?php
/**
 * footer.php — Pie de página unificado
 * Incluir al final de cada vista, justo antes de </body>
 */

// Asegurar que $base está definida (normalmente la define header.php, pero por si acaso)
if (!isset($base)) {
    $scriptPath = str_replace('\\', '/', $_SERVER['SCRIPT_FILENAME']);
    $enRaiz = (strpos($scriptPath, '/vistas/') === false);
    $base = $enRaiz ? '' : '../';
}
?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<footer class="app-footer">
    <div class="footer-content">
        <p>&copy; <?php echo date('Y'); ?> Next Level Codex - Proyecto de Empresa DAW</p>
        <p class="footer-links">
            <a href="https://github.com/Mampro2002/NextLevelCodex.git" target="_blank" rel="noopener noreferrer">
                <i class="fab fa-github"></i> GitHub
            </a>
            <a href="#">
                <i class="fas fa-book"></i> Documentación
            </a>
            <a href="<?= $base ?>vistas/contacto.php">
                <i class="fas fa-envelope"></i> Contacto
            </a>
        </p>
        <p class="footer-version">v1.0 - Manuel Acevedo Marín</p>
    </div>
</footer>

<script>
    // Auto-logout por inactividad (15 minutos)
    let timer;
    function resetTimer() {
        clearTimeout(timer);
        timer = setTimeout(() => window.location.href = "<?= $base ?>sec/log_out.php", 15 * 60 * 1000);
    }
    document.addEventListener('mousemove', resetTimer);
    document.addEventListener('keypress', resetTimer);
    document.addEventListener('click', resetTimer);
    document.addEventListener('scroll', resetTimer);
    resetTimer();
</script>

</body>

</html>