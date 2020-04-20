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
    String username = (String) session.getAttribute("username");
    if(username == null){
        response.sendRedirect("/StazioneFerroviaria/");
        return;
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
    <div class="home-menu salvo-menu salvo-menu-horizontal salvo-menu-fixed">
        <a class="salvo-menu-heading" style="padding: 0;"><img src="./img/logo.png"></a>

        <ul class="salvo-menu-list">
            <li class="salvo-menu-item salvo-menu-selected"><a href="home.jsp" class="salvo-menu-link">Home</a></li>
            <li class="salvo-menu-item cursor-pointer"><a onclick="logoutFunction()" class="salvo-menu-link">Logout</a></li>
        </ul>
    </div>
</div>


<div class="splash-container">
    <div class="splash">
        <div class="l-box-lrg salvo-u-1 salvo-u-md-2-5">
            <div id="views">
                <div id="Admin-view" style="display: none;">
                    <div id="choiceMenu" class="marginino-sotto">
                        <button class="salvo-button salvo-button-primary" id="partenze-button">Partenze</button>
                        <button class="salvo-button salvo-button-primary" id="arrivi-button">Arrivi</button>
                    </div>

                    <div id="BEerrors">
                        <c:if test="${(not empty result) and (not empty insert) and (result) and (not insert)}">
                            <div class="alert-login marginino-sopra-sotto">
                                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
                                <%=error%>
                            </div>
                        </c:if>
                        <c:if test="${(not empty result) and (not empty insert) and (not result) and (not insert)}">
                            <div class="alert-login marginino-sopra-sotto">
                                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
                                <%
                                    Set<String> chiavi = errors.keySet();
                                    for ( String chiave : chiavi) {
                                %>
                                <strong><%=chiave%></strong>:<%=errors.get(chiave)%>
                                <br>
                                <% } %>
                            </div>
                        </c:if>
                        <c:if test="${(not empty result) and (not empty insert) and (result) and (insert)}">
                            <div class="alert success">
                                <span class="closebtn" onclick="this.parentElement.style.display='none';">×</span>
                                <strong>OK!</strong> Il treno è stato inserito correttamente.
                            </div>
                        </c:if>
                    </div>

                    <div id="pageTable">
                        <div id="partenze-table">
                            <button class="w3-button w3-xlarge w3-circle w3-red marginino-sotto" id="createTrenoPartenza" onclick="openCreateModal(this.id)">+</button>
                            <br>
                            <table class="salvo-table center-table" id="tablePartenze">
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
                            <button class="w3-button w3-xlarge w3-circle w3-red marginino-sotto" id="createTrenoArrivo" onclick="openCreateModal(this.id)">+</button>
                            <table class="salvo-table center-table" id="tableArrivi">
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
                    </div>

                    <div id="createModal" class="modal">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span id="closeCreateModal" class="close">&times;</span>
                            <form class="salvo-form salvo-form-aligned" action="/StazioneFerroviaria/treno" method="POST" onsubmit="return validateForm('Insert')">
                                <fieldset>
                                    <legend>Inserisci un nuovo treno</legend>
                                    <div id="errorsCreateModal">
                                        <ul id="errCrMod" class="alert" style="display: none;">

                                        </ul>
                                    </div>

                                    <div class="salvo-control-group">
                                        <label for="numeroTrenoInsert">Numero: </label>
                                        <input required type="text" name="numeroTrenoInsert" id="numeroTrenoInsert" placeholder="Inserire numero treno">
                                    </div>


                                    <div class="salvo-control-group">
                                        <label for="stazionePartenzaInsert">Stazione di Partenza: </label>
                                        <select id="stazionePartenzaInsert" name="stazionePartenzaInsert" required>
                                            <option selected disabled value> -- Seleziona una stazione -- </option>
                                        </select>
                                        <button id="addStazioneInsert" class="salvo-button-primary salvo-button" type="button" onclick="addStazioneIntermedia('Insert')">Aggiungi stazione intermedia</button>
                                    </div>

                                    <div id="scaliInsert"></div>

                                    <div class="salvo-control-group">
                                        <label for="stazioneArrivoInsert">Stazione di Arrivo: </label>
                                        <select id="stazioneArrivoInsert" name="stazioneArrivoInsert" required>
                                            <option selected disabled value> -- Seleziona una stazione -- </option>
                                        </select>
                                    </div>

                                    <div class="salvo-control-group">
                                        <label for="giornoPartenzaInsert">Giorno: </label>
                                        <input type="text" name="giornoPartenzaInsert" id="giornoPartenzaInsert" required placeholder="gg/mm/aaaa">
                                    </div>

                                    <div class="salvo-control-group">
                                        <label for="oraPartenzaInsert">Ora Partenza: </label>
                                        <input type="text" name="oraPartenzaInsert" id="oraPartenzaInsert" required placeholder="hh:mm">
                                    </div>

                                    <div class="salvo-control-group">
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
                                    <button id="insertButton" class="button-success salvo-button" type="submit" name="tipoForm" value="Inserisci treno">Inserisci treno</button>
                                </fieldset>
                            </form>

                        </div>

                    </div>
                    <div id="updateModal" class="modal">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span id="closeUpdateModal" class="close">&times;</span>
                            <form class="salvo-form salvo-form-aligned" action="/StazioneFerroviaria/treno" method="POST" onsubmit="return validateForm('Update')">

                                <fieldset>
                                    <legend>Modifica treno</legend>

                                    <div id="errorsUpdateModal">
                                        <ul id="errUpMod" class="alert" style="display: none;">

                                        </ul>
                                    </div>

                                    <div class="salvo-control-group">
                                        <label for="numeroTrenoUpdate">Numero: </label>
                                        <input required disabled type="text" name="numeroTrenoUpdate" id="numeroTrenoUpdate" placeholder="Inserire numero treno">
                                    </div>

                                    <div id="scaliUpdate"></div>

                                    <div class="salvo-control-group">
                                        <label for="giornoPartenzaUpdate">Giorno: </label>
                                        <input type="text" name="giornoPartenzaUpdate" id="giornoPartenzaUpdate" required placeholder="gg/mm/aaaa">
                                    </div>

                                    <div class="salvo-control-group">
                                        <label for="oraPartenzaUpdate">Ora Partenza: </label>
                                        <input type="text" name="oraPartenzaUpdate" id="oraPartenzaUpdate" required placeholder="hh:mm">
                                    </div>

                                    <div class="salvo-control-group">
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
                                    <button class="button-success salvo-button" id="updateButton" type="submit" name="tipoForm" value="Modifica treno">Modifica treno</button>
                                </fieldset>
                            </form>

                        </div>

                    </div>
                    <div id="deleteModal" class="modal">
                        <div class="modal-content">
                            <span id="closeDeleteModal" class="close">&times;</span>
                            <p>Vuoi davvero eliminare questo treno?</p>
                            <button class="button-error salvo-button" id="modalEliminaTreno">ELIMINA</button>
                        </div>

                    </div>
                </div>
                <div id="Partenze-view" style="display: none;">
                    <div id="partenze-view-table">
                        <h2>PARTENZE</h2>
                        <table class="salvo-table center-table" id="tablePartenzeView">
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
                        <div id="pagPartPass"></div>
                    </div>
                </div>
                <div id="Arrivi-view" style="display: none;">
                    <div id="arrivi-view-table">
                        <h2>ARRIVI</h2>
                        <table class="salvo-table center-table" id="tableArriviView">
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
                        <div id="pagArrPass"></div>
                    </div>
                </div>
                <div id="Binario1-view" style="display: none;">
                    <div id="binario1-view-table">
                        <h2>BINARIO 1</h2>
                        <table class="salvo-table center-table" id="tableBinario1View">
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
                        <div id="pagBin1Pass"></div>
                    </div>
                </div>
                <div id="Binario2-view" style="display: none;">
                    <div id="binario2-view-table">
                        <h2>BINARIO 2</h2>
                        <table class="salvo-table center-table" id="tableBinario2View">
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
                        <div id="pagBin2Pass"></div>
                    </div>
                </div>
                <div id="Binario3-view" style="display: none;">
                    <div id="binario3-view-table">
                        <h2>BINARIO 3</h2>
                        <table class="salvo-table center-table" id="tableBinario3View">
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
                        <div id="pagBin3Pass"></div>
                    </div>
                </div>
                <div id="Binario4-view" style="display: none;">
                    <div id="binario4-view-table">
                        <h2>BINARIO 4</h2>
                        <table class="salvo-table center-table" id="tableBinario4View">
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
                        <div id="pagBin4Pass"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/jquery-3.4.1.js"></script>
<script src="js/admin.js" type="text/javascript"></script>

</body>

<script>
    function ajaxCall() {
        $.get(window.location.origin+"/StazioneFerroviaria/stazioni", function(responseJson) {
            stazioni = responseJson;
            appendStazioniToSelect(${"stazionePartenzaInsert"});
            appendStazioniToSelect(${"stazioneArrivoInsert"});
        });

        $.get(window.location.origin+"/StazioneFerroviaria/partenze", function (responseJson) {
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
                $(tablePartenzePages).append("<button class=\"salvo-button salvo-button-primary margine-alto-dx\" id=\"partenzePagina"+i+"\">"+i+"</button>");
            $('[id^=partenzePagina]').each(function () {
                $(this).on("click", function () {
                    var num = this.id.substring(14);
                    currentpartenzePage = num-1;
                    $(tablePartenze).find('tbody').html(partenzePages[num-1]);
                    openModalTreno();
                })
            });
        });

        $.get(window.location.origin+"/StazioneFerroviaria/arrivi", function (responseJson) {
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
                $(tableArriviPages).append("<button class=\"salvo-button salvo-button-primary margine-alto-dx\" id=\"arriviPagina"+i+"\">"+i+"</button>");
            $('[id^=arriviPagina]').each(function () {
                $(this).on("click", function () {
                    var num = this.id.substring(12);
                    currentarriviPage = num-1;
                    $(tableArrivi).find('tbody').html(arriviPages[num-1]);
                    openModalTreno();
                })
            });
        });

        $.ajax({
            url: window.location.origin+"/StazioneFerroviaria/binari",
            type: "get", //send it through get method
            data: {
                binario: binario,
            },
            success: function (responseJson) {
                responseJson.forEach( element => {
                    var today = new Date();
                    var arrivoPrevisto = new Date(element.arrivoPrevisto);
                    if (today < arrivoPrevisto && element.stazioneArrivo != "Palermo") {
                        binari.push(element);
                    }
                });
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
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
</script>

</html>
