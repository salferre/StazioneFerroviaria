var stazioni = {};

$(document).ready(function() {

    $.get("admin", function(responseJson) {
        stazioni = responseJson;
        appendStazioniToSelect(stazionePartenza);
        appendStazioniToSelect(stazioneArrivo);
    });

    $(forms).children('div').each(function () {
        $(this).hide();
    });

});

toggleFunctions();

function toggleFunctions() {
    $(buttons).children('button').each(function () {
        $(this).click(function () {
            form = $(this).attr('id').split('-')[0]+'-form';
            closeOthers(form);
            form = '#'+form;
            $(form).toggle();
        });
    });
}

function validateForm() {
    alert("Name must be filled out");
    return false;
}

function appendStazioniToSelect(selectId) {
    $.each(stazioni, function(index, category) {
        $("<option>").val(category.nomeStazione).text(category.nomeStazione).appendTo(selectId);
    });
}

var idSelect = 0;

function addStazioneIntermedia() {
    if(idSelect < 8){
        var select = document.createElement("select");
        select.id = "tappaIntermedia"+idSelect;
        select.name = "tappaIntermedia"+idSelect;
        idSelect++;
        select.innerHTML = '<option disabled selected value> -- Seleziona una stazione -- </option>';

        var label = document.createElement("label");
        label.setAttribute("for", select.id);
        label.innerHTML = "Stazione Intermedia " + idSelect + ": ";

        var br = document.createElement("br");
        var br2 = document.createElement("br");

        document.getElementById("scali").appendChild(label);
        document.getElementById("scali").appendChild(select);
        document.getElementById("scali").appendChild(br);
        document.getElementById("scali").appendChild(br2);

        appendStazioniToSelect(select);
    }
}

function closeOthers(nonChiudere) {
    $(forms).children('div').each(function () {
        if($(this).is(":visible") && $(this).attr('id') != nonChiudere){
            $(this).hide();
        }
    });
}
