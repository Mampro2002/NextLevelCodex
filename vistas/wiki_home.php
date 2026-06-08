<?php
include "../sec/bdd.php";
include "../sec/sec.php";
$paginaActiva = 'biblioteca';
$idioma = simplexml_load_file("../assets/locales/" . $_SESSION["idioma"] . ".xml");
include "../sec/header.php";

// Variables de idioma para JavaScript
$js_buscando = addslashes((string) $idioma->palabras->wiki_buscando);
$js_noJuegos = addslashes((string) $idioma->palabras->wiki_noJuegos);
$js_errorServidor = addslashes((string) $idioma->palabras->wiki_errorServidor);
$js_proximamente = addslashes((string) $idioma->palabras->ini_proximamente);
$js_verFicha = addslashes((string) $idioma->palabras->ini_verFicha);
?>

<div class="main-container">
    <h1><i class="fas fa-book"></i> <?= $idioma->palabras->header_biblioteca ?></h1>

    <!-- Buscador y filtros -->
    <div class="search-box"
        style="display: flex; gap: var(--spacing-sm); margin-bottom: var(--spacing-sm); flex-wrap: wrap;">
        <input type="text" id="queryBusqueda" class="input"
            placeholder="<?= htmlspecialchars((string) $idioma->palabras->wiki_placeholder) ?>"
            style="flex: 1; min-width: 200px;">
        <select id="filtroGenero" class="input" style="max-width: 200px;">
            <option value=""><?= $idioma->palabras->wiki_todosGeneros ?></option>
            <option value="Acción">Acción</option>
            <option value="Acción/Aventura">Acción/Aventura</option>
            <option value="Aventura">Aventura</option>
            <option value="Aventura Gráfica">Aventura Gráfica</option>
            <option value="Battle Royale">Battle Royale</option>
            <option value="Cartas">Cartas</option>
            <option value="Carreras">Carreras</option>
            <option value="Deportes">Deportes</option>
            <option value="Estrategia">Estrategia</option>
            <option value="Estrategia por Turnos">Estrategia por Turnos</option>
            <option value="Gestión/Simulación">Gestión/Simulación</option>
            <option value="Horror">Horror</option>
            <option value="Lucha">Lucha</option>
            <option value="Metroidvania">Metroidvania</option>
            <option value="MMO">MMO</option>
            <option value="Mundo Abierto">Mundo Abierto</option>
            <option value="Musical/Ritmo">Musical/Ritmo</option>
            <option value="Novela Visual">Novela Visual</option>
            <option value="Plataformas">Plataformas</option>
            <option value="Puzles">Puzles</option>
            <option value="Roguelike/Roguelite">Roguelike/Roguelite</option>
            <option value="RPG">RPG</option>
            <option value="RPG de Acción">RPG de Acción</option>
            <option value="Sandbox">Sandbox</option>
            <option value="Shooter">Shooter</option>
            <option value="Sigilo">Sigilo</option>
            <option value="Simulación">Simulación</option>
            <option value="Soulslike">Soulslike</option>
            <option value="Supervivencia">Supervivencia</option>
            <option value="Terror Psicológico">Terror Psicológico</option>
            <option value="Visual Novel">Visual Novel</option>
        </select>
        <input type="text" id="filtroDesarrollador" class="input"
            placeholder="<?= htmlspecialchars((string) $idioma->palabras->wiki_placeholderDev) ?>"
            style="max-width: 200px;">
        <input type="number" id="filtroAnyo" class="input"
            placeholder="<?= htmlspecialchars((string) $idioma->palabras->wiki_placeholderAnyo) ?>"
            style="max-width: 110px;" min="1970" max="2030">
        <button class="btn btn-primary" id="ejecutarBusqueda">
            <i class="fas fa-search"></i> <?= $idioma->palabras->amgB ?>
        </button>
    </div>

    <!-- Estado de carga -->
    <div id="status-busqueda" style="margin-bottom: var(--spacing-md);"></div>

    <!-- Tabla de resultados -->
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th><?= $idioma->palabras->wiki_th1 ?></th>
                    <th><?= $idioma->palabras->wiki_th2 ?></th>
                    <th><?= $idioma->palabras->wiki_th3 ?></th>
                    <th><?= $idioma->palabras->wiki_th4 ?></th>
                    <th><?= $idioma->palabras->wiki_th5 ?></th>
                </tr>
            </thead>
            <tbody id="cuerpoResultados"></tbody>
        </table>
    </div>
</div>

<?php include "../sec/footer.php"; ?>

<script>
    const lang = {
        buscando: '<?= $js_buscando ?>',
        noJuegos: '<?= $js_noJuegos ?>',
        errorServidor: '<?= $js_errorServidor ?>',
        proximamente: '<?= $js_proximamente ?>',
        verFicha: '<?= $js_verFicha ?>'
    };

    // Buscar juegos al hacer clic o al presionar Enter
    $("#ejecutarBusqueda").click(buscarJuegos);
    $("#queryBusqueda").keypress(function (e) {
        if (e.which == 13) buscarJuegos();
    });

    function buscarJuegos() {
        let texto = $("#queryBusqueda").val().trim();
        let genero = $("#filtroGenero").val();
        let desarrollador = encodeURIComponent($("#filtroDesarrollador").val().trim());
        let anyo = $("#filtroAnyo").val();

        $("#status-busqueda").html('<p class="text-muted"><i class="fas fa-spinner fa-spin"></i> ' + lang.buscando + '</p>');
        $("#cuerpoResultados").empty();

        $.ajax({
            type: "post",
            url: "../controladores/controlador_wiki.php",
            data: {
                opt: 1,
                query: texto,
                genero: genero,
                desarrollador: decodeURIComponent(desarrollador),
                anyo: anyo
            },
            dataType: "json",
            success: function (data) {
                $("#status-busqueda").empty();
                if (data.length > 0) {
                    let html = "";
                    $.each(data, function (i, juego) {
                        // Construir estrellas según media
                        let estrellasHTML = '';
                        if (juego.media !== undefined && juego.media !== null && juego.total > 0) {
                            for (let i = 1; i <= 5; i++) {
                                estrellasHTML += (i <= Math.round(parseFloat(juego.media)))
                                    ? '<i class="fas fa-star" style="color: var(--warning);"></i>'
                                    : '<i class="far fa-star" style="color: var(--warning);"></i>';
                            }
                            estrellasHTML += ` <span style="font-size:13px; color:var(--text-secondary);">${parseFloat(juego.media).toFixed(1)} (${juego.total})</span>`;
                        } else {
                            estrellasHTML = '<span class="text-muted">-</span>';
                        }

                        html += `<tr>
                            <td><strong>${juego.titulo}</strong></td>
                            <td>${juego.desarrollador || '-'}</td>
                            <td>${(juego.en_desarrollo == 1)
                                ? `<span class="badge" style="background: var(--warning); color: #000;">${lang.proximamente}</span>`
                                : (juego.fecha_lanzamiento || '-')}</td>
                            <td>${estrellasHTML}</td>
                            <td><a href="ficha_juego.php?id=${juego.id}" class="btn btn-sm btn-primary">${lang.verFicha}</a></td>
                        </tr>`;
                    });
                    $("#cuerpoResultados").html(html);
                } else {
                    $("#cuerpoResultados").html(`<tr><td colspan="6" class="text-muted" style="text-align: center;">${lang.noJuegos}</td></tr>`);
                }
            },
            error: function () {
                $("#status-busqueda").html(`<p class="text-danger">${lang.errorServidor}</p>`);
            }
        });
    }
</script>