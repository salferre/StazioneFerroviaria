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

            <h5>Insert Treno</h5>

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

    <div id="update-form" >

        <%--        <form action="/StazioneFerroviaria/admin" method="PUT" onsubmit="return validateForm('Update')">--%>

        <form action="/StazioneFerroviaria/admin" method="GET"> <%--TODO capire come richiamare l'update lato server--%>
            <h5>Update Treno</h5>

            <label for="numeroTrenoUpdate">Numero: </label>
            <input required type="text" name="numeroTrenoUpdate" id="numeroTrenoUpdate" placeholder="Inserire numero treno">
            <input type="button" name="caricaTreno" id="caricaTreno" value="Carica treno">
            <br/><br/>

            <%--            <label for="stazionePartenzaUpdate">Stazione di Partenza: </label>--%>
            <%--            <select id="stazionePartenzaUpdate" name="stazionePartenzaUpdate">--%>
            <%--                <option selected disabled value> -- Seleziona una stazione -- </option>--%>
            <%--            </select>--%>
            <%--            <button id="addStazioneUpdate" type="button" io="addStazioneIntermedia('Update')">Aggiungi stazione intermedia</button>--%>
            <%--            <br/><br/>--%>

            <%--            <div id="scaliUpdate"></div>--%>

            <%--            <label for="stazioneArrivoUpdate">Stazione di Arrivo: </label>--%>
            <%--            <select id="stazioneArrivoUpdate" name="stazioneArrivoUpdate">--%>
            <%--                <option selected disabled value> -- Seleziona una stazione -- </option>--%>
            <%--            </select>--%>
            <%--            <br/><br/>--%>

            <%--            <label for="giornoPartenzaUpdate">Giorno: </label>--%>
            <%--            <input type="text" name="giornoPartenzaUpdate" id="giornoPartenzaUpdate" placeholder="gg/mm/aaaa">--%>
            <%--            <br/><br/>--%>

            <%--            <label for="oraPartenzaUpdate">Ora Partenza: </label>--%>
            <%--            <input type="text" name="oraPartenzaUpdate" id="oraPartenzaUpdate" placeholder="hh:mm">--%>
            <%--            <br/><br/>--%>

            <%--            <label for="binarioUpdate">Binario: </label>--%>
            <%--            <input type="text" name="binarioUpdate" id="binarioUpdate" placeholder="Inserire binario">--%>

            <%--            <input type="submit" name="tipoForm" id="updateButton" value="Modifica treno">--%>

        </form>

    </div>

    <div id="delete-form">

        <form action="/StazioneFerroviaria/admin" method="GET"><%--            onsubmit="return validateForm('Delete')">--%>

            <h5>Delete Treno</h5>

            <label for="numeroTrenoDelete">Numero: </label>
            <input required type="text" name="numeroTrenoDelete" id="numeroTrenoDelete" placeholder="Inserire numero treno">
            <br/><br/>
            <input type="submit" name="tipoForm" id="DeleteButton" value="Elimina treno">

        </form>
    </div>
</div>

<div id="deleteModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">
        <span class="close">&times;</span>
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
                console.log('MODIFICA!');
            });
        });

        $('[id^=eliminaTreno]').each(function() {
            $(this).on("click", function(){
                console.log(this.id);
                toDelete = this.id.substring(12);

                // Get the modal
                var modal = document.getElementById("deleteModal");

                // Get the button that opens the modal
                var btn = document.getElementById("myBtn");

                // Get the <span> element that closes the modal
                var span = document.getElementsByClassName("close")[0];

                // When the user clicks on the button, open the modal
                modal.style.display = "block";

                // When the user clicks on <span> (x), close the modal
                span.onclick = function() {
                    modal.style.display = "none";
                }

                // When the user clicks anywhere outside of the modal, close it
                window.onclick = function(event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }


            });
        });
    }

    $("#eliminaTreno").click(function(e) {
        e.preventDefault();

        $.ajax({
            url: "deleteTreno",
            type: "post", //send it through get method
            data: {
                toDelete: toDelete,
            },
            success: function(responseJson) {
                location.reload();
            },
            error: function(xhr) {
                //Do Something to handle error
            }
        });


    });

    $("#caricaTreno").click(function(e) {
        e.preventDefault();
        var numeroTrenoUpdate = $("#numeroTrenoUpdate").val();

        $.ajax({
            url: "treno",
            type: "get", //send it through get method
            data: {
                numeroTrenoUpdate: numeroTrenoUpdate,
            },
            success: function(responseJson) {
                treno = responseJson;
            },
            error: function(xhr) {
                //Do Something to handle error
            }
        });
    });

</script>

</html>
