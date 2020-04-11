<%@ page import="dao.models.TrenoForm" %>
<%@ page import="java.util.List" %>
<%@ page import="controller.TrattaController" %>
<%@ page import="dao.repositories.TrattaRepository" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo - Admin Console</title>
    <link href="css/custom.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://unpkg.com/purecss@1.0.1/build/pure-min.css" integrity="sha384-" crossorigin="anonymous">

</head>
<body>
<%
    //allow access only if session exists
    String user = null;
    if(session.getAttribute("username") == null){
        response.sendRedirect("/StazioneFerroviaria/");
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
%>

<div class="header">
    <div class="home-menu pure-menu pure-menu-horizontal pure-menu-fixed">
        <a class="pure-menu-heading" style="padding: 0;"><img src="./img/logo.png"></a>

        <ul class="pure-menu-list">
            <li class="pure-menu-item pure-menu-selected"><a href="home.jsp" class="pure-menu-link">Home</a></li>
            <li class="pure-menu-item"><a onclick="logoutFunction()" class="pure-menu-link">Logout</a></li>
        </ul>
    </div>
</div>


<div class="splash-container">
    <div class="splash">
        <div class="l-box-lrg pure-u-1 pure-u-md-2-5">
            <div id="views">
                <div id="Admin-view">
                    <div id="choiceMenu">
                        <button id="partenze-button">Partenze</button>
                        <button id="arrivi-button">Arrivi</button>
                        <button id="ruoli-button">Ruoli</button>
                    </div>
                    <br/>
                    <div id="pageTable">
                        <div id="partenze-table">
                            <button id="createTrenoPartenza" onclick="openCreateModal(this.id)">Inserisci un nuovo treno in partenza!</button>
                            <br>
                            <table class="pure-table" id="tablePartenze">
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
                        </div>
                        <div id="arrivi-table">
                            <button id="createTrenoArrivo" onclick="openCreateModal(this.id)">Inserisci un nuovo treno in arrivo!</button>
                            <table class="pure-table" id="tableArrivi">
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
                        <div id="ruoli-table">
                            <table class="pure-table" id="tableRuoli">
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
                            <form action="/StazioneFerroviaria/treno" method="POST" onsubmit="return validateForm('Insert')">

                                <div id="errors"></div>
                                <h5>Inserisci un nuovo Treno</h5>

                                <label for="numeroTrenoInsert">Numero: </label>
                                <input required type="text" name="numeroTrenoInsert" id="numeroTrenoInsert" placeholder="Inserire numero treno">
                                <br/><br/>

                                <label for="stazionePartenzaInsert">Stazione di Partenza: </label>
                                <select id="stazionePartenzaInsert" name="stazionePartenzaInsert" required>
                                    <option selected disabled value> -- Seleziona una stazione -- </option>
                                </select>
                                <button id="addStazioneInsert" type="button" onclick="addStazioneIntermedia('Insert')">Aggiungi stazione intermedia</button>
                                <br/><br/>

                                <div id="scaliInsert"></div>

                                <label for="stazioneArrivoInsert">Stazione di Arrivo: </label>
                                <select id="stazioneArrivoInsert" name="stazioneArrivoInsert" required>
                                    <option selected disabled value> -- Seleziona una stazione -- </option>
                                </select>
                                <br/><br/>

                                <label for="giornoPartenzaInsert">Giorno: </label>
                                <input type="text" name="giornoPartenzaInsert" id="giornoPartenzaInsert" required placeholder="gg/mm/aaaa">
                                <br/><br/>

                                <label for="oraPartenzaInsert">Ora Partenza: </label>
                                <input type="text" name="oraPartenzaInsert" id="oraPartenzaInsert" required placeholder="hh:mm">
                                <br/><br/>

                                <label for="binarioInsert">Binario: </label>
                                <select id="binarioInsert" name="binarioInsert" required>
                                    <option selected disabled value> -- Seleziona un binario -- </option>
                                    <option value="1"> 1 </option>
                                    <option value="2"> 2 </option>
                                    <option value="3"> 3 </option>
                                    <option value="4"> 4 </option>
                                </select>

                                <input type="submit" name="tipoForm" id="insertButton" value="Inserisci treno">

                            </form>

                        </div>

                    </div>
                    <div id="updateModal" class="modal">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span id="closeUpdateModal" class="close">&times;</span>
                            <form action="/StazioneFerroviaria/treno" method="POST" onsubmit="return validateForm('Update')">

                                <h5>Update Treno</h5>

                                <label for="numeroTrenoUpdate">Numero: </label>
                                <input required disabled type="text" name="numeroTrenoUpdate" id="numeroTrenoUpdate" placeholder="Inserire numero treno">
                                <br/><br/>

                                <div id="scaliUpdate"></div>

                                <label for="giornoPartenzaUpdate">Giorno: </label>
                                <input type="text" name="giornoPartenzaUpdate" id="giornoPartenzaUpdate" required placeholder="gg/mm/aaaa">
                                <br/><br/>

                                <label for="oraPartenzaUpdate">Ora Partenza: </label>
                                <input type="text" name="oraPartenzaUpdate" id="oraPartenzaUpdate" required placeholder="hh:mm">
                                <br/><br/>

                                <label for="binarioUpdate">Binario: </label>
                                <select id="binarioUpdate" name="binarioUpdate" required>
                                    <option selected disabled value> -- Seleziona un binario -- </option>
                                    <option value="1"> 1 </option>
                                    <option value="2"> 2 </option>
                                    <option value="3"> 3 </option>
                                    <option value="4"> 4 </option>
                                </select>

                                <input type="submit" name="tipoForm" id="updateButton" value="Modifica treno">

                            </form>

                        </div>

                    </div>
                    <div id="deleteModal" class="modal">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span id="closeDeleteModal" class="close">&times;</span>
                            <p>Vuoi davvero eliminare questo treno?</p>
                            <button id="eliminaTreno">ELIMINA</button>
                        </div>

                    </div>
                </div>
                <div id="Partenze-view">
                    <div id="partenze-view-table">
                        <table class="pure-table" id="tablePartenzeView">
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
                        <table class="pure-table" id="tableArriviView">
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
                <div id="Binari-view">
                    <div id="binario-view-table">
                        <table class="pure-table" id="tableBinarioView">
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

    $(document).ready(function() {

        $(views).children('div').each(function () {
            $(this).hide();
        });

        showView();

        $.get("stazioni", function(responseJson) {
            stazioni = responseJson;
            appendStazioniToSelect(${"stazionePartenzaInsert"});
            appendStazioniToSelect(${"stazioneArrivoInsert"});
        });

        $.get("partenze", function(responseJson) {
            partenze = responseJson;
            var count = 0;
            var classTable = "";
            partenze.forEach( element => {
                count++;

                if(count%2 == 0){
                    classTable = "pure-table-odd";
                } else {
                    classTable = "pure-table-even";
                }
                $(tablePartenze).find('tbody').append("" +
                    "<tr class=\"" + classTable + "\" >\n" +
                    "<td>"+element.numeroTreno+"</td>\n" +
                    "<td>"+element.stazioneArrivo+"</td>\n" +
                    "<td>"+element.arrivoPrevisto+"</td>\n" +
                    "<td>"+element.stato+"</td>\n" +
                    // "<td>"+element.ritardo+"</td>\n" +
                    "<td>"+element.binario+"</td>\n" +
                    "<td><button class='button-warning pure-button' id=\"modificaTreno"+element.numeroTreno+"\">MODIFICA</button><button class='button-error pure-button' id=\"eliminaTreno"+element.numeroTreno+"\">ELIMINA</button></td>\n" +
                    "</tr>"
                );

                var today = new Date();
                var arrivoPrevisto = new Date(element.arrivoPrevisto);

                if (today < arrivoPrevisto){
                    $(tablePartenzeView).find('tbody').append("" +
                        "<tr class=\"" + classTable + "\" >\n" +
                        "<td>"+element.numeroTreno+"</td>\n" +
                        "<td>"+element.stazioneArrivo+"</td>\n" +
                        "<td>"+element.arrivoPrevisto+"</td>\n" +
                        "<td>"+element.stato+"</td>\n" +
                        // "<td>"+element.ritardo+"</td>\n" +
                        "<td>"+element.binario+"</td>\n" +
                        "</tr>"
                    );
                }
            })
            openModalTreno();
        });

        $.get("arrivi", function(responseJson) {
            arrivi = responseJson;
            var count = 0;
            var classTable = "";

            arrivi.forEach( element => {
                count++;

                if(count%2 == 0){
                    classTable = "pure-table-odd";
                } else {
                    classTable = "pure-table-even";
                }
                $(tableArrivi).find('tbody').append("" +
                    "<tr class=\"" + classTable + "\" >\n" +
                    "<td>"+element.numeroTreno+"</td>\n" +
                    "<td>"+element.stazionePartenza+"</td>\n" +
                    "<td>"+element.arrivoPrevisto+"</td>\n" +
                    "<td>"+element.stato+"</td>\n" +
                    // "<td>"+element.ritardo+"</td>\n" +
                    "<td>"+element.binario+"</td>\n" +
                    "<td><button class='button-warning pure-button' id=\"modificaTreno"+element.numeroTreno+"\">MODIFICA</button><button class='button-error pure-button' id=\"eliminaTreno"+element.numeroTreno+"\">ELIMINA</button></td>\n" +
                    "</tr>"
                );
                var today = new Date();
                var arrivoPrevisto = new Date(element.arrivoPrevisto);
                if (today < arrivoPrevisto){
                    $(tableArriviView).find('tbody').append("" +
                        "<tr class=\"" + classTable + "\" >\n" +
                        "<td>"+element.numeroTreno+"</td>\n" +
                        "<td>"+element.stazionePartenza+"</td>\n" +
                        "<td>"+element.arrivoPrevisto+"</td>\n" +
                        "<td>"+element.stato+"</td>\n" +
                        // "<td>"+element.ritardo+"</td>\n" +
                        "<td>"+element.binario+"</td>\n" +
                        "</tr>"
                    );
                }
            })
            openModalTreno();
        });

        $.get("binari", function(responseJson) {
            binari = responseJson;
            var count = 0;
            var classTable = "";

            binari.forEach( element => {
                count++;

                if(count%2 == 0){
                    classTable = "pure-table-odd";
                } else {
                    classTable = "pure-table-even";
                }
                $(tableBinarioView).find('tbody').append("" +
                    "<tr class=\"" + classTable + "\" >\n" +
                    "<td>"+element.numeroTreno+"</td>\n" +
                    "<td>"+element.stazioneArrivo+"</td>\n" +
                    "<td>"+element.arrivoPrevisto+"</td>\n" +
                    "<td>"+element.stato+"</td>\n" +
                    // "<td>"+element.ritardo+"</td>\n" +
                    "<td>"+element.binario+"</td>\n" +
                    "</tr>"
                );
            })
        });

    });


    function openModalTreno() {
        $('[id^=modificaTreno]').each(function() {
            $(this).on("click", function(){
                toUpdate = this.id.substring(13);

                $.ajax({
                    url: "treno",
                    type: "get", //send it through get method
                    data: {
                        toUpdate: toUpdate,
                    },
                    success: function(responseJson) {
                        treno = responseJson;
                        $("#numeroTrenoUpdate").val(treno.numeroTreno);
                        $("#giornoPartenzaUpdate").val(treno.giornoPartenza);
                        $("#oraPartenzaUpdate").val(treno.oraPartenza);
                        $("#binarioUpdate").val(treno.binario);
                        var idSelect = -1;
                        document.getElementById("scaliUpdate").innerHTML = "";

                        treno.tappe.forEach( function (element) {

                            var select = document.createElement("select");
                            select.id = "tappaIntermediaUpdate"+idSelect;
                            select.name = "tappaIntermediaUpdate";
                            select.setAttribute("disabled", true);
                            idSelect++;
                            select.innerHTML = '<option disabled selected value>' + element + ' </option>';

                            var label = document.createElement("label");
                            label.setAttribute("for", select.id);
                            if(idSelect == 0){
                                label.innerHTML = "Stazione di Partenza: ";
                            } else if ( idSelect == treno.tappe.length -1) {
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
                    error: function(xhr) {
                        //Do Something to handle error
                    }
                });

                var modal = document.getElementById("updateModal");
                var span = document.getElementById("closeUpdateModal");
                modal.style.display = "block";
                span.onclick = function() {
                    modal.style.display = "none";
                }
                window.onclick = function(event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }
            });
        });

        $('[id^=eliminaTreno]').each(function() {
            $(this).on("click", function(){
                toDelete = this.id.substring(12);
                var modal = document.getElementById("deleteModal");
                var span = document.getElementById("closeDeleteModal");
                modal.style.display = "block";
                span.onclick = function() {
                    modal.style.display = "none";
                }
                window.onclick = function(event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }
            });
        });
    }

    // $('#createTreno').on("click", function(){
    function openCreateModal(buttonId) {

        if(buttonId == "createTrenoPartenza"){
            $(stazionePartenzaInsert).empty();
            $("<option>").val("Palermo").text("Palermo").appendTo(stazionePartenzaInsert);
            $(stazionePartenzaInsert).val('Palermo');
            $(stazionePartenzaInsert); //.prop( "disabled", true );
            $(stazioneArrivoInsert).empty();
            $(stazioneArrivoInsert).html("<option selected disabled value> -- Seleziona una stazione -- </option>");
            appendStazioniToSelect(stazioneArrivoInsert);
            $(stazioneArrivoInsert).prop( "disabled", false );
            $(scaliInsert).empty();
            idSelect = 0;
        } else {
            $(stazionePartenzaInsert).empty();
            $(stazionePartenzaInsert).html("<option selected disabled value> -- Seleziona una stazione -- </option>");
            appendStazioniToSelect(stazionePartenzaInsert);
            $(stazionePartenzaInsert).prop( "disabled", false );
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
        span.onclick = function() {
            modal.style.display = "none";
        }
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    }

    $("#eliminaTreno").click(function(e) {
        e.preventDefault();
        $.ajax({
            url: "treno",
            type: "delete", //send it through get method
            data: {
                toDelete : toDelete,
            },
            success: function(responseJson) {
                location.reload();
            },
            error: function(xhr) {
                //Do Something to handle error
            }
        });
    });

    $("#updateButton").click(function(e) {
        e.preventDefault();

        numeroTreno = toUpdate;
        giornoPartenza = $("#giornoPartenzaUpdate").val();
        oraPartenza = $("#oraPartenzaUpdate").val();
        binario = $("#binarioUpdate").val();

        $.ajax({
            url: "treno",
            type: "put", //send it through get method
            data: {
                numeroTreno : numeroTreno,
                giornoPartenza : giornoPartenza,
                oraPartenza : oraPartenza,
                binario : binario
            },
            success: function(responseJson) {
                location.reload();
            },
            error: function(xhr) {
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
        mostrare = visualizzazione+'-view';
        $("body").find('#' + mostrare).show();
    }

    function logoutFunction() {
        $.ajax({
            url: "logout",
            type: "POST", //send it through get method
            success: function(responseJson) {
                location.reload();
            },
            error: function(xhr) {
                //Do Something to handle error
            }
        });
    }

</script>

</html>
