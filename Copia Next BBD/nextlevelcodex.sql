-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-05-2026 a las 12:01:01
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `nextlevelcodex`
--
CREATE DATABASE IF NOT EXISTS `nextlevelcodex` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `nextlevelcodex`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `armas`
--

CREATE TABLE `armas` (
  `id` int(11) NOT NULL,
  `id_juego` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `daño` int(11) DEFAULT 0,
  `municion` varchar(50) DEFAULT NULL,
  `rareza` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bloqueados`
--

CREATE TABLE `bloqueados` (
  `id_recep` int(11) NOT NULL,
  `id_block` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `id_juego` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id`, `id_juego`, `id_usuario`, `comentario`, `fecha`) VALUES
(3, 9, 1, 'Me flipa este juego!!!!!!!!!!!!!!!!', '2026-05-06 16:48:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `domingueros`
--

CREATE TABLE `domingueros` (
  `id_sol` int(11) NOT NULL,
  `id_rec` int(11) NOT NULL,
  `fecha` int(11) NOT NULL,
  `statu` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elementos`
--

CREATE TABLE `elementos` (
  `id` int(11) NOT NULL,
  `id_juego` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL COMMENT 'Subtipo libre (Espada, Joker, Hechizo...)',
  `valor1` varchar(50) DEFAULT NULL COMMENT 'Primer stat (Daño, Puntos, Maná...)',
  `valor2` varchar(50) DEFAULT NULL COMMENT 'Segundo stat (Munición, Coste...)',
  `rareza` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Nombre del archivo de imagen del elemento'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `elementos`
--

INSERT INTO `elementos` (`id`, `id_juego`, `nombre`, `tipo`, `valor1`, `valor2`, `rareza`, `descripcion`, `imagen`) VALUES
(9, 9, 'Espada de Hierro', 'Espada', '150', 'Ninguna', 'Común', NULL, NULL),
(10, 9, 'Arco de Kadachi', 'Arco', '180', 'Electricidad', 'Raro', NULL, NULL),
(11, 9, 'Martillo de Diablos', 'Martillo', '250', 'Ninguna', 'Épico', NULL, NULL),
(12, 9, 'Hoz de Nergigante', 'Espada Larga', '300', 'Dragón', 'Legendario', NULL, NULL),
(13, 9, 'Lanza de Rathalos', 'Lanza', '220', 'Fuego', 'Épico', NULL, NULL),
(14, 10, 'Espada Estigia', 'Arma Infernal', '90', 'Golpe crítico +15%', 'Legendaria', NULL, NULL),
(15, 10, 'Arco de Artemisa', 'Bendición', '70', 'Disparo rápido', 'Divina', NULL, NULL),
(16, 10, 'Lanza de Ares', 'Bendición', '110', 'Maldición de ruina', 'Divina', NULL, NULL),
(17, 10, 'Escudo de Zeus', 'Bendición', '60', 'Cadena de rayos', 'Divina', NULL, NULL),
(18, 11, 'Filo del Sueño', 'Habilidad de Aguijón', '21', 'Almas', 'Legendaria', NULL, NULL),
(19, 11, 'Garra de Mantis', 'Habilidad de Movimiento', '0', 'Agarrar paredes', 'Épica', NULL, NULL),
(20, 11, 'Corazón de Sombra', 'Habilidad de Hechizo', '30', 'Almas', 'Rara', NULL, NULL),
(21, 12, 'Joker Sonriente', 'Carta Joker', '+4 Mult', 'Común', 'Común', NULL, NULL),
(22, 12, 'Excursionista', 'Carta', '+5 Fichas', 'Por cada Carta Jugada', 'Raro', '', 'elem_1778140174.png'),
(23, 12, 'Joker Místico', 'Carta Joker', 'x2 Mult', 'Al descartar', 'Épico', NULL, NULL),
(24, 12, 'Joker Invisible', 'Carta Joker', 'Copia Joker', 'Aleatorio', 'Legendario', NULL, NULL),
(25, 12, 'Joker del Trueno', 'Carta Joker', '+50 Fichas', 'Al jugar corazón', 'Raro', NULL, NULL),
(26, 14, 'Fresa Alada', 'Coleccionable', '1000', 'Puntos', 'Especial', NULL, NULL),
(27, 14, 'Cristal Azul', 'Objeto de Historia', '0', 'Desbloquea final B', 'Único', NULL, NULL),
(28, 14, 'Pluma Dorada', 'Objeto de Historia', '0', 'Desbloquea final C', 'Único', NULL, NULL),
(29, 15, 'Río de Sangre', 'Katana', '76', 'Sangrado (50)', 'Legendario', 'Katana maldita del espadachín Okina, infunde pérdida de sangre.', NULL),
(30, 15, 'Espada de la Noche y la Llama', 'Arma', '115', 'Escalado de Fe e Inteligencia', 'Legendario', 'Espada mitológica y tesoro de la mansión de los Caria.\r\nEs una de las armas legendarias.\r\n\r\nLos astrólogos que precedieron a los hechiceros se establecieron en lo alto de las montañas más elevadas, las que casi tocaban el cielo, y consideraban a los gigantes de fuego como sus vecinos.\r\n\r\nHabilidad: Combate igneocturno\r\nNo alces ni bajes la espada y prepárate para lanzar un hechizo. Acompáñala con un ataque normal para lanzar el hechizo del dardo nocturno, o bien con un ataque potente para incendiar la zona situada frente a ti en un movimiento de barrido.', 'elem_1778145674.png'),
(31, 15, 'Hoja Blasfema', 'Arma', '145', 'Robo de vida', 'Legendario', 'Es el arma sagrada de Rykard, Señor de la Blasfemia. Se trata de un espadón cuya superficie está cubierta por los restos de los innumerables héroes que el señor devoró, los cuales se retuercen sobre el metal compartiendo ahora la misma sangre como una \"familia\".\r\n\r\nAl activar su ceniza de guerra única, el jugador alza la espada para envolverla en llamas blasfemas y luego la baja para lanzar una ráfaga de fuego frontal. Esta ráfaga no solo inflige daño masivo, sino que absorbe PS de los enemigos alcanzados, lo que permite recuperar vida rápidamente durante el combate.', 'elem_1778146190.png'),
(33, 15, 'Espadón de la luna negra', 'Arma', '130', 'Magia de hielo', 'Legendario', 'Espadón de la luna otorgado por las reinas carianas a sus cónyuges según una longeva tradición.\r\nUna de las armas legendarias.\r\n\r\nEl sello de Ranni es una luna llena, fría y plúmbea, y esta espada es un haz de su luz.\r\n\r\nHabilidad única: Espadón de luz lunar\r\nAlza la espada por encima de tu cabeza para bañarla en la luz de la luna negra.\r\nAumenta temporalmente la potencia de ataque mágico e imbuye la hoja en congelación.\r\nLos ataques cargados liberan ráfagas de luz lunar.', 'elem_1778145456.png'),
(34, 15, 'Lanza Sagrada de Mohgwyn', 'Gran lanza', '120', 'Sangrado (70)', 'Legendario', 'Lanza del Señor de la Sangre. Realiza un ritual que inflige pérdida de sangre masiva.', NULL),
(35, 15, 'Espadón de Hoja Injertada', 'Arma', '150', 'Atributos +5', 'Legendario', 'La famosa espada del Castillo de Morne. Arma de vengador que carga con océanos de ira y arrepentimiento.\r\nUna de la armas legendarias.\r\n\r\nUn solitario campeón, superviviente de un país desaparecido, mostró tal determinación a la hora de seguir luchando que reclamó las espadas de todo un clan de guerreros.\r\n\r\nHabilidad: Juramento de venganza\r\nHaz un juramento sobre el espadón para vengar al clan, lo que aumentará todos tus atributos de forma temporal. Mientras los efectos del juramento estén activos, tu aplomo también aumentará.', 'elem_1778145690.png'),
(36, 15, 'Espadón de Ruinas', 'Arma', '160', 'Gravedad', 'Legendario', 'Aunque originalmente era un escombro de una ruina que cayó del cielo, este fragmento acabaría convirtiéndose en un arma.\r\nEs una de las armas legendarias.\r\n\r\nLa ruina de la que provenía se vino abajo al impactar un meteorito contra ella. Por tanto, este arma posee su poder destructivo.\r\n\r\nHabilidad única: Ola de destrucción\r\nLevanta la espada en lo alto y luego golpea el suelo con ella para lanzar una onda de choque gravitatoria.', 'elem_1778145712.png'),
(37, 15, 'Cetro del Devorador', 'Arma', '140', 'Devastación', 'Legendario', 'Cetro con forma de serpiente devorando el mundo. Esta arma se convertirá, algún día, en el símbolo del señor de la Blasfemia.\r\nEs una de las armas legendarias.\r\n\r\nDicen que su diseño es una breve visión del futuro que tuvo Rykard en sus últimos momentos de vida, tras ser devorado por la gran serpiente.\r\n\r\nHabilidad: Devorador de mundos\r\nCarga el cetro con magia y golpea el suelo con él para robar los PS de todos los enemigos cercanos.', 'elem_1778145512.png'),
(38, 15, 'Shotel del eclipse', 'Arma', '100', 'Fuego de la muerte', 'Legendario', 'La famosa espada atesorada en el Castillo de Sól, representa un sol eclipsado y carente de color.\r\nEs una de las armas legendarias.\r\n\r\nEn Sól, el eclipse infunde un gran temor, pero no es posible apartar la mirada ante tal fenómeno.\r\n\r\nHabilidad única: Llamarada mortal\r\nHaz arder el sol desprovisto de brillo con las llamas del Príncipe de la Muerte. Este encantamiento inflige muerte a los enemigos. Vuelve a pulsar el botón para bajar el arma y desencadenar una explosión.', 'elem_1778146279.png'),
(39, 17, 'Aerondight', 'Espada de Plata', '522-638', 'Carga de energía', 'Legendario', 'La espada de plata más poderosa del juego. Genera cargas que aumentan el daño un 10% por golpe.', NULL),
(40, 17, 'Espada de Acero de la Escuela del Gato', 'Espada de Acero', '140', '+10% Prob. Crítico', 'Reliquia', 'Parte del equipo de la Escuela del Gato. Bonifica la probabilidad de golpe crítico.', NULL),
(41, 17, 'Iris', 'Espada de Acero', '130', 'Carga de poder', 'Reliquia', 'Espada única del DLC Hearts of Stone. Acumula energía para liberar un ataque devastador.', NULL),
(42, 17, 'Espada de Plata de la Escuela del Lobo', 'Espada de Plata', '130', '+20% Daño vs. Monstruos', 'Reliquia', 'Espada de plata de la Escuela del Lobo. Ideal para cazadores de bestias.', NULL),
(43, 17, 'Ballesta de la Escuela del Oso', 'Ballesta', '50', 'Daño adicional a bestias', 'Reliquia', 'Ballesta pesada eficaz contra bestias grandes.', NULL),
(44, 17, 'Armadura de la Escuela del Grifo', 'Armadura Media', '120', '+25% Intensidad de Señal', 'Reliquia', 'Aumenta la intensidad de las señales de brujo. Perfecta para builds de magia.', NULL),
(45, 17, 'Armadura de la Escuela del Oso', 'Armadura Pesada', '150', '+30% Defensa', 'Reliquia', 'Proporciona una defensa excepcional para builds de tanque.', NULL),
(46, 17, 'Espada de Plata de la Escuela de la Víbora', 'Espada de Plata', '125', '+10% Prob. Envenenar', 'Reliquia', 'Disponible en Hearts of Stone. Aplica veneno con cada golpe.', NULL),
(47, 17, 'Gran Armadura de la Escuela del Grifo', 'Armadura', '150', '+25% Intensidad de Señal', 'Reliquia', 'Versión superior de la armadura del Grifo con mayor protección.', NULL),
(48, 17, 'Ballesta de la Escuela del Gato', 'Ballesta', '45', '+5% Prob. Crítico', 'Reliquia', 'Ballesta ligera para builds rápidos. Aumenta la probabilidad de crítico.', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `id_usuario` int(11) NOT NULL,
  `id_juego` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `favoritos`
--

INSERT INTO `favoritos` (`id_usuario`, `id_juego`, `fecha`) VALUES
(1, 9, '2026-05-06 16:46:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `juegos`
--

CREATE TABLE `juegos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `desarrollador` varchar(100) DEFAULT NULL,
  `distribuidora` varchar(100) DEFAULT NULL,
  `fecha_lanzamiento` date DEFAULT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `portada` varchar(255) DEFAULT 'default_game.jpg',
  `mapa_imagen` varchar(255) DEFAULT NULL,
  `enlace_compra` varchar(500) DEFAULT NULL,
  `creador_id` int(11) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `tiene_items` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = tiene elementos (armas, cartas...)',
  `nombre_items` varchar(50) DEFAULT 'Armas' COMMENT 'Nombre del tipo de elemento (Armas, Cartas, Hechizos...)',
  `tiene_personajes` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = tiene personajes / NPCs',
  `tiene_mapa` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = tiene mapa propio',
  `en_desarrollo` tinyint(1) NOT NULL DEFAULT 0,
  `trailer` varchar(500) DEFAULT NULL COMMENT 'Enlace al tráiler (YouTube, etc.)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `juegos`
--

INSERT INTO `juegos` (`id`, `titulo`, `desarrollador`, `distribuidora`, `fecha_lanzamiento`, `genero`, `descripcion`, `portada`, `mapa_imagen`, `enlace_compra`, `creador_id`, `fecha_creacion`, `tiene_items`, `nombre_items`, `tiene_personajes`, `tiene_mapa`, `en_desarrollo`, `trailer`) VALUES
(9, 'Monster Hunter World', 'Capcom', 'Capcom', '2018-01-26', 'RPG de Acción', 'Embárcate en una épica cacería en el Nuevo Mundo. Enfréntate a monstruos colosales en ecosistemas vivos, forja equipo poderoso y colabora con otros cazadores en esta obra maestra de la saga Monster Hunter.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/582010/MONSTER_HUNTER_WORLD/', 1, '2026-05-05 17:50:24', 1, 'Armas', 1, 0, 0, NULL),
(10, 'Hades', 'Supergiant Games', 'Supergiant Games', '2020-09-17', 'Roguelike', 'Escapa del inframundo en este aclamado roguelike de acción. Como Zagreo, hijo de Hades, lucharás a través de mazmorras generadas aleatoriamente con la ayuda de los dioses del Olimpo.', 'game_1778072432.png', 'map_1777997211.jpg', '', 1, '2026-05-05 17:50:24', 1, 'Armas', 1, 1, 0, NULL),
(11, 'Hollow Knight', 'Team Cherry', 'Team Cherry', '2017-02-24', 'Metroidvania', 'Forja tu propio camino en Hallownest, un reino antiguo lleno de insectos extraños y secretos ocultos. Un metroidvania dibujado a mano con una atmósfera inolvidable y una jugabilidad desafiante.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/367520/Hollow_Knight/', 2, '2026-05-05 17:50:24', 1, 'Habilidad', 1, 0, 0, NULL),
(12, 'Balatro', 'LocalThunk', 'Playstack', '2024-02-20', 'Roguelike de Cartas', 'El póker se encuentra con el roguelike en este adictivo juego de construcción de mazos. Combina manos de póker con comodines especiales para superar ciegas cada vez más difíciles.', 'game_1778078491.jpg', NULL, '', 2, '2026-05-05 17:50:24', 1, 'Carta', 0, 0, 0, 'https://youtu.be/VUyP21iQ_-g?si=IW3SrkMv8NaMHeQ9'),
(13, 'Hollow Knight: Silksong', 'Team Cherry', 'Team Cherry', '2026-12-31', 'Metroidvania', 'Juega como Hornet en esta esperada secuela de Hollow Knight. Explora un nuevo reino, domina nuevas habilidades y descubre los secretos de Pharloom en esta aventura independiente.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/1030300/Hollow_Knight_Silksong/', 2, '2026-05-05 17:50:24', 0, 'Armas', 0, 0, 1, NULL),
(14, 'Celeste', 'Maddy Makes Games', 'Maddy Makes Games', '2018-01-25', 'Plataformas', 'Ayuda a Madeline a escalar la Montaña Celeste en este desafiante juego de plataformas pixel-art. Una historia emotiva sobre la superación personal, la ansiedad y la perseverancia.', 'default_game.jpg', NULL, '', 3, '2026-05-05 17:50:24', 1, 'Armas', 1, 0, 0, ''),
(15, 'Elden Ring', 'FromSoftware', 'Bandai Namco Entertainment', '2022-02-25', 'RPG de Acción', 'Levántate, Sinluz, y recorre las imponentes Tierras Intermedias para restaurar el Círculo de Elden y convertirte en el Señor del Círculo. Una aventura épica de fantasía oscura creada por Hidetaka Miyazaki y George R.R. Martin.', 'game_1778144555.png', NULL, 'https://store.steampowered.com/app/1245620/ELDEN_RING/', 5, '2026-05-07 10:57:02', 1, 'Armas', 1, 0, 0, 'https://youtu.be/CptaXqVY6-E?si=-oKFKYwWprTgTgTj'),
(17, 'The Witcher 3: Wild Hunt', 'CD Projekt Red', 'CD Projekt', '2015-05-19', 'RPG', 'Encarna a Geralt de Rivia, un cazador de monstruos a sueldo, en un mundo de fantasía oscura. Persigue a la Niña de la Profecía, Ciri, y enfréntate a la Cacería Salvaje en una aventura épica que define el destino del Continente.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/292030/The_Witcher_3_Wild_Hunt/', 5, '2026-05-07 12:00:11', 1, 'Armas', 1, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logros`
--

CREATE TABLE `logros` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `icono` varchar(50) DEFAULT 'trophy',
  `criterio` varchar(255) NOT NULL COMMENT 'Descripción del requisito'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logros`
--

INSERT INTO `logros` (`id`, `nombre`, `descripcion`, `icono`, `criterio`) VALUES
(1, 'Primer juego', 'Añade tu primer juego a la wiki', 'gamepad', 'juegos >= 1'),
(2, 'Coleccionista', 'Añade 5 juegos a la wiki', 'layer-group', 'juegos >= 5'),
(3, 'Crítico', 'Valora 10 juegos', 'star', 'valoraciones >= 10'),
(4, 'Votante', 'Valora al menos un juego', 'star-half-alt', 'valoraciones >= 1'),
(5, 'Social', 'Haz 5 colaboradores', 'users', 'amigos >= 5'),
(6, 'Conversador', 'Envía 10 mensajes (chat global/privado)', 'comments', 'mensajes >= 10'),
(7, 'Favorito', 'Marca un juego como favorito', 'heart', 'favoritos >= 1'),
(8, 'Explorador', 'Visita 10 fichas de juegos diferentes', 'search', 'visitas >= 10'),
(9, 'Popular', 'Recibe 5 valoraciones en tus juegos añadidos', 'thumbs-up', 'valoraciones_recibidas >= 5'),
(10, 'Veterano', 'Mantén tu cuenta activa durante 30 días', 'calendar-check', 'antiguedad >= 30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logros_usuarios`
--

CREATE TABLE `logros_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `id_logro` int(11) NOT NULL,
  `fecha_obtencion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logros_usuarios`
--

INSERT INTO `logros_usuarios` (`id_usuario`, `id_logro`, `fecha_obtencion`) VALUES
(1, 1, '2026-05-05 17:43:31'),
(1, 4, '2026-05-05 17:43:31'),
(1, 6, '2026-05-05 17:43:32'),
(1, 7, '2026-05-05 17:43:32'),
(1, 8, '2026-05-06 17:04:10'),
(1, 9, '2026-05-06 17:04:10'),
(2, 1, '2026-05-06 16:58:24'),
(2, 4, '2026-05-06 16:58:24'),
(2, 6, '2026-05-06 16:58:24'),
(3, 1, '2026-05-06 16:53:22'),
(3, 4, '2026-05-06 16:53:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mapas`
--

CREATE TABLE `mapas` (
  `id` int(11) NOT NULL,
  `id_juego` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `pos_x` decimal(6,2) DEFAULT NULL COMMENT 'Posición X en % sobre la imagen del mapa',
  `pos_y` decimal(6,2) DEFAULT NULL COMMENT 'Posición Y en % sobre la imagen del mapa',
  `icono` varchar(10) DEFAULT '?' COMMENT 'Emoji o icono del punto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mapas`
--

INSERT INTO `mapas` (`id`, `id_juego`, `nombre`, `latitud`, `longitud`, `tipo`, `descripcion`, `pos_x`, `pos_y`, `icono`) VALUES
(18, 10, 'Tártaro', NULL, NULL, 'Primera Zona', 'Las Profundidades más oscuras del Inframundo. LLeno de trampas, brujas y almas perdidas. \n\nJefe de Zona: Primera Furia.\n\nHabitaciones aprox: 15', 48.24, 25.85, '⚔️'),
(19, 10, 'Casa de', NULL, NULL, 'Hades', 'Zona Inicial', 48.54, 13.35, '🏠'),
(20, 10, 'Asfódelo', NULL, NULL, 'Segunda Zona', 'Un mar de lava y ceniza, donde las almas navegan eternamente.\n\nJefe de Zona: Hidra Ósea de Lerna.\n\nHabitaciones aprox: 10', 48.24, 39.65, '⛩️'),
(21, 10, 'Elíseo', NULL, NULL, 'Tercera Zona', 'Campos de descaso de héroes y castigo para los malvados. Enemigos poderosos te esperan.\n\nJefe de Zona:  Teseo y Asterio.\n\nHabitaciones Aprox: 11', 48.73, 55.86, '⚔️'),
(22, 10, 'Templo de Estigia', NULL, NULL, 'Cuarta Zona', 'Un laberinto de veneno y secretos. Encuentra el Saco de Caronte para avanzar.', 48.34, 70.38, '⛩️'),
(23, 10, 'Puerta del Tartaro', NULL, NULL, 'Ultima zona', 'Final del camino donde el temor y la sangre llegan hasta el final. Allí el tu padre Zagreo espera.\n\nJefe final: Dios del Inframundo, Zagreo', 48.83, 83.01, '💀'),
(24, 10, 'Superficie', NULL, NULL, 'Fin de Juego', 'Por fin consigues salir del Tartataro, la pesadilla acabo.', 48.83, 95.77, '⭐');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_grupales`
--

CREATE TABLE `mensajes_grupales` (
  `id` int(11) NOT NULL,
  `emisor` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes_grupales`
--

INSERT INTO `mensajes_grupales` (`id`, `emisor`, `mensaje`, `fecha`) VALUES
(1, 2, 'Hola', '2026-04-22 16:44:28'),
(2, 2, 'Como estas??', '2026-04-22 16:44:41'),
(3, 1, 'Muy bien y tu??', '2026-04-22 16:44:57'),
(4, 2, 'Q', '2026-04-22 16:45:10'),
(5, 2, 'Kakaka', '2026-04-22 16:45:32'),
(6, 2, 'hdhd', '2026-04-22 16:49:47'),
(7, 1, 'ad', '2026-04-22 16:49:58'),
(8, 2, 'dad', '2026-04-22 16:55:01'),
(9, 1, 'asd', '2026-04-22 16:56:48'),
(10, 1, 'Hoalaaa', '2026-04-27 10:10:20'),
(11, 1, 'MADRE MIA', '2026-04-27 16:16:19'),
(12, 2, 'DESDE LUEGO', '2026-04-27 16:16:45'),
(13, 3, 'Jode', '2026-04-29 10:10:34'),
(14, 3, 'Que conversancion mas CREEPE', '2026-04-29 10:10:47'),
(15, 3, 'Holaaaa', '2026-04-30 14:17:04'),
(16, 3, 'ddsfg', '2026-04-30 14:17:19'),
(17, 1, 'Porbnafaf', '2026-04-30 14:19:28'),
(18, 3, 'Que tal??', '2026-04-30 14:19:45'),
(19, 1, 'Bien', '2026-04-30 14:19:56'),
(20, 3, 'ada', '2026-04-30 14:19:57'),
(21, 2, 'adads', '2026-04-30 14:45:28'),
(22, 1, 'daad', '2026-04-30 14:45:42'),
(23, 2, 'adasdas', '2026-05-06 17:09:25'),
(24, 2, 'fsdff', '2026-05-06 17:09:47'),
(25, 1, 'vsvcsad', '2026-05-06 17:09:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_privados`
--

CREATE TABLE `mensajes_privados` (
  `id` int(11) NOT NULL,
  `emisor` int(11) NOT NULL,
  `receptor` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `leido` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes_privados`
--

INSERT INTO `mensajes_privados` (`id`, `emisor`, `receptor`, `mensaje`, `fecha`, `leido`) VALUES
(1, 2, 1, 'Hao', '2026-04-22 16:51:08', 1),
(2, 1, 2, 'Que tal??', '2026-04-22 16:51:16', 1),
(3, 2, 1, 'Bien y tu??', '2026-04-22 16:51:33', 1),
(4, 1, 2, 'Bien tambien', '2026-04-22 16:51:44', 1),
(5, 1, 2, 'hdhf', '2026-04-22 16:54:13', 1),
(6, 1, 2, 'wetw', '2026-04-22 16:57:37', 1),
(7, 2, 1, 'afaf', '2026-04-22 16:57:47', 1),
(8, 2, 1, 'sfsf', '2026-04-30 14:46:03', 1),
(9, 2, 1, 'sfsf', '2026-04-30 14:46:03', 1),
(10, 2, 1, 'fsdsdf', '2026-04-30 14:46:23', 1),
(11, 2, 1, 'fsdsdf', '2026-04-30 14:46:23', 1),
(12, 2, 1, 'dsfsf', '2026-04-30 14:46:50', 1),
(13, 2, 1, 'dsfsf', '2026-04-30 14:46:50', 1),
(14, 2, 1, 'Holaaaa', '2026-05-06 17:08:58', 1),
(15, 2, 1, 'CONTESTA COÑO NFDNASLODNASLDFNS', '2026-05-06 17:11:00', 1),
(16, 1, 2, 'QUE COÑO QUIERES???????????????', '2026-05-06 17:12:09', 1),
(17, 2, 1, 'YA NAAAAA', '2026-05-07 10:33:27', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personajes`
--

CREATE TABLE `personajes` (
  `id` int(11) NOT NULL,
  `id_juego` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `rol` varchar(50) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL COMMENT 'Nombre del archivo de imagen del personaje'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personajes`
--

INSERT INTO `personajes` (`id`, `id_juego`, `nombre`, `rol`, `ubicacion`, `descripcion`, `imagen`) VALUES
(5, 9, 'El Cazador', 'Principal', 'Astera', NULL, NULL),
(6, 9, 'Nergigante', 'Monstruo', 'Lecho de los Ancianos', NULL, NULL),
(7, 9, 'Rathalos', 'Monstruo', 'Bosque Primigenio', NULL, NULL),
(8, 10, 'Zagreo', 'Principal', 'Inframundo', NULL, NULL),
(9, 10, 'Hades', 'Antagonista', 'Templo de Hades', NULL, NULL),
(10, 10, 'Artemisa', 'Aliado', 'Olimpo', NULL, NULL),
(11, 11, 'El Caballero', 'Principal', 'Dirtmouth', NULL, NULL),
(12, 11, 'Hornet', 'Aliado', 'Nido Profundo', NULL, NULL),
(13, 14, 'Madeline', 'Principal', 'Montaña Celeste', NULL, NULL),
(14, 14, 'Badeline', 'Antagonista', 'Espejo del Templo', NULL, NULL),
(15, 15, 'Melina', 'Doncella', 'Necrolimbo', 'Guía del Sin Luz. Permite invocar a Torrente y transformar runas en poder.', NULL),
(16, 15, 'Ranni la Bruja', 'Princesa Lunar', 'Liurnia de los Lagos', 'Princesa Caria que busca un nuevo orden bajo la luna y las estrellas.', NULL),
(17, 15, 'Blaidd el Medio Lobo', 'Guerrero', 'Necrolimbo', 'Sombra y guardaespaldas de Ranni, creado para protegerla.', NULL),
(18, 15, 'Malenia, la Espada de Miquella', 'Semidiós', 'Árbol Hierático', 'Guerrera invicta. Ha sucumbido a la putrefacción roja.', NULL),
(19, 15, 'General Radahn', 'Semidiós', 'Caelid', 'Semidiós que detuvo las estrellas con magia gravitatoria.', NULL),
(20, 15, 'Rykard, Señor de la Blasfemia', 'Semidiós', 'Monte Gelmir', 'Semidiós fusionado con la gran serpiente Eiglay.', NULL),
(21, 15, 'Sir Gideon Ofnir', 'Jefe', 'Mesa Redonda', 'Hechicero que buscaba ser el Señor del Círculo.', NULL),
(22, 15, 'Godfrey, Primer Señor del Círculo', 'Jefe', 'Leyndell', 'Guerrero ancestral, primer marido de la Reina Marika.', NULL),
(23, 15, 'Morgott, Rey de los Augurios', 'Semidiós', 'Castillo de Velo Tormentoso', 'Semidiós rechazado. Gobernante de Leyndell.', NULL),
(24, 15, 'Radagon de la Orden Dorada', 'Dios', 'Dentro del Erdtree', 'Otra mitad de la Reina Marika. Jefe final que encarna el Círculo de Elden.', NULL),
(25, 17, 'Geralt de Rivia', 'Protagonista / Brujo', 'Kaer Morhen', 'El brujo protagonista, conocido como el Lobo Blanco. Maestro espadachín y cazador de monstruos profesional.', NULL),
(26, 17, 'Ciri', 'Bruja / Hija Adoptiva', 'Kaer Morhen', 'Heredera al trono de Cintra e hija adoptiva de Geralt. Posee poderes de viaje interdimensional.', NULL),
(27, 17, 'Yennefer de Vengerberg', 'Hechicera', 'Novigrado / Skellige', 'Una de las hechiceras más poderosas del Norte. Antigua amante de Geralt y figura materna para Ciri.', NULL),
(28, 17, 'Triss Merigold', 'Hechicera', 'Novigrado', 'Hechicera pelirroja, amiga íntima de Geralt y miembro de la Logia de Hechiceras.', NULL),
(29, 17, 'Vesemir', 'Brujo / Mentor', 'Kaer Morhen', 'El brujo más anciano de la Escuela del Lobo. Mentor y figura paterna de Geralt y Ciri.', NULL),
(30, 17, 'Emhyr var Emreis', 'Emperador de Nilfgaard', 'Vizima', 'Emperador de Nilfgaard y padre biológico de Ciri. Conocido como \"La Llama Blanca\".', NULL),
(31, 17, 'Eredin Bréacc Glas', 'Rey de la Cacería Salvaje', 'Varias', 'Líder de la Cacería Salvaje que persigue a Ciri para obtener su poder interdimensional.', NULL),
(32, 17, 'El Barón Sanguinario', 'Señor de la Guerra', 'Arboleda de los Susurros', 'Antiguo soldado convertido en barón de Velen. Su historia personal es una de las tramas más memorables.', NULL),
(33, 17, 'Dandelion (Jaskier)', 'Bardo', 'Novigrado', 'El bardo más famoso del mundo, amigo íntimo de Geralt. Conocido por sus baladas.', NULL),
(34, 17, 'Zoltan Chivay', 'Herrero / Enano', 'Novigrado', 'Herrero enano y amigo leal de Geralt. Veterano de guerra y miembro de la resistencia.', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1 COMMENT '0=Admin, 1=Usuario normal',
  `amigos` text DEFAULT NULL,
  `ultima_conexion` datetime DEFAULT NULL,
  `conectado` int(11) DEFAULT 0,
  `ban_hasta` datetime DEFAULT NULL,
  `avatar` varchar(255) DEFAULT 'default.jpg' COMMENT 'Nombre del archivo de avatar',
  `bio` text DEFAULT NULL COMMENT 'Descripción del perfil',
  `idioma` varchar(5) DEFAULT 'es' COMMENT 'Idioma preferido (es / en)',
  `perfil_publico` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = perfil visible para otros usuarios'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `user`, `email`, `pass`, `nombre`, `level`, `amigos`, `ultima_conexion`, `conectado`, `ban_hasta`, `avatar`, `bio`, `idioma`, `perfil_publico`) VALUES
(1, 'admin', 'admin@codex.com', '$2y$10$.lcZx/nYYiigptnDuhgELuVDhUzm0BDs2/yUbzS1cMgt2qyBUQTze', 'Administrador', 0, '#2#', '2026-05-07 10:57:10', 0, NULL, 'avatar_1_1777879973.jpg', 'Me llamo Manuel Acevedo y soy el Admin de Next Level Code.', 'es', 0),
(2, 'editor', 'editor@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Editor de Contenido', 1, '#1#', '2026-05-07 10:33:13', 1, NULL, 'default.jpg', 'Editor de Next Level Code, cuyo superior es el Admin.', 'es', 0),
(3, 'user', 'user@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Dani', 1, NULL, '2026-05-06 17:44:35', 0, NULL, 'default.jpg', NULL, 'es', 0),
(5, 'nora', 'nora@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Nora', 1, NULL, NULL, 0, NULL, 'default.jpg', 'Exploradora de mundos abiertos y amante de los RPG.', 'es', 0),
(6, 'ivan', 'ivan@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Iván', 1, NULL, NULL, 0, NULL, 'default.jpg', 'Fan de los juegos de estrategia y los combates tácticos.', 'es', 0),
(7, 'pedro', 'pedro@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Pedro', 1, NULL, NULL, 0, NULL, 'default.jpg', 'Coleccionista de logros y cazador de secretos en videojuegos.', 'es', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoraciones`
--

CREATE TABLE `valoraciones` (
  `id` int(11) NOT NULL,
  `id_juego` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `puntuacion` tinyint(4) NOT NULL CHECK (`puntuacion` between 1 and 5),
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `valoraciones`
--

INSERT INTO `valoraciones` (`id`, `id_juego`, `id_usuario`, `puntuacion`, `fecha`) VALUES
(10, 9, 1, 5, '2026-05-05 17:53:16'),
(11, 9, 2, 4, '2026-05-05 17:53:16'),
(12, 9, 3, 5, '2026-05-05 17:53:16'),
(13, 10, 1, 5, '2026-05-05 17:53:16'),
(14, 10, 2, 5, '2026-05-05 17:53:16'),
(15, 11, 1, 5, '2026-05-05 17:53:16'),
(16, 11, 3, 4, '2026-05-05 17:53:16'),
(17, 12, 1, 4, '2026-05-05 17:53:16'),
(18, 12, 3, 5, '2026-05-05 17:53:16'),
(19, 14, 2, 5, '2026-05-05 17:53:16'),
(20, 14, 3, 5, '2026-05-05 17:53:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `visitas_juegos`
--

CREATE TABLE `visitas_juegos` (
  `id` int(11) NOT NULL,
  `id_juego` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `visitas_juegos`
--

INSERT INTO `visitas_juegos` (`id`, `id_juego`, `id_usuario`, `fecha`) VALUES
(7, 9, 1, '2026-05-05 17:53:31'),
(8, 10, 1, '2026-05-05 17:53:48'),
(9, 10, 1, '2026-05-05 17:54:07'),
(10, 10, 1, '2026-05-05 17:54:24'),
(11, 9, 1, '2026-05-05 17:54:47'),
(12, 10, 1, '2026-05-05 17:56:03'),
(13, 9, 1, '2026-05-05 17:56:50'),
(14, 10, 1, '2026-05-05 17:57:23'),
(15, 10, 1, '2026-05-05 18:07:04'),
(16, 9, 1, '2026-05-06 09:44:02'),
(17, 9, 1, '2026-05-06 09:44:13'),
(18, 9, 1, '2026-05-06 09:45:11'),
(19, 11, 1, '2026-05-06 09:47:34'),
(20, 9, 1, '2026-05-06 09:58:37'),
(21, 10, 1, '2026-05-06 10:14:59'),
(22, 10, 1, '2026-05-06 10:26:04'),
(23, 10, 1, '2026-05-06 10:29:21'),
(24, 10, 1, '2026-05-06 10:30:06'),
(25, 10, 1, '2026-05-06 10:32:28'),
(26, 10, 1, '2026-05-06 10:35:57'),
(27, 10, 1, '2026-05-06 14:20:38'),
(28, 10, 1, '2026-05-06 14:52:35'),
(29, 10, 1, '2026-05-06 14:59:41'),
(30, 10, 1, '2026-05-06 15:00:36'),
(31, 10, 1, '2026-05-06 16:15:42'),
(32, 10, 1, '2026-05-06 16:22:30'),
(33, 10, 1, '2026-05-06 16:23:17'),
(34, 10, 1, '2026-05-06 16:24:54'),
(35, 10, 1, '2026-05-06 16:25:02'),
(36, 10, 1, '2026-05-06 16:27:24'),
(37, 10, 1, '2026-05-06 16:27:31'),
(38, 12, 1, '2026-05-06 16:41:09'),
(39, 12, 1, '2026-05-06 16:41:37'),
(40, 10, 1, '2026-05-06 16:44:43'),
(41, 9, 1, '2026-05-06 16:46:18'),
(42, 9, 1, '2026-05-06 16:47:45'),
(43, 14, 3, '2026-05-06 16:54:10'),
(44, 12, 3, '2026-05-06 16:54:16'),
(45, 10, 3, '2026-05-06 16:54:24'),
(46, 10, 2, '2026-05-06 16:54:37'),
(47, 10, 2, '2026-05-06 16:54:41'),
(48, 11, 2, '2026-05-06 16:55:50'),
(49, 10, 2, '2026-05-06 16:57:33'),
(50, 13, 2, '2026-05-06 16:57:43'),
(51, 14, 2, '2026-05-06 16:58:01'),
(52, 14, 2, '2026-05-06 16:58:34'),
(53, 10, 1, '2026-05-06 17:05:12'),
(54, 13, 1, '2026-05-06 17:30:46'),
(55, 11, 1, '2026-05-06 17:37:26'),
(56, 9, 3, '2026-05-06 18:07:19'),
(57, 10, 3, '2026-05-06 18:07:40'),
(58, 13, 1, '2026-05-06 18:08:50'),
(59, 13, 1, '2026-05-07 09:13:51'),
(60, 12, 1, '2026-05-07 09:15:55'),
(61, 9, 1, '2026-05-07 09:43:37'),
(62, 12, 1, '2026-05-07 09:49:46'),
(63, 12, 1, '2026-05-07 09:55:41'),
(64, 12, 1, '2026-05-07 10:11:09'),
(65, 12, 1, '2026-05-07 10:13:12'),
(66, 12, 1, '2026-05-07 10:31:41'),
(67, 13, 1, '2026-05-07 10:32:02'),
(68, 15, 1, '2026-05-07 10:57:13'),
(69, 15, 1, '2026-05-07 10:58:49'),
(70, 15, 1, '2026-05-07 11:02:40'),
(71, 15, 1, '2026-05-07 11:22:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `armas`
--
ALTER TABLE `armas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `bloqueados`
--
ALTER TABLE `bloqueados`
  ADD PRIMARY KEY (`id_recep`,`id_block`),
  ADD KEY `id_block` (`id_block`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_juego` (`id_juego`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `domingueros`
--
ALTER TABLE `domingueros`
  ADD PRIMARY KEY (`id_sol`,`id_rec`),
  ADD KEY `id_rec` (`id_rec`);

--
-- Indices de la tabla `elementos`
--
ALTER TABLE `elementos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_elementos_juego` (`id_juego`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id_usuario`,`id_juego`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `juegos`
--
ALTER TABLE `juegos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creador_id` (`creador_id`);

--
-- Indices de la tabla `logros`
--
ALTER TABLE `logros`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `logros_usuarios`
--
ALTER TABLE `logros_usuarios`
  ADD PRIMARY KEY (`id_usuario`,`id_logro`),
  ADD KEY `id_logro` (`id_logro`);

--
-- Indices de la tabla `mapas`
--
ALTER TABLE `mapas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `mensajes_grupales`
--
ALTER TABLE `mensajes_grupales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emisor` (`emisor`),
  ADD KEY `idx_msg_grupales_id` (`id`);

--
-- Indices de la tabla `mensajes_privados`
--
ALTER TABLE `mensajes_privados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `receptor` (`receptor`),
  ADD KEY `idx_msg_privados_conv` (`emisor`,`receptor`,`id`);

--
-- Indices de la tabla `personajes`
--
ALTER TABLE `personajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user` (`user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unica_valoracion` (`id_juego`,`id_usuario`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `visitas_juegos`
--
ALTER TABLE `visitas_juegos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_visitas_juego` (`id_juego`),
  ADD KEY `idx_visitas_fecha` (`fecha`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `armas`
--
ALTER TABLE `armas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `elementos`
--
ALTER TABLE `elementos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `juegos`
--
ALTER TABLE `juegos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `logros`
--
ALTER TABLE `logros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `mapas`
--
ALTER TABLE `mapas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `mensajes_grupales`
--
ALTER TABLE `mensajes_grupales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `mensajes_privados`
--
ALTER TABLE `mensajes_privados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `personajes`
--
ALTER TABLE `personajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `visitas_juegos`
--
ALTER TABLE `visitas_juegos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `armas`
--
ALTER TABLE `armas`
  ADD CONSTRAINT `armas_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `bloqueados`
--
ALTER TABLE `bloqueados`
  ADD CONSTRAINT `bloqueados_ibfk_1` FOREIGN KEY (`id_recep`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bloqueados_ibfk_2` FOREIGN KEY (`id_block`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `domingueros`
--
ALTER TABLE `domingueros`
  ADD CONSTRAINT `domingueros_ibfk_1` FOREIGN KEY (`id_sol`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `domingueros_ibfk_2` FOREIGN KEY (`id_rec`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `elementos`
--
ALTER TABLE `elementos`
  ADD CONSTRAINT `elementos_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `juegos`
--
ALTER TABLE `juegos`
  ADD CONSTRAINT `juegos_ibfk_1` FOREIGN KEY (`creador_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `logros_usuarios`
--
ALTER TABLE `logros_usuarios`
  ADD CONSTRAINT `logros_usuarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `logros_usuarios_ibfk_2` FOREIGN KEY (`id_logro`) REFERENCES `logros` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mapas`
--
ALTER TABLE `mapas`
  ADD CONSTRAINT `mapas_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensajes_grupales`
--
ALTER TABLE `mensajes_grupales`
  ADD CONSTRAINT `mensajes_grupales_ibfk_1` FOREIGN KEY (`emisor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensajes_privados`
--
ALTER TABLE `mensajes_privados`
  ADD CONSTRAINT `mensajes_privados_ibfk_1` FOREIGN KEY (`emisor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mensajes_privados_ibfk_2` FOREIGN KEY (`receptor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `personajes`
--
ALTER TABLE `personajes`
  ADD CONSTRAINT `personajes_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD CONSTRAINT `valoraciones_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `valoraciones_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `visitas_juegos`
--
ALTER TABLE `visitas_juegos`
  ADD CONSTRAINT `visitas_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
