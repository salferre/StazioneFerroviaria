var stazioni = {};
var partenze = {};
var arrivi = {};
var partenzePassivo = [];
var arriviPassivo = [];
var binari = [];
var treno = {};
var erroriJS = [];

$(document).ready(function() {

    $(pageTable).children('div').each(function () {
        if(this.id != "partenze-table"){
            $(this).hide();
        }
    });

});

toggleFunctions();

function toggleFunctions() {
    $(choiceMenu).children('button').each(function () {
        $(this).click(function () {
            table = $(this).attr('id').split('-')[0]+'-table';
            closeOthers(table);
            table = '#'+table;
            $(table).show();
        });
    });
}

function validateForm(tipoForm) {

    $(errors).empty();
    erroriJS = [];

    var numRegex = /^\d+$/;
    var dateRegex = /^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;
    var timeRegex = /^([01][0-9]|[2][0-3]):([0-5]\d)$/;

    if(!numRegex.test($('#numeroTreno'+tipoForm).val())) {
        erroriJS.push("Il numero treno può contenere solo caratteri numerici!");
    }
    if(!dateRegex.test($('#giornoPartenza'+tipoForm).val())) {
        erroriJS.push("Inserire il giorno della partenza in formato dd/mm/yyyy!");
    }
    var today = new Date();
    var giornoPartenza = new Date($('#giornoPartenza'+tipoForm).val());
    if (today < giornoPartenza){
        erroriJS.push("Il giorno della partenza deve essere posteriore o uguale alla data odierna!");
    }
    if(!timeRegex.test($('#oraPartenza'+tipoForm).val())) {
        erroriJS.push("Inserire l'ora della partenza in formato hh:mm!");
    }
    if(!numRegex.test($('#binario'+tipoForm).val())) {
        erroriJS.push("Il binario può contenere solo caratteri numerici!");
    }

    if ( erroriJS.length == 0 ){
        return true;
    }
    erroriJS.forEach(element => {
        $(errors).append(element);
    });
    return false;
}

function appendStazioniToSelect(selectId) {
    $.each(stazioni, function(index, category) {
        $("<option>").val(category.nomeStazione).text(category.nomeStazione).appendTo(selectId);
    });
}

var idSelect = 0;

function addStazioneIntermedia(tipoForm) {
    if(idSelect < 9){
        idSelect++;

        var div = document.createElement("div");
        div.id = "stazIntermedia" + idSelect;
        div.setAttribute("class", "pure-control-group")

        var select = document.createElement("select");
        select.id = "tappaIntermedia"+tipoForm+idSelect;
        select.name = "tappaIntermedia"+tipoForm;
        select.innerHTML = '<option disabled selected value> -- Seleziona una stazione -- </option>';

        var label = document.createElement("label");
        label.setAttribute("for", select.id);
        label.innerHTML = "Stazione Intermedia " + idSelect + ": ";

        var span = document.createElement("span");
        span.setAttribute("class", "pure-form-message-inline");
        span.id = "rimuovi"+idSelect;

        var img = document.createElement("img");
        img.setAttribute("src", "./img/delete.png");
        img.setAttribute("style", "width: 30px; height: 30px;");

        span.appendChild(img);

        document.getElementById("scali"+tipoForm).appendChild(div);
        div.appendChild(label);
        div.appendChild(select);
        div.appendChild(span);

        span.onclick = eliminaStazioneIntermedia;

        appendStazioniToSelect(select);
    }
}

function eliminaStazioneIntermedia() {
    var stazioneToDelete = this.id.substring(7);

    for ( i = stazioneToDelete; i < idSelect ; i++){
        k = +i +1;
        var cancellare = "stazIntermedia" + i;
        var spostare = "stazIntermedia" + k;
        $('#' + cancellare).children("select").val($('#' + spostare).children("select").val());
    }

    var canc = "stazIntermedia" + idSelect;
    $('#' + canc).remove();

    idSelect--;
}

function closeOthers(nonChiudere) {
    $(pageTable).children('div').each(function () {
        if($(this).is(":visible") && $(this).attr('id') != nonChiudere){
            $(this).hide();
        }
    });
}
