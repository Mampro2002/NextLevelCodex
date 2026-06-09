# 🎮 Next Level Codex

Plataforma web colaborativa de videojuegos que combina una wiki especializada con funcionalidades de red social vertical. Desarrollada como Proyecto de Fin de Ciclo del Grado Superior en Desarrollo de Aplicaciones Web (DAW).

![PHP](https://img.shields.io/badge/PHP-8.2-777BB4?style=flat&logo=php)
![MariaDB](https://img.shields.io/badge/MariaDB-10.4-003545?style=flat&logo=mariadb)
![JavaScript](https://img.shields.io/badge/JavaScript-ES6-F7DF1E?style=flat&logo=javascript)
![CSS3](https://img.shields.io/badge/CSS3-Variables-1572B6?style=flat&logo=css3)
![jQuery](https://img.shields.io/badge/jQuery-3.7-0769AD?style=flat&logo=jquery)
![Chart.js](https://img.shields.io/badge/Chart.js-4.4-FF6384?style=flat&logo=chartdotjs)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)

---

## 📖 Descripción

**Next Level Codex** es una plataforma web dinámica que funciona como wiki colaborativa de videojuegos y red social vertical para la comunidad gamer. Los usuarios pueden consultar fichas detalladas de una amplia variedad de títulos —incluyendo armas, personajes, mapas interactivos y guías—, puntuar juegos, dejar comentarios, crear una red de colaboradores y chatear en tiempo real.

El sistema incorpora un panel de administración para la gestión completa del contenido, estadísticas con gráficas interactivas y un sistema de logros que incentiva la participación de la comunidad.

---

## ✨ Características Principales

### 📚 Wiki de Videojuegos
- Fichas detalladas de juegos con pestañas (General, Elementos, Personajes, Mapa, Comentarios, Tráiler).
- Búsqueda avanzada con filtros por género, año y desarrollador.
- Sistema flexible de elementos: armas, cartas, hechizos, objetos, armaduras y tipos personalizados.
- Mapas interactivos con pines personalizables y coordenadas relativas.
- Modo "En desarrollo" con cuenta atrás en tiempo real para próximos lanzamientos.
- Enlaces de compra personalizados (Steam, GOG, etc.).

### 👥 Red Social
- Sistema de colaboradores (solicitudes, aceptación, rechazo con temporizador de 15 días, bloqueo).
- Chat global y chats privados en tiempo real (AJAX polling con pausa por inactividad).
- Valoraciones de juegos (1-5 estrellas) con media de puntuaciones.
- Comentarios en fichas de juego con permisos de eliminación.
- Favoritos y sistema de logros/insignias.
- Perfil de usuario público/privado con biografía, avatar y estadísticas.

### 🛡️ Panel de Administración
- CRUD completo de usuarios con baneo temporal.
- Gestión de juegos, elementos, personajes y mapas con subida de imágenes.
- Panel de estadísticas con KPIs y gráficas de Chart.js.
- Control de acceso granular (Administrador, Editor, Usuario).

### 🎨 Interfaz de Usuario
- Tema claro/oscuro conmutado desde localStorage.
- Diseño responsive adaptable a escritorio y dispositivos móviles.
- Navegación por pestañas y carga dinámica de contenido mediante AJAX.
- Notificaciones visuales de mensajes no leídos y solicitudes pendientes.

---

## 🛠️ Tecnologías Utilizadas

| Capa | Tecnología |
| :--- | :--- |
| **Backend** | PHP 8.2, MariaDB 10.4 |
| **Frontend** | HTML5, CSS3 (Flexbox, Grid, Variables), JavaScript ES6 |
| **Librerías JS** | jQuery 3.7 (AJAX), Chart.js 4.4 (gráficas), Leaflet 1.9 (gestión de mapas) |
| **Iconografía** | Font Awesome 6.0 |
| **Servidor** | Apache 2.4 (XAMPP) |
| **Control de Versiones** | Git / GitHub |

---

## 📋 Requisitos Previos

- **XAMPP** (o cualquier servidor con Apache y MariaDB/MySQL).
- **PHP 8.2** o superior.
- **MariaDB 10.4** o superior.
- **Git** (opcional, para clonar el repositorio).

---

## 🚀 Instalación y Despliegue

### 1. Clonar el repositorio

```bash
git clone https://github.com/Mampro2002/NextLevelCodex.git