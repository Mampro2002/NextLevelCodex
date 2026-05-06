// Gestión del tema claro/oscuro
(function() {
    // Obtener tema guardado o usar 'dark' por defecto
    const savedTheme = localStorage.getItem('theme') || 'dark';
    document.documentElement.setAttribute('data-theme', savedTheme);
    
    // Función para alternar tema
    window.toggleTheme = function() {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        
        // Actualizar icono del botón si existe
        const themeIcon = document.querySelector('.theme-toggle i');
        if (themeIcon) {
            themeIcon.className = newTheme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
        }
    };
    
    // Inicializar icono cuando el DOM esté listo
    document.addEventListener('DOMContentLoaded', function() {
        const themeIcon = document.querySelector('.theme-toggle i');
        if (themeIcon) {
            const currentTheme = document.documentElement.getAttribute('data-theme');
            themeIcon.className = currentTheme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
        }
    });
})();