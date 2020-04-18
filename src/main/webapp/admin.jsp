<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo - Admin Console</title>
    <link href="css/custom.css" rel="stylesheet" type="text/css">

</head>
<body>
<%
    //allow access only if session exists
    String user = null;
    if(session.getAttribute("username") == null){
        response.sendRedirect("/StazioneFerroviaria/");
        return;
    }else user = (String) session.getAttribute("user");
    String userName = null;
    String sessionID = null;
    Cookie[] cookies = request.getCookies();
    if(cookies !=null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals(user)) userName = cookie.getValue();
        }
    }else{
        sessionID = session.getId();
    }

    Boolean result = (Boolean) request.getAttribute("result");
    Boolean insert = (Boolean) request.getAttribute("insert");
    String error = "";
    Map<String, String> errors = new HashMap<>();
    if( result != null && insert != null){
        if(result && !insert){
            error = (String) request.getAttribute("errors");
        } else if (!result && !insert) {
            errors = (HashMap<String, String>)  request.getAttribute("errors");
        }
    }

%>

<div class="header">
    <div class="home-menu pure-menu pure-menu-horizontal pure-menu-fixed">
        <a class="pure-menu-heading" style="padding: 0;"><img src="./img/logo.png"></a>

        <ul class="pure-menu-list">
            <li class="pure-menu-item pure-menu-selected"><a href="home.jsp" class="pure-menu-link">Home</a></li>
            <li class="pure-menu-item cursor-pointer"><a onclick="logoutFunction()" class="pure-menu-link">Logout</a></li>
        </ul>
    </div>
</div>


<div class="splash-container">
    <div class="splash">
        <div class="l-box-lrg pure-u-1 pure-u-md-2-5">
            <div id="views">
                <div id="Admin-view">
                    <div id="choiceMenu">
                        <button class="pure-button pure-button-primary" id="partenze-button">Partenze</button>
                        <button class="pure-button pure-button-primary" id="arrivi-button">Arrivi</button>
                        <button class="pure-button pure-button-primary" id="ruoli-button">Ruoli</button>
                    </div>

                    <div id="BEerrors">
                        <ul>
                            <c:if test="${(result) and (!insert)}">
                                <li>
                                    <%=error%>
                                </li>
                            </c:if>
                            <c:if test="${(!result) and (!insert)}">
                                <%
                                    Set<String> chiavi = errors.keySet();
                                    for ( String chiave : chiavi) {
                                %>
                                <li><%=chiave%>:<%=errors.get(chiave)%></li>
                                <% } %>
                            </c:if>
                        </ul>
                    </div>

                    <br/>
                    <div id="pageTable">
                        <div id="partenze-table">
                            <button class="pure-button pure-button-primary" id="createTrenoPartenza" onclick="openCreateModal(this.id)">Inserisci un nuovo treno in partenza!</button>
                            <br>
                            <table class="pure-table center-table" id="tablePartenze">
                                <thead>
                                <tr>
                                    <th>Numero Treno</th>
                                    <th>Stazione di Arrivo</th>
                                    <th>Arrivo Previsto</th>
                                    <th>Stato</th>
                                    <%--            <th>Ritardo(?)</th>--%>
                                    <th>Binario</th>
                                    <th>Azioni</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div id="tablePartenzePages"></div>
                        </div>
                        <div id="arrivi-table">
                            <button class="pure-button pure-button-primary" id="createTrenoArrivo" onclick="openCreateModal(this.id)">Inserisci un nuovo treno in arrivo!</button>
                            <table class="pure-table center-table" id="tableArrivi">
                                <thead>
                                <tr>
                                    <th>Numero Treno</th>
                                    <th>Stazione di Partenza</th>
                                    <th>Arrivo Previsto</th>
                                    <th>Stato</th>
                                    <%--            <th>Ritardo(?)</th>--%>
                                    <th>Binario</th>
                                    <th>Azioni</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div id="tableArriviPages"></div>
                        </div>
                        <div id="ruoli-table">
                            <table class="pure-table center-table" id="tableRuoli">
                                <thead>
                                <tr>
                                    <th>Numero Treno</th>
                                    <th>Stazione di Partenza</th>
                                    <th>Arrivo Previsto</th>
                                    <th>Stato</th>
                                    <%--            <th>Ritardo(?)</th>--%>
                                    <th>Binario</th>
                                    <th>Azioni</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="createModal" class="modal">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span id="closeCreateModal" class="close">&times;</span>
                            <form class="pure-form pure-form-aligned" action="/StazioneFerroviaria/treno" method="POST" onsubmit="return validateForm('Insert')">
                                <fieldset>
                                    <legend>Inserisci un nuovo treno</legend>
                                    <div id="errors"></div>

                                    <div class="pure-control-group">
                                        <label for="numeroTrenoInsert">Numero: </label>
                                        <input required type="text" name="numeroTrenoInsert" id="numeroTrenoInsert" placeholder="Inserire numero treno">
                                    </div>


                                    <div class="pure-control-group">
                                        <label for="stazionePartenzaInsert">Stazione di Partenza: </label>
                                        <select id="stazionePartenzaInsert" name="stazionePartenzaInsert" required>
                                            <option selected disabled value> -- Seleziona una stazione -- </option>
                                        </select>
                                        <button id="addStazioneInsert" type="button" onclick="addStazioneIntermedia('Insert')">Aggiungi stazione intermedia</button>
                                    </div>

                                    <div id="scaliInsert"></div>

                                    <div class="pure-control-group">
                                        <label for="stazioneArrivoInsert">Stazione di Arrivo: </label>
                                        <select id="stazioneArrivoInsert" name="stazioneArrivoInsert" required>
                                            <option selected disabled value> -- Seleziona una stazione -- </option>
                                        </select>
                                    </div>

                                    <div class="pure-control-group">
                                        <label for="giornoPartenzaInsert">Giorno: </label>
                                        <input type="text" name="giornoPartenzaInsert" id="giornoPartenzaInsert" required placeholder="gg/mm/aaaa">
                                    </div>

                                    <div class="pure-control-group">
                                        <label for="oraPartenzaInsert">Ora Partenza: </label>
                                        <input type="text" name="oraPartenzaInsert" id="oraPartenzaInsert" required placeholder="hh:mm">
                                    </div>

                                    <div class="pure-control-group">
                                        <label for="binarioInsert">Binario: </label>
                                        <select id="binarioInsert" name="binarioInsert" required>
                                            <option selected disabled value> -- Seleziona un binario -- </option>
                                            <option value="1"> 1 </option>
                                            <option value="2"> 2 </option>
                                            <option value="3"> 3 </option>
                                            <option value="4"> 4 </option>
                                        </select>
                                    </div>
                                    <br>
                                    <button id="insertButton" type="submit" name="tipoForm" value="Inserisci treno">Inserisci treno</button>
                                </fieldset>
                            </form>

                        </div>

                    </div>
                    <div id="updateModal" class="modal">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span id="closeUpdateModal" class="close">&times;</span>
                            <form class="pure-form pure-form-aligned" action="/StazioneFerroviaria/treno" method="POST" onsubmit="return validateForm('Update')">

                                <fieldset>
                                    <legend>Modifica treno</legend>

                                    <%--<div id="errors"></div> TODO aggiungere logica errori UPDATE--%>

                                    <div class="pure-control-group">
                                        <label for="numeroTrenoUpdate">Numero: </label>
                                        <input required disabled type="text" name="numeroTrenoUpdate" id="numeroTrenoUpdate" placeholder="Inserire numero treno">
                                    </div>

                                    <div id="scaliUpdate"></div>

                                    <div class="pure-control-group">
                                        <label for="giornoPartenzaUpdate">Giorno: </label>
                                        <input type="text" name="giornoPartenzaUpdate" id="giornoPartenzaUpdate" required placeholder="gg/mm/aaaa">
                                    </div>

                                        <div class="pure-control-group">
                                            <label for="oraPartenzaUpdate">Ora Partenza: </label>
                                            <input type="text" name="oraPartenzaUpdate" id="oraPartenzaUpdate" required placeholder="hh:mm">
                                        </div>

                                            <div class="pure-control-group">
                                                <label for="binarioUpdate">Binario: </label>
                                                <select id="binarioUpdate" name="binarioUpdate" required>
                                                    <option selected disabled value> -- Seleziona un binario -- </option>
                                                    <option value="1"> 1 </option>
                                                    <option value="2"> 2 </option>
                                                    <option value="3"> 3 </option>
                                                    <option value="4"> 4 </option>
                                                </select>
                                            </div>
                                    <br>
                                    <button id="updateButton" type="submit" name="tipoForm" value="Modifica treno">Modifica treno</button>
                                </fieldset>
                            </form>

                        </div>

                    </div>
                    <div id="deleteModal" class="modal">
                        <div class="modal-content">
                            <span id="closeDeleteModal" class="close">&times;</span>
                            <p>Vuoi davvero eliminare questo treno?</p>
                            <button id="modalEliminaTreno">ELIMINA</button>
                        </div>

                    </div>
                </div>
                <div id="Partenze-view">
                    <div id="partenze-view-table">
                        <table class="pure-table center-table" id="tablePartenzeView">
                            <thead>
                            <tr>
                                <th>Numero Treno</th>
                                <th>Stazione di Arrivo</th>
                                <th>Arrivo Previsto</th>
                                <th>Stato</th>
                                <%--            <th>Ritardo(?)</th>--%>
                                <th>Binario</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="Arrivi-view">
                    <div id="arrivi-view-table">
                        <table class="pure-table center-table" id="tableArriviView">
                            <thead>
                            <tr>
                                <th>Numero Treno</th>
                                <th>Stazione di Partenza</th>
                                <th>Arrivo Previsto</th>
                                <th>Stato</th>
                                <%--            <th>Ritardo(?)</th>--%>
                                <th>Binario</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="Binario1-view">
                    <div id="binario1-view-table">
                        <table class="pure-table center-table" id="tableBinario1View">
                            <thead>
                            <tr>
                                <th>Numero Treno</th>
                                <th>Stazione di Arrivo</th>
                                <th>Arrivo Previsto</th>
                                <th>Stato</th>
                                <%--            <th>Ritardo(?)</th>--%>
                                <th>Binario</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="Binario2-view">
                    <div id="binario2-view-table">
                        <table class="pure-table center-table" id="tableBinario2View">
                            <thead>
                            <tr>
                                <th>Numero Treno</th>
                                <th>Stazione di Arrivo</th>
                                <th>Arrivo Previsto</th>
                                <th>Stato</th>
                                <%--            <th>Ritardo(?)</th>--%>
                                <th>Binario</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="Binario3-view">
                    <div id="binario3-view-table">
                        <table class="pure-table center-table" id="tableBinario3View">
                            <thead>
                            <tr>
                                <th>Numero Treno</th>
                                <th>Stazione di Arrivo</th>
                                <th>Arrivo Previsto</th>
                                <th>Stato</th>
                                <%--            <th>Ritardo(?)</th>--%>
                                <th>Binario</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="Binario4-view">
                    <div id="binario4-view-table">
                        <table class="pure-table center-table" id="tableBinario4View">
                            <thead>
                            <tr>
                                <th>Numero Treno</th>
                                <th>Stazione di Arrivo</th>
                                <th>Arrivo Previsto</th>
                                <th>Stato</th>
                                <%--            <th>Ritardo(?)</th>--%>
                                <th>Binario</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<c:choose>
    <c:when test="${not empty result && result == true}">
        INSERT ESEGUITA!!!
    </c:when>
    <c:otherwise>
        <c:forEach items="${errors}" var="errore">
            ${errore}
        </c:forEach>
    </c:otherwise>
</c:choose>

<script src="js/jquery-3.4.1.js"></script>
<script src="js/admin.js" type="text/javascript"></script>

</body>

<script>

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

        $(views).children('div').each(function () {
            $(this).hide();
        });

        showView();

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
        }

        currentpartenzePassivoPage++;
        currentarriviPassivoPage++;
        currentbinariPage++;
        currentpartenzePassivoPage = currentpartenzePassivoPage % partenzePassivoPages.length;
        currentarriviPassivoPage = currentarriviPassivoPage % arriviPassivoPages.length;
        currentbinariPage = currentbinariPage % binariPages.length;
        $(tablePartenze).find('tbody').empty();
        $(tablePartenze).find('tbody').html(partenzePages[currentpartenzePage]);
        $(tablePartenzeView).find('tbody').empty();
        $(tablePartenzeView).find('tbody').html(partenzePassivoPages[currentpartenzePassivoPage]);
        $(tableArrivi).find('tbody').empty();
        $(tableArrivi).find('tbody').html(arriviPages[currentarriviPage]);
        $(tableArriviView).find('tbody').empty();
        $(tableArriviView).find('tbody').html(arriviPassivoPages[currentarriviPassivoPage]);

        var tabtmp = "tableBinario"+binario+"View"
        $('#' + tabtmp).find('tbody').empty();
        $('#' + tabtmp).find('tbody').html(binariPages[currentbinariPage]);

        openModalTreno();
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
            partenzePages.push(createPartenzePage(p));
        }
        for(var p = 0; p < numpartenzePassivoPages; p++){
            partenzePassivoPages.push(createPartenzePassivoPage(p));
        }
        for(var p = 0; p < numarriviPages; p++){
            arriviPages.push(createArriviPage(p));
        }
        for(var p = 0; p < numarriviPassivoPages; p++){
            arriviPassivoPages.push(createArriviPassivoPage(p));
        }
        for(var p = 0; p < numbinariPages; p++){
            binariPages.push(createBinariPage(p));
        }
    }

    function createPartenzePage(n){
        var count = 1;
        var classTable = "";

        var s = "";
        for(var i = n*trainsPerPage; i<(n+1)*trainsPerPage && i<partenze.length; i++){

            if(count%2 == 0){
                classTable = "pure-table-odd";
            } else {
                classTable = "pure-table-even";
            }
            count++;

            s = s + "<tr class=\"" + classTable + "\" >\n";
            s = s + "<td>" + partenze[i].numeroTreno + "</td>";
            s = s + "<td>" + partenze[i].stazioneArrivo + "</td>";
            s = s + "<td>" + partenze[i].arrivoPrevisto + "</td>";
            s = s + "<td>" + partenze[i].stato + "</td>";
            s = s + "<td>" + partenze[i].binario + "</td>";
            s = s + "<td id='actionPartenzeButtons'><button class='button-warning pure-button' id=\"modificaTreno"+partenze[i].numeroTreno+"\">MODIFICA</button><button class='button-error pure-button' id=\"eliminaTreno"+partenze[i].numeroTreno+"\">ELIMINA</button></td>\n";
            s = s + "</tr>";
        }
        return s;
    }

    function createPartenzePassivoPage(n){
        var count = 1;
        var classTable = "";

        var s = "";
        for(var i = n*trainsPerPage; i<(n+1)*trainsPerPage && i<partenzePassivo.length; i++){

            if(count%2 == 0){
                classTable = "pure-table-odd";
            } else {
                classTable = "pure-table-even";
            }
            count++;

            s = s + "<tr class=\"" + classTable + "\" >\n";
            s = s + "<td>" + partenzePassivo[i].numeroTreno + "</td>";
            s = s + "<td>" + partenzePassivo[i].stazioneArrivo + "</td>";
            s = s + "<td>" + partenzePassivo[i].arrivoPrevisto + "</td>";
            s = s + "<td>" + partenzePassivo[i].stato + "</td>";
            s = s + "<td>" + partenzePassivo[i].binario + "</td>";
            s = s + "</tr>";
        }
        return s;
    }

    function createArriviPage(n){
        var count = 1;
        var classTable = "";

        var s = "";
        for(var i = n*trainsPerPage; i<(n+1)*trainsPerPage && i<arrivi.length; i++){

            if(count%2 == 0){
                classTable = "pure-table-odd";
            } else {
                classTable = "pure-table-even";
            }
            count++;

            s = s + "<tr class=\"" + classTable + "\" >\n";
            s = s + "<td>" + arrivi[i].numeroTreno + "</td>";
            s = s + "<td>" + arrivi[i].stazionePartenza + "</td>";
            s = s + "<td>" + arrivi[i].arrivoPrevisto + "</td>";
            s = s + "<td>" + arrivi[i].stato + "</td>";
            s = s + "<td>" + arrivi[i].binario + "</td>";
            s = s + "<td id='actionPartenzeButtons'><button class='button-warning pure-button' id=\"modificaTreno"+arrivi[i].numeroTreno+"\">MODIFICA</button><button class='button-error pure-button' id=\"eliminaTreno"+arrivi[i].numeroTreno+"\">ELIMINA</button></td>\n";
            s = s + "</tr>";
        }
        return s;
    }

    function createArriviPassivoPage(n){
        var count = 1;
        var classTable = "";

        var s = "";
        for(var i = n*trainsPerPage; i<(n+1)*trainsPerPage && i<arriviPassivo.length; i++){

            if(count%2 == 0){
                classTable = "pure-table-odd";
            } else {
                classTable = "pure-table-even";
            }
            count++;

            s = s + "<tr class=\"" + classTable + "\" >\n";
            s = s + "<td>" + arriviPassivo[i].numeroTreno + "</td>";
            s = s + "<td>" + arriviPassivo[i].stazioneArrivo + "</td>";
            s = s + "<td>" + arriviPassivo[i].arrivoPrevisto + "</td>";
            s = s + "<td>" + arriviPassivo[i].stato + "</td>";
            s = s + "<td>" + arriviPassivo[i].binario + "</td>";
            s = s + "</tr>";
        }
        return s;
    }

    function createBinariPage(n){
        var count = 1;
        var classTable = "";

        var s = "";
        for(var i = n*trainsPerPage; i<(n+1)*trainsPerPage && i<binari.length; i++){

            if(count%2 == 0){
                classTable = "pure-table-odd";
            } else {
                classTable = "pure-table-even";
            }
            count++;

            s = s + "<tr class=\"" + classTable + "\" >\n";
            s = s + "<td>" + binari[i].numeroTreno + "</td>";
            s = s + "<td>" + binari[i].stazioneArrivo + "</td>";
            s = s + "<td>" + binari[i].arrivoPrevisto + "</td>";
            s = s + "<td>" + binari[i].stato + "</td>";
            s = s + "<td>" + binari[i].binario + "</td>";
            s = s + "</tr>";
        }
        return s;
    }

    function openModalTreno() {
        $('[id^=modificaTreno]').each(function () {
            $(this).on("click", function () {
                toUpdate = this.id.substring(13);

                $.ajax({
                    url: "treno",
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
                        var idSelect = -1;
                        document.getElementById("scaliUpdate").innerHTML = "";

                        treno.tappe.forEach(function (element) {

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

                            var br = document.createElement("br");
                            var br2 = document.createElement("br");

                            document.getElementById("scaliUpdate").appendChild(label);
                            document.getElementById("scaliUpdate").appendChild(select);
                            document.getElementById("scaliUpdate").appendChild(br);
                            document.getElementById("scaliUpdate").appendChild(br2);
                        })

                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });

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
            });
        });

        $('[id^=eliminaTreno]').each(function () {
            $(this).on("click", function () {
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

        // <option selected disabled value> -- Seleziona una stazione -- </option>
        //     $("<option>").val(category.nomeStazione).text(category.nomeStazione).appendTo(selectId);

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
            url: "treno", //sala="+vsala.valueOf();
            dataType: 'application/json',
            type: "delete", //send it through get method
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

        numeroTreno = toUpdate;
        giornoPartenza = $("#giornoPartenzaUpdate").val();
        oraPartenza = $("#oraPartenzaUpdate").val();
        binario = $("#binarioUpdate").val();

        $.ajax({
            url: "treno",
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
    });

    function getCookie(name) {
        var value = "; " + document.cookie;
        var parts = value.split("; " + name + "=");
        if (parts.length == 2) return parts.pop().split(";").shift();
    }

    function showView() {
        visualizzazione = getCookie('opzioniVisualizzazione');
        if(visualizzazione.startsWith("Binario")){
            binario = visualizzazione.substring(7);
        }
        mostrare = visualizzazione + '-view';
        $("body").find('#' + mostrare).show();
        ajaxCall();
    }

    function ajaxCall() {
        $.get("stazioni", function(responseJson) {
            stazioni = responseJson;
            appendStazioniToSelect(${"stazionePartenzaInsert"});
            appendStazioniToSelect(${"stazioneArrivoInsert"});
        });

        $.get("partenze", function (responseJson) {
            partenze = responseJson;
            var pagePartenze = 0;
            partenze.forEach( element => {
                pagePartenze++;
                var today = new Date();
                var arrivoPrevisto = new Date(element.arrivoPrevisto);
                if (today < arrivoPrevisto){
                    partenzePassivo.push(element);
                }
            });
            var numPaginePartenze = Math.ceil(partenze.length/trainsPerPage);
            for ( i = 1; i < numPaginePartenze+1 ; i++ )
                $(tablePartenzePages).append("<button id=\"partenzePagina"+i+"\">"+i+"</button>");
            $('[id^=partenzePagina]').each(function () {
                $(this).on("click", function () {
                    var num = this.id.substring(14);
                    currentpartenzePage = num-1;
                    $(tablePartenze).find('tbody').html(partenzePages[num-1]);
                })
            });
        });

        $.get("arrivi", function (responseJson) {
            arrivi = responseJson;
            arrivi.forEach( element => {
                var today = new Date();
                var arrivoPrevisto = new Date(element.arrivoPrevisto);
                if (today < arrivoPrevisto) {
                    arriviPassivo.push(element);
                }
            });
            var numPagineArrivi = Math.ceil(arrivi.length/trainsPerPage);
            for ( i = 1; i < numPagineArrivi+1 ; i++ )
                $(tableArriviPages).append("<button id=\"arriviPagina"+i+"\">"+i+"</button>");
            $('[id^=arriviPagina]').each(function () {
                $(this).on("click", function () {
                    var num = this.id.substring(12);
                    currentarriviPage = num-1;
                    $(tableArrivi).find('tbody').html(arriviPages[num-1]);
                })
            });
        });

        $.ajax({
            url: "binari",
            type: "get", //send it through get method
            data: {
                binario: binario,
            },
            success: function (responseJson) {
                responseJson.forEach( element => {
                    var today = new Date();
                    var arrivoPrevisto = new Date(element.arrivoPrevisto);
                    if (today < arrivoPrevisto) {
                        binari.push(element);
                    }
                });
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
    }

    function logoutFunction() {
        $.ajax({
            url: "logout",
            type: "POST", //send it through get method
            success: function (responseJson) {
                window.location.href = "/StazioneFerroviaria/";
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
    }


</script>

</html>
