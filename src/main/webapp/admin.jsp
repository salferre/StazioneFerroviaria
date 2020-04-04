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
</head>
<body>
<div id="choiceMenu">
    <button id="arriviButton">Arrivi</button>
    <button id="partenzeButton">Partenze</button>
    <button id="ruoliButton">Ruoli</button>
</div>
<br/>
<button id="createTreno">Inserisci un nuovo treno!</button>

<table id="tableArrivi">
    <tbody>
    <tr>
        <th>Numero Treno</th>
        <th>Stazione di Partenza</th>
        <th>Arrivo Previsto</th>
        <th>Stato</th>
        <%--            <th>Ritardo(?)</th>--%>
        <th>Binario</th>
        <th>Azioni</th>
    </tr>
    </tbody>
</table>


<div id="buttons">
    <button id="insert-button">Insert</button>
    <button id="update-button">Update</button>
    <button id="delete-button">Delete</button>
</div>

<div id="forms">
    <div id="insert-form" >
        <form action="/StazioneFerroviaria/admin" method="POST" onsubmit="return validateForm('Insert')">
        </form>
    </div>
    <div id="update-form" >
        <form action="/StazioneFerroviaria/admin" method="GET"> <%--TODO capire come richiamare l'update lato server--%>
        </form>
    </div>
    <div id="delete-form">
        <form action="/StazioneFerroviaria/admin" method="GET"><%-- onsubmit="return validateForm('Delete')">--%>
        </form>
    </div>
</div>

<div id="createModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">
        <span id="closeCreateModal" class="close">&times;</span>
        <form action="/StazioneFerroviaria/treno" method="POST" onsubmit="return validateForm('Insert')">

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
            <input type="text" name="binarioInsert" id="binarioInsert" required placeholder="Inserire binario">

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


<%--            <label for="stazionePartenzaUpdate">Stazione di Partenza: </label>--%>
<%--            <select id="stazionePartenzaUpdate" name="stazionePartenzaUpdate" required disabled>--%>
<%--                <option selected disabled value> -- Seleziona una stazione -- </option>--%>
<%--            </select>--%>
<%--            <br/><br/>--%>

            <div id="scaliUpdate"></div>

<%--            <label for="stazioneArrivoUpdate">Stazione di Arrivo: </label>--%>
<%--            <select id="stazioneArrivoUpdate" name="stazioneArrivoUpdate" required disabled>--%>
<%--                <option selected disabled value> -- Seleziona una stazione -- </option>--%>
<%--            </select>--%>
<%--            <br/><br/>--%>

            <label for="giornoPartenzaUpdate">Giorno: </label>
            <input type="text" name="giornoPartenzaUpdate" id="giornoPartenzaUpdate" required placeholder="gg/mm/aaaa">
            <br/><br/>

            <label for="oraPartenzaUpdate">Ora Partenza: </label>
            <input type="text" name="oraPartenzaUpdate" id="oraPartenzaUpdate" required placeholder="hh:mm">
            <br/><br/>

            <label for="binarioUpdate">Binario: </label>
            <input type="text" name="binarioUpdate" id="binarioUpdate" required placeholder="Inserire binario">

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

<c:choose>
    <c:when test="${empty result}"></c:when>
    <c:when test="${not empty result && result == true}">
        ${result}
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

    $(document).ready(function() {

        $.get("stazioni", function(responseJson) {
            stazioni = responseJson;
            appendStazioniToSelect(${"stazionePartenzaInsert"});
            appendStazioniToSelect(${"stazioneArrivoInsert"});
        });

        $.get("partenze", function(responseJson) {
            partenze = responseJson;

            partenze.forEach( element => {
                $(tableArrivi).find('tbody').append("" +
                    "<tr>\n" +
                    "<td>"+element.numeroTreno+"</td>\n" +
                    "<td>"+element.stazionePartenza+"</td>\n" +
                    "<td>"+element.arrivoPrevisto+"</td>\n" +
                    "<td>"+element.stato+"</td>\n" +
                    // "<td>"+element.ritardo+"</td>\n" +
                    "<td>"+element.binario+"</td>\n" +
                    "<td><button id=\"modificaTreno"+element.numeroTreno+"\">MODIFICA</button><button id=\"eliminaTreno"+element.numeroTreno+"\">ELIMINA</button></td>\n" +
                    "</tr>"
                );
            })
            openModalTreno();
        });

        $.get("arrivi", function(responseJson) {
            arrivi = responseJson;
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
                        var idSelect = 0;
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
                            if(idSelect == 1){
                                label.innerHTML = "Stazione di Partenza: ";
                            } else if ( idSelect == treno.tappe.length) {
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

    $('#createTreno').on("click", function(){
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
    });

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

</script>

</html>
