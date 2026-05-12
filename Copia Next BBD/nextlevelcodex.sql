-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-05-2026 a las 14:35:19
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

--
-- Volcado de datos para la tabla `domingueros`
--

INSERT INTO `domingueros` (`id_sol`, `id_rec`, `fecha`, `statu`) VALUES
(1, 7, 1778586214, 0),
(7, 2, 1778159126, 0);

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
(21, 12, 'Calcetines y botines', 'Comodín (Joker)', 'Reactiva todas las cartas de Figura (J, Q, K) juga', 'N/A (Efecto de re-activación)', 'Raro', 'Representando las máscaras clásicas de la tragedia y la comedia, este Comodín convierte el tablero en un escenario donde la nobleza actúa dos veces. Cada vez que juegas una Jota, Reina o Rey, sus habilidades, bonificadores de fichas y multiplicadores se activan una segunda vez. Es el catalizador perfecto para maximizar el valor de las cartas con sellos, ediciones especiales o aquellas que tienen efectos al puntuar. Con este Comodín, la corte de la baraja no solo se presenta, sino que ofrece un bis que puede duplicar fácilmente la potencia total de tu mano.', 'elem_1778487011.png'),
(22, 12, 'Excursionista', 'Comodín (Joker)', '+4 Fichas (Chips) permanentes a cada carta jugada', 'El bono se añade a la carta individualmente al pun', 'Común', 'Con su mochila al hombro y un bastón resistente, este Comodín entiende que el éxito es un camino de mil pasos. Cada vez que una carta de tu mano puntúa, el Excursionista le otorga un bono permanente de +4 fichas. A diferencia de otros efectos, este beneficio se \"graba\" en la carta para el resto de la partida; cuanto más uses las mismas cartas, más pesadas y valiosas se volverán. Es el aliado perfecto para mazos pequeños y optimizados, transformando naipes comunes en auténticos titanes de puntuación a base de pura persistencia y kilómetros recorridos.', 'elem_1778140174.png'),
(23, 12, 'Mimo', 'Comodín (Joker)', 'Reactiva todas las habilidades de las cartas reten', 'N/A (Efecto de repetición)', 'Raro', 'Una figura silenciosa que imita cada gesto y propiedad de los naipes que aún no han sido jugados. El Mimo no interactúa con los Comodines, sino que se especializa en duplicar los efectos de las cartas que el jugador decide conservar en su mano. Si posees cartas con sellos de oro, cartas de acero o cartas con bonificadores que se activan \"al final de la mano\", el Mimo obliga a que esas habilidades se disparen una segunda vez. Es un maestro del valor pasivo, permitiendo que tu reserva de cartas genere una montaña de puntos o dinero sin necesidad de ser lanzadas a la mesa', 'elem_1778486837.png'),
(24, 12, 'Comodín Estandar', 'Comodín (Joker)', '+4 de Multiplicador.', 'Efecto constante (sin condiciones).', 'Común', 'El rostro más familiar y emblemático de la baraja. Este bufón clásico no se anda con rodeos ni exige combinaciones complejas: su mera presencia en tu fila de Comodines garantiza un aumento directo del multiplicador en cada mano que lances, sea cual sea. Aunque es la herramienta más básica en el arsenal de un jugador, su fiabilidad lo convierte en el soporte ideal durante los primeros niveles, asegurando que ninguna jugada se quede corta. Es el recordatorio de que, en este juego, incluso el recurso más sencillo puede ser la clave para sobrevivir una ronda más.', 'elem_1778486671.png'),
(25, 12, 'Comodín Lujurioso', 'Comodín (Joker)', '+3 de Multiplicador por cada carta jugada.', 'Solo aplica a cartas del palo de Corazones.', 'Común', 'Un comodín que irradia una energía pasional y vibrante, obsesionado con el color rojo y la forma del corazón. Esta carta premia la consistencia temática en tu mano: cada vez que juegas una carta de Corazones que puntúa, añade un bono directo al multiplicador. Es una herramienta fundamental en las fases tempranas del juego para escalar el puntaje de forma sencilla, especialmente si consigues transformar tu mazo para que las cartas rojas dominen el tablero. Su poder es simple pero implacable: mientras más amor le des a tus jugadas, más alto volará tu puntuación.', 'elem_1778486514.png'),
(26, 14, 'Fresa Alada', 'Coleccionable / Objeto de Desafío', '+1000 Puntos de puntuación.', 'Desaparece instantáneamente si el portador utiliza', 'Raro', 'Una variante etérea de la fruta común de la montaña, dotada de un par de alas blancas que baten con nerviosismo. Esta fresa posee una naturaleza esquiva y orgullosa: solo permite ser recolectada por aquellos que demuestren la pureza de su ascenso. Si el escalador intenta utilizar su energía interna para impulsarse (Dash) mientras está cerca, la fresa se asustará y volará rápidamente hacia lo alto, perdiéndose entre las nubes. Es un trofeo de paciencia y habilidad técnica, un recordatorio de que a veces el camino más lento es el único que permite alcanzar la verdadera recompensa.', 'elem_1778510894.png'),
(27, 14, 'Cristal Azul', 'Artefacto Mágico / Cristal de Energía', 'Recuperación instantánea del Impulso (Dash).', 'Emite una resonancia que revela plataformas oculta', 'Épico', 'Una gema de un azul gélido y profundo que parece latir con el mismo ritmo que el corazón de la montaña Celeste. Al entrar en contacto con él, el viajero siente una ráfaga de claridad que restaura sus energías instantáneamente, permitiendo un nuevo impulso en el aire. Más allá de su utilidad física, el cristal actúa como un espejo de la psique; brilla con más intensidad cuando el portador acepta sus miedos, convirtiendo la ansiedad en la fuerza necesaria para ascender por las paredes más escarpadas de la cueva.', 'elem_1778510659.png'),
(28, 14, 'Pluma Dorada', 'Artefacto de Vuelo / Consumible Temporal', 'Otorga vuelo libre durante un tiempo limitado.', 'Inmunidad a la fatiga mientras se está en forma de', 'Épico', 'Una pluma que irradia un brillo cálido y constante, tan ligera que parece flotar desafiando la gravedad de la montaña. Al tocarla, el cuerpo del viajero se transforma en una esfera de luz pura, permitiéndole navegar por las corrientes de aire con total libertad en cualquier dirección. Es una herramienta de meditación física: requiere una mente calmada para ser dirigida con precisión. Para Madeline, esta pluma es el recordatorio de un ejercicio de respiración: un ancla de paz que permite elevarse por encima del caos y las espinas del entorno.', 'elem_1778511052.png'),
(29, 15, 'Río de Sangre', 'Katana', 'Daño Físico y de Fuego (Escala con Destreza y Arca', 'Acumulación de Hemorragia y habilidad única \"Senda', 'Legendario', 'Una katana de hoja carmesí que perteneció a Okina, un espadachín de la Tierra de los Juncos cuya sed de sangre era tan grande que fue bendecido por el propio Mohg. Su habilidad especial, \"Senda de Sangre\", permite al portador desatar ráfagas de tajos diagonales formados por sangre maldita que tienen un alcance sorprendente. Cada golpe no solo corta la carne, sino que consume la vitalidad del enemigo en un torrente de fuego y hemorragia. Es un arma elegante y cruel, diseñada para terminar los duelos antes de que el oponente pueda siquiera comprender que ya ha sido sentenciado.', 'elem_1778575034.png'),
(30, 15, 'Espada de la Noche y la Llama', 'Arma', '115', 'Escalado de Fe e Inteligencia', 'Legendario', 'Espada mitológica y tesoro de la mansión de los Caria.\r\nEs una de las armas legendarias.\r\n\r\nLos astrólogos que precedieron a los hechiceros se establecieron en lo alto de las montañas más elevadas, las que casi tocaban el cielo, y consideraban a los gigantes de fuego como sus vecinos.\r\n\r\nHabilidad: Combate igneocturno\r\nNo alces ni bajes la espada y prepárate para lanzar un hechizo. Acompáñala con un ataque normal para lanzar el hechizo del dardo nocturno, o bien con un ataque potente para incendiar la zona situada frente a ti en un movimiento de barrido.', 'elem_1778145674.png'),
(31, 15, 'Hoja Blasfema', 'Arma', '145', 'Robo de vida', 'Legendario', 'Es el arma sagrada de Rykard, Señor de la Blasfemia. Se trata de un espadón cuya superficie está cubierta por los restos de los innumerables héroes que el señor devoró, los cuales se retuercen sobre el metal compartiendo ahora la misma sangre como una \"familia\".\r\n\r\nAl activar su ceniza de guerra única, el jugador alza la espada para envolverla en llamas blasfemas y luego la baja para lanzar una ráfaga de fuego frontal. Esta ráfaga no solo inflige daño masivo, sino que absorbe PS de los enemigos alcanzados, lo que permite recuperar vida rápidamente durante el combate.', 'elem_1778146190.png'),
(33, 15, 'Espadón de la luna negra', 'Arma', '130', 'Magia de hielo', 'Legendario', 'Espadón de la luna otorgado por las reinas carianas a sus cónyuges según una longeva tradición.\r\nUna de las armas legendarias.\r\n\r\nEl sello de Ranni es una luna llena, fría y plúmbea, y esta espada es un haz de su luz.\r\n\r\nHabilidad única: Espadón de luz lunar\r\nAlza la espada por encima de tu cabeza para bañarla en la luz de la luna negra.\r\nAumenta temporalmente la potencia de ataque mágico e imbuye la hoja en congelación.\r\nLos ataques cargados liberan ráfagas de luz lunar.', 'elem_1778145456.png'),
(34, 15, 'Lanza Sagrada de Mohgwyn', 'Lanza Grande / Arma de Recuerdo', 'Daño Físico y de Fuego (Escala con Fuerza, Destrez', 'Acumulación masiva de Hemorragia y habilidad \"Ritu', 'Legendario', 'Un tridente que sirve como símbolo del futuro Palacio de Mohgwyn y del Reino de la Sangre que Mohg desea establecer. Esta lanza no solo es una herramienta de guerra, sino un conducto ritual para comulgar con la \"Madre Sin Forma\". Su habilidad especial permite al portador alzar el tridente y apuñalar el cielo, provocando explosiones de sangre sagrada que bañan el área y causan una hemorragia catastrófica a cualquiera que esté cerca. Es el arma definitiva para quienes han jurado lealtad al Señor de la Sangre, capaz de convertir el campo de batalla en un altar de sacrificio carmesí.', 'elem_1778574934.png'),
(35, 15, 'Espadón de Hoja Injertada', 'Arma', '150', 'Atributos +5', 'Legendario', 'La famosa espada del Castillo de Morne. Arma de vengador que carga con océanos de ira y arrepentimiento.\r\nUna de la armas legendarias.\r\n\r\nUn solitario campeón, superviviente de un país desaparecido, mostró tal determinación a la hora de seguir luchando que reclamó las espadas de todo un clan de guerreros.\r\n\r\nHabilidad: Juramento de venganza\r\nHaz un juramento sobre el espadón para vengar al clan, lo que aumentará todos tus atributos de forma temporal. Mientras los efectos del juramento estén activos, tu aplomo también aumentará.', 'elem_1778145690.png'),
(36, 15, 'Espadón de Ruinas', 'Arma', '160', 'Gravedad', 'Legendario', 'Aunque originalmente era un escombro de una ruina que cayó del cielo, este fragmento acabaría convirtiéndose en un arma.\r\nEs una de las armas legendarias.\r\n\r\nLa ruina de la que provenía se vino abajo al impactar un meteorito contra ella. Por tanto, este arma posee su poder destructivo.\r\n\r\nHabilidad única: Ola de destrucción\r\nLevanta la espada en lo alto y luego golpea el suelo con ella para lanzar una onda de choque gravitatoria.', 'elem_1778145712.png'),
(37, 15, 'Cetro del Devorador', 'Cetro', 'Daño: 140', 'Ceniza: Devastación', 'Legendario', 'Cetro con forma de serpiente devorando el mundo. Esta arma se convertirá, algún día, en el símbolo del señor de la Blasfemia.\r\nEs una de las armas legendarias.\r\n\r\nDicen que su diseño es una breve visión del futuro que tuvo Rykard en sus últimos momentos de vida, tras ser devorado por la gran serpiente.\r\n\r\nHabilidad: Devorador de mundos\r\nCarga el cetro con magia y golpea el suelo con él para robar los PS de todos los enemigos cercanos.', 'elem_1778153553.png'),
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
(48, 17, 'Ballesta de la Escuela del Gato', 'Ballesta', '45', '+5% Prob. Crítico', 'Reliquia', 'Ballesta ligera para builds rápidos. Aumenta la probabilidad de crítico.', NULL),
(49, 19, 'La Espada de la Justicia', 'Espadón', '2d6 + 1 (Cortante)', 'Conjuro \"Protección de Tyr\" (Acción adicional).', 'Raro', 'Un espadón imponente con el símbolo de la balanza de Tyr grabado en el pomo. Esta hoja no solo está afilada para imponer la ley, sino que está imbuida con una bendición protectora. El portador puede invocar la \"Protección de Tyr\", un escudo de fe que rodea al guerrero y aumenta su Clase de Armadura en +2. Se dice que mientras la causa sea justa, la hoja nunca se mellaría, aunque la sangre de los inocentes puede apagar su brillo divino.', 'elem_1778509337.png'),
(50, 19, 'Espadón del Señor del Caos', 'Espadón', '2d6+2', '1d4 de daño elemental aleatorio (Fuego, Rayo o Áci', 'Épico', 'Una hoja cuya forma parece mutar ligeramente cuando no se la observa directamente, forjada en un nexo donde los planos elementales colisionan. Al impactar, la energía del caos se libera de forma errática, bañando al enemigo en llamas, descargas eléctricas o fluidos corrosivos sin un patrón fijo. Aquellos que la empuñan dicen escuchar una cacofonía de voces que celebran cada golpe crítico, otorgando al portador \"Entusiasmo Caótico\", lo que le permite realizar un ataque adicional si logra derribar a un oponente.', 'elem_1778509489.png'),
(51, 19, 'Bastón de Nigromancia Apreciada', 'Bastón de combate', '1d6 (1d8) + 1 (Contundente)', 'Cosecha de Vida (Lanzamiento gratuito de hechizos ', 'Épico', 'Un báculo retorcido que exhala un frío sepulcral, imbuido con la esencia de innumerables almas atrapadas. Su propiedad más temible, \"Cosecha de Vida\", permite al portador absorber la energía vital de un enemigo caído para alimentar su propia magia; tras matar a una criatura con un hechizo, el siguiente hechizo de nigromancia no consumirá espacios de conjuro. Además, el bastón impone desventaja a los enemigos en sus tiradas de salvación contra tus conjuros de muerte, asegurando que el abrazo de la tumba sea inevitable.', 'elem_1778510024.png'),
(52, 19, 'Gontr Mael', 'Arco Largo', '1d8+3', 'Daño psíquico 1d4', 'Legendario', 'Tallado en madera de árbol umbral regada con sangre de ilusionista drow. Las flechas disparadas con este arco atraviesan la oscuridad sin penalización y aplican «Aterrorizado» al objetivo si falla una tirada de salvación de Sabiduría CD 15. Perfecto para los rangers que prefieren las sombras a la luz.', 'elem_1778503856.png'),
(53, 19, 'Escudo de la Devoción', 'Escudo', '+2 CA', 'Otorga un espacio de conjuro adicional de nivel 1.', 'Épico', 'Un escudo de acero pulido que brilla con una pureza sobrenatural, reflejando no solo al enemigo, sino la fe inquebrantable de quien lo porta. Su bendición principal, \"Devoción Adicional\", expande la reserva mágica del usuario permitiéndole lanzar un hechizo más de primer nivel. Además, permite usar la reacción \"Reprimenda Escudada\" para derribar a los atacantes que fallen sus golpes cuerpo a cuerpo, convirtiendo la defensa en un acto de justicia divina.', 'elem_1778509176.png'),
(54, 19, 'Daga Ritual de Shar', 'Daga', '1d4 + 1 (Perforante)', '+1d4 (Necrótico) al atacar desde las sombras.', 'Raro', 'Una daga de obsidiana que emana una neblina de sombras al ser desenvainada. Los ataques con ella desde posición de ocultamiento infligen 2d6 adicionales de daño psíquico y no rompen la invisibilidad del portador si el objetivo muere. Arma favorita de los Asesinos del Culto de la Araña.', 'elem_1778504469.png'),
(55, 19, 'Amuleto de Salud Superior', 'Amuleto', 'Constitución 19', 'Regeneración 2 PG/turno', 'Épico', 'Tallado en madera de roble por el Gran Druida del Bosque de Silvanus. Fija la Constitución del portador en 19 sin importar su valor base, y al inicio de cada turno en combate regenera 2 puntos de golpe siempre que el portador esté en contacto con suelo natural.', 'elem_1778503136.png'),
(56, 19, 'Espada Plateada de Voss', 'Espadón', '2d6 + 2 (Cortante)', '+1d6 (Psíquico) si el portador es Githyanki.', 'Épico', 'Una hoja de plata astral forjada con técnicas githyanki milenarias que cortan no solo la carne, sino el tejido de la realidad. Resuena con la mente del portador, otorgando ventaja en tiradas de salvación mentales contra magia. Su filo ignora la resistencia al daño cortante de los constructos y permite al usuario desvanecerse mediante \"Paso Brumoso\". Es un símbolo de rebelión y poder, capaz de cercenar vínculos de plata en el Plano Astral.', 'elem_1778504320.png'),
(57, 19, 'Travesura carmesí', 'Daga', '1d4 + 2 (Perforante)', '+1d4 (Necrótico) y daño adicional contra objetivos', 'Legendario', 'Una hoja cruel y dentada que parece latir con una sed de sangre insaciable, reflejando la locura de su antigua dueña. Esta daga destaca por su habilidad \"Presa del Dominio\": si atacas con ventaja, infliges 7 de daño perforante adicional. Además, cuando se empuña en la mano principal, inflige daño necrótico extra a los enemigos que tengan menos del 50% de su vida. Es una herramienta de ejecución perfecta, diseñada no solo para herir, sino para deleitarse en la agonía final de la víctima.', 'elem_1778509886.png'),
(58, 19, 'La Alabarda de la Vigilancia', 'Alabarada', '1d10 + 2 (Cortante)', '+1d4 (Fuerza) y Ventaja en ataques de oportunidad.', 'Épico', 'Una pesada arma de asta cuya hoja parece seguir los movimientos del enemigo antes incluso de que estos ocurran. Gracias a su encantamiento de \"Centinela Adiestrado\", el portador goza de una agudeza sensorial sobrenatural, obteniendo una bonificación de +1 a las tiradas de Iniciativa y Ventaja en todos los ataques de oportunidad. Además, cada impacto resuena con una energía cinética pura que añade daño de fuerza adicional, convirtiéndola en la herramienta defensiva definitiva para mantener a raya a las hordas del Absoluto.', 'elem_1778509731.png'),
(59, 19, 'Armadura del Anochecer Infernal', 'Armadura/Traje', 'CA 21', 'Fuego (Inmunidad a Quemado) y Reducción de daño fí', 'Legendario', 'Forjada en las llamas más profundas de los Nueve Infiernos por el mismísimo Raphael, esta placa legendaria vibra con un calor eterno y malévolo. Proporciona competencia automática con armaduras pesadas al portador. Su superficie castiga a los agresores con el estado \"Quemado\" tras un hechizo fallido. Incluye la capacidad de \"Vuelo Infernal\". Sin embargo, su poder tiene un origen oscuro: el alma del portador se siente constantemente observada por los ojos del Archidiablo, recordándole que toda protección en el Averno tiene un precio.', 'elem_1778503842.png'),
(60, 19, 'Botas del Teletransportador Fugaz', 'Botas Mágicas', 'Velocidad +3 m', 'Paso Brumoso (3/descanso)', 'Raro', 'Unas ligeras botas de cuero encontradas en el equipaje de un mago githyanki. Aumentan el movimiento base 3 metros y permiten lanzar «Paso Brumoso» hasta 3 veces por descanso corto sin usar ningún espacio de hechizo. Populares entre los pícaros de la Costa de la Espada.', 'elem_1778504044.png'),
(61, 20, 'Hacha Leviatán', 'Arma principal', 'Daño de hielo', 'Furia de la tormenta de hielo', 'Legendario', 'La poderosa hacha que perteneció a Laufey, la esposa de Kratos. Puede congelar enemigos y ser arrojada para volver a la mano.', NULL),
(62, 20, 'Espadas del Caos', 'Espadas dobles', 'Daño de fuego', 'Llamarada ígnea', 'Legendario', 'Armas inseparables de Kratos desde su época en Grecia, perfectas para combates contra grupos de enemigos.', NULL),
(63, 20, 'Lanza Draupnir', 'Arma principal', 'Daño de viento', 'Multiplicación explosiva', 'Legendario', 'Una nueva arma forjada por los Hermanos Huldra. Absorbe enemigos a distancia, se multiplica y detona.', NULL),
(64, 20, 'Escudo Guardián', 'Escudo', 'Defensa equilibrada', 'Contragolpe potente', 'Raro', 'El escudo que le regaló su esposa Faye a Kratos, un equilibrio perfecto entre defensa y contraataque.', NULL),
(65, 20, 'Arco de Garra', 'Arco (Atreus)', 'Disparo simple', 'Aumento de aturdimiento', 'Común', 'El arco principal de Atreus, fabricado por su madre. Útil para atacar a distancia y resolver puzzles.', NULL),
(66, 20, 'Armadura de placas del Juicio Absoluto', 'Armadura de pecho', 'Defensa excepcional', 'Inmunidad al aturdimiento', 'Muy Rara', 'Una imponente armadura forjada en los hornos de Svartalfheim que otorga una defensa inigualable.', NULL),
(67, 20, 'Faja de la Perdición de Lúnda', 'Armadura de cintura', 'Suerte moderada', 'Activación de golpe crítico', 'Rara', 'Armadura ligera de cuero flexible que otorga una gran suerte, permitiendo activar golpes críticos.', NULL),
(68, 20, 'Reliquia del Talismán de Meign', 'Reliquia', 'Aumento de daño cuerpo a cuerpo', '89s de recarga', 'Épica', 'Un artefacto antiguo que, al activarse, imbuye los ataques cuerpo a cuerpo de Kratos con una fuerza devastadora.', NULL),
(69, 20, 'Encantamiento de Niflheim', 'Encantamiento', 'Defensa alta', 'Regeneración de vida', 'Raro', 'Una gema de hielo extraída de la niebla de Niflheim que acelera la curación de las heridas.', NULL),
(70, 20, 'Puño de los Cuatro Vientos', 'Accesorio de Lanza', 'Fuerza aumentada', 'Onda de choque al rematar', 'Raro', 'Un estabilizador aerodinámico que se acopla a la Lanza Draupnir para crear una onda de choque al final de los combos.', NULL),
(71, 21, 'Malorian Arms 3516', 'Pistola de Potencia Icónica', 'Daño físico con una cadencia de tiro semiautomátic', 'Los disparos desde la cadera tienen rebote; al apu', 'Legendario', 'Más que una simple herramienta de destrucción, esta pistola es una extensión de la leyenda de Johnny Silverhand. Fabricada por encargo especial a Malorian Arms, es un híbrido tecnológico adelantado a su época: combina la potencia bruta de un cañón de mano con la precisión de un rifle técnico. Su característica más icónica es el lanzallamas integrado que se activa al golpear cuerpo a cuerpo, permitiendo incinerar a los enemigos que se acerquen demasiado. Empuñarla no es solo cuestión de potencia de fuego, es heredar el espíritu rebelde que intentó derribar la Torre Arasaka.', 'elem_1778572911.png'),
(72, 21, 'Satori', 'Katana Icónica', 'Daño físico base ligeramente inferior a otras kata', 'Multiplicador de daño crítico masivo (hasta un 500', 'Legendario', 'Una antigüedad forjada en el siglo XX que ha sido mantenida con una perfección casi divina. La Satori no es un arma de fuerza bruta, sino de precisión absoluta. Aunque sus tajos normales pueden parecer estándar, un golpe bien colocado en un punto vital es capaz de infligir una cantidad de daño devastadora, superando con creces a cualquier otra hoja moderna. Es el símbolo del honor y la letalidad silenciosa de la dinastía Arasaka; una espada que no solo corta la carne, sino que dicta el destino de aquellos que se atreven a enfrentarse a su portador.', 'elem_1778573229.png'),
(73, 21, 'Psalm 11:6', 'Fusil de Asalto de Potencia', 'Daño térmico masivo con una probabilidad extremada', 'Los proyectiles pueden rebotar en superficies y ex', 'Épico', '\"Sobre los impíos hará llover brasas, fuego y azufre\". Fiel a la cita bíblica que le da nombre, este fusil convierte el campo de batalla en un infierno literal. Cada bala disparada por el Psalm 11:6 está imbuida de energía térmica, garantizando que casi cualquier enemigo alcanzado termine envuelto en llamas en cuestión de segundos. Es el arma definitiva para el control de masas: su cadencia de tiro, sumada a su capacidad de rebote, permite limpiar habitaciones enteras mientras los oponentes gritan presa del pánico y el fuego.', 'elem_1778572333.png'),
(74, 21, 'Overwatch', 'Rifle de Francotirador de Potencia (Icónico)', 'Daño físico masivo con un multiplicador de impacto', 'Silenciador personalizado integrado (único en su c', 'Legendario', 'Este rifle de precisión no es una pieza de fábrica de Arasaka ni de Militech; es una obra maestra de la ingeniería nómada, modificada personalmente por Panam Palmer. Su característica más letal es su silenciador artesanal de gran calibre, que permite abatir objetivos desde kilómetros de distancia sin alertar a los sistemas de seguridad enemigos ni romper el silencio del desierto. Con un chasis reforzado para resistir las tormentas de arena de las Badlands, el Overwatch es la herramienta definitiva para el mercenario que busca la máxima letalidad desde las sombras. Es, en esencia, el guardián silencioso de aquellos que recorren el camino libre.', 'elem_1778572719.png'),
(75, 21, 'Solucionadora', 'Subfusil de Asalto de Potencia', 'Daño físico masivo gracias a su altísima cadencia ', 'Cargador ampliado y velocidad de disparo increment', 'Épico', 'Un fusil de asalto de la familia de los M221 Saratoga, modificado para priorizar la saturación de fuego sobre cualquier otra métrica. La Solucionadora no está diseñada para la precisión quirúrgica, sino para \"solucionar\" cualquier conflicto mediante la fuerza bruta, escupiendo balas a una velocidad tal que puede vaciar su cargador ampliado en un parpadeo. Su retroceso es salvaje, pero en las manos adecuadas, es capaz de convertir un pasillo lleno de enemigos en una zona de desastre en cuestión de segundos. Es el arma preferida de los mercenarios que creen que no existe el exceso de potencia de fuego.', 'elem_1778573357.png'),
(76, 21, 'Enviudador', 'Rifle de Precisión Técnico', 'Dispara 2 proyectiles por tiro; inflige daño quími', 'Los disparos cargados atraviesan paredes y tienen ', 'Legendario', 'Un arma que hace honor a su nombre con una eficiencia aterradora. Este rifle técnico ha sido modificado para disparar dos proyectiles simultáneos que se fragmentan al impactar, cubriendo al objetivo en una nube de compuestos tóxicos. Al cargar el disparo, su potencia aumenta hasta el punto de ignorar coberturas sólidas, permitiendo eliminar enemigos desde la seguridad de otra habitación. No es solo un rifle, es una sentencia de muerte química que asegura que nadie sobreviva para contar quién apretó el gatillo.', 'elem_1778571814.png'),
(77, 21, 'Yinglong', 'Subfusil inteligente', 'Daño eléctrico con una probabilidad base de Shock ', 'Al impactar, tiene una probabilidad de crear una e', 'Legendario', 'Una obra maestra de Kang Tao que lleva la guerra electrónica al campo de batalla. El Yinglong no solo rastrea a sus objetivos con una precisión quirúrgica, sino que imbuye cada bala con una carga eléctrica capaz de sobrecargar los sistemas nerviosos y mecánicos de cualquier oponente. Su característica más temida es la generación de pulsos electromagnéticos al impactar, lo que convierte a cada enemigo en una bomba de interferencia que deja a sus aliados vulnerables y sin defensas tecnológicas. Es, literalmente, una tormenta eléctrica contenida en un chasis de polímero blanco y rojo.', 'elem_1778573450.png'),
(78, 21, 'Doom Doom', 'Revólver', 'Dispara una ráfaga de 4 balas por cada tiro.', 'Alta probabilidad de Hemorragia y Desmembramiento;', 'Épico', 'Un revólver modificado con la sádica ingeniería de los Maelstrom. La Doom Doom no entiende de sutilezas: cada vez que aprietas el gatillo, el arma escupe cuatro proyectiles simultáneos, convirtiendo lo que debería ser un disparo de precisión en una lluvia de plomo capaz de despedazar a cualquier enemigo a corta distancia. Aunque su retroceso es difícil de domar, el daño resultante es devastador, haciendo honor a su nombre con cada impacto. Es el arma ideal para los mercenarios que prefieren que sus problemas desaparezcan en una nube de humo y restos cibernéticos.', 'elem_1778571618.png'),
(79, 21, 'Bastón de Cóctel', 'Katana Icónica', 'Daño físico elevado con alta probabilidad de Hemor', 'Mayor alcance de ataque y daño base aumentado mien', 'Legendario', 'No te dejes engañar por su vibrante color rosa neón; esta katana es mucho más que un accesorio de moda de Night City. Perteneciente originalmente a Evelyn Parker, el Bastón de Cóctel es una hoja de precisión quirúrgica diseñada para parecer un juguete hasta que es demasiado tarde. Al entrar en combate, su filo de polímero reforzado ignora gran parte de la armadura enemiga y tiene una facilidad pasmosa para cercenar extremidades. Es el arma perfecta para quienes quieren sembrar el caos en los clubes más exclusivos de Watson con estilo, elegancia y una eficiencia sangrienta.', 'elem_1778150338.png'),
(80, 21, 'Skippy', 'Pistola Inteligente Icónica', 'Daño eléctrico que escala automáticamente con el n', 'Sistema de auto-apuntado inteligente con dos modos', 'Legendario', 'Una pistola experimental de Arasaka que ha desarrollado una conciencia propia y un sentido del humor bastante cuestionable. Skippy no necesita que apuntes; sus balas inteligentes rastrean al objetivo y corrigen su trayectoria en el aire. Sin embargo, el arma tiene voluntad: te obligará a elegir entre disparar solo a la cabeza o solo a las piernas, y puede que cambie de opinión (o se ponga a cantar canciones de Rihanna) en el momento menos oportuno. Es un arma que no solo dispara balas, sino que también ofrece comentarios sarcásticos sobre tu puntería y tus decisiones morales.', 'elem_1778573088.png'),
(81, 22, 'Repartidor (Deliverer)', 'Arma', '55', 'Mejor precisión y 25% menos PA en V.A.T.S.', 'Legendario', 'Pistola única del Ferrocarril, ágil y precisa en combate.', NULL),
(82, 22, 'Justicia (Justice)', 'Arma', '85', 'Probabilidad de tambalear al impactar', 'Legendario', 'Vendida en Covenant. Eficaz para controlar grupos de enemigos.', NULL),
(83, 22, 'Pistola de Kellogg', 'Arma', '48', 'Los golpes críticos rellenan los Puntos de Acción', 'Legendario', 'Recuperada de Kellogg en Fuerte Hagen.', NULL),
(84, 22, 'Cryolator', 'Arma', '50 (Hielo)', 'Congela a los enemigos', 'Legendario', 'Arma criogénica única del Refugio 111.', NULL),
(85, 22, 'Ashmaker', 'Arma', '25', '15 puntos de daño por fuego', 'Legendario', 'Recompensa de Fahrenheit en Goodneighbor. Prende fuego a los objetivos.', NULL),
(86, 22, 'Le Fusil Terribles', 'Arma', '140', '+25% daño y daño a extremidades', 'Legendario', 'Encontrada en Libertalia. Devastadora a corta distancia.', NULL),
(87, 22, 'Big Boy', 'Arma', '468', 'Dispara un proyectil adicional', 'Legendario', 'Vendida por Arturo en Diamond City. Lanza 2 mini-nukes.', NULL),
(88, 22, 'Último Minuto (The Last Minute)', 'Arma', '180', '+50% daño a extremidades', 'Legendario', 'Vendido por Ronnie Shaw en El Castillo.', NULL),
(89, 22, 'Hacha de Grognak', 'Arma', '55', 'Daño cuerpo a cuerpo aumentado', 'Legendario', 'Encontrada en Hubris Comics. Arma del bárbaro de cómic.', NULL),
(90, 22, 'Rifle Ferroviario (Railway Rifle)', 'Arma', '130', 'Alta penetración', 'Legendario', 'Recompensa del Ferrocarril. Dispara púas de ferrocarril.', NULL),
(91, 22, 'Protector del Vigilante', 'Arma', '95', 'Dispara un proyectil adicional', 'Legendario', 'Vendido por Alexis Combes en el Refugio 81. Ideal para largas distancias.', NULL),
(92, 22, 'Amigo del Yermo', 'Arma', '24/24 (Bal./Energ.)', '+50% daño a extremidades', 'Legendario', 'Vendida por Deb en Bunker Hill.', NULL),
(93, 22, 'Arma de Lorenzo', 'Arma', '50 (Bal.)', 'Empuja a los enemigos con telequinesis', 'Legendario', 'Recompensa de \"El Secreto de la Casa Cabot\". Efecto único.', NULL),
(94, 22, 'Salvavidas del Superviviente', 'Arma', '26 (Energía)', '+150% daño con salud baja', 'Legendario', 'Obtenida del Paladín Brandis.', NULL),
(95, 22, 'Aniquiladora de Ghouls', 'Arma', '15 (Radiación)', '+50% daño contra necrófagos', 'Legendario', 'De la misión \"La patrulla perdida\".', NULL),
(96, 22, 'Armadura de Combate Pesada', 'Armadura/Traje', '200+ Defensa', 'Resistencia al daño balístico y de energía', 'Épico', 'De las mejores armaduras no-asistidas. Usada por la Hermandad del Acero.', NULL),
(97, 22, 'Servoarmadura X-01', 'Armadura/Traje', '1390 Defensa', 'Alta resistencia a la energía', 'Legendario', 'La mejor servoarmadura del juego. Se encuentra en la Corte 35.', NULL),
(98, 22, 'Servoarmadura T-60', 'Armadura/Traje', '1220 Defensa', 'Resistencia equilibrada', 'Épico', 'Utilizada por la Hermandad del Acero.', NULL),
(99, 22, 'Marine Armor', 'Armadura/Traje', '250+ Defensa', 'Resistencia al agua y a la radiación', 'Épico', 'Equipo de asalto marino del DLC Far Harbor.', NULL),
(100, 22, 'Silver Shroud Armor', 'Armadura/Traje', '150 Defensa', 'Carisma +1, Percepción +1', 'Raro', 'Traje icónico del superhéroe de la radio. Se obtiene completando sus misiones.', NULL),
(101, 23, 'Espada de Plasma', 'Arma', 'Corte energético', 'Daño por calor', 'Épico', 'Espada de energía roja utilizada por Jordan para combate cuerpo a cuerpo. Capaz de desmembrar robots y criaturas hostiles.', NULL),
(102, 23, 'Pistola de Plasma', 'Arma', 'Daño de energía', 'Munición de plasma', 'Raro', 'Arma de fuego estándar que dispara proyectiles de plasma. Precisa y letal a media distancia.', NULL),
(103, 23, 'Nave Espacial Porsche', 'Objeto', 'Velocidad de salto', 'Escudo de plasma', 'Legendario', 'La nave personal de Jordan, un Porsche modificado para viajes interestelares.', NULL),
(104, 23, 'Traje de Bounty Hunter', 'Armadura/Traje', 'Protección balística', 'Resistencia al vacío', 'Épico', 'Traje especializado para cazarrecompensas con sistemas de soporte vital integrados.', NULL),
(105, 23, 'Botas de Gravedad', 'Objeto', 'Salto aumentado', 'Estabilidad en superficies', 'Raro', 'Permiten a Jordan saltar grandes distancias y adherirse a superficies en gravedad cero.', NULL),
(106, 23, 'Dispositivo de Hackeo', 'Objeto', 'Acceso a sistemas', 'Desactivación de robots', 'Épico', 'Herramienta esencial para infiltrarse en sistemas enemigos y desactivar defensas robóticas.', NULL),
(107, 23, 'Granada de Plasma', 'Arma', 'Daño en área', 'Efecto de calor residual', 'Común', 'Granada que libera una explosión de plasma al detonar, dañando todo a su alrededor.', NULL),
(108, 23, 'Visor de Rastreo', 'Objeto', 'Detección de calor', 'Marcado de objetivos', 'Raro', 'Permite a Jordan rastrear enemigos a través de paredes y en la oscuridad.', NULL),
(109, 23, 'Kit Médico Avanzado', 'Objeto', 'Regeneración de salud', 'Curación de heridas', 'Común', 'Kit de campo para curar heridas y restaurar la salud durante las misiones.', NULL),
(110, 23, 'Propulsores de Muñeca', 'Objeto', 'Dash lateral', 'Esquiva rápida', 'Épico', 'Pequeños propulsores que permiten a Jordan realizar movimientos evasivos rápidos.', NULL),
(111, 24, 'Pistola (Beretta 92FS)', 'Arma', '35', 'Precisión alta', 'Común', 'Pistola semiautomática estándar, fiable y precisa. Arma de mano básica para cualquier situación.', NULL),
(112, 24, 'Mustang .357', 'Arma', '70', 'Alto poder de parada', 'Raro', 'Revólver de gran calibre con un retroceso considerable. Capaz de abatir enemigos con un solo disparo bien colocado.', NULL),
(113, 24, 'Escopeta de Doble Cañón', 'Arma', '85', 'Dispersión amplia', 'Común', 'Escopeta recortada ideal para combates a corta distancia. Su dispersión la hace letal en espacios cerrados.', NULL),
(114, 24, 'SMG (Heckler & Koch MP5)', 'Arma', '30', 'Cadencia de fuego alta', 'Raro', 'Subfusil compacto con alta cadencia de disparo. Perfecto para combates de media distancia y drive-by.', NULL),
(115, 24, 'Fusil de Asalto Duke', 'Arma', '45', 'Precisión en ráfagas', 'Épico', 'Fusil de asalto versátil con selector de disparo. Combina potencia y control en distancias medias y largas.', NULL),
(116, 24, 'Fusil de Francotirador de Cerrojo', 'Arma', '120', 'Mira telescópica', 'Épico', 'Fusil de precisión con acción de cerrojo. Ideal para eliminaciones silenciosas a larga distancia.', NULL),
(117, 24, 'Bate de Béisbol', 'Arma', '25', 'Aturdimiento', 'Común', 'Arma cuerpo a cuerpo contundente que puede dejar fuera de combate a un oponente de un solo golpe.', NULL),
(118, 24, 'Martillo', 'Arma', '30', 'Daño estructural', 'Común', 'Herramienta pesada que sirve como arma improvisada. Eficaz para romper cerraduras y defensas.', NULL),
(119, 24, 'Lanzagranadas', 'Arma', '150', 'Daño en área', 'Épico', 'Dispara granadas explosivas que detonan al impactar. Capaz de destruir vehículos y eliminar grupos enteros.', NULL),
(120, 24, 'Cóctel Molotov', 'Arma', '60', 'Incendia área', 'Común', 'Bomba incendiaria casera. Al impactar, crea un charco de fuego que causa daño continuo en una zona.', NULL),
(121, 12, 'Canio', 'Comodín (Joker)', 'Multiplicador x1 inicial (Creciente)', 'Aumenta +x1 al Multiplicador X por cada carta de F', 'Legendario', 'Un bufón envuelto en sombras y ropajes reales, cuya fuerza emana del sacrificio de la nobleza. Canio no se conforma con sumar puntos; él multiplica tu puntuación total de forma exponencial a medida que eliminas cartas de figuras (Jota, Reina o Rey) de tu mazo. Es una carta de destrucción y purificación: cuanto más pequeño y refinado sea tu mazo tras deshacerte de la corte, más masivo será el multiplicador que Canio otorgará a tus manos. Es la personificación de la caída de los reyes en favor del caos absoluto del jugador.', 'elem_1778487286.png'),
(122, 12, 'Ectoplasma', 'Carta Espectral', 'Otorga el estado Negativo a un Comodín aleatorio.', 'Reduce el tamaño de la mano en -1 permanentemente.', 'Raro', 'Una sustancia viscosa y traslúcida que emana un frío de ultratumba, capaz de alterar la materia misma de tu mazo. Al ser utilizada, imbuye a uno de tus Comodines actuales con energía espectral, volviéndolo \"Negativo\": esto permite que la carta no ocupe espacio en tu límite de Comodines, dándote un hueco extra para añadir más poder a tu arsenal. Sin embargo, este pacto con el más allá tiene un coste físico severo: la fatiga espiritual reduce tu capacidad de sostener cartas, restando una unidad al tamaño de tu mano de forma permanente durante toda la partida.Tip estratégico: Úsalo solo cuando tengas un Comodín realmente poderoso que quieras conservar sin que te estorbe, o si tienes formas de compensar la pérdida de mano (como con el cupón Paintbrush). ¡Tener un Comodín extra es genial, pero tener pocas cartas para jugar es peligroso!¿Quieres que preparemos la ficha de la carta Inmolación o prefieres el Grimorio para invocar cartas de Tarot?Las respuestas de la IA pueden contener errores. Más información', 'elem_1778487565.png'),
(123, 12, 'El Emperador', 'Carta de Tarot', 'Genera 2 cartas de Tarot al azar', 'Requiere un espacio libre en la zona de consumible', 'Raro', 'Una figura de autoridad absoluta que se sienta sobre su trono de piedra, dictando el orden de las fuerzas místicas en tu mano. Al invocar el poder del Emperador, este no altera tus cartas de juego directamente, sino que manifiesta dos nuevos Arcanos seleccionados al azar para tu arsenal. Es la carta de la planificación y el control; capaz de convertir una situación desesperada en una oportunidad estratégica al proporcionarte herramientas para transformar palos, mejorar cartas o aumentar tu economía. Bajo su mandato, el azar se convierte en una extensión de tu voluntad.', 'elem_1778487785.png'),
(124, 14, 'Fresa Dorada', 'Reliquia de Maestría / Objeto de Desafío Extremo', '+5000 Puntos de puntuación', 'Teletransporta al portador al inicio del nivel si ', 'Legendario', 'Una fruta que emite un resplandor dorado cegador, manifestándose solo ante aquellos que ya han conquistado la cima y buscan el desafío final. A diferencia de otras fresas, esta se vincula al alma del escalador desde el primer momento en que es tocada: si el portador comete un solo error o tropieza en su ascenso, la fresa estalla en luz y lo devuelve instantáneamente al punto de partida. Es el símbolo máximo de la perfección; obtenerla significa haber recorrido todo el camino en un estado de gracia total, sin un solo paso en falso.', 'elem_1778511194.png'),
(125, 9, 'Espada y Escudo de Nergigante', 'Arma', '180', 'Daño Dragón', 'Legendario', 'El filo regenerativo de Nergigante otorga salud al cazador con cada golpe consecutivo. Ideal para un estilo de juego agresivo y de alto riesgo.', NULL),
(126, 9, 'Gran Espada de Rathalos', 'Arma', '350', 'Daño Fuego', 'Legendario', 'Una espada colosal imbuida con la furia del Rey de los Cielos. Cargarla al máximo libera una explosión de fuego que calcina a las bestias.', NULL),
(127, 9, 'Martillo de Teostra', 'Arma', '280', 'Daño Explosivo', 'Legendario', 'Este martillo contiene el polvo ígneo del Emperador de las Llamas. Cada golpe acumula polvo explosivo que detona al impactar.', NULL),
(128, 9, 'Cornamusa de Lunastra', 'Arma', '250', 'Melodías de Recuperación', 'Legendario', 'Una cornamusa que entona la canción de la Emperatriz Azul. Sus melodías curan y otorgan resistencia al fuego a todo el grupo de caza.', NULL),
(129, 9, 'Lanza de Vaal Hazak', 'Arma', '220', 'Daño Dracónico', 'Legendario', 'Una lanza impregnada del efluvio del Viejo Dragón. Cada estocada drena la vida del enemigo y la transfiere al portador, maldiciendo lentamente a la bestia.', NULL),
(130, 9, 'Lanza Pistola de Zorah Magdaros', 'Arma', '300', 'Daño Explosivo (Pirocañón)', 'Legendario', 'Forjada con la corteza volcánica del Coloso Anciano. Su pirocañón descarga una perforación explosiva que parte la coraza de cualquier monstruo.', NULL),
(131, 9, 'Hacha Espada de Deviljho', 'Arma', '270', 'Daño Dragón', 'Legendario', 'Un arma que canaliza el hambre insaciable del Wyvern Voraz. En modo espada, absorbe energía del monstruo para aumentar su poder bruto.', NULL),
(132, 9, 'Espada Cargada de Kushala Daora', 'Arma', '260', 'Daño Hielo', 'Legendario', 'Un escudo y espada imbuidos con la tormenta del Dragón de Acero. Al liberar la energía, desata un torbellino helado que desgarra la armadura enemiga.', NULL),
(133, 9, 'Glaive Insecto de Xeno\'jiiva', 'Arma', '240', 'Daño Dragón', 'Legendario', 'Una glaive nacida del Emperador Dragón de la Creación. Su insecto absorbe la esencia vital del monstruo para potenciar al cazador durante el combate.', NULL),
(134, 9, 'Ballesta Pesada de Kulve Taroth', 'Arma', '330', 'Munición de Asedio', 'Legendario', 'Una ballesta dorada que brilla con el tesoro de la Diosa de la Fortuna. Dispara una ráfaga de munición de asedio que derriba monstruos con facilidad.', NULL),
(135, 10, 'Lanza de Varatha', 'Arma Infernal', '150', 'Golpe crítico aumentado', 'Legendaria', 'La lanza sagrada de Zagreo, capaz de atravesar las sombras del inframundo con una furia imparable. Su aspecto oculto invoca el poder de los dioses olvidados.', NULL),
(136, 10, 'Escudo de Caos', 'Arma Infernal', '120', 'Bloqueo perfecto', 'Legendaria', 'El escudo de Zagreo, forjado en el mismo Caos primordial. Puede ser lanzado como un proyectil que rebota entre los enemigos, sembrando el desconcierto en las tropas de Hades.', NULL),
(137, 10, 'Guantes de Malphon', 'Arma Infernal', '200', 'Combo de ataques', 'Legendaria', 'Los guantes de combate de Zagreo, que canalizan la furia de los titanes. Permiten realizar combos devastadores a corta distancia y drenar la energía de los enemigos.', NULL),
(138, 10, 'Rail de Adamant', 'Arma Infernal', '250', 'Daño de energía concentrado', 'Legendaria', 'El raíl de Zagreo, un artefacto de los dioses del Olimpo. Dispara un rayo de energía que puede ser potenciado con las bendiciones de Zeus para causar un daño masivo a distancia.', NULL),
(139, 10, 'Bendición de Zeus', 'Bendición', '110', 'Cadena de rayos', 'Divina', 'La bendición del dios del trueno, que imbuye los ataques de Zagreo con la furia del rayo. Los enemigos alcanzados sufren descargas eléctricas que saltan a otros objetivos.', NULL),
(140, 10, 'Bendición de Poseidón', 'Bendición', '90', 'Empuje y daño de agua', 'Divina', 'La bendición del dios de los mares, que transforma los ataques en olas imparables. Los enemigos son arrastrados y golpeados contra las paredes del inframundo.', NULL),
(141, 11, 'Piedra de la Sombra', 'Hechizo', '30', 'Almas', 'Rara', 'Un amuleto que concentra la energía de las sombras, permitiendo al portador lanzar un poderoso hechizo de alma que atraviesa las defensas enemigas.', NULL),
(142, 11, 'Caparazón de Baldur', 'Objeto', '0', 'Bloqueo pasivo', 'Épica', 'Un caparazón endurecido que se adhiere al cuerpo del Caballero. Mientras se concentra, genera un escudo protector que absorbe el daño entrante.', NULL),
(143, 11, 'Sangre de Colmena', 'Habilidad de Movimiento', '0', 'Recuperación de almas', 'Rara', 'Un antiguo amuleto de la tribu Colmena que otorga una pequeña cantidad de almas al recibir daño, alimentando la sed de venganza del portador.', NULL),
(144, 11, 'Alma del Rey', 'Habilidad de Hechizo', '45', 'Almas', 'Legendaria', 'Un fragmento del alma del Rey Pálido, que imbuye los hechizos con un poder real. Los hechizos lanzados generan una explosión de energía blanca que daña a los enemigos cercanos.', NULL),
(145, 11, 'Capullo de la Vida', 'Objeto', '0', 'Regeneración pasiva', 'Épica', 'Un capullo azul que palpita con vida. Al concentrarse, el portador consume almas para regenerar lentamente sus heridas, pero no puede moverse durante el proceso.', NULL),
(146, 11, 'Garra de la Bestia', 'Objeto', '0', 'Transformación', 'Legendaria', 'Una garra afilada que canaliza la furia primigenia. El portador puede arañar las paredes y enemigos con una fuerza devastadora, abriendo nuevas rutas en el mundo.', NULL),
(147, 12, 'Plano', 'Carta Joker', 'Copia la habilidad del Comodín a su derecha', 'N/A (Versatilidad pura).', 'Raro', 'Una carta que muestra un esquema técnico detallado, capaz de replicar la esencia de cualquier otro componente del mazo. Blueprint no tiene un poder propio, sino que actúa como un espejo funcional: copia exactamente el efecto del Comodín situado inmediatamente a su derecha. Su valor es incalculable, ya que permite duplicar multiplicadores masivos, generar el doble de dinero o activar dos veces efectos de retribución. Es la pieza maestra para cualquier \"build\" avanzada, adaptándose a la necesidad del jugador en cada mano con solo cambiar su posición en la fila.', 'elem_1778513532.png'),
(148, 12, 'Lluvia de ideas', 'Comodín (Joker)', 'Copia la habilidad del Comodín situado en el extre', 'N/A (Versatilidad pura)', 'Raro', 'Una bombilla que estalla en un resplandor de ingenio, capturando la esencia de la estrategia principal de tu mazo. Esta carta no posee un efecto propio, sino que replica fielmente la habilidad del Comodín que ocupa la primera posición a la izquierda de la fila. Al igual que el Plano, su poder reside en su flexibilidad: puedes mover tus otros Comodines a la posición de \"foco\" para duplicar multiplicadores, generación de dinero o efectos de re-activación. Es la pieza final para cualquier combinación de alto nivel, permitiendo que una sola idea brillante se ejecute dos veces con una fuerza devastadora.', 'elem_1778514358.png'),
(149, 12, 'ADN', 'Comodín (Joker)', 'Crea una copia permanente de la primera carta juga', 'La copia se añade directamente a la mano del jugad', 'Raro', 'Una cadena de código genético que brilla con una luz de neón, capaz de reescribir la estructura misma de tu baraja. Si la primera jugada de una ronda consiste en una sola carta, el ADN la analiza y genera un duplicado exacto de forma instantánea. No importa si la carta original tiene sellos, ediciones especiales o encantamientos; la nueva copia conservará todas sus propiedades y se sumará a tu mazo permanentemente. Es la herramienta de ingeniería definitiva, permitiendo que una sola carta legendaria se multiplique hasta dominar todo el mazo.', 'elem_1778514488.png');
INSERT INTO `elementos` (`id`, `id_juego`, `nombre`, `tipo`, `valor1`, `valor2`, `rareza`, `descripcion`, `imagen`) VALUES
(150, 12, 'Perkeo', 'Comodín (Joker)', 'Crea una copia Negativa de 1 carta consumible al a', 'El efecto se activa al salir de la Tienda', 'Legendario', 'Un bufón de aspecto noble y enigmático que sostiene una copa de vino infinita, capaz de embriagar la realidad misma. Perkeo no lucha en la mesa, sino que trabaja en los pasillos de la tienda: cada vez que terminas de comprar y te diriges a la siguiente ronda, selecciona uno de tus consumibles (Tarot, Planeta o Espectral) y crea una copia exacta con el modificador \"Negativo\". Esto significa que puedes acumular una cantidad ilimitada de cartas de poder sin ocupar espacio, permitiéndote alcanzar niveles de fuerza divinos al duplicar una y otra vez tus mejores recursos.', 'elem_1778514661.png'),
(151, 12, 'Comodín Loco', 'Carta Joker', '+12 de Multiplicador', 'Solo se activa si la mano jugada contiene una Esca', 'Común', 'Con una mirada errática y una sonrisa desencajada, este comodín solo encuentra sentido en el orden perfecto del caos. No se conforma con simples parejas o tríos; su poder solo se desata cuando las cartas se alinean en una sucesión numérica impecable. Al completar una Escalera, el Comodín Loco inyecta un impulso de adrenalina al multiplicador, permitiendo que una de las manos más difíciles de formar se convierta también en una de las más letales. Es el aliado ideal para quienes disfrutan arriesgándose a descartar cartas en busca de esa pieza intermedia que falta para completar la serie.', 'elem_1778513828.png'),
(152, 12, 'Constelación', 'Carta Joker', 'Multiplicador x1.1 actual (Creciente).', '+0.1 de Multiplicador X por cada carta de Planeta ', 'Raro', 'Un mapa estelar que brilla con una luz cósmica, cuya potencia aumenta a medida que el jugador descubre los secretos del sistema solar. Este Comodín no otorga un bono plano, sino que multiplica el puntaje total de forma exponencial. Cada vez que utilizas una carta de Planeta para subir el nivel de tus manos de póquer, la constelación se expande, añadiendo permanentemente un +0.1 a su multiplicador de \"X\". Es una de las mejores inversiones del juego; lo que comienza como un pequeño destello puede convertirse en una supernova de puntos si logras comprar suficientes sobres celestiales en la tienda.', 'elem_1778513700.png'),
(154, 14, 'Cinta de Casete', 'Artefacto de Desbloqueo / Objeto Musical', 'Desbloquea la versión \"Lado B\" (B-Side) del capítu', 'Modifica la banda sonora del nivel al ser recolect', 'Épico', 'Una cinta magnética envuelta en una energía rítmica y distorsionada que flota en lugares recónditos de la montaña. Al tocarla, la realidad parece vibrar y transformarse, revelando una versión mucho más compleja, técnica y peligrosa del camino ya recorrido. Estas cintas contienen las remezclas más intensas de los temas de la montaña, sirviendo como una invitación para aquellos escaladores que no se conforman con llegar a la cima, sino que desean dominar cada salto y cada impulso en un entorno de máxima exigencia. Escuchar su estática es aceptar que el verdadero viaje acaba de empezar.', 'elem_1778515285.png'),
(155, 14, 'Bandera de Cumbre', 'Monumento / Punto de Control', 'Marca la culminación del ascenso (3000 metros)', 'Desbloquea el epílogo y los \"Lados B\" del nivel', 'Épico', 'Una bandera roja y desgastada que ondea con furia contra los vientos gélidos de la cima más alta. Representa mucho más que el final geográfico de la montaña; es el testamento físico de la perseverancia de Madeline. Al llegar a ella, el caos de la tormenta se disipa para revelar un cielo estrellado y eterno, simbolizando la paz interior alcanzada tras la reconciliación con Badeline. Es el lugar donde el esfuerzo se transforma en asombro, y donde el escalador finalmente puede sentarse, respirar y contemplar lo lejos que ha llegado desde la base de la montaña.', 'elem_1778515211.png'),
(157, 13, 'Aguja Afilada', 'Arma', 'Cuerpo a cuerpo rápido', 'Puede lanzarse y recuperarse', 'Común', 'El arma principal de Hornet, un estoque largo y afilado heredado de su tribu natal, el Nido Profundo. A diferencia del Aguijón del Caballero, la Aguja permite ataques más rápidos y precisos, y puede ser lanzada a distancia para golpear enemigos o activar mecanismos.', NULL),
(158, 13, 'Lanza de Seda', 'Habilidad de Seda', 'Proyectil lineal', 'Atraviesa múltiples enemigos', 'Raro', 'Hornet concentra seda en la punta de su aguja y la dispara como un proyectil perforante que atraviesa a todos los enemigos en línea recta. Consume un carrete de seda por uso. Ideal para salas con formaciones enemigas alineadas.', NULL),
(159, 13, 'Tormenta de Hilos', 'Habilidad de Seda', 'Daño en área', 'Golpea a todos los enemigos cercanos', 'Épico', 'Hornet gira sobre sí misma desplegando hilos de seda en todas direcciones, dañando a cualquier enemigo en un radio considerable. La tormenta también destruye proyectiles enemigos. Consume dos carretes de seda.', NULL),
(160, 13, 'Capa de Flotador', 'Objeto', 'Planeo horizontal', 'Recuperación de seda en el aire', 'Raro', 'Un manto ligero tejido con seda de tejedor que permite a Hornet planear distancias cortas. Al utilizarlo, Hornet también recupera lentamente sus carretes de seda mientras está en el aire.', NULL),
(161, 13, 'Agarre de Pinza', 'Habilidad de Movimiento', 'Agarrar salientes', 'Impulso vertical', 'Raro', 'Una técnica ancestral que permite a Hornet agarrarse a salientes y cornisas con su aguja. Tras engancharse, puede impulsarse hacia arriba para alcanzar plataformas elevadas o esquivar ataques bajos.', NULL),
(162, 13, 'Fragmento de Caparazón', 'Consumible', 'Repara herramientas', 'Se obtiene de enemigos derrotados', 'Común', 'Pequeños trozos de exoesqueleto que sueltan los enemigos al ser derrotados. Se utilizan para reparar las Herramientas Rojas (dispositivos ofensivos como bombas, proyectiles y trampas) en los bancos de Pharloom.', NULL),
(163, 13, 'Cresta del Cazador', 'Amuleto', 'Aumenta daño con golpes sucesivos', 'Ranuras: 2 Herramienta, 1 Seda', 'Épico', 'Una cresta otorgada por Eva, la primera aliada de Hornet en Pharloom. Potencia los ataques consecutivos: cada golpe exitoso aumenta ligeramente el daño del siguiente, recompensando un estilo de combate agresivo.', NULL),
(164, 13, 'Bomba de Seda', 'Herramienta Roja', 'Explosión en área', 'Se repone con Fragmentos de Caparazón', 'Raro', 'Un dispositivo creado por los artesanos de Pharloom. Al lanzarse, explota en una nube de seda que daña y ralentiza a los enemigos en un área pequeña. Eficaz para controlar grupos.', NULL),
(165, 13, 'Frasco de Plásmio', 'Herramienta Roja', 'Niebla corrosiva', 'Daño continuo en área', 'Épico', 'Un frasco que contiene una sustancia viscosa y brillante extraída de las profundidades de Pharloom. Al romperse, libera una nube tóxica que daña continuamente a los enemigos que permanecen en su interior.', NULL),
(166, 13, 'Emblema de Pino', 'Amuleto', 'Genera seda al recibir daño', 'Pasiva', 'Raro', 'Un emblema antiguo con la forma de un pino. Cuando Hornet recibe daño, el emblema convierte parte del impacto en seda adicional, permitiéndole usar sus habilidades especiales con más frecuencia en combates intensos.', NULL);

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
(9, 'Monster Hunter World', 'Capcom', 'Capcom', '2018-01-26', 'RPG de Acción', '¡Conviértete en el cazador definitivo! Embárcate en una épica aventura por el Nuevo Mundo, un continente salvaje repleto de monstruos colosales y ecosistemas vivos. Forja armas y armaduras legendarias con los restos de tus presas, domina 14 tipos de armas diferentes y colabora con otros cazadores en intensas batallas cooperativas. La naturaleza es tu enemiga y tu aliada: usa el entorno para tender emboscadas, atraer bestias a trampas y sobrevivir a los embates de dragones ancianos. La caza te espera.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/582010/MONSTER_HUNTER_WORLD/', 1, '2026-05-05 17:50:24', 1, 'Armas', 1, 0, 0, NULL),
(10, 'Hades', 'Supergiant Games', 'Supergiant Games', '2020-09-17', 'Roguelike/Roguelite', 'Escapa del inframundo en este aclamado roguelike de acción del estudio creador de Bastion y Transistor. Como Zagreo, el inmortal príncipe del Inframundo, desafía a tu padre Hades y ábrete paso a través de mazmorras generadas aleatoriamente. Recibe bendiciones y poderes de los dioses del Olimpo —Zeus, Poseidón, Afrodita y muchos más— para crear combinaciones devastadoras. Cada muerte es una oportunidad para volver más fuerte, descubrir secretos de la mitología griega y desentrañar una historia fascinante contada con un estilo artístico único.', 'game_1778072432.png', 'map_1777997211.jpg', '', 1, '2026-05-05 17:50:24', 1, 'Armas', 1, 1, 0, ''),
(11, 'Hollow Knight', 'Team Cherry', 'Team Cherry', '2017-02-24', 'Metroidvania', 'Desciende a las profundidades de Hallownest, un reino antiguo en ruinas habitado por insectos extraños y secretos olvidados. Este aclamado metroidvania dibujado a mano te pone en la piel del Caballero, un guerrero silencioso armado con un aguijón afilado. Explora un vasto mundo interconectado lleno de criaturas retorcidas, jefes desafiantes y habilidades ocultas. Cada rincón esconde un nuevo poder, un aliado inesperado o un fragmento de la trágica historia de este reino caído. La atmósfera, la banda sonora y la precisión de su combate convierten cada partida en una experiencia inolvidable.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/367520/Hollow_Knight/', 2, '2026-05-05 17:50:24', 1, 'Habilidad', 1, 0, 0, NULL),
(12, 'Balatro', 'LocalThunk', 'Playstack', '2024-02-20', 'Roguelike/Roguelite', 'El póker nunca fue tan adictivo. Balatro reinventa el clásico juego de cartas como un roguelike de construcción de mazos donde las reglas están para romperse. Combina manos de póker tradicionales con más de 150 comodines (Jokers) que alteran las reglas, multiplican tus ganancias y desafían la lógica. Supera ciegas cada vez más difíciles, descubre sinergias imposibles y desbloquea cartas secretas mientras intentas alcanzar puntuaciones astronómicas. Fácil de aprender, imposible de dejar.', 'game_1778078491.jpg', NULL, 'https://store.steampowered.com/app/2379780/Balatro/', 2, '2026-05-05 17:50:24', 1, 'Carta', 0, 0, 0, 'https://youtu.be/VUyP21iQ_-g?si=IW3SrkMv8NaMHeQ9'),
(13, 'Hollow Knight: Silksong', 'Team Cherry', 'Team Cherry', '2026-12-31', 'Metroidvania', 'La esperada secuela de Hollow Knight. Juega como Hornet, la princesa protectora de Hallownest, en un nuevo reino llamado Pharloom. Domina un sistema de combate completamente renovado con nuevas armas, herramientas y habilidades acrobáticas. Escala paredes, esquiva trampas mortales y enfréntate a una legión de nuevos enemigos en esta aventura independiente que expande el universo de Team Cherry. Un viaje de descubrimiento, peligro y belleza dibujado a mano que promete superar a su predecesor.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/1030300/Hollow_Knight_Silksong/', 2, '2026-05-05 17:50:24', 1, 'Armas', 1, 0, 1, NULL),
(14, 'Celeste', 'Maddy Makes Games', 'Maddy Makes Games', '2018-01-25', 'Plataformas', 'Ayuda a Madeline a superar sus demonios internos mientras escala la implacable Montaña Celeste. Este desafiante juego de plataformas pixel-art combina controles precisos y ajustables con una historia profundamente emotiva sobre la ansiedad, la determinación y el autodescubrimiento. Con más de 700 pantallas de plataformas, secretos ocultos y una banda sonora galardonada, Celeste es una experiencia que pondrá a prueba tus reflejos y tocará tu corazón. ¿Estás listo para alcanzar la cima?', 'game_1778510374.png', NULL, 'https://store.steampowered.com/app/504230/Celeste/', 3, '2026-05-05 17:50:24', 1, 'Armas', 1, 0, 0, 'https://youtu.be/70d9irlxiB4?si=S4V_8ph-ww-YrThA'),
(15, 'Elden Ring', 'FromSoftware', 'Bandai Namco Entertainment', '2022-02-25', 'RPG de Acción', 'Levántate, Sinluz, y reclama tu destino en las Tierras Intermedias. FromSoftware y George R.R. Martin unen fuerzas para crear el RPG de acción más ambicioso de la historia. Cabalga sobre Torrente, tu fiel corcel, a través de un inmenso mundo abierto repleto de mazmorras ocultas, jefes legendarios y secretos olvidados. Forja tu propio camino entre la luz y la oscuridad, domina cientos de armas y hechizos, y descubre por qué el Círculo de Elden fue destruido. La muerte es solo el principio.', 'game_1778144555.png', 'map_1778577609.png', 'https://store.steampowered.com/app/1245620/ELDEN_RING/', 5, '2026-05-07 10:57:02', 1, 'Armas', 1, 1, 0, 'https://youtu.be/CptaXqVY6-E?si=-oKFKYwWprTgTgTj'),
(17, 'The Witcher 3: Wild Hunt', 'CD Projekt Red', 'CD Projekt', '2015-05-19', 'RPG', 'Encarena a Geralt de Rivia, el cazador de monstruos más famoso del Continente, en la aventura definitiva de la saga aclamada por la crítica. Recorre un mundo de fantasía oscura devastado por la guerra, donde cada decisión tiene consecuencias imprevisibles. Persigue a la Niña de la Profecía, Ciri, mientras te enfrentas a la Cacería Salvaje, criaturas míticas y la crueldad humana. Con una narrativa profunda, combates dinámicos y dos expansiones masivas —Hearts of Stone y Blood and Wine—, The Witcher 3 estableció un nuevo estándar para los RPG de mundo abierto.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/292030/The_Witcher_3_Wild_Hunt/', 5, '2026-05-07 12:00:11', 1, 'Armas', 1, 0, 0, NULL),
(19, 'Baldur\'s Gate 3', 'Larian Studios', 'Larian Studios', '2023-08-03', 'RPG', 'Reúne a tu grupo y regresa a los Reinos Olvidados en la obra maestra de Larian Studios que ha redefinido el género RPG. Basado en las reglas de Dungeons & Dragons 5ª edición, Baldur\'s Gate 3 te ofrece una libertad sin precedentes: explora un mundo reactivo donde cada elección moldea tu historia, recluta compañeros con personalidades profundas, participa en combates tácticos por turnos y descubre una trama de conspiraciones, parásitos mentales y dioses olvidados. Romance, traición, amistad y sacrificio te esperan en esta aventura épica.', 'game_1778513205.png', 'map_1778496351.png', 'https://store.steampowered.com/app/1086940/Baldurs_Gate_3/', 7, '2026-05-07 12:12:03', 1, 'Armas', 1, 1, 0, 'https://youtu.be/1T22wNvoNiU?si=EIoJT9Bdl8jVBY9b'),
(20, 'God of War: Ragnarök', 'Santa Monica Studio', 'Sony Interactive Entertainment', '2022-11-09', 'Acción/Aventura', 'Kratos y Atreus regresan en la épica conclusión de la saga nórdica. El Fimbulvetr, el invierno que precede al fin del mundo, ha llegado a los Nueve Reinos. Padre e hijo deberán recorrer los reinos más peligrosos del cosmos nórdico mientras se preparan para el Ragnarök, la batalla que acabará con todo. Enfréntate a dioses y monstruos de la mitología nórdica como Thor y Odín, domina el hacha Leviatán, las Espadas del Caos y la nueva Lanza Draupnir en combates más brutales y tácticos que nunca.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/2000950/God_of_War_Ragnarok/', 3, '2026-05-07 12:18:14', 1, 'Armas', 1, 0, 0, NULL),
(21, 'Cyberpunk 2077', 'CD Projekt Red', 'Bandai Namco Entertainment', '2020-12-10', 'RPG', 'Night City, 2077. El sueño del futuro se ha convertido en una distopía obsesionada con el poder, el glamour y la modificación corporal. Juega como V, un mercenario en busca de un implante único que ofrece la llave de la inmortalidad. Personaliza tu estilo de juego con implantes cibernéticos, hackea sistemas, conduce por las calles iluminadas de neón y forja alianzas con personajes inolvidables como Johnny Silverhand (interpretado por Keanu Reeves). Cada decisión tiene consecuencias en este RPG de mundo abierto donde la línea entre humanidad y máquina se desvanece.', 'game_1778574696.png', NULL, 'https://store.steampowered.com/app/1091500/Cyberpunk_2077/?l=spanish', 6, '2026-05-07 12:26:33', 1, 'Armas', 1, 0, 0, 'https://youtu.be/8X2kIfS6fb8?si=8TWhEkf81V1gcrlT'),
(22, 'Fallout 4', 'Bethesda Game Studios', 'Bethesda Softworks', '2015-11-10', 'RPG de Acción', 'Boston, 2287. Dos siglos después de la Gran Guerra nuclear, emerge del Refugio 111 como el único superviviente de tu familia. Explora la Commonwealth, un páramo radiactivo lleno de asentamientos en peligro, facciones enfrentadas —los Minutemen, la Hermandad del Acero, el Ferrocarril y el misterioso Instituto— y criaturas mutantes. Construye y defiende tus propios asentamientos, modifica armas y servoarmaduras, y busca a tu hijo secuestrado en un mundo donde la libertad es tu mayor recurso y cada elección define tu destino.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/377160/Fallout_4/', 1, '2026-05-07 13:04:46', 1, 'Armas', 1, 0, 0, NULL),
(23, 'Intergalactic: The Heretic Prophet', 'Naughty Dog', 'PlayStation Studios', '2027-06-15', 'Acción/Aventura', 'El estudio creador de The Last of Us y Uncharted te lleva a las estrellas. Encarna a Jordan A. Mun, una peligrosa cazarrecompensas que queda varada en el remoto planeta Sempiria mientras persigue al sindicato criminal de los Cinco Ases. Aislado durante más de 600 años, este mundo está repleto de robots hostiles, secretos ancestrales y una secta fanática que adora a un antiguo profeta. Explora un planeta salvaje, domina armas de plasma y descubre la verdad oculta tras la leyenda del Profeta Hereje en la aventura espacial más ambiciosa de Naughty Dog.', 'default_game.jpg', NULL, '', 1, '2026-05-07 14:05:56', 1, 'Armas', 1, 0, 1, 'https://www.youtube.com/watch?v=Yr0J8r3x8zQ'),
(24, 'Grand Theft Auto VI', 'Rockstar Games', 'Rockstar Games', '2026-11-19', 'Acción/Aventura', 'Vuelve a Vice City y al estado de Leonida en la entrega más esperada de la saga más vendida de todos los tiempos. Sigue la historia de Lucía Caminos y Jason Duval, dos criminales atrapados en un torbellino de drogas, poder y traiciones bajo el ardiente sol de Florida. Explora un mapa masivo que incluye playas paradisíacas, pantanos infestados de caimanes y la vibrante vida nocturna de Vice City. Conoce a personajes excéntricos, planea golpes imposibles y sobrevive en un mundo donde el sueño americano tiene un precio muy alto.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/271590/Grand_Theft_Auto_VI/', 5, '2026-05-07 14:11:34', 1, 'Armas', 1, 0, 1, 'https://youtu.be/QdBZY2fk6bU');

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
(3, 4, '2026-05-06 16:53:22'),
(5, 1, '2026-05-07 18:07:37');

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
(24, 10, 'Superficie', NULL, NULL, 'Fin de Juego', 'Por fin consigues salir del Tartataro, la pesadilla acabo.', 48.83, 95.77, '⭐'),
(26, 19, 'Nufragio del Nautiliode', NULL, NULL, 'Zona de Inicio', 'Punto inicial tras el prólogo. Primeras interacciones y reclutamiento temprano.', 7.65, 25.78, '⭐'),
(27, 19, 'Tumba Susurrante', NULL, NULL, 'Mazmorra', 'Ruinas con secretos, trampas, y encuentros clave', 18.18, 8.81, '🏠'),
(28, 19, 'Arbo Esmeralda', NULL, NULL, 'Ciudad', 'Centro diplomático del Acto . Decisiones entre druidas y refugiados.', 28.72, 18.67, '🏰'),
(29, 19, 'Piscina Sagrada', NULL, NULL, 'Zona Especial', 'Núcleo interno del bosque druídico.', 36.47, 28.77, '💎'),
(30, 19, 'Cueva del Oso Búho', NULL, NULL, 'Mazmorra', 'Encuentro opcional con botín y eventos especiales.', 11.64, 30.43, '💀'),
(31, 19, 'Aldea Arrasada', NULL, NULL, 'Pueblo', 'Aldea abandonada con múltiples rutas narrativas.', 19.29, 25.78, '🏚️'),
(32, 19, 'Campamento Goblin', NULL, NULL, 'Encuentro con Enemigos', 'Fortaleza hostil con múltiples rutas.', 18.40, 36.09, '⚔️'),
(33, 19, 'Sagrario Destrozado', NULL, NULL, 'Jefe', 'Núcleo interno del campamento goblin.', 19.62, 41.08, '🔥'),
(34, 19, 'Perreras de los Huargos', NULL, NULL, 'Mazmorra', 'Zona subterránea infestada.', 13.41, 43.40, '💀'),
(35, 19, 'Entrañas Putrefactas', NULL, NULL, 'Acceso', 'Entrada principal al subsuelo.', 14.86, 54.21, '🗝️'),
(36, 19, 'Entras a Underdark', NULL, NULL, 'Ciudad', 'Centro neutral del Underdark.', 24.61, 73.84, '🏰'),
(40, 19, 'Colonia Miconida', NULL, NULL, 'Ciudad', 'Centro neutral del Underdark.', 28.60, 56.21, '🏰'),
(41, 19, 'Torre Arcana', NULL, NULL, 'Torre', 'Exploración, acertijos y loot mágico.', 33.37, 59.37, '🎯'),
(42, 19, 'Forja de Grym', NULL, NULL, 'Fortaleza', 'Zona industrial antigua.', 42.79, 50.22, '🔥'),
(43, 19, 'Forja Adamantina', NULL, NULL, 'Crafting', 'Forja legendaria para equipo único.', 48.12, 49.39, '💎'),
(44, 19, 'Monasterio de Rosymorn', NULL, NULL, 'Ruinas', 'Entrada hacia la ruta githyanki.', 33.15, 5.82, '📜'),
(45, 19, 'Guarida de Créche Githyanki', NULL, NULL, 'Facción', 'Base githyanki crítica para companion quests.', 51.00, 9.48, '🛡️'),
(47, 19, 'Posada de la Última Luz', NULL, NULL, 'Refugio', 'Principal zona segura del Acto 2.', 50.89, 33.59, '🏰'),
(48, 19, 'Pueblo de Reithwin', NULL, NULL, 'Ciudad maldita', 'Exploración narrativa y eventos oscuros.', 57.54, 33.59, '💀'),
(49, 19, 'Casa de la Curación', NULL, NULL, 'Mazmorra', 'Hospital abandonado con encuentros perturbadores.', 68.85, 34.59, '❤️'),
(50, 19, 'Casa del Pelaje', NULL, NULL, 'Instalación', 'Antigua estación fiscal infestada por fuerzas corruptas y guardianes hostiles.', 61.97, 50.89, '🗝️'),
(51, 19, 'Luna Menguante', NULL, NULL, 'Evento', 'Localización narrativa cargada de tensión, exploración y encuentros decisivos.', 80.04, 37.58, '⭐'),
(52, 19, 'Torres del Alzamiento Lunar', NULL, NULL, 'Fortaleza', 'Centro neurálgico del poder enemigo durante el acto.', 68.18, 46.23, '⚔️'),
(53, 19, 'Prisión de las Torres', NULL, NULL, 'Rescate', 'Cárceles fuertemente custodiadas donde se desarrollan infiltraciones críticas.', 69.18, 56.21, '📜'),
(54, 19, 'Colonia Ilítida', NULL, NULL, 'Mazmorra', 'Complejo subterráneo biológico conectado directamente con la amenaza principal.', 74.50, 29.43, '💀'),
(55, 19, 'Guantelete de Shar', NULL, NULL, 'Trial', 'Santuario de pruebas, sacrificios y decisiones fundamentales para la narrativa.', 67.18, 69.85, '🎯'),
(56, 19, 'Biblioteca Silenciosa', NULL, NULL, 'Puzzle', 'Archivo arcano protegido por magia restrictiva y acertijos complejos', 82.59, 73.01, '📜'),
(57, 19, 'Entrada al Plano de las Sombras', NULL, NULL, 'Punto crítico', 'Umbral irreversible hacia eventos que alteran profundamente la historia.', 83.59, 80.32, '⛩️'),
(58, 19, 'Circo de los Últimos Días', NULL, NULL, 'Evento', 'Recinto itinerante repleto de espectáculos, secretos, personajes peculiares y misiones secundarias con múltiples desenlaces.', 41.80, 73.01, '⭐'),
(59, 19, 'Templo del Puño Abierto', NULL, NULL, 'Templo', 'Santuario religioso donde comienza una investigación clave relacionada con conspiraciones y asesinatos en la ciudad.', 42.90, 63.19, '📜'),
(60, 19, 'Taberna Canción de Elfos', NULL, NULL, 'Posada', 'Principal centro de descanso urbano. Sirve como punto de reunión, alojamiento y nodo narrativo para varias cadenas de misiones.', 46.23, 67.85, '🏰'),
(61, 19, 'Suministros Arcanos', NULL, NULL, 'Tienda', 'Torre comercial especializada en magia avanzada, grimorios raros, artefactos poderosos y secretos ocultos entre sus niveles superiores.', 43.02, 76.66, '💎'),
(62, 19, 'Torre comercial especializada en magia avanzada, grimorios raros, artefactos poderosos y secretos oc', NULL, NULL, 'Instalación', 'Banco fortificado con cámaras protegidas, vigilancia reforzada y acceso a una de las operaciones de infiltración más complejas del acto.', 46.34, 80.99, '🗝️'),
(63, 19, 'Casa de la Esperanza', NULL, NULL, 'Mazmorra', 'Dominio extraplanar lleno de trampas, tesoros excepcionales y uno de los enfrentamientos más memorables del juego.', 47.45, 86.81, '🔥'),
(65, 19, 'Salón de la Gremial', NULL, NULL, 'Refugio', 'Cuartel general del inframundo criminal, donde se negocian alianzas, favores y conflictos entre facciones clandestinas.', 84.04, 55.71, '🗝️'),
(66, 19, 'Templo de Bhaal', NULL, NULL, 'Santuario', 'Refugio ceremonial del culto asesino. Zona hostil cargada de pruebas letales y decisiones narrativas cruciales.', 67.96, 79.49, '💀'),
(67, 19, 'Accesos al Alcantarillado', NULL, NULL, 'Acceso', 'Red subterránea que conecta múltiples distritos y permite rutas alternativas para infiltración o exploración secreta.', 71.73, 88.14, '⛩️'),
(68, 19, 'Piscina Mórfica', NULL, NULL, 'Punto crítico', 'Umbral hacia la fase final de la historia. Marca la transición hacia el desenlace principal.', 58.87, 92.30, '⭐'),
(69, 19, 'Ascenso al Cerebro Abisal', NULL, NULL, 'Conclusión', 'Último tramo del juego; acceso directo al enfrentamiento culminante que define el destino de Baldur’s Gate.', 35.70, 89.14, '⚔️'),
(70, 15, 'Iglesia de Elleh', NULL, NULL, 'Punto de Gracia / Tienda', 'Aquí está el Mercader Kalé. Vende el Kit de creación, el Recetario de guerrero nómada y el Telescopio. También hay una mesa de herrería para mejorar armas hasta +3.', 23.15, 34.95, '🏠'),
(71, 15, 'Puente del Sacrificio', NULL, NULL, 'Paso fronterizo / Combate', 'Conecta Necrolimbo con la Península Llorona. Muy custodiado. Contiene una Llave de espada pétrea', 26.92, 49.93, '🛡️'),
(73, 15, 'Puerta de Raya Lucaria', NULL, NULL, 'Acceso a Mazmorra', 'Entrada a la Academia. Requiere Llave de piedra fulgurante. Punto de viaje rápido importante.', 27.59, 29.40, '🗝️'),
(74, 15, 'Castillo de Morne', NULL, NULL, 'Mazmorra de Legado', 'Gran fuerte al sur. Jefe: Bastardo Leonino. Suelta el Espadón de hoja injertada (arma legendaria)', 16.42, 30.95, '🏰'),
(75, 15, 'Torre de la Morne', NULL, NULL, 'Puesto de NPC', 'Ubicación de Edgar. Necesario para avanzar en la misión de Irina y obtener materiales de mejora', 26.70, 36.28, '⛩️'),
(76, 15, 'Cabaña del Comerciante Kalé', NULL, NULL, 'Tienda', 'Vende Kit de creación y herramientas básicas. Nota: Es el mismo punto que la Iglesia de Elleh', 33.43, 62.46, '🏕️'),
(77, 15, 'Ruinas de las Murallas', NULL, NULL, 'Punto de Gracia', 'Zona de descanso estratégica entre el Bosque Neblinoso y el Castillo de Velo Tormentoso', 24.11, 40.61, '🛖'),
(78, 15, 'Catacumbas de los Perdidos', NULL, NULL, 'Mazmorra menor', 'Laberinto con trampas. Ideal para farmear Estatice sepulcral (mejora de invocaciones)', 21.75, 48.71, '💀'),
(79, 15, 'Túnel de la Costa', NULL, NULL, 'Mina / Túnel', 'Conecta con la isla de la Iglesia del Dragón. Contiene Piedras de forja para mejorar armas', 14.20, 47.37, '🏔️'),
(80, 15, 'Iglesia de la Peregrinación', NULL, NULL, 'Punto de interés', 'Contiene una Lágrima Sagrada para mejorar la potencia de tus viales', 21.08, 78.55, '💎'),
(81, 15, 'Castillo de Velo Tormentoso', NULL, NULL, 'Mazmorra de Legado', 'Primera gran fortaleza. Jefes: Margit y Godrick. Clave para la historia', 25.30, 71.01, '🏰'),
(82, 15, 'Ruinas de la Calle Principal', NULL, NULL, 'Punto de Gracia / Ruinas', 'Zona de paso con enemigos básicos. Útil como punto de reabastecimiento rápido.', 31.36, 69.12, '🛖'),
(83, 15, 'Cueva del Conocimiento', NULL, NULL, 'Tutorial', 'Zona inicial de aprendizaje. Jefe: Soldado de Godrick. Enseña mecánicas de combate', 33.88, 74.67, '🏔️'),
(84, 15, 'Catacumbas de los Apóstoles', NULL, NULL, 'Mazmorra secundaria', 'Contiene materiales de mejora para cenizas. Cuidado con las trampas y esqueletos', 36.32, 64.57, '💀'),
(85, 15, 'Cabaña del Maestro de Guerra', NULL, NULL, 'NPC / Tienda', 'Aquí está Bernahl. Vende Cenizas de Guerra para personalizar tus habilidades de armas', 31.58, 79.22, '🏕️'),
(86, 15, 'Torre de las Tres Hermanas', NULL, NULL, 'Punto de misión (Lore)', 'Hogar de Ranni la Bruja. Punto de inicio para uno de los finales del juego', 34.76, 83.21, '📜'),
(87, 15, 'Academia de Raya Lucaria', NULL, NULL, 'Mazmorra de Legado', 'Gran zona de hechicería. Jefe principal: Rennala. Necesaria para desbloquear el renacimiento (reseteo de estadísticas)', 34.62, 37.17, '🏰'),
(88, 15, 'Iglesia del Voto', NULL, NULL, 'Punto de interés / Lore', 'Donde reside Miriel (la tortuga sabia). Permite expiar pecados para volver amistosos a NPCs atacados por error', 45.56, 56.69, '💎'),
(89, 15, 'Ruinas de los Hechiceros', NULL, NULL, 'Ruinas / Combate', 'Zona con enemigos que usan magia de piedras fulgurantes. Contiene sótanos con tesoros o hechizos', 41.94, 35.50, '🛖'),
(90, 15, 'Ascensor de Dectus', NULL, NULL, 'Gran elevador', 'Conecta Liurnia con la Meseta Altus. Requiere las dos mitades del Medallón de Dectus para funcionar', 43.64, 51.04, '🏠'),
(91, 15, 'Gran Biblioteca de Raya Lucaria', NULL, NULL, 'Punto de Gracia / NPC', 'Habitación final de la Academia tras vencer a Rennala. Lugar para cambiar tu apariencia y estadísticas.', 36.61, 41.72, '📜'),
(92, 15, 'Templo de la Rosa', NULL, NULL, 'Punto de misión', 'Ubicación de Varré. Clave para obtener el objeto de invasión infinita y acceso temprano al Palacio de Mohgwyn', 48.67, 47.26, '🛡️'),
(93, 15, 'Sellia, Ciudad de la Hechicería', NULL, NULL, 'Ciudad / Puzle', 'Ciudad encantada. Debes encender tres hogueras en las torres para romper los sellos mágicos y acceder al jefe', 64.64, 79.77, '🔥'),
(94, 15, 'Inmundicia Escarlata (Lago)', NULL, NULL, 'Zona de peligro / Estado', 'Área inundada de Podredumbre Roja. Muy peligrosa sin bolos de inmunidad. Contiene materiales de mejora raros', 61.09, 62.02, '💀'),
(96, 15, 'Torre de Caelid (Torre Sagrada)', NULL, NULL, 'Plataformas / Gran Runa', 'Requiere parkour por el exterior para entrar. Aquí se activa la Gran Runa de Radahn tras vencerlo', 67.75, 59.36, '⛩️'),
(97, 15, 'Cueva del Sabio', NULL, NULL, 'Mazmorra secreta', 'Llena de paredes ilusorias (falsas). Contiene cofres con objetos muy valiosos, como la Capa de plumas de ave rapaz', 64.57, 70.78, '🏔️'),
(98, 15, 'Fortaleza de la Putrefacción', NULL, NULL, 'Fuerte / Combate', 'Castillo custodiado por soldados y perros mutantes. Contiene el Manual de armero [7] y equipo de alta resistencia', 58.80, 68.79, '🏰'),
(99, 15, 'Prisión Eterna', NULL, NULL, 'Desafío de Jefe', 'Arena circular para duelos 1vs1 contra jefes opcionales poderosos. No permite invocaciones de cenizas', 72.63, 74.67, '🎯'),
(100, 15, 'Catedral de la Comunión del Dragón', NULL, NULL, 'Altar / Hechizos', 'Lugar para intercambiar Corazones de Dragón por hechizos de aliento de fuego, hielo o podredumbre', 54.14, 71.23, '🔥'),
(101, 15, 'Pantano de Aeonia', NULL, NULL, 'Zona de Jefe de mundo', 'Territorio de la Comandante O\'Neil. Clave para obtener la Aguja de Oro de la misión de Millicent', 48.15, 75.67, '💀'),
(102, 15, 'Entrada a Altus Plateau', NULL, NULL, 'Punto de acceso', 'Se llega mediante el Gran Elevador de Dectus o el Despeñadero de las Ruinas. Marca el inicio de la zona dorada', 34.76, 14.65, '⛩️'),
(103, 15, 'Ruinas de Windmill Village (Dominula)', NULL, NULL, 'Punto de interés / Jefe', 'Aldea con bailarinas que ríen. Jefe: Apóstol de la piel de dios. Suelta el arma Pelador de piel de dios', 37.94, 16.86, '🛖'),
(104, 15, 'Carretera de Iniquidad', NULL, NULL, 'Camino principal / Combate', 'Ruta que rodea el monte Gelmir. Llena de enemigos de la Inquisición y acceso a puentes destruidos hacia la Mansión Volcánica', 36.02, 23.96, '🛡️'),
(105, 15, 'Leyndell, Capital Real (Entrada)', NULL, NULL, 'Mazmorra de Legado', 'Acceso principal a la gran ciudad. Requiere tener al menos dos Grandes Runas activas para que el sello se abra', 32.03, 27.51, '🗝️'),
(106, 15, 'Fortaleza de Leyndell', NULL, NULL, 'Fuerte / Defensa', 'Murallas exteriores protegidas por caballeros de la capital y gárgolas. Punto estratégico antes de entrar al corazón de la ciudad', 41.79, 25.85, '🏰'),
(107, 15, 'Templo de la Capital', NULL, NULL, 'Punto de interés / Lore', 'Santuario dentro de Leyndell. Lugar de importancia religiosa donde se encuentran objetos clave relacionados con la Orden Dorada', 44.60, 27.63, '💎'),
(108, 15, 'Subsuelo de Leyndell (Alcantarillas)', NULL, NULL, 'Mazmorra secreta', 'Laberinto oscuro bajo la ciudad. Contiene al jefe Mohg, el Presagio y el acceso al final de la Llama Frenética', 38.76, 29.40, '💀'),
(109, 15, 'Camino del Inquisidor', NULL, NULL, 'Senda / Mazmorra', 'Ruta peligrosa que lleva a la cueva del Inquisidor. Llena de enemigos que causan locura y secuestradores (doncellas de hierro)', 66.86, 41.49, '🛡️'),
(110, 15, 'Mansión Volcánica', NULL, NULL, 'Mazmorra de Legado', 'Sede de los Recusantes. Debes decidir si unirte a ellos o explorar sus secretos. Jefe: Rykard, Señor de la Blasfemia', 71.08, 42.38, '💀'),
(111, 15, 'Templo del Señor de la Sangre', NULL, NULL, 'Zona de Jefe / Teletransporte', 'Ubicado en el Palacio de Mohgwyn. Lugar del combate contra Mohg, Señor de la Sangre. Recompensa: su Gran Runa', 66.20, 46.82, '💀'),
(112, 15, 'Ruinas de Street of Sages (Ruinas de la Calle de los Sabios)', NULL, NULL, 'Ruinas / Tesoro', 'En el Pantano de Aeonia. Crucial para magos, aquí se encuentra el Bastón de meteorito y el hechizo Lanzarrocas', 63.17, 42.49, '🛖');

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
(25, 1, 'vsvcsad', '2026-05-06 17:09:52'),
(26, 2, 'cvsfewfwsdwe', '2026-05-12 13:54:20'),
(27, 2, 'wfwfwf', '2026-05-12 13:54:34');

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
(17, 2, 1, 'YA NAAAAA', '2026-05-07 10:33:27', 1),
(18, 2, 1, 'VETE A LA MIERDA', '2026-05-07 18:02:21', 1);

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
(13, 14, 'Madeline', 'Protagonista / Escaladora', 'Base de la Montaña Celeste', 'Una joven determinada que viaja a la montaña Celeste con el único propósito de alcanzar su cima para demostrarse a sí misma que es capaz de lograr algo significativo. Madeline lucha constantemente contra ataques de pánico y una depresión que ella describe como \"estar atrapada en el fondo de un océano\". A diferencia de su reflejo, su cabello cambia de color según su estado de energía: pelirrojo por defecto y azul tras agotar su impulso. Su mayor fortaleza no es su agilidad física, sino su capacidad de persistir a pesar del fracaso constante. A través del ascenso, aprende que la montaña no es algo que deba \"derrotar\", sino un lugar donde debe aprender a escucharse y reconciliarse con su propia ansiedad para encontrar la paz.', 'pj_1778511436.png'),
(14, 14, 'Badeline', 'Antagonista / Reflejo Psicológico', 'Espejo del Templo (y las profundidades de la mente de Madeline)', 'Conocida inicialmente como \"Parte de Mí\", Badeline es la manifestación física de la ansiedad, el miedo y las inseguridades de Madeline, nacida a través de un espejo místico en el Templo de la Montaña Celeste. De piel pálida, ojos de un fucsia brillante y cabello de un púrpura eléctrico, posee habilidades de movimiento superiores, incluyendo impulsos ilimitados y la capacidad de disparar rayos de energía. Aunque actúa como una fuerza obstructiva que intenta convencer a Madeline de abandonar su ascenso, su verdadera intención es protegerla de lo que ella considera un peligro innecesario. Su evolución de enemiga a aliada es el corazón del viaje, simbolizando la aceptación propia y la integración de nuestras sombras para alcanzar la cima.', 'pj_1778511403.png'),
(15, 15, 'Melina', 'Doncella de los Dedos (autoproclamada) / Guía del ', 'Sitios de Gracia en todas las Tierras Intermedias.', 'Una joven enigmática que se presenta ante el Sinluz para ofrecerle un pacto: ella le otorgará el poder de las runas y el silbato del corcel Torrentera a cambio de ser llevada al pie del Árbol Áureo. Melina es un ser etéreo, una \"proyección\" que busca cumplir el propósito que le encomendó su madre dentro del Árbol. A pesar de su apariencia frágil y su ojo izquierdo sellado con una marca de garra, es una guerrera capaz que domina la magia sacra y las dagas. Su destino es arder para servir de yesca y quemar las espinas que bloquean el paso al Trono del Círculo, sacrificando su existencia para que un nuevo Señor pueda nacer y restaurar el Orden.', 'pj_1778575695.png'),
(16, 15, 'Ranni la Bruja (nacida como la Princesa Lunar Ranni)', 'Semidiosa / Empyrea / Líder de la facción de la Lu', 'Tres Hermanas (Liurnia) / Torre de Ranni', 'Hija de Radagon y Rennala, Ranni es una Empyrea que renunció a su destino y a su cuerpo físico para escapar del control de la Voluntad Mayor. Durante la \"Noche de los Puñales Negros\", orquestó el asesinato de Godwyn el Dorado para liberar su espíritu, habitando desde entonces el cuerpo de una muñeca de porcelana de cuatro brazos. Es una maestra de las artes oscuras de la luna y el frío, y busca derrocar el Orden Dorado para instaurar un nuevo orden basado en las estrellas y el cosmos, lejos de la influencia de los dioses exteriores. A pesar de su apariencia fría y calculadora, siente un profundo aprecio por sus seguidores, como Blaidd e Iji, y ofrece al Sinluz uno de los caminos más largos y significativos hacia el trono.', 'pj_1778576056.png'),
(17, 15, 'Blaidd el SemiLobo', 'Guerrero / Sombra de Ranni', 'Ruinas de Mistwood / Río Siofra / Liurnia', 'Un imponente guerrero híbrido, mitad hombre y mitad lobo, creado por los Dedos para servir como la \"Sombra\" y guardián incondicional de Ranni la Bruja. Ataviado con una armadura pesada y empuñando un espadón colosal imbuido de frío, Blaidd destaca por su nobleza y su ferocidad en combate. A pesar de su apariencia bestial, es un aliado cortés y de palabra que ayuda al Sinluz en la caza del traidor Darriwil y en el asalto contra el General Radahn. Sin embargo, su destino está marcado por la tragedia: como creación de la Voluntad Mayor, Blaidd lucha internamente para no sucumbir a la locura cuando los planes de su señora desafían el orden establecido por sus creadores.', 'pj_1778575228.png'),
(18, 15, 'Malenia, la Espada de Miquella', 'Semidiosa / Portadora de la Gran Runa / Jefa de Le', 'Elphael, tutor del Árbol Jerárquico', 'La hija de Marika y Radagon, nacida con la maldición de la Putrefacción Roja que consume su cuerpo desde el interior. Malenia es una guerrera de una destreza inigualable que nunca ha conocido la derrota; utiliza prótesis de oro puro en su brazo y pierna para blandir su característica hoja en forma de ala. Su vida está dedicada por completo a la protección de su hermano gemelo, Miquella, a quien considera el único y verdadero dios. Durante la guerra de la Devastación, desató el poder de la Flor de la Putrefacción en Caelid para empatar con Radahn, condenando a toda una región. En combate es grácil, rápida y letal, capaz de curar sus heridas con cada golpe que asesta y de invocar la temida \"Danza de las Aves\".', 'pj_1778575569.png'),
(19, 15, 'General Radahn, Azote de las Estrellas', 'Semidiós / Portador de la Gran Runa / Jefe de Zona', 'Castillo de la Melena Roja (Caelid)', 'El hijo más poderoso de Radagon y Rennala, un titán que domina la magia gravitatoria. Radahn es famoso por haber desafiado al mismísimo cosmos, deteniendo el movimiento de las estrellas para proteger el destino del mundo. Tras su épico y devastador duelo contra Malenia, quedó infectado por la Putrefacción Roja, lo que lo convirtió en una bestia errante y sin mente que devora los cadáveres de aliados y enemigos por igual en las dunas de Caelid. A pesar de su locura, sigue montando a su diminuto y amado caballo, Leonard, usando sus poderes gravitatorios para no aplastarlo. El Festival de la Lucha se celebra en su honor para otorgarle una muerte digna de un guerrero.', 'pj_1778575354.png'),
(20, 15, 'Rykard, Señor de la Blasfemia', 'Semidiós / Portador de la Gran Runa / Jefe de Leye', 'Mansión del Volcán (Monte Gelmir)', 'Hijo de Radagon y Rennala, Rykard fue una vez un respetado juez de la Inquisición, pero su ambición lo llevó por un camino de depravación. Despreciando el Orden Dorado, permitió que una serpiente devoradora de dioses lo engullera para fusionarse con ella y alcanzar la inmortalidad. Ahora, desde las entrañas del Monte Gelmir, lidera una rebelión blasfema contra el Árbol Áureo. Su cuerpo es una masa grotesca de carne y rostros de aquellos a los que ha devorado, y lucha utilizando la Hoja Blasfema, una espada cubierta de restos orgánicos que laten con vida propia. Su único objetivo es consumir el mundo entero para que todos puedan vivir \"como familia\" dentro del vientre de la serpiente eterna.', 'pj_1778576206.png'),
(21, 15, 'Sir Gideon Ofnir, el Omnisciente', 'Líder de la Mesa Redonda / Sinluz / Jefe de Leyend', 'Mesa Redonda / Leyndell, Capital Cenicienta', 'Un Sinluz de intelecto prodigioso que dedica su existencia a la recopilación de todo el conocimiento del mundo. Como líder de la Mesa Redonda, Gideon actúa como un estratega que observa y manipula los hilos del destino desde su estudio rodeado de libros. Su armadura está decorada con innumerables orejas y ojos, simbolizando su red de espionaje y su capacidad para escucharlo todo. Aunque inicialmente parece un mentor que guía al jugador, su verdadera lealtad reside en mantener el statu quo del Árbol Áureo. En combate, hace honor a su nombre utilizando los hechizos y encantamientos de todos los semidioses que el Sinluz ha derrotado, demostrando que el conocimiento es, literalmente, su arma más poderosa.', 'pj_1778576326.png'),
(22, 15, 'Godfrey (Hoarah Loux)', 'Primer Señor del Círculo / Jefe de Leyenda', 'Leyndell, capital del Reino', 'El guerrero definitivo y consorte de la Reina Marika. Originalmente conocido como el feroz caudillo Hoarah Loux, aceptó el nombre de Godfrey y cargó con el regente Serosh en su espalda para contener su sed de sangre infinita y convertirse en un monarca digno. Fue el primer Sinluz, exiliado de las Tierras Intermedias tras perder el brillo de la Gracia una vez que sus enemigos fueron derrotados. Empuña un hacha colosal y simboliza la era dorada del Árbol Áureo. En combate, representa la dualidad entre la majestad de un rey y la brutalidad de un bárbaro que lucha solo con sus manos desnudas cuando la situación lo requiere.', 'pj_1778575469.png'),
(23, 15, 'Morgott, Rey de los Augurios', 'Semidiós / Rey de Leyndell / Protector del Árbol Á', 'Trono del Círculo (Leyndell, capital del Reino)', 'Nacido como un Augurio —una estirpe maldita con cuernos que crecen en su carne—, Morgott fue encerrado en las alcantarillas de la capital desde su nacimiento por sus padres, Marika y Godfrey. A pesar de este rechazo, cuando el Círculo de Elden se rompió y sus hermanos se entregaron a la ambición, él fue el único que permaneció para defender el trono bajo la identidad secreta de \"Margit, el Augurio Caído\". Morgott no lucha por el poder, sino por un deber que sabe que nunca le será agradecido, considerando a todos los demás semidioses como traidores manchados por la llama de la ambición. Empuña una espada de sangre maldita y es capaz de invocar armas de luz dorada para castigar a cualquier Sinluz que ose acercarse al Árbol Sagrado.', 'pj_1778575802.png'),
(24, 15, 'Radagon de la Orden Dorada', 'Dios / Segundo Señor del Círculo / Jefe Final', 'Trono del Círculo (Interior del Árbol Áureo)', 'Un campeón de cabellos rojos flamígeros que ascendió a la posición de Señor del Círculo tras la partida de Godfrey. Radagon es un fanático del Orden Dorado que dedicó su vida a alcanzar la perfección a través de la ley y la regresión. Tras el asesinato de Godwyn y el estallido del Círculo de Elden, se reveló que Radagon y Marika son, en realidad, un mismo ser compartiendo un único cuerpo en conflicto. Mientras Marika buscaba destruir el Círculo, Radagon intentó repararlo desesperadamente. Empuña el Martillo de Marika, imbuido con el poder de la Voluntad Mayor, y combate con una determinación divina, utilizando rayos de luz sólida y explosiones de oro para aniquilar a cualquier Sinluz que aspire a convertirse en el nuevo Señor.', 'pj_1778575962.png'),
(25, 17, 'Geralt de Rivia', 'Protagonista / Brujo', 'Kaer Morhen', 'El brujo protagonista, conocido como el Lobo Blanco. Maestro espadachín y cazador de monstruos profesional.', NULL),
(26, 17, 'Ciri', 'Bruja / Hija Adoptiva', 'Kaer Morhen', 'Heredera al trono de Cintra e hija adoptiva de Geralt. Posee poderes de viaje interdimensional.', NULL),
(27, 17, 'Yennefer de Vengerberg', 'Hechicera', 'Novigrado / Skellige', 'Una de las hechiceras más poderosas del Norte. Antigua amante de Geralt y figura materna para Ciri.', NULL),
(28, 17, 'Triss Merigold', 'Hechicera', 'Novigrado', 'Hechicera pelirroja, amiga íntima de Geralt y miembro de la Logia de Hechiceras.', NULL),
(29, 17, 'Vesemir', 'Brujo / Mentor', 'Kaer Morhen', 'El brujo más anciano de la Escuela del Lobo. Mentor y figura paterna de Geralt y Ciri.', NULL),
(30, 17, 'Emhyr var Emreis', 'Emperador de Nilfgaard', 'Vizima', 'Emperador de Nilfgaard y padre biológico de Ciri. Conocido como \"La Llama Blanca\".', NULL),
(31, 17, 'Eredin Bréacc Glas', 'Rey de la Cacería Salvaje', 'Varias', 'Líder de la Cacería Salvaje que persigue a Ciri para obtener su poder interdimensional.', NULL),
(32, 17, 'El Barón Sanguinario', 'Señor de la Guerra', 'Arboleda de los Susurros', 'Antiguo soldado convertido en barón de Velen. Su historia personal es una de las tramas más memorables.', NULL),
(33, 17, 'Dandelion (Jaskier)', 'Bardo', 'Novigrado', 'El bardo más famoso del mundo, amigo íntimo de Geralt. Conocido por sus baladas.', NULL),
(34, 17, 'Zoltan Chivay', 'Herrero / Enano', 'Novigrado', 'Herrero enano y amigo leal de Geralt. Veterano de guerra y miembro de la resistencia.', NULL),
(35, 19, 'Shadowheart', 'Compañera', 'Barco Náutiloide / Monasterio de la Dualidad', 'Clérigo medio-elfo de Shar, diosa de la oscuridad y los secretos. Fría y reservada, oculta un pasado traumático que ella misma ha suprimido de su memoria. Es la única del grupo capaz de retirar el parásito cerebral y su arco personal es uno de los más emocionalmente profundos del juego.', 'pj_1778495296.png'),
(36, 19, 'Astarion', 'Compañero', 'Playa del Náutiloide / Vilhon Reach', 'Pícaro vampiro alto-elfo. Fue esclavo del archivampiro Cazador durante doscientos años, obligado a seducir víctimas. Ahora, con el parásito que suprime la maldición vampírica, experimenta una libertad que nunca conoció. Cáustico, encantador y profundamente roto.', 'pj_1778489124.png'),
(37, 19, 'Gale Dekarios', 'Compañero', 'Portal de Magia / Torre de Waterdeep', 'Mago humano de Waterdeep y antiguo favorito de Mystra, diosa de la magia. Cometió el error de intentar robar un fragmento de la Corona de Karsus, absorbiendo una «singularidad de Weave» que amenaza con destruirlo —y todo lo que le rodea— si no consume artefactos mágicos con regularidad.', 'pj_1778491425.png'),
(38, 19, 'Lae\'zel', 'Compañera', 'Barco Náutiloide / Campos de Batalla de Crecia', 'Guerrera githyanki de élite, criadadesde la infancia para matar ilusionistas. Disciplinada, directa hasta la brutalidad y convencida de la supremacía githyanki. Su misión es purificarse ante la Lich-Reina Vlaakith, pero el parásito y las revelaciones del viaje cuestionan todo lo que le han enseñado.', 'pj_1778495270.png'),
(39, 19, 'Wyll Ravengard', 'Compañero', 'Goblin Camp / Ciudad de Baldur\'s Gate', 'El «Filo de los Fronteros», un hechicero-brujo humano famoso en la Ciudad de Baldur\'s Gate como héroe del pueblo. Hizo un pacto con la diablesa Mizora a cambio de poder suficiente para proteger a su ciudad, y ahora arrastra las consecuencias de ese trato. Un idealista atrapado entre su héroe interior y su patrona infernal.', 'pj_1778495309.png'),
(40, 19, 'Karlach', 'Compañera', 'Río Chionthar / Avernus', 'Bárbara tiefling con un motor infernal incrustado en el pecho: un artefacto de Avernus que la incendia desde dentro y la condena a muerte si no encuentra la forma de repararlo. Escapó del servicio forzado de Zariel y rebosa de energía y vitalidad, aunque sabe que su tiempo podría estar contado.', 'pj_1778495201.png'),
(41, 19, 'Halsin', 'Compañero Opcional', 'Campamento Goblin / Bosque Silvanus', 'Gran Druida elfo de madera del Bosque de Silvanus y líder del Campamento de los Druidas. Lleva décadas estudiando la Sombra que corrompe las Tierras Malditas. Cuando se une al grupo como compañero completo en el Acto II, aporta una perspectiva de sabio anciano y un corazón genuinamente bondadoso.', 'pj_1778495249.png'),
(42, 19, 'Minthara Baenre', 'Compañera Opcional', 'Campamento Goblin / Underdark', 'Paladín drow y comandante de las fuerzas goblins al servicio del Absoluto. Solo se une al grupo en una ruta moralmente oscura. Implacable, letal y con un trasfondo de nobleza drow que explica —aunque no justifica— su crueldad. Uno de los personajes más complejos moralmente del juego.', 'pj_1778495285.png'),
(43, 19, 'El Absoluto (Cazador de Ilusiones)', 'Antagonista', 'Templo del Absoluto / Ciudad de Baldur\'s Gate', 'Un antiguo Cazador de Ilusiones —la forma más poderosa de la raza de los ilusionistas— que ha sido corrompido y convertido en la encarnación del «Absoluto», un culto que controla mentes mediante parásitos cerebrales. Estratega frío e implacable, su objetivo es conquistar Faerûn comenzando por Baldur\'s Gate.', 'pj_1778491415.png'),
(44, 19, 'Dame Aylin', 'Aliada / PNJ', 'Shadowfell / Ciudad de Baldur\'s Gate', 'La Doncella de la Aurora, hija inmortal de la diosa Selûne. Fue capturada por Lorroakan para ser convertida en fuente de energía. Su amor por la princesa Isobel y su inmortalidad impuesta la convierten en uno de los personajes más trágicos del Acto II, y su liberación es uno de los momentos más épicos del juego.', 'pj_1778491402.png'),
(45, 20, 'Kratos', 'Protagonista', 'Los Nueve Reinos', 'El Fantasma de Esparta y antiguo dios griego de la guerra, busca redención mientras protege a su hijo.', NULL),
(46, 20, 'Atreus (Loki)', 'Hijo de Kratos', 'Los Nueve Reinos', 'El hijo de Kratos y la gigante Laufey, intenta comprender su papel en el mundo y su destino.', NULL),
(47, 20, 'Mimir', 'Aliado / Sabio', 'Los Nueve Reinos', 'El hombre más listo del mundo, una cabeza reanimada que acompaña a Kratos y Atreus en su viaje.', NULL),
(48, 20, 'Freya', 'Aliada / Antagonista', 'Vanaheim', 'La reina de las Valquirias y antigua esposa de Odín, busca venganza por la muerte de su hijo Baldur.', NULL),
(49, 20, 'Thor', 'Antagonista Principal', 'Asgard', 'El temible Dios del Trueno, hijo de Odín, un oponente formidable que busca venganza contra Kratos.', NULL),
(50, 20, 'Odin', 'Antagonista Final', 'Asgard', 'El Rey de los Aesir, un ser increíblemente astuto y manipulador obsesionado con evitar el Ragnarök.', NULL),
(51, 20, 'Týr', 'Aliado', 'Svartalfheim', 'El antiguo Dios de la Guerra nórdico, amante de la paz, cuyo regreso representa una chispa de esperanza.', NULL),
(52, 20, 'Angrboda', 'Aliada / Gigante', 'Jötunheim', 'Una de las últimas gigantes, sabia y poderosa, ayuda a Atreus a comprender su herencia y su destino como Loki.', NULL),
(53, 20, 'Brok', 'Herrero / Aliado', 'Svartalfheim', 'Un maestro herrero enano que forjó el hacha Leviatán y la lanza Draupnir, leal y habilidoso.', NULL),
(54, 20, 'Sindri', 'Herrero / Aliado', 'Svartalfheim', 'El hermano de Brok, un herrero extremadamente meticuloso y brillante, vital para desbloquear los secretos de la forja.', NULL),
(55, 21, 'V (Vincent / Valerie)', 'Protagonista (Mercenario / Edgerunner)', 'Night City (Apartamento en H10, Watson)', 'Un mercenario en ascenso que busca hacerse un nombre en la ciudad de los sueños rotos. Ya sea como un antiguo empleado corporativo, un nómada del desierto o un buscavidas de las calles, el destino de V cambia radicalmente tras un atraco fallido a la Torre Arasaka. Con el biochip \"Relic\" dañado en su cerebro, V debe lidiar con la personalidad digital de Johnny Silverhand, que amenaza con borrar su existencia. A través de implantes cibernéticos, hackeo y armas de fuego, V lucha contra el reloj para encontrar una cura, convirtiéndose en el epicentro de una tormenta que sacudirá los cimientos de las megacorporaciones y decidirá el futuro de Night City.', 'pj_1778574284.png'),
(56, 21, 'Johnny Silverhand', 'Rockerboy / Líder de la banda Samurai / Inquilino ', 'Night City (Residiendo en el biochip Relic de V)', 'Un veterano de guerra desertor que se convirtió en el icono de la rebelión antisistema en Night City. Líder y vocalista de la legendaria banda Samurai, Johnny utilizó su música como arma contra el control de las megacorporaciones, especialmente Arasaka. Tras su aparente muerte en 2023 durante el asalto nuclear a la Torre Arasaka, su conciencia fue digitalizada mediante el programa Almicida (Soulkiller). Es un hombre impulsivo, cínico y carismático, cuyo brazo biónico plateado le da su apodo. Acompaña a V como un \"fantasma digital\", guiándolo (o manipulándolo) mientras su personalidad comienza a sobrescribir la del mercenario, buscando completar su venganza contra el sistema.', 'pj_1778573930.png'),
(57, 21, 'Jackie Welles', 'Mercenario / Compañero y mejor amigo de V', 'Heywood (El Coyote Cojo) / Night City', 'Un mercenario de gran corazón, exmiembro de la banda de los Valentinos y con una ambición tan grande como su físico. Jackie es la definición de lealtad en una ciudad que carece de ella. Su mayor sueño es salir de los suburbios de Heywood y entrar en las grandes ligas del Afterlife para convertirse en una leyenda de Night City. A pesar de su apariencia ruda y sus dos pistolas \"La Chingona Dorada\", Jackie es un hombre profundamente familiar, devoto de su madre (Mamá Welles) y de su novia Misty. Su optimismo inquebrantable y su valentía lo llevan a participar en el atraco al Arasaka Waterfront, un evento que sellaría su destino y el de V para siempre.', 'pj_1778573821.png'),
(58, 21, 'Dexter DeShawn', 'Fixer (Arreglador) Legendario', 'Afterlife / Watson (Night City)', 'Conocido como uno de los mejores fixers de la ciudad, Dex es un hombre cuya reputación precede a su imponente figura. Tras una larga ausencia de Night City debido a un trabajo que salió mal en el pasado, regresa para organizar el atraco del siglo: el robo del Biochip de Arasaka. De modales pausados, fumador de puros y siempre rodeado de lujo en su limusina, Dex vende a sus mercenarios el sueño de convertirse en leyendas. Sin embargo, tras su fachada de profesionalismo y sabiduría callejera, se esconde un hombre pragmático que no dudará en \"limpiar los cabos sueltos\" si las cosas se complican. Su lema plantea la pregunta definitiva de Night City: ¿Prefieres vivir como un don nadie o morir en un estallido de gloria?', 'pj_1778573748.png'),
(59, 21, 'Judy Álvarez', 'Técnica de Neurodanza / Miembro de las Mox', 'Watson (Lizzie\'s Bar) / Su apartamento en Northside', 'Una virtuosa de la tecnología de neurodanza (BD) con un fuerte sentido de la justicia y una lealtad inquebrantable hacia sus amigos. Judy es una artista visual que prefiere trabajar entre cables y editores que en los tiroteos de la calle, aunque no duda en ensuciarse las manos si es por una causa en la que cree. Como miembro de las Mox, se dedica a proteger y dar voz a los trabajadores sexuales de la ciudad. Su vida da un vuelco tras el desastroso atraco al Biochip, lo que la lleva a buscar venganza y un cambio real en el sistema. Tras su apariencia punk, sus tatuajes y su cabello multicolor, se esconde una mujer idealista y sensible que sueña con encontrar algo de humanidad en la selva de neón que es Night City.', 'pj_1778574020.png'),
(60, 21, 'Victor Vector', 'Matasanos (Ripperdoc)', 'Watson (Little China), en el sótano bajo la tienda de Misty (Night City)', 'Victor es un veterano matasanos con manos de cirujano y un corazón de oro, algo casi imposible de encontrar en Night City. Especialista en ciberware de alta gama y antiguo boxeador, Vik regenta una clínica modesta pero equipada con tecnología de punta. Es el médico de confianza de V y Jackie Welles, a quienes trata casi como a sus propios hijos, llegando incluso a fiarles implantes carísimos por pura fe en su talento. A diferencia de otros matasanos que solo ven remolinos de dinero, Vik posee una ética inquebrantable y es el primero en advertir a V sobre los peligros reales de jugar con la tecnología de Arasaka. Su clínica es el único lugar de la ciudad donde el mercenario puede sentirse realmente a salvo.', 'pj_1778574496.png'),
(61, 21, 'Panam Palmer', 'Nómada / Exmiembro de los Aldecaldos', 'Badlands (Campamento nómada)', 'Una mujer de armas tomar, impulsiva y ferozmente independiente que vive bajo sus propias reglas en las afueras de Night City. Tras una fuerte disputa con Saul, el líder de su clan, Panam decide probar suerte como mercenaria solitaria en la ciudad, aunque su corazón y sus valores siguen perteneciendo al camino y a la familia nómada. Es una experta conductora y mecánica, inseparable de su furgoneta personalizada y de su rifle de francotirador Overwatch. Su lealtad no tiene límites: una vez que confía en alguien, está dispuesta a asaltar una torre corporativa o enfrentarse a un ejército entero para protegerlo. Representa la libertad salvaje de las Badlands frente a la opresión tecnológica de la metrópolis.', 'pj_1778574101.png'),
(62, 21, 'Saburo Arasaka', 'CEO de Arasaka Corporation / Patriarca de la Dinas', 'Torre Arasaka (Sede central en Tokio) / Night City', 'Considerado el hombre más poderoso e influyente del siglo XXI, Saburo es un veterano de la Segunda Guerra Mundial que transformó una empresa familiar en la megacorporación más dominante del planeta. Con una visión de orden absoluto y un desprecio profundo por los valores occidentales modernos, Saburo gobierna Arasaka con mano de hierro y una paciencia milenaria. Su obsesión con la inmortalidad y la preservación del legado familiar lo llevó a financiar el programa Secure Your Soul (Relic). A pesar de su inmensa riqueza, mantiene una disciplina samurái y un código de honor estricto que solo su hijo, Yorinobu, se atreve a desafiar, desencadenando los eventos que pondrán en jaque a toda Night City.', 'pj_1778574188.png'),
(63, 21, 'Yorinobu Arasaka', 'Heredero de Arasaka / Antagonista', 'Torre Arasaka (Night City)', 'El hijo menor y rebelde de Saburo Arasaka. A diferencia de su hermana Hanako, Yorinobu pasó décadas fuera del control familiar, liderando la banda de moteros \"Steel Dragons\" en un intento de destruir el imperio de su padre desde fuera. Al darse cuenta de que la fuerza bruta no era suficiente, regresó al seno de la corporación para intentar destruirla desde sus cimientos. Es un hombre atormentado, impulsivo y visionario que está dispuesto a quemarlo todo con tal de liberar al mundo de la sombra de su padre. El robo del biochip Relic es solo una pieza en su tablero de ajedrez para desatar una guerra que cambie el orden mundial para siempre.', 'pj_1778574567.png'),
(64, 21, 'Adam Smasher', 'Antagonista Principal / Mercenario de Arasaka', 'Torre Arasaka (Night City)', 'Una leyenda viviente del mundo mercenario, aunque de \"vivo\" le queda muy poco. Adam Smasher es un ciborg de combate casi total que ha reemplazado prácticamente toda su humanidad por cromo y hardware militar de Arasaka. Carece de empatía, piedad o remordimientos, viendo a los seres orgánicos como \"carne débil\" y obsoleta. Es famoso por ser el verdugo de Johnny Silverhand en 2023 y por su papel como el arma definitiva de la corporación Arasaka. Equipado con un lanzamisiles integrado en el hombro, blindaje de grado militar y el sistema Sandevistan más avanzado, Smasher no pelea por ideología, sino por el puro placer de la destrucción y la dominación física. Es el muro infranqueable que separa a cualquier \"edgerunner\" de la verdadera gloria.', 'pj_1778573574.png'),
(65, 22, 'Único Superviviente', 'Protagonista', 'Refugio 111', 'El personaje controlado por el jugador. Despierta tras 210 años de criogenización. Busca a su hijo Shaun.', NULL),
(66, 22, 'Shaun (Padre)', 'Antagonista principal / Hijo', 'El Instituto', 'El hijo del protagonista, ahora líder anciano del Instituto bajo el título de Padre.', NULL),
(67, 22, 'Albóndiga (Dogmeat)', 'Compañero (Perro)', 'Taller de Red Rocket', 'Un pastor alemán leal. No cuenta como compañero a efectos de la ventaja Lobo Solitario.', NULL),
(68, 22, 'Codsworth', 'Compañero (Robot Mr. Handy)', 'Sanctuary Hills', 'El robot mayordomo de la familia del protagonista antes de la guerra.', NULL),
(69, 22, 'Preston Garvey', 'Compañero / Líder de los Minutemen', 'Museo de la Libertad, Concord', 'El líder de los Minutemen de la Commonwealth. Incansable defensor de los asentamientos.', NULL),
(70, 22, 'Paladín Danse', 'Compañero / Hermandad del Acero', 'Comisaría de Policía de Cambridge', 'Un paladín de la Hermandad del Acero con una fuerte convicción en su misión.', NULL),
(71, 22, 'Piper Wright', 'Compañera / Periodista', 'Diamond City', 'Una periodista independiente que busca exponer la verdad sobre el Instituto y la corrupción.', NULL),
(72, 22, 'Nick Valentine', 'Compañero / Detective Sintético', 'Refugio 114 (rescate)', 'Un detective sintético con la personalidad de un policía de los años 40.', NULL),
(73, 22, 'Cait', 'Compañera / Luchadora de jaula', 'Combat Zone, Boston', 'Una luchadora de jaula irlandesa con problemas de adicción. Experta en combate cuerpo a cuerpo.', NULL),
(74, 22, 'Robert MacCready', 'Compañero / Mercenario', 'Goodneighbor (The Third Rail)', 'Un mercenario francotirador y antiguo alcalde de Little Lamplight.', NULL),
(75, 22, 'Curie', 'Compañera / Científica (Mrs. Handy)', 'Refugio 81', 'Un robot científica con la conciencia de una investigadora pre-guerra.', NULL),
(76, 22, 'Deacon', 'Compañero / Ferrocarril', 'Old North Church', 'Un espía del Ferrocarril experto en disfraces. Su pasado es un misterio.', NULL),
(77, 22, 'John Hancock', 'Compañero / Alcalde de Goodneighbor', 'Old State House', 'El líder carismático y hedonista de la ciudad libre de Goodneighbor.', NULL),
(78, 22, 'Strong', 'Compañero / Supermutante', 'Trinity Tower', 'Un supermutante interesado en la literatura, diferente al resto de su especie.', NULL),
(79, 22, 'X6-88', 'Compañero / Cursor del Instituto', 'Libertalia', 'Un avanzado sintético del Instituto, asignado como escolta del protagonista.', NULL),
(80, 22, 'Arthur Maxson', 'Líder de la Hermandad del Acero', 'El Prydwen', 'El joven pero formidable Elder de la Hermandad del Acero.', NULL),
(81, 22, 'Desdemona', 'Líder del Ferrocarril', 'Old North Church', 'La líder de la facción Ferrocarril, dedicada a liberar a los sintéticos conscientes.', NULL),
(82, 22, 'Padre (Father)', 'Líder del Instituto', 'El Instituto', 'El líder del Instituto, una organización científica secreta que controla tecnología avanzada.', NULL),
(83, 22, 'Kellogg', 'Antagonista / Mercenario del Instituto', 'Fuerte Hagen', 'Un cazarrecompensas cibernético responsable del secuestro de Shaun.', NULL),
(84, 22, 'Alcalde McDonough', 'Alcalde de Diamond City', 'Diamond City', 'El alcalde sintético de Diamond City, un infiltrado del Instituto.', NULL),
(85, 23, 'Jordan A. Mun', 'Protagonista / Cazarrecompensas', 'Planeta Sempiria', 'Una peligrosa cazarrecompensas interestelar, experta en combate y rastreo. Interpretada por Tati Gabrielle.', NULL),
(86, 23, 'Colin Graves', 'Antagonista / Miembro de los Cinco Ases', 'Planeta Sempiria', 'Un despiadado criminal, líder de una facción de los Cinco Ases. Interpretado por Kumail Nanjiani.', NULL),
(87, 23, 'AJ', 'Aliada / Consejera', 'Comunicaciones orbitales', 'La consejera y apoyo técnico de Jordan, que le guía desde la nave en órbita. Interpretada por Halley Gross.', NULL),
(88, 23, 'El Herrero', 'Antagonista / Líder de la secta', 'Templo del Profeta', 'El misterioso líder de la secta The Heretic Prophet que controla Sempiria.', NULL),
(89, 23, 'Comandante Robótico', 'Enemigo / Jefe', 'Base Central de Sempiria', 'Un robot de tres brazos con una enorme espada láser que protege el núcleo del planeta.', NULL),
(90, 23, 'Teniente de los Cinco Ases', 'Antagonista / Criminal', 'Base de operaciones', 'Mano derecha de Colin Graves, un experto en combate táctico y estrategia.', NULL),
(91, 23, 'Dra. Eva Sempir', 'Aliada / Científica', 'Laboratorio de investigación', 'Una científica que lleva siglos atrapada en Sempiria, conoce los secretos del planeta.', NULL),
(92, 23, 'Bounty Hunter Rival', 'Antagonista / Rival', 'Múltiples ubicaciones', 'Otro cazarrecompensas que compite con Jordan por los mismos objetivos.', NULL),
(93, 23, 'Superviviente de Sempiria', 'PNJ / Aliado', 'Asentamiento oculto', 'Uno de los pocos humanos que quedan en Sempiria, ofrece información y refugio a Jordan.', NULL),
(94, 23, 'Piloto de los Cinco Ases', 'Enemigo / Secuaz', 'Base de los Cinco Ases', 'Un hábil piloto de combate que protege las rutas de escape de los Cinco Ases.', NULL),
(95, 24, 'Lucia Caminos', 'Protagonista', 'Penitenciaría de Leonida', 'Una de las dos protagonistas del juego. Criada en Liberty City, aprendió a defenderse desde pequeña y pasó por prisión. Ahora busca tomar el control de su destino, sin que nada ni nadie la vuelva a arrastrar.', NULL),
(96, 24, 'Jason Duval', 'Protagonista', 'Cayos de Leonida', 'El otro protagonista. Criado entre criminales, intentó escapar alistándose en el ejército, pero regresó a Leonida y cayó en el tráfico de drogas. Ve en Lucía una posible redención.', NULL),
(97, 24, 'Cal Hampton', 'Aliado / Secundario', 'Cayos de Leonida', 'Amigo de Jason, obsesionado con teorías conspirativas. Vive retirado espiando comunicaciones de la Guardia Costera, convencido de que fuerzas ocultas gobiernan el mundo.', NULL),
(98, 24, 'Boobie Ike', 'Figura de Poder', 'Vice City', 'Un antiguo callejero convertido en magnate. Ha construido un imperio legal basado en bienes raíces y un estudio de grabación. Encantador en la superficie, letal en los negocios.', NULL),
(99, 24, 'Dre\'Quan Priest', 'Empresario / Aliado', 'Vice City', 'Protegido de Boobie, pasó de vender droga a fundar Only Raw Records. Ambicioso y con una visión marcada por la cultura callejera y el sueño del estrellato musical.', NULL),
(100, 24, 'Bae-Luxe', 'Estrella Emergente (Real Dimez)', 'Vice City', 'Mitad del dúo viral Real Dimez. Con su carisma en redes y estilo agresivo en el rap, pasó de estafar a ser una estrella en ascenso en la escena musical de Vice City.', NULL),
(101, 24, 'Roxy', 'Estrella Emergente (Real Dimez)', 'Vice City', 'La otra mitad del dúo Real Dimez. Junto a Bae-Luxe, representa la nueva cara cultural de Vice City, firmada por el sello de Dre\'Quan.', NULL),
(102, 24, 'Raul Bautista', 'Criminal Veterano', 'Leonida', 'Un experto en robos de bancos, elegante y calculador. Busca jóvenes con agallas para formar el golpe perfecto. Su experiencia es tan valiosa como peligrosa.', NULL),
(103, 24, 'Brian Heder', 'Contrabandista', 'Cayos de Leonida', 'Un viejo contrabandista, figura legendaria en el tráfico marítimo. Vive como un jubilado despreocupado, pero sigue moviendo producto desde su astillero.', NULL),
(104, 24, 'Jefe de Policía de Vice City', 'Antagonista', 'Vice City', 'La máxima autoridad policial, encargada de perseguir y desmantelar las redes criminales de la ciudad. Su implacable persecución pondrá a prueba a Lucía y Jason.', NULL),
(105, 14, 'Theo', 'Aliado / Co-protagonista', 'Sendero de la Montaña (y redes sociales)', 'Un joven fotógrafo y viajero de Seattle que se encuentra con Madeline en varios puntos del ascenso. Theo es un espíritu libre, siempre con su teléfono en mano para documentar su viaje en \"Instapix\" y con una actitud relajada que choca con la intensidad de Madeline. A pesar de su apariencia despreocupada, Theo oculta sus propias presiones familiares y dudas sobre su futuro. En el capítulo del Templo del Espejo, se convierte en una pieza clave de la jugabilidad cuando Madeline debe rescatarlo del interior de un cristal, simbolizando cómo la amistad y la confianza mutua pueden ayudar a superar las pruebas más oscuras de la mente.', 'pj_1778511509.png'),
(106, 9, 'Rathian', 'Monstruo', 'Bosque Primigenio', 'La Reina de la Tierra, una wyvern voladora que patrulla su territorio con una ferocidad implacable. Su cola venenosa y sus bolas de fuego la convierten en una oponente letal para cazadores novatos.', NULL),
(107, 9, 'Diablos', 'Monstruo', 'Desierto de los Alientos', 'Un wyvern excavador ciego, pero increíblemente agresivo. Sus cuernos pueden perforar la coraza más dura y su carga subterránea es una de las embestidas más temidas del Nuevo Mundo.', NULL),
(108, 9, 'Teostra', 'Dragón Anciano', 'Valle de los Efluvios', 'El Emperador de las Llamas, un dragón anciano que controla el polvo explosivo. Su presencia convierte el campo de batalla en un infierno de llamas y detonaciones.', NULL),
(109, 9, 'Lunastra', 'Dragón Anciano', 'Valle de los Efluvios', 'La Emperatriz Azul, consorte de Teostra. Su fuego es aún más intenso y su vínculo con Teostra la hace invocar una devastadora técnica de unión cuando ambos están presentes.', NULL),
(110, 9, 'Kushala Daora', 'Dragón Anciano', 'Nido de Dragones', 'El Dragón de Acero, una bestia metálica que controla los vientos y las tormentas. Su cuerpo está envuelto en un aura de viento que repele los ataques a distancia.', NULL),
(111, 9, 'Vaal Hazak', 'Dragón Anciano', 'Valle de los Efluvios', 'El Viejo Dragón, un ser cubierto de una niebla putrefacta que drena la vida de todo lo que toca. Su efluvio es letal sin la protección adecuada.', NULL),
(112, 9, 'Xeno\'jiiva', 'Dragón Anciano', 'Nido de la Creación', 'El Emperador Dragón de la Creación, una criatura recién nacida de pura energía. Su cuerpo cristalino absorbe la bioenergía del entorno para desatar ataques láser de inmenso poder.', NULL),
(113, 9, 'Kulve Taroth', 'Dragón Anciano', 'Cañón de Kulve Taroth', 'La Diosa de la Fortuna, una dragona dorada que porta un manto de oro puro. Su asedio es una misión cooperativa donde dieciséis cazadores deben romper sus defensas para obtener sus tesoros.', NULL),
(114, 9, 'Deviljho', 'Wyvern Brutal', 'Todos los mapas', 'El Wyvern Voraz, una máquina de destrucción que devora todo a su paso. Su hambre insaciable lo vuelve más agresivo y peligroso cuanto más lucha.', NULL),
(115, 9, 'Rajang', 'Bestia Colmilluda', 'Nido de Dragones', 'El Rey de las Bestias, un primate gigante que ataca con una furia incontrolable. Al entrar en modo furia, su cuerpo se vuelve dorado y su poder ofensivo se dispara a niveles legendarios.', NULL),
(116, 10, 'Zeus', 'Dios del Olimpo', 'Olimpo', 'El Rey de los Dioses, que ofrece su poder a Zagreo en forma de rayos devastadores. Su orgullo es tan inmenso como el cielo mismo, pero reconoce el potencial del joven dios del inframundo.', NULL),
(117, 10, 'Poseidón', 'Dios del Olimpo', 'Olimpo', 'El Dios de los Mares, que otorga a Zagreo el poder de las olas para arrastrar a sus enemigos. Su actitud es relajada y un tanto despreocupada.', NULL),
(118, 10, 'Afrodita', 'Diosa del Olimpo', 'Olimpo', 'La Diosa del Amor, que debilita a los enemigos con su hechizo y otorga a Zagreo un poder encantador. Su influencia es sutil pero letal.', NULL),
(119, 10, 'Dionisio', 'Dios del Olimpo', 'Olimpo', 'El Dios del Vino y el Éxtasis, que maldice a los enemigos con resaca y confusión. Su estilo de combate es festivo y caótico.', NULL),
(120, 10, 'Megaera', 'Furia', 'Inframundo', 'La Primera Furia, una de las hermanas que castigan a Zagreo en su intento de fuga. Su látigo y sus alas de mariposa la convierten en una oponente formidable.', NULL),
(121, 10, 'Tisífone', 'Furia', 'Inframundo', 'La Segunda Furia, una criatura vengativa que atormenta a Zagreo con su magia oscura y su risa enloquecedora.', NULL),
(122, 10, 'Caronte', 'Barquero del Inframundo', 'Río Estigia', 'El enigmático barquero que transporta las almas a través del río Estigia. Aunque taciturno, acepta las ofrendas de Zagreo para intercambiar objetos valiosos.', NULL),
(123, 10, 'Eurídice', 'Aliada / Ninfa', 'Asfódelo', 'La esposa de Orfeo, atrapada en el inframundo por un trágico destino. Su canto alivia las penas de los viajeros y ofrece poderosas mejoras a Zagreo.', NULL),
(124, 10, 'Patroclo', 'Aliado / Guerrero', 'Elíseo', 'El amante de Aquiles, un espíritu que reside en los campos del Elíseo. Se enfrentó a Zagreo como campeón y ahora le ofrece ayuda en su viaje.', NULL),
(125, 10, 'Skelly', 'Aliado / Esqueleto', 'Inframundo', 'Un esqueleto parlante y sarcástico que sirve como saco de entrenamiento para Zagreo. Siempre está dispuesto a recibir una paliza a cambio de un poco de conversación.', NULL),
(126, 11, 'Quirrel', 'Aliado / Viajero', 'Dirtmouth', 'Un viajero enmascarado que explora las ruinas de Hallownest con una curiosidad insaciable. Porta la espada del Soñador y protege al Caballero en momentos clave de su viaje.', NULL),
(127, 11, 'Zote el Poderoso', 'Aliado / Fanfarrón', 'Dirtmouth', 'Un guerrero incompetente y cobarde que se cree el mejor espadachín del reino. Aparece en múltiples lugares, siempre metido en problemas que el Caballero debe resolver.', NULL),
(128, 11, 'La Dama Blanca', 'Aliada / Reina de Hallownest', 'Jardín de la Reina', 'La esposa del Rey Pálido y madre de los Caballeros. Vive recluida en sus jardines, atormentada por la culpa y la pérdida de su reino.', NULL),
(129, 11, 'El Rey Pálido', 'Antagonista', 'Palacio Blanco', 'El soberano de Hallownest, un ser de luz que intentó expandir su reino de forma artificial, provocando la ruina de su civilización. Su voluntad quedó sellada en los sueños de los Soñadores.', NULL),
(130, 11, 'El Herrero', 'Aliado / Herrero', 'Filo del Reino', 'Un herrero experto en la forja de aguijones que mejora el arma del Caballero a cambio de minerales de paleón. Su conocimiento de la forja es legendario.', NULL),
(131, 11, 'La Cazadora (Hornet)', 'Aliada / Protectora', 'Nido Profundo', 'La protectora de Hallownest y rival del Caballero. Con su aguijón y su agilidad, pone a prueba al protagonista en varias ocasiones para asegurarse de que es digno de salvar el reino.', NULL),
(132, 14, 'Sr. Oshiro', 'Antagonista Trágico / Jefe de Zona', 'Resort Celestial (Capítulo 3)', 'El antiguo y perfeccionista dueño del \"Resort Celestial\", ahora convertido en un fantasma incapaz de abandonar su puesto. Oshiro es la personificación de la negación y el apego al pasado; se niega a aceptar que su hotel es una ruina llena de polvo y sombras. Aunque inicialmente se muestra hospitalario y servicial con Madeline, su inestabilidad emocional lo convierte en una amenaza física cuando su frustración estalla. Su arco argumental es un reflejo de lo que ocurre cuando alguien se queda atrapado en sus propios traumas y se niega a dejar ir lo que ya no existe, convirtiendo su propio refugio en una prisión de rencor.', 'pj_1778515665.png'),
(134, 14, 'El Pájaro (El Cuervo de la Montaña)', 'Guía / Mentor Espiritual', 'Aparece en momentos clave de todos los capítulos.', 'Una misteriosa y majestuosa ave de plumaje oscuro y ojos brillantes que parece observar el progreso de Madeline desde las sombras. Actúa como un mentor silencioso, apareciendo en los momentos de mayor duda para mostrar el camino, enseñar nuevas mecánicas (como el uso de las Plumas Doradas) o simplemente para recordar al escalador que no está solo. En el capítulo final, Farewell, el Pájaro se convierte en el núcleo emocional de la historia, representando el vínculo con la memoria de la Anciana y guiando a Madeline a través del proceso del duelo. Su presencia es un símbolo de libertad y de la capacidad de elevarse por encima de los propios miedos.', 'pj_1778515489.png'),
(135, 14, 'La Anciana (Granny)', 'Mentora / Guardiana de la Montaña', 'Cabaña al inicio del ascenso y puntos estratégicos del camino', 'Una mujer de edad avanzada, risa burlona y sabiduría profunda que vive en la base de la montaña Celeste. A pesar de su apariencia frágil, Granny posee un conocimiento absoluto sobre los secretos y peligros psicológicos de la montaña. Actúa como una guía cínica pero cariñosa para Madeline, a quien suele desafiar con comentarios sarcásticos para obligarla a confrontar sus propias inseguridades. Ella es la única que no parece inmutarse ante las manifestaciones de Badeline, tratándolas con la naturalidad de quien ya ha librado sus propias batallas internas. Su presencia es un recordatorio de que la montaña no se conquista con fuerza, sino con aceptación y humor ante la adversidad.', 'pj_1778515593.png'),
(136, 13, 'Hornet', 'Protagonista', 'Pharloom', 'La princesa protectora de Hallownest, hija del Rey Pálido y Herrah la Bestia. Capturada y llevada a Pharloom, debe abrirse paso a través de este reino desconocido usando su aguja, sus habilidades de seda y su astucia. Letal, ágil y determinada, Hornet es una cazadora nata que no descansará hasta descubrir los secretos de este nuevo mundo y encontrar el camino de vuelta a casa.', NULL),
(137, 13, 'Lace', 'Antagonista / Rival', 'Múltiples ubicaciones', 'Una guerrera de Pharloom armada con un alfiler de combate que sirve como némesis de Hornet. Elegante, rápida y letal, Lace es un espejo oscuro de la protagonista. Aparece en varios momentos del juego, desafiando a Hornet en combates cada vez más intensos que ponen a prueba las habilidades del jugador.', NULL),
(138, 13, 'Sherma', 'Aliado / Vagabundo', 'Borde del Reino', 'Un viajero encapuchado que recorre Pharloom con un caparazón agrietado y una actitud sabia y tranquila. Ofrece consejos a Hornet sobre las distintas regiones del reino y parece conocer más de lo que aparenta. Sus encuentros con la protagonista revelan lentamente fragmentos de la historia de Pharloom.', NULL),
(139, 13, 'Maestro de Agujas Plinney', 'Aliado / Herrero', 'Corazón de la Campana', 'Un anciano artesano de Pharloom, experto en la forja y reparación de agujas. Es el equivalente al Herrero de Hallownest: puede mejorar el arma de Hornet hasta cuatro niveles utilizando Aceite Pálido, un recurso escaso que se encuentra explorando el mapa.', NULL),
(140, 13, 'Eva', 'Aliada / Guía', 'Senda del Cazador', 'Una habitante de Pharloom que encuentra a Hornet al inicio de su viaje. Es quien le entrega la Cresta del Cazador y le enseña los conceptos básicos de supervivencia en el nuevo reino. Su paradero posterior es incierto, pero sus enseñanzas acompañan a Hornet durante toda la aventura.', NULL),
(141, 13, 'Shakra', 'Comerciante', 'Itinerante', 'Una comerciante nómada que viaja por todo Pharloom ofreciendo bienes raros a cambio de Rosarios, la moneda del reino. Tiene un carisma peculiar y siempre parece saber qué necesita Hornet antes de que ella misma lo sepa.', NULL),
(142, 13, 'Bell Beast', 'Jefe (Acto 1)', 'El Tuétano', 'Una bestia enorme que emerge de las profundidades cuando suena la campana del Tuétano. Su cuerpo está cubierto de un denso pelaje negro y ataca usando el badajo de la campana como arma contundente. Es uno de los primeros jefes obligatorios que pone a prueba la capacidad de esquiva de Hornet.', NULL),
(143, 13, 'Moss Mother', 'Jefe (Acto 1)', 'Gruta de Musgo', 'Una criatura ancestral que habita en las cuevas más profundas de la Gruta de Musgo. Su cuerpo está fusionado con el musgo y las raíces del entorno, lo que le permite camuflarse y atacar con zarcillos desde múltiples direcciones. Es el primer gran desafío de Hornet en Pharloom.', NULL),
(144, 13, 'The Last Judge', 'Jefe (Acto 1)', 'Escalones Devastados', 'Un ser imponente que actúa como guardián de los Escalones Devastados. Su diseño recuerda a un verdugo ancestral, con una gran máscara y ataques pesados que castigan los errores del jugador con daño masivo. Es el último jefe obligatorio del primer acto.', NULL),
(145, 13, 'Chamanes Caracol', 'NPCs / Místicos', 'Capilla en Ruinas', 'Tres hermanos caracol —la Doncella de la Capilla, el Cuidador y el Ermitaño de la Campana— que llegaron a la Capilla en Ruinas tras el colapso de Pharloom. Son fundamentales para la progresión del Acto 3 y ofrecen pistas sobre el destino del reino y el origen de la seda que da nombre al juego.', NULL);

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
(1, 'admin', 'admin@codex.com', '$2y$10$.lcZx/nYYiigptnDuhgELuVDhUzm0BDs2/yUbzS1cMgt2qyBUQTze', 'Administrador', 0, '#2#', '2026-05-12 14:29:18', 1, NULL, 'avatar_1_1777879973.jpg', 'Me llamo Manuel Acevedo y soy el Admin de Next Level Code.', 'es', 0),
(2, 'editor', 'editor@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Editor de Contenido', 1, '#1##5#', '2026-05-12 13:53:46', 0, NULL, 'default.jpg', 'Editor de Next Level Code, cuyo superior es el Admin.', 'es', 0),
(3, 'user', 'user@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Dani', 1, NULL, '2026-05-11 17:20:24', 0, NULL, 'default.jpg', NULL, 'es', 0),
(5, 'nora', 'nora@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Nora', 1, '#2#', '2026-05-12 13:39:15', 0, NULL, 'default.jpg', 'Exploradora de mundos abiertos y amante de los RPG.', 'es', 0),
(6, 'ivan', 'ivan@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Iván', 1, NULL, NULL, 0, NULL, 'default.jpg', 'Fan de los juegos de estrategia y los combates tácticos.', 'es', 0),
(7, 'pedro', 'pedro@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Pedro', 1, NULL, '2026-05-12 13:43:40', 0, NULL, 'default.jpg', 'Coleccionista de logros y cazador de secretos en videojuegos.', 'es', 0);

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
(20, 14, 3, 5, '2026-05-05 17:53:16'),
(21, 22, 1, 5, '2026-05-07 14:16:18'),
(22, 19, 5, 4, '2026-05-07 18:08:19'),
(23, 19, 7, 5, '2026-05-11 16:34:23'),
(24, 13, 3, 4, '2026-05-11 17:23:34'),
(25, 21, 1, 5, '2026-05-12 10:31:44'),
(26, 15, 1, 5, '2026-05-12 10:32:17'),
(27, 19, 1, 4, '2026-05-12 13:20:35');

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
(71, 15, 1, '2026-05-07 11:22:00'),
(72, 19, 1, '2026-05-07 12:13:26'),
(73, 20, 1, '2026-05-07 12:18:32'),
(74, 21, 1, '2026-05-07 12:36:25'),
(75, 22, 1, '2026-05-07 13:04:59'),
(76, 22, 1, '2026-05-07 13:06:51'),
(77, 22, 1, '2026-05-07 13:06:56'),
(78, 22, 1, '2026-05-07 13:18:43'),
(79, 22, 1, '2026-05-07 13:21:01'),
(80, 22, 1, '2026-05-07 13:22:05'),
(81, 22, 1, '2026-05-07 13:27:02'),
(82, 22, 1, '2026-05-07 13:30:41'),
(83, 15, 1, '2026-05-07 13:32:50'),
(84, 15, 1, '2026-05-07 13:33:22'),
(85, 23, 1, '2026-05-07 14:06:29'),
(86, 23, 1, '2026-05-07 14:11:41'),
(87, 24, 1, '2026-05-07 14:11:44'),
(88, 22, 1, '2026-05-07 14:14:55'),
(89, 22, 7, '2026-05-07 14:19:05'),
(90, 24, 7, '2026-05-07 14:19:09'),
(91, 22, 7, '2026-05-07 15:06:25'),
(92, 24, 7, '2026-05-07 15:06:30'),
(93, 21, 7, '2026-05-07 15:06:33'),
(94, 20, 7, '2026-05-07 15:06:37'),
(95, 19, 7, '2026-05-07 15:06:40'),
(96, 17, 7, '2026-05-07 15:06:46'),
(97, 9, 7, '2026-05-07 15:06:53'),
(98, 12, 7, '2026-05-07 15:07:23'),
(99, 22, 5, '2026-05-07 18:05:15'),
(100, 21, 5, '2026-05-07 18:05:56'),
(101, 15, 5, '2026-05-07 18:06:29'),
(102, 19, 5, '2026-05-07 18:08:18'),
(103, 10, 1, '2026-05-07 18:10:00'),
(104, 11, 1, '2026-05-07 18:11:34'),
(105, 22, 1, '2026-05-07 18:16:29'),
(106, 9, 1, '2026-05-07 18:16:53'),
(107, 24, 1, '2026-05-11 09:58:22'),
(108, 23, 1, '2026-05-11 09:58:40'),
(109, 12, 1, '2026-05-11 10:07:36'),
(110, 12, 1, '2026-05-11 10:11:30'),
(111, 12, 1, '2026-05-11 10:14:58'),
(112, 12, 1, '2026-05-11 10:19:35'),
(113, 12, 1, '2026-05-11 10:24:01'),
(114, 19, 1, '2026-05-11 11:24:15'),
(115, 19, 1, '2026-05-11 12:26:13'),
(116, 19, 7, '2026-05-11 12:29:15'),
(117, 19, 7, '2026-05-11 12:45:38'),
(118, 19, 7, '2026-05-11 13:05:23'),
(119, 19, 7, '2026-05-11 13:06:33'),
(120, 19, 7, '2026-05-11 13:22:42'),
(121, 19, 7, '2026-05-11 13:46:23'),
(122, 19, 7, '2026-05-11 14:30:50'),
(123, 19, 7, '2026-05-11 14:34:33'),
(124, 23, 7, '2026-05-11 14:35:25'),
(125, 19, 7, '2026-05-11 16:16:52'),
(126, 19, 7, '2026-05-11 16:33:59'),
(127, 14, 7, '2026-05-11 16:34:53'),
(128, 14, 7, '2026-05-11 16:36:10'),
(129, 14, 3, '2026-05-11 16:36:51'),
(130, 14, 3, '2026-05-11 16:38:36'),
(131, 14, 3, '2026-05-11 16:39:41'),
(132, 19, 7, '2026-05-11 16:40:07'),
(133, 19, 7, '2026-05-11 16:41:02'),
(134, 21, 3, '2026-05-11 16:59:55'),
(135, 11, 3, '2026-05-11 17:00:05'),
(136, 17, 3, '2026-05-11 17:00:19'),
(137, 9, 3, '2026-05-11 17:00:23'),
(138, 23, 3, '2026-05-11 17:00:27'),
(139, 13, 3, '2026-05-11 17:00:30'),
(140, 10, 3, '2026-05-11 17:00:37'),
(141, 24, 3, '2026-05-11 17:15:56'),
(142, 24, 3, '2026-05-11 17:16:00'),
(143, 23, 3, '2026-05-11 17:16:05'),
(144, 12, 3, '2026-05-11 17:16:14'),
(145, 19, 3, '2026-05-11 17:16:36'),
(146, 14, 3, '2026-05-11 17:16:47'),
(147, 13, 3, '2026-05-11 17:19:00'),
(148, 13, 3, '2026-05-11 17:20:40'),
(149, 13, 3, '2026-05-11 17:23:33'),
(150, 13, 3, '2026-05-11 17:23:37'),
(151, 13, 3, '2026-05-11 17:23:38'),
(152, 13, 3, '2026-05-11 17:24:16'),
(153, 19, 3, '2026-05-11 17:24:54'),
(154, 19, 7, '2026-05-11 17:27:25'),
(155, 12, 7, '2026-05-11 17:27:32'),
(156, 12, 1, '2026-05-11 17:28:19'),
(157, 12, 1, '2026-05-11 17:52:12'),
(158, 12, 1, '2026-05-11 17:53:37'),
(159, 19, 1, '2026-05-11 17:53:45'),
(160, 14, 1, '2026-05-11 17:54:09'),
(161, 14, 1, '2026-05-11 17:55:38'),
(162, 14, 1, '2026-05-11 17:55:52'),
(163, 19, 1, '2026-05-12 09:35:08'),
(164, 14, 1, '2026-05-12 09:35:18'),
(165, 21, 1, '2026-05-12 09:35:33'),
(166, 21, 1, '2026-05-12 10:10:57'),
(167, 21, 1, '2026-05-12 10:11:14'),
(168, 21, 1, '2026-05-12 10:29:39'),
(169, 21, 1, '2026-05-12 10:31:42'),
(170, 15, 1, '2026-05-12 10:32:16'),
(171, 15, 1, '2026-05-12 10:37:20'),
(172, 15, 1, '2026-05-12 10:37:57'),
(173, 15, 1, '2026-05-12 10:58:58'),
(174, 15, 1, '2026-05-12 11:03:34'),
(175, 15, 1, '2026-05-12 12:23:28'),
(176, 12, 1, '2026-05-12 13:19:12'),
(177, 19, 1, '2026-05-12 13:19:58'),
(178, 15, 1, '2026-05-12 13:21:53'),
(179, 24, 1, '2026-05-12 13:28:20'),
(180, 12, 5, '2026-05-12 13:40:52'),
(181, 23, 1, '2026-05-12 13:45:10'),
(182, 22, 1, '2026-05-12 13:45:13'),
(183, 13, 1, '2026-05-12 13:45:24'),
(184, 24, 1, '2026-05-12 14:01:35'),
(185, 21, 1, '2026-05-12 14:30:35'),
(186, 19, 1, '2026-05-12 14:30:44'),
(187, 20, 1, '2026-05-12 14:33:26');

--
-- Índices para tablas volcadas
--

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
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `elementos`
--
ALTER TABLE `elementos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- AUTO_INCREMENT de la tabla `juegos`
--
ALTER TABLE `juegos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `logros`
--
ALTER TABLE `logros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `mapas`
--
ALTER TABLE `mapas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT de la tabla `mensajes_grupales`
--
ALTER TABLE `mensajes_grupales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `mensajes_privados`
--
ALTER TABLE `mensajes_privados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `personajes`
--
ALTER TABLE `personajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `visitas_juegos`
--
ALTER TABLE `visitas_juegos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=188;

--
-- Restricciones para tablas volcadas
--

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
