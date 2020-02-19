var stazioni = {};
var erroriJS = [];

$(document).ready(function() {

    // $.get("admin", function(responseJson) {
    //     stazioni = responseJson;
    //     appendStazioniToSelect(stazionePartenza);
    //     appendStazioniToSelect(stazioneArrivo);
    // });

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

function validateForm(tipoForm) {

    erroriJS = [];

    var numRegex = /^\d+$/;
    var dateRegex = /^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;
    var timeRegex = /^([01][0-9]|[2][0-3]):([0-5]\d)$/;

    if(!numRegex.test($('#numeroTreno').val())) {
        erroriJS.push("Il numero treno può contenere solo caratteri numerici!");
    }
    if(!dateRegex.test($('#giornoPartenza').val())) {
        erroriJS.push("Inserire il giorno della partenza in formato dd/mm/yyyy!");
    }
    if(!timeRegex.test($('#oraPartenza').val())) {
        erroriJS.push("Inserire l'ora della partenza in formato hh:mm!");
    }
    if(!numRegex.test($('#binario').val())) {
        erroriJS.push("Il binario può contenere solo caratteri numerici!");
    }

    if ( erroriJS.length == 0 ){
        return true;
    }
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
        select.name = "tappaIntermedia";
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
