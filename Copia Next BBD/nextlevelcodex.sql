-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-05-2026 a las 15:12:17
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
(21, 12, 'Joker Sonriente', 'Carta Joker', '+4 Mult', 'Común', 'Común', NULL, NULL),
(22, 12, 'Excursionista', 'Carta', '+5 Fichas', 'Por cada Carta Jugada', 'Raro', '', 'elem_1778140174.png'),
(23, 12, 'Joker Místico', 'Carta Joker', 'x2 Mult', 'Al descartar', 'Épico', NULL, NULL),
(24, 12, 'Joker Invisible', 'Carta Joker', 'Copia Joker', 'Aleatorio', 'Legendario', NULL, NULL),
(25, 12, 'Joker del Trueno', 'Carta Joker', '+50 Fichas', 'Al jugar corazón', 'Raro', NULL, NULL),
(26, 14, 'Fresa Alada', 'Coleccionable', '1000', 'Puntos', 'Raro', '', NULL),
(27, 14, 'Cristal Azul', 'Objeto de Historia', '0', 'Desbloquea final B', 'Raro', '', NULL),
(28, 14, 'Pluma Dorada', 'Objeto de Historia', '0', 'Desbloquea final C', 'Épico', '', NULL),
(29, 15, 'Río de Sangre', 'Katana', '76', 'Sangrado (50)', 'Legendario', 'Katana maldita del espadachín Okina, infunde pérdida de sangre.', NULL),
(30, 15, 'Espada de la Noche y la Llama', 'Arma', '115', 'Escalado de Fe e Inteligencia', 'Legendario', 'Espada mitológica y tesoro de la mansión de los Caria.\r\nEs una de las armas legendarias.\r\n\r\nLos astrólogos que precedieron a los hechiceros se establecieron en lo alto de las montañas más elevadas, las que casi tocaban el cielo, y consideraban a los gigantes de fuego como sus vecinos.\r\n\r\nHabilidad: Combate igneocturno\r\nNo alces ni bajes la espada y prepárate para lanzar un hechizo. Acompáñala con un ataque normal para lanzar el hechizo del dardo nocturno, o bien con un ataque potente para incendiar la zona situada frente a ti en un movimiento de barrido.', 'elem_1778145674.png'),
(31, 15, 'Hoja Blasfema', 'Arma', '145', 'Robo de vida', 'Legendario', 'Es el arma sagrada de Rykard, Señor de la Blasfemia. Se trata de un espadón cuya superficie está cubierta por los restos de los innumerables héroes que el señor devoró, los cuales se retuercen sobre el metal compartiendo ahora la misma sangre como una \"familia\".\r\n\r\nAl activar su ceniza de guerra única, el jugador alza la espada para envolverla en llamas blasfemas y luego la baja para lanzar una ráfaga de fuego frontal. Esta ráfaga no solo inflige daño masivo, sino que absorbe PS de los enemigos alcanzados, lo que permite recuperar vida rápidamente durante el combate.', 'elem_1778146190.png'),
(33, 15, 'Espadón de la luna negra', 'Arma', '130', 'Magia de hielo', 'Legendario', 'Espadón de la luna otorgado por las reinas carianas a sus cónyuges según una longeva tradición.\r\nUna de las armas legendarias.\r\n\r\nEl sello de Ranni es una luna llena, fría y plúmbea, y esta espada es un haz de su luz.\r\n\r\nHabilidad única: Espadón de luz lunar\r\nAlza la espada por encima de tu cabeza para bañarla en la luz de la luna negra.\r\nAumenta temporalmente la potencia de ataque mágico e imbuye la hoja en congelación.\r\nLos ataques cargados liberan ráfagas de luz lunar.', 'elem_1778145456.png'),
(34, 15, 'Lanza Sagrada de Mohgwyn', 'Gran lanza', '120', 'Sangrado (70)', 'Legendario', 'Lanza del Señor de la Sangre. Realiza un ritual que inflige pérdida de sangre masiva.', NULL),
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
(49, 19, 'Espada Mano de Cazadora', 'Espada Larga', '2d6+3', 'Velocidad de Ataque +1', 'Muy Rara', 'Forjada en los talleres de los Cazadores Élite de Baldur\'s Gate, esta hoja plateada lleva grabada la marca de cien bestias abatidas. Otorga ventaja en tiradas de ataque contra enemigos de tipo monstruo y permite lanzar «Marca del Cazador» sin gastar espacio de hechizo una vez por descanso largo.', NULL),
(50, 19, 'Espadón del Señor del Caos', 'Espadón', '2d6+2', 'Daño de fuego 1d6', 'Rara', 'Un espadón de dos manos impregnado de la esencia caótica de los planos exteriores. Cada golpe tiene un 10 % de probabilidad de liberar una descarga de energía aleatoria —hielo, ácido, trueno o fuego— que sacude al objetivo en un radio de 1,5 metros.', NULL),
(51, 19, 'Vara de los Semidioses', 'Bastón Mágico', '1d6+4', 'Concentración de hechizos +2', 'Legendaria', 'Un bastón que perteneció a un semidiós olvidado de Faerûn. Amplifica todos los hechizos de conjuración: los hechizos lanzados con este bastón ignoran la resistencia al daño de criatura una vez por turno, y su portador puede lanzar «Deseo» como acción de bonificación una vez por descanso largo.', NULL),
(52, 19, 'Arco de la Noche Eterna', 'Arco Largo', '1d8+3', 'Daño psíquico 1d4', 'Muy Rara', 'Tallado en madera de árbol umbral regada con sangre de ilusionista drow. Las flechas disparadas con este arco atraviesan la oscuridad sin penalización y aplican «Aterrorizado» al objetivo si falla una tirada de salvación de Sabiduría CD 15. Perfecto para los rangers que prefieren las sombras a la luz.', NULL),
(53, 19, 'Escudo de los Tres Juramentos', 'Escudo', '+3 CA', 'Resistencia al daño necrótico', 'Muy Rara', 'Escudo de mithral grabado con los tres juramentos de los Paladines de Tyr. Mientras el portador mantenga al menos un Juramento activo, obtiene resistencia al daño necrótico y puede reaccionar una vez por turno para reducir a cero el daño de un ataque crítico recibido.', NULL),
(54, 19, 'Daga de la Tejedora de Sombras', 'Daga', '1d4+4', 'Veneno (Cegado) 1d6', 'Muy Rara', 'Una daga de obsidiana que emana una neblina de sombras al ser desenvainada. Los ataques con ella desde posición de ocultamiento infligen 2d6 adicionales de daño psíquico y no rompen la invisibilidad del portador si el objetivo muere. Arma favorita de los Asesinos del Culto de la Araña.', NULL),
(55, 19, 'Amuleto de Salud del Gran Druida', 'Amuleto', 'Constitución 19', 'Regeneración 2 PG/turno', 'Rara', 'Tallado en madera de roble por el Gran Druida del Bosque de Silvanus. Fija la Constitución del portador en 19 sin importar su valor base, y al inicio de cada turno en combate regenera 2 puntos de golpe siempre que el portador esté en contacto con suelo natural.', NULL),
(56, 19, 'Cetro del Intelecto de Volo', 'Cetro Mágico', '1d6+3', 'Inteligencia 18', 'Rara', 'Volo —el famoso bardo y viajero— dejó olvidado este cetro en la posada de la Aldea Devastada tras una noche de excesos. Fija la Inteligencia del portador en 18 y permite lanzar «Identificar» y «Detectar Magia» sin gastar ningún espacio de hechizo, un número ilimitado de veces.', NULL),
(57, 19, 'Hachas Gemelas del Berserker Gnoll', 'Hacha de Mano (par)', '1d6+2 c/u', 'Frenesí: +1d6 de daño cortante', 'Rara', 'Estas hachas mellizas fueron arrebatadas a un gnoll berserker en los túneles bajos del Mapa de la Costa de la Espada. Al luchar con ambas, el portador puede activar «Frenesí Gnoll» como acción de bonificación, obteniendo un ataque extra de 1d6 de daño y un nivel de Agotamiento al terminar el combate.', NULL),
(58, 19, 'Grimorio de las Tormentas Imperiales', 'Tomo / Hechizos', 'Rayo 8d6', 'Tormenta de Hielo 2d8+2d6', 'Legendaria', 'Un pesado grimorio encuadernado en piel de dragón de tormenta. Contiene los hechizos «Rayo» de nivel 8 y «Tormenta de Hielo» mejorada. Además, cuando el mago portador lanza cualquier hechizo de tormenta, puede elegir que el área de efecto sea el doble de lo normal sin gastar un espacio adicional, una vez por descanso largo.', NULL),
(59, 19, 'Armadura de Placas del Juicio Absoluto', 'Armadura Pesada', 'CA 20', 'Inmunidad al daño de veneno', 'Muy Rara', 'Armadura forjada en los hornos del Templo de Bane y bendecida por el propio Absoluto. Además de proporcionar una CA de 20, su portador no puede ser envenenado ni paralizado. Sin embargo, llevarla durante más de un descanso largo seguido inflige 1d4 de daño psíquico al inicio de cada día, pues la voluntad del Absoluto se filtra en la mente del guerrero.', NULL),
(60, 19, 'Botas del Teletransportador Fugaz', 'Botas Mágicas', 'Velocidad +3 m', 'Paso Brumoso (3/descanso)', 'Rara', 'Unas ligeras botas de cuero encontradas en el equipaje de un mago githyanki. Aumentan el movimiento base 3 metros y permiten lanzar «Paso Brumoso» hasta 3 veces por descanso corto sin usar ningún espacio de hechizo. Populares entre los pícaros de la Costa de la Espada.', NULL),
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
(71, 21, 'Malorian Arms 3516', 'Pistola de potencia', 'Recarga rápida', 'Daño de fuego', 'Legendario', 'La pistola personalizada de Johnny Silverhand. Tiene una cadencia de fuego excepcional y una animación de desenfundado única.', NULL),
(72, 21, 'Satori', 'Katana', '80', 'Prob. Crítico +15%', 'Legendario', 'La katana personal de Saburo Arasaka. Su daño base es menor, pero tiene una probabilidad de golpe crítico muy superior.', NULL),
(73, 21, 'Fénix', 'Fusil de asalto', '90', 'Cadencia y recarga mejoradas', 'Legendario', 'Un fusil de asalto fiable y potente, ideal para combates a corta y media distancia.', NULL),
(74, 21, 'Justiciero', 'Fusil de francotirador', '115', 'Silenciador y recarga rápida', 'Legendario', 'Un fusil de precisión ideal para eliminaciones sigilosas. Viene con mira de alta potencia y silenciador.', NULL),
(75, 21, 'Solucionadora', 'Subfusil', '75', 'Cargador ampliado', 'Legendario', 'Un subfusil de gran calibre con una capacidad de cargador enorme y una cadencia de fuego muy alta.', NULL),
(76, 21, 'Enviudador', 'Fusil de precisión', '125', 'Daño químico', 'Legendario', 'Un fusil tecnológico que dispara dos proyectiles e inflige daño químico, lo que envenena a los enemigos.', NULL),
(77, 21, 'Yinglong', 'Subfusil inteligente', '80', 'Daño eléctrico', 'Legendario', 'Un subfusil inteligente muy poco común. Sus balas autoguiadas infligen un potente daño eléctrico adicional.', NULL),
(78, 21, 'Doom Doom', 'Revólver', '110', '4 perdigones por disparo', 'Legendario', 'Un revólver modificado por Dum Dum. Dispara cuatro perdigones por cada bala, con alta probabilidad de desmembrar.', NULL),
(79, 21, 'Bastón de Cóctel', 'Arma', '70', 'Daño crítico aumentado', 'Legendario', 'Una katana reservada para los clientes VIP de \"Nubes\". El daño que inflige con golpes críticos es devastador.', 'elem_1778150338.png'),
(80, 21, 'Prueba de Fuego', 'Fusil de precisión', '130', 'Efecto de quemadura', 'Legendario', 'Una variante del fusil \"Enviudador\" que dispara munición incendiaria, aplicando un efecto de quemadura a los enemigos.', NULL),
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
(120, 24, 'Cóctel Molotov', 'Arma', '60', 'Incendia área', 'Común', 'Bomba incendiaria casera. Al impactar, crea un charco de fuego que causa daño continuo en una zona.', NULL);

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
(10, 'Hades', 'Supergiant Games', 'Supergiant Games', '2020-09-17', 'Roguelike/Roguelite', 'Escapa del inframundo en este aclamado roguelike de acción. Como Zagreo, hijo de Hades, lucharás a través de mazmorras generadas aleatoriamente con la ayuda de los dioses del Olimpo.', 'game_1778072432.png', 'map_1777997211.jpg', '', 1, '2026-05-05 17:50:24', 1, 'Armas', 1, 1, 0, ''),
(11, 'Hollow Knight', 'Team Cherry', 'Team Cherry', '2017-02-24', 'Metroidvania', 'Forja tu propio camino en Hallownest, un reino antiguo lleno de insectos extraños y secretos ocultos. Un metroidvania dibujado a mano con una atmósfera inolvidable y una jugabilidad desafiante.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/367520/Hollow_Knight/', 2, '2026-05-05 17:50:24', 1, 'Habilidad', 1, 0, 0, NULL),
(12, 'Balatro', 'LocalThunk', 'Playstack', '2024-02-20', 'Roguelike de Cartas', 'El póker se encuentra con el roguelike en este adictivo juego de construcción de mazos. Combina manos de póker con comodines especiales para superar ciegas cada vez más difíciles.', 'game_1778078491.jpg', NULL, '', 2, '2026-05-05 17:50:24', 1, 'Carta', 0, 0, 0, 'https://youtu.be/VUyP21iQ_-g?si=IW3SrkMv8NaMHeQ9'),
(13, 'Hollow Knight: Silksong', 'Team Cherry', 'Team Cherry', '2026-12-31', 'Metroidvania', 'Juega como Hornet en esta esperada secuela de Hollow Knight. Explora un nuevo reino, domina nuevas habilidades y descubre los secretos de Pharloom en esta aventura independiente.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/1030300/Hollow_Knight_Silksong/', 2, '2026-05-05 17:50:24', 0, 'Armas', 0, 0, 1, NULL),
(14, 'Celeste', 'Maddy Makes Games', 'Maddy Makes Games', '2018-01-25', 'Plataformas', 'Ayuda a Madeline a escalar la Montaña Celeste en este desafiante juego de plataformas pixel-art. Una historia emotiva sobre la superación personal, la ansiedad y la perseverancia.', 'default_game.jpg', NULL, '', 3, '2026-05-05 17:50:24', 1, 'Armas', 1, 0, 0, ''),
(15, 'Elden Ring', 'FromSoftware', 'Bandai Namco Entertainment', '2022-02-25', 'RPG de Acción', 'Levántate, Sinluz, y recorre las imponentes Tierras Intermedias para restaurar el Círculo de Elden y convertirte en el Señor del Círculo. Una aventura épica de fantasía oscura creada por Hidetaka Miyazaki y George R.R. Martin.', 'game_1778144555.png', NULL, 'https://store.steampowered.com/app/1245620/ELDEN_RING/', 5, '2026-05-07 10:57:02', 1, 'Armas', 1, 0, 0, 'https://youtu.be/CptaXqVY6-E?si=-oKFKYwWprTgTgTj'),
(17, 'The Witcher 3: Wild Hunt', 'CD Projekt Red', 'CD Projekt', '2015-05-19', 'RPG', 'Encarna a Geralt de Rivia, un cazador de monstruos a sueldo, en un mundo de fantasía oscura. Persigue a la Niña de la Profecía, Ciri, y enfréntate a la Cacería Salvaje en una aventura épica que define el destino del Continente.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/292030/The_Witcher_3_Wild_Hunt/', 5, '2026-05-07 12:00:11', 1, 'Armas', 1, 0, 0, NULL),
(19, 'Baldur\'s Gate 3', 'Larian Studios', 'Larian Studios', '2023-08-03', 'RPG de Rol', 'Reúne a tus compañeros, arma a tu grupo y explora los vastos mundos de Dungeons & Dragons en la siguiente gran aventura de la saga Baldur\'s Gate. Una magia oscura y antigua amenaza con corromper todo a su paso. Atrapados en su interior, debes dominar tu poder o ser destruido por él. La elección es tuya.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/1086940/Baldurs_Gate_3/', 7, '2026-05-07 12:12:03', 1, 'Armas', 1, 0, 0, 'https://youtu.be/s8bFzSXpDsA?si=wVNXcJJY9n6EX8pS'),
(20, 'God of War: Ragnarök', 'Santa Monica Studio', 'Sony Interactive Entertainment', '2022-11-09', 'Acción/Aventura', 'Kratos y Atreus se embarcan en un viaje a los Nueve Reinos para encontrar respuestas y detener el Ragnarök, el fin del mundo. Una épica historia de destino, guerra y redención familiar.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/2000950/God_of_War_Ragnarok/', 3, '2026-05-07 12:18:14', 1, 'Armas', 1, 0, 0, NULL),
(21, 'Cyberpunk 2077', 'CD Projekt Red', 'Bandai Namco Entertainment', '2020-12-10', 'RPG', 'Entra en la piel de V, un mercenario en busca de un implante único que ofrece la llave de la inmortalidad, en la megalópolis de Night City. Un futuro oscuro donde las megacorporaciones dictan las reglas y la línea entre la humanidad y la máquina se desdibuja.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/1091500/Cyberpunk_2077/', 6, '2026-05-07 12:26:33', 1, 'Armas', 1, 0, 0, NULL),
(22, 'Fallout 4', 'Bethesda Game Studios', 'Bethesda Softworks', '2015-11-10', 'RPG de Acción/Mundo Abierto', 'Emerge del Refugio 111 como el Único Superviviente, en un mundo post-apocalíptico asolado por la guerra nuclear. Recorre la Commonwealth de Boston, forja alianzas con facciones enfrentadas, construye asentamientos y busca a tu hijo secuestrado en una tierra yerma llena de secretos, peligros y moralidad difusa.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/377160/Fallout_4/', 1, '2026-05-07 13:04:46', 1, 'Armas', 1, 0, 0, NULL),
(23, 'Intergalactic: The Heretic Prophet', 'Naughty Dog', 'PlayStation Studios', '2027-06-15', 'Acción/Aventura', 'Ponte en la piel de Jordan A. Mun, una peligrosa cazarrecompensas interestelar, que queda varada en el remoto planeta Sempiria mientras persigue al sindicato criminal de los Cinco Ases. Un planeta aislado durante más de 600 años, lleno de robots hostiles y secretos ancestrales. La aventura espacial más ambiciosa de Naughty Dog.', 'default_game.jpg', NULL, '', 1, '2026-05-07 14:05:56', 1, 'Armas', 1, 0, 1, 'https://www.youtube.com/watch?v=Yr0J8r3x8zQ'),
(24, 'Grand Theft Auto VI', 'Rockstar Games', 'Rockstar Games', '2026-11-19', 'Acción/Aventura', 'Vuelve a Vice City y al estado de Leonida en la entrega más ambiciosa de la saga. Sigue la historia de Lucía Caminos y Jason Duval, dos criminales que buscan su lugar en el mundo mientras navegan por un submundo de drogas, poder y traiciones. La sexta entrega de la saga más vendida de todos los tiempos redefine el sandbox con un mapa masivo, multitud de personajes excéntricos y una historia oscura sobre el sueño americano.', 'default_game.jpg', NULL, 'https://store.steampowered.com/app/271590/Grand_Theft_Auto_VI/', 5, '2026-05-07 14:11:34', 1, 'Armas', 1, 0, 1, 'https://youtu.be/QdBZY2fk6bU');

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
(34, 17, 'Zoltan Chivay', 'Herrero / Enano', 'Novigrado', 'Herrero enano y amigo leal de Geralt. Veterano de guerra y miembro de la resistencia.', NULL),
(35, 19, 'Shadowheart', 'Compañera', 'Barco Náutiloide / Monasterio de la Dualidad', 'Clérigo medio-elfo de Shar, diosa de la oscuridad y los secretos. Fría y reservada, oculta un pasado traumático que ella misma ha suprimido de su memoria. Es la única del grupo capaz de retirar el parásito cerebral y su arco personal es uno de los más emocionalmente profundos del juego.', NULL),
(36, 19, 'Astarion', 'Compañero', 'Playa del Náutiloide / Vilhon Reach', 'Pícaro vampiro alto-elfo. Fue esclavo del archivampiro Cazador durante doscientos años, obligado a seducir víctimas. Ahora, con el parásito que suprime la maldición vampírica, experimenta una libertad que nunca conoció. Cáustico, encantador y profundamente roto.', NULL),
(37, 19, 'Gale', 'Compañero', 'Portal de Magia / Torre de Waterdeep', 'Mago humano de Waterdeep y antiguo favorito de Mystra, diosa de la magia. Cometió el error de intentar robar un fragmento de la Corona de Karsus, absorbiendo una «singularidad de Weave» que amenaza con destruirlo —y todo lo que le rodea— si no consume artefactos mágicos con regularidad.', NULL),
(38, 19, 'Lae\'zel', 'Compañera', 'Barco Náutiloide / Campos de Batalla de Crecia', 'Guerrera githyanki de élite, criadadesde la infancia para matar ilusionistas. Disciplinada, directa hasta la brutalidad y convencida de la supremacía githyanki. Su misión es purificarse ante la Lich-Reina Vlaakith, pero el parásito y las revelaciones del viaje cuestionan todo lo que le han enseñado.', NULL),
(39, 19, 'Wyll', 'Compañero', 'Goblin Camp / Ciudad de Baldur\'s Gate', 'El «Filo de los Fronteros», un hechicero-brujo humano famoso en la Ciudad de Baldur\'s Gate como héroe del pueblo. Hizo un pacto con la diablesa Mizora a cambio de poder suficiente para proteger a su ciudad, y ahora arrastra las consecuencias de ese trato. Un idealista atrapado entre su héroe interior y su patrona infernal.', NULL),
(40, 19, 'Karlach', 'Compañera', 'Río Chionthar / Avernus', 'Bárbara tiefling con un motor infernal incrustado en el pecho: un artefacto de Avernus que la incendia desde dentro y la condena a muerte si no encuentra la forma de repararlo. Escapó del servicio forzado de Zariel y rebosa de energía y vitalidad, aunque sabe que su tiempo podría estar contado.', NULL),
(41, 19, 'Halsin', 'Compañero Opcional', 'Campamento Goblin / Bosque Silvanus', 'Gran Druida elfo de madera del Bosque de Silvanus y líder del Campamento de los Druidas. Lleva décadas estudiando la Sombra que corrompe las Tierras Malditas. Cuando se une al grupo como compañero completo en el Acto II, aporta una perspectiva de sabio anciano y un corazón genuinamente bondadoso.', NULL),
(42, 19, 'Minthara', 'Compañera Opcional', 'Campamento Goblin / Underdark', 'Paladín drow y comandante de las fuerzas goblins al servicio del Absoluto. Solo se une al grupo en una ruta moralmente oscura. Implacable, letal y con un trasfondo de nobleza drow que explica —aunque no justifica— su crueldad. Uno de los personajes más complejos moralmente del juego.', NULL),
(43, 19, 'El Absoluto (Cazador de Ilusiones)', 'Antagonista', 'Templo del Absoluto / Ciudad de Baldur\'s Gate', 'Un antiguo Cazador de Ilusiones —la forma más poderosa de la raza de los ilusionistas— que ha sido corrompido y convertido en la encarnación del «Absoluto», un culto que controla mentes mediante parásitos cerebrales. Estratega frío e implacable, su objetivo es conquistar Faerûn comenzando por Baldur\'s Gate.', NULL),
(44, 19, 'Dame Aylin', 'Aliada / PNJ', 'Shadowfell / Ciudad de Baldur\'s Gate', 'La Doncella de la Aurora, hija inmortal de la diosa Selûne. Fue capturada por Lorroakan para ser convertida en fuente de energía. Su amor por la princesa Isobel y su inmortalidad impuesta la convierten en uno de los personajes más trágicos del Acto II, y su liberación es uno de los momentos más épicos del juego.', NULL),
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
(55, 21, 'V', 'Protagonista', 'Night City', 'Un joven mercenario que llega a Night City buscando hacerse un nombre. Su vida da un vuelco tras un trabajo fallido.', NULL),
(56, 21, 'Johnny Silverhand', 'Guía (Engrama)', 'Night City', 'Legendario rockero y terrorista anticorporativo. Su conciencia digitalizada reside ahora en el cerebro de V. Es interpretado por Keanu Reeves.', NULL),
(57, 21, 'Jackie Welles', 'Aliado (Mejor amigo)', 'Night City', 'Un mercenario leal y de buen corazón, compañero inseparable de V durante los primeros compases del juego.', NULL),
(58, 21, 'Dexter DeShawn', 'Fixer (Arreglador)', 'Night City', 'Un intermediario cínico y calculador que conecta a V y Jackie con trabajos de alto riesgo.', NULL),
(59, 21, 'Judy Álvarez', 'Aliada (Técnica de BD)', 'Night City', 'Una talentosa técnica de danza cerebral y miembro de las Mox, con un fuerte sentido de la justicia.', NULL),
(60, 21, 'Victor Vector', 'Aliado (Doctor)', 'Night City', 'Un cirujano implantes que opera en un pequeño local y es el primer \"doc\" de confianza de V.', NULL),
(61, 21, 'Panam Palmer', 'Aliada (Nómada)', 'Night City', 'Una experta conductora del Clan Aldecaldos. De carácter fuerte, independiente y leal hasta la muerte. Interés romántico de V.', NULL),
(62, 21, 'Saburo Arasaka', 'Antagonista Corporativo', 'Night City', 'El legendario y anciano fundador de la megacorporación Arasaka, dueña de un imperio global.', NULL),
(63, 21, 'Yorinobu Arasaka', 'Antagonista', 'Night City', 'El hijo pródigo de Saburo que traiciona a su padre y a la corporación, poniendo en marcha los acontecimientos del juego.', NULL),
(64, 21, 'Adam Smasher', 'Maquinaria de combate', 'Night City', 'Un imponente cíborg que ha sido el ejecutor de la corporación Arasaka durante décadas, casi indestructible.', NULL),
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
(104, 24, 'Jefe de Policía de Vice City', 'Antagonista', 'Vice City', 'La máxima autoridad policial, encargada de perseguir y desmantelar las redes criminales de la ciudad. Su implacable persecución pondrá a prueba a Lucía y Jason.', NULL);

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
(1, 'admin', 'admin@codex.com', '$2y$10$.lcZx/nYYiigptnDuhgELuVDhUzm0BDs2/yUbzS1cMgt2qyBUQTze', 'Administrador', 0, '#2#', '2026-05-07 14:06:26', 0, NULL, 'avatar_1_1777879973.jpg', 'Me llamo Manuel Acevedo y soy el Admin de Next Level Code.', 'es', 0),
(2, 'editor', 'editor@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Editor de Contenido', 1, '#1#', '2026-05-07 15:05:18', 1, NULL, 'default.jpg', 'Editor de Next Level Code, cuyo superior es el Admin.', 'es', 0),
(3, 'user', 'user@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Dani', 1, NULL, '2026-05-06 17:44:35', 0, NULL, 'default.jpg', NULL, 'es', 0),
(5, 'nora', 'nora@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Nora', 1, NULL, NULL, 0, NULL, 'default.jpg', 'Exploradora de mundos abiertos y amante de los RPG.', 'es', 0),
(6, 'ivan', 'ivan@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Iván', 1, NULL, NULL, 0, NULL, 'default.jpg', 'Fan de los juegos de estrategia y los combates tácticos.', 'es', 0),
(7, 'pedro', 'pedro@codex.com', '$2y$10$B6uMaHUm2lmgH05Awhj3.uCfdcU110VWBZnJNT0Ekwuz.JWbGdumO', 'Pedro', 1, NULL, '2026-05-07 15:05:03', 1, NULL, 'default.jpg', 'Coleccionista de logros y cazador de secretos en videojuegos.', 'es', 0);

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
(21, 22, 1, 5, '2026-05-07 14:16:18');

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
(98, 12, 7, '2026-05-07 15:07:23');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `visitas_juegos`
--
ALTER TABLE `visitas_juegos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

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
