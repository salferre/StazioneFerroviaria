var stazioni = {};
var partenze = {};
var arrivi = {};
var partenzePassivo = [];
var arriviPassivo = [];
var binari = [];
var treno = {};
var erroriJS = [];
var toDelete = 0;
var toUpdate = 0;
var numeroTreno = "";
var giornoPartenza = "";
var oraPartenza = "";
var binario = "";
var visualizzazione = "";
var mostrare = "";
var trainsPerPage = 7;
var trainsPerPagePassivo = 10;
var newDataAvailable = true;
var currentpartenzePage = 0;
var currentpartenzePassivoPage = -1;
var currentarriviPage = 0;
var currentarriviPassivoPage = -1;
var currentbinariPage = -1;
var arriviPassivoPages;
var arriviPages;
var partenzePassivoPages;
var partenzePages;
var binariPages;
var timeoutTime = 1000;


$(document).ready(function() {
    showView();
    $(pageTable).children('div').each(function () {
        if(this.id != "partenze-table"){
            $(this).hide();
        }
    });
});

startLoadData();

function startLoadData(){
    startDisplay();
    if(newDataAvailable){
        impostaTimeout(visualizzazione);
    }
    setTimeout("startLoadData()", timeoutTime);
}

function impostaTimeout(visualizzazione) {
    if(visualizzazione === "Admin"){
        if( partenze.length > 0 && arrivi.length > 0){
            newDataAvailable = false;
            timeoutTime = 10000;
        }
    } else if ( visualizzazione === "Arrivi" ){
        if(arrivi.length > 0){
            newDataAvailable = false;
            timeoutTime = 10000;
        }
    } else if ( visualizzazione === "Partenze" ){
        if(partenze.length > 0){
            newDataAvailable = false;
            timeoutTime = 10000;
        }
    } else if ( visualizzazione.startsWith("Binario") ){
        if(binari.length > 0){
            newDataAvailable = false;
            timeoutTime = 10000;
        }
    }
}

function startDisplay(){
    if(newDataAvailable){
        createNewPages();
        currentpartenzePassivoPage = -1;
        currentarriviPassivoPage = -1;
        currentbinariPage = -1;
        $(tablePartenze).find('tbody').empty();
        $(tablePartenze).find('tbody').html(partenzePages[currentpartenzePage]);
        $(tableArrivi).find('tbody').empty();
        $(tableArrivi).find('tbody').html(arriviPages[currentarriviPage]);
        openModalTreno();
    }

    currentpartenzePassivoPage++;
    currentarriviPassivoPage++;
    currentbinariPage++;
    currentpartenzePassivoPage = currentpartenzePassivoPage % partenzePassivoPages.length;
    currentarriviPassivoPage = currentarriviPassivoPage % arriviPassivoPages.length;
    currentbinariPage = currentbinariPage % binariPages.length;
    $(tablePartenzeView).find('tbody').empty();
    $(tablePartenzeView).find('tbody').html(partenzePassivoPages[currentpartenzePassivoPage]);
    $(tableArriviView).find('tbody').empty();
    $(tableArriviView).find('tbody').html(arriviPassivoPages[currentarriviPassivoPage]);

    var tabtmp = "tableBinario"+binario+"View"
    $('#' + tabtmp).find('tbody').empty();
    $('#' + tabtmp).find('tbody').html(binariPages[currentbinariPage]);

    changePagesNum();
}

function changePagesNum() {
    if(!isNaN(currentpartenzePassivoPage))
        $('#pagPartPass').html("Pagina " + (+currentpartenzePassivoPage +1) + "/" + partenzePassivoPages.length);

    if(!isNaN(currentarriviPassivoPage))
        $('#pagArrPass').html("Pagina " + (+currentarriviPassivoPage +1) + "/" + arriviPassivoPages.length);
    $('[id^=pagBin]').each(function () {
        if(!isNaN(currentbinariPage))
            $(this).html("Pagina " + (+currentbinariPage + 1) + "/" + binariPages.length);
    });
}


function createNewPages(){
    partenzePages = new Array();
    partenzePassivoPages = new Array();
    arriviPages = new Array();
    arriviPassivoPages = new Array();
    binariPages = new Array();
    var numpartenzePages = Math.ceil(partenze.length/trainsPerPage);
    var numpartenzePassivoPages = Math.ceil(partenzePassivo.length/trainsPerPage);
    var numarriviPages = Math.ceil(arrivi.length/trainsPerPage);
    var numarriviPassivoPages = Math.ceil(arriviPassivo.length/trainsPerPage);
    var numbinariPages = Math.ceil(binari.length/trainsPerPage);
    for(var p = 0; p < numpartenzePages; p++){
        partenzePages.push(createTreniPage(p, partenze, "partenza", true));
    }
    for(var p = 0; p < numpartenzePassivoPages; p++){
        partenzePassivoPages.push(createTreniPage(p, partenzePassivo, "partenza", false));
    }
    for(var p = 0; p < numarriviPages; p++){
        arriviPages.push(createTreniPage(p, arrivi, "arrivo", true));
    }
    for(var p = 0; p < numarriviPassivoPages; p++){
        arriviPassivoPages.push(createTreniPage(p, arriviPassivo, "arrivo", false));
    }
    for(var p = 0; p < numbinariPages; p++){
        binariPages.push(createTreniPage(p, binari, "binari", false));
    }
}

function createTreniPage(n, treniArray, arrivoOrPartenza, isAdmin){
    var count = 1;
    var classTable = "";

    var s = "";
    for(var i = n*trainsPerPage; i<(n+1)*trainsPerPage && i<treniArray.length; i++){

        if(count%2 == 0){
            classTable = "salvo-table-odd";
        } else {
            classTable = "salvo-table-even";
        }
        count++;

        s = s + "<tr class=\"" + classTable + "\" >\n";
        s = s + "<td>" + treniArray[i].numeroTreno + "</td>";

        if(arrivoOrPartenza === "arrivo")
            s = s + "<td>" + treniArray[i].stazionePartenza + "</td>";
        else
            s = s + "<td>" + treniArray[i].stazioneArrivo + "</td>";

        s = s + "<td>" + treniArray[i].arrivoPrevisto + "</td>";
        s = s + "<td>" + treniArray[i].stato + "</td>";
        s = s + "<td>" + treniArray[i].binario + "</td>";

        if(isAdmin){
            if(treniArray[i].stato === "Confermato"){
                if(arrivoOrPartenza === "arrivo")
                    s = s + "<td id='actionArriviButtons'><button class='button-warning salvo-button' style='margin-right: 10px;' id=\"modificaTreno"+treniArray[i].numeroTreno+"\">MODIFICA</button><button class='button-error salvo-button' id=\"eliminaTreno"+treniArray[i].numeroTreno+"\">ELIMINA</button></td>\n";
                else if (arrivoOrPartenza === "partenza")
                    s = s + "<td id='actionPartenzeButtons'><button class='button-warning salvo-button' style='margin-right: 10px;' id=\"modificaTreno"+treniArray[i].numeroTreno+"\">MODIFICA</button><button class='button-error salvo-button' id=\"eliminaTreno"+treniArray[i].numeroTreno+"\">ELIMINA</button></td>\n";
            } else {
                if(arrivoOrPartenza === "arrivo")
                    s = s + "<td id='actionArriviButtons'><button class='button-warning salvo-button salvo-bottone-disabled' disabled style='margin-right: 10px;' id=\"modificaTreno"+treniArray[i].numeroTreno+"\">MODIFICA</button><button class='button-error salvo-button salvo-bottone-disabled' disabled id=\"eliminaTreno"+treniArray[i].numeroTreno+"\">ELIMINA</button></td>\n";
                else if (arrivoOrPartenza === "partenza")
                    s = s + "<td id='actionPartenzeButtons'><button class='button-warning salvo-button salvo-bottone-disabled' disabled style='margin-right: 10px;' id=\"modificaTreno"+treniArray[i].numeroTreno+"\">MODIFICA</button><button class='button-error salvo-button salvo-bottone-disabled' disabled id=\"eliminaTreno"+treniArray[i].numeroTreno+"\">ELIMINA</button></td>\n";
            }
        }
        s = s + "</tr>";
    }
    return s;
}

function openModalTreno() {
    // $('[id^=modificaTreno]').each(function () {
    $('.button-warning').on("click", function () {
        toUpdate = this.id.substring(13);

        $.ajax({
            url: window.location.origin+"/StazioneFerroviaria/treno",
            type: "get", //send it through get method
            data: {
                toUpdate: toUpdate,
            },
            success: function (responseJson) {
                treno = responseJson;
                $("#numeroTrenoUpdate").val(treno.numeroTreno);
                $("#giornoPartenzaUpdate").val(treno.giornoPartenza);
                $("#oraPartenzaUpdate").val(treno.oraPartenza);
                $("#binarioUpdate").val(treno.binario);
                var idSelect = 0;
                document.getElementById("scaliUpdate").innerHTML = "";

                treno.tappe.forEach(function (element) {

                    var div = document.createElement("div");
                    div.id = "stazIntermediaUpdMod" + idSelect;
                    div.setAttribute("class", "salvo-control-group")

                    var select = document.createElement("select");
                    select.id = "tappaIntermediaUpdate" + idSelect;
                    select.name = "tappaIntermediaUpdate";
                    select.setAttribute("disabled", true);
                    idSelect++;
                    select.innerHTML = '<option disabled selected value>' + element + ' </option>';

                    var label = document.createElement("label");
                    label.setAttribute("for", select.id);
                    if (idSelect == 0) {
                        label.innerHTML = "Stazione di Partenza: ";
                    } else if (idSelect == treno.tappe.length - 1) {
                        label.innerHTML = "Stazione di Arrivo: ";
                    } else {
                        label.innerHTML = "Stazione Intermedia " + idSelect + ": ";
                    }

                    document.getElementById("scaliUpdate").appendChild(div);
                    div.appendChild(label);
                    div.appendChild(select);
                    var modal = document.getElementById("updateModal");
                    var span = document.getElementById("closeUpdateModal");
                    modal.style.display = "block";
                    span.onclick = function () {
                        modal.style.display = "none";
                    }
                    window.onclick = function (event) {
                        if (event.target == modal) {
                            modal.style.display = "none";
                        }
                    }
                })

            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });


    });


    $('[id^=eliminaTreno]').on("click", function () {
        toDelete = this.id.substring(12);
        var modal = document.getElementById("deleteModal");
        var span = document.getElementById("closeDeleteModal");
        modal.style.display = "block";
        span.onclick = function () {
            modal.style.display = "none";
        }
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    });

}

function openCreateModal(buttonId) {

    if (buttonId == "createTrenoPartenza") {
        $(stazionePartenzaInsert).empty();
        $("<option>").val("Palermo").text("Palermo").appendTo(stazionePartenzaInsert);
        $(stazionePartenzaInsert).val('Palermo');
        $(stazionePartenzaInsert); //.prop( "disabled", true );
        $(stazioneArrivoInsert).empty();
        $(stazioneArrivoInsert).html("<option selected disabled value> -- Seleziona una stazione -- </option>");
        appendStazioniToSelect(stazioneArrivoInsert);
        $(stazioneArrivoInsert).prop("disabled", false);
        $(scaliInsert).empty();
        idSelect = 0;
    } else {
        $(stazionePartenzaInsert).empty();
        $(stazionePartenzaInsert).html("<option selected disabled value> -- Seleziona una stazione -- </option>");
        appendStazioniToSelect(stazionePartenzaInsert);
        $(stazionePartenzaInsert).prop("disabled", false);
        $(stazioneArrivoInsert).empty();
        $("<option>").val("Palermo").text("Palermo").appendTo(stazioneArrivoInsert);
        $(stazioneArrivoInsert);//.prop( "disabled", true );
        $(scaliInsert).empty();
        idSelect = 0;
    }

    var modal = document.getElementById("createModal");
    var span = document.getElementById("closeCreateModal");
    modal.style.display = "block";
    span.onclick = function () {
        modal.style.display = "none";
    }
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
}

$("#modalEliminaTreno").click(function (e) {
    e.preventDefault();
    $.ajax({
        url: window.location.origin+"/StazioneFerroviaria/treno",
        type: "delete",
        data: {
            "toDelete": toDelete,
        },
        success: function (responseJson) {
            location.reload();
        },
        error: function (xhr) {
            //Do Something to handle error
        }
    });
});

$("#updateButton").click(function (e) {
    e.preventDefault();

    var result = validateForm('Update');

    if(result){
        numeroTreno = toUpdate;
        giornoPartenza = $("#giornoPartenzaUpdate").val();
        oraPartenza = $("#oraPartenzaUpdate").val();
        binario = $("#binarioUpdate").val();

        $.ajax({
            url: window.location.origin+"/StazioneFerroviaria/treno",
            type: "put", //send it through get method
            data: {
                numeroTreno: numeroTreno,
                giornoPartenza: giornoPartenza,
                oraPartenza: oraPartenza,
                binario: binario
            },
            success: function (responseJson) {
                location.reload();
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
    }
});

function getCookie(name) {
    var value = "; " + document.cookie;
    var parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
}

function showView() {
    var utenteloggato = '<%= username %>';
    visualizzazione = getCookie(utenteloggato+'opzioniVisualizzazione');
    if(visualizzazione.startsWith("Binario")){
        binario = visualizzazione.substring(7);
    }
    mostrare = visualizzazione + '-view';
    $("body").find('#' + mostrare).show();
    ajaxCall();
    reloadPassivi();
}

function reloadPassivi(){
    if(!visualizzazione.startsWith("Admin")){
        setTimeout(function() {
            location.reload();
        }, 60000);
    }
}

function logoutFunction() {
    $.ajax({
        url: window.location.origin+"/StazioneFerroviaria/logout",
        type: "POST", //send it through get method
        success: function (responseJson) {
            window.location.href = "/StazioneFerroviaria/";
        },
        error: function (xhr) {
            //Do Something to handle error
        }
    });
}

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

    $(errCrMod).hide();
    $(errCrMod).empty();
    $(errUpMod).hide();
    $(errUpMod).empty();

    erroriJS = [];

    var numRegex = /^\d+$/;
    var dateRegex = /^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;
    var timeRegex = /^([01][0-9]|[2][0-3]):([0-5]\d)$/;

    if(!numRegex.test($('#numeroTreno'+tipoForm).val())) {
        erroriJS.push("Il numero treno può contenere solo caratteri numerici!");
    }
    if(!dateRegex.test($('#giornoPartenza'+tipoForm).val())) {
        erroriJS.push("Inserire il giorno della partenza in formato dd/mm/yyyy!");
    } else {
        var today = new Date();
        var ggPartenza = $('#giornoPartenza'+tipoForm).val();
        var oraPartenza = $('#oraPartenza'+tipoForm).val();
        var giornoPartenza = new Date(ggPartenza.split('/')[2], +ggPartenza.split('/')[1]-1, ggPartenza.split('/')[0], oraPartenza.split(':')[0], oraPartenza.split(':')[1]);
        if (today > giornoPartenza){
            erroriJS.push("Il giorno della partenza deve essere posteriore o uguale alla data odierna!");
        }
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
    if(tipoForm === 'Insert'){
        erroriJS.forEach(element => {
            $(errCrMod).append('<li>'+element+'</li>');
        });

        $(errCrMod).show();
    } else if (tipoForm === 'Update'){
        erroriJS.forEach(element => {
            $(errUpMod).append('<li>'+element+'</li>');
        });

        $(errUpMod).show();
    }
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
        div.setAttribute("class", "salvo-control-group")

        var select = document.createElement("select");
        select.id = "tappaIntermedia"+tipoForm+idSelect;
        select.name = "tappaIntermedia"+tipoForm;
        select.innerHTML = '<option disabled selected value> -- Seleziona una stazione -- </option>';

        var label = document.createElement("label");
        label.setAttribute("for", select.id);
        label.innerHTML = "Stazione Intermedia " + idSelect + ": ";

        var span = document.createElement("span");
        span.setAttribute("class", "salvo-form-message-inline");
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
