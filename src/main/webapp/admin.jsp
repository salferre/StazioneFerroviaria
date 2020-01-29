<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.models.Stazione" %>
<%@ page import="controller.StazioneController" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo - Admin</title>

    <script src="js/jquery-3.4.1.js"></script>

</head>
<body>
Cosa vuoi fare?
<div id="buttons">
    <button id="insert-button">Insert</button>
    <button id="update-button">Update</button>
    <button id="delete-button">Delete</button>
</div>

<div id="forms">
    <div id="insert-form" >

        <form action="InsertTreno" method="POST">

            <h5>Insert Treno</h5>

            Numero: <input type="text" name="numero" id="numero" ><br /><br />
            Stazione di Partenza:
            <select id="stazionePartenza">
                <option disabled selected value> -- Seleziona una stazione -- </option>
            </select>
            <button id="addStazione" type="button" onclick="addStazioneIntermedia()">Aggiungi stazione intermedia</button>
            <br /><br />

            <div id="scali"></div>

            Stazione di Arrivo:
            <select id="stazioneArrivo">
                <option disabled selected value> -- Seleziona una stazione -- </option>
            </select>
            <br /><br />
            Giorno: <input type="text" name="giorno" id="giorno" ><br /><br />
            Ora Partenza: <input type="text" name="oraPartenza" id="oraPartenza" ><br /><br />
            Binario: <input type="text" name="binario" id="binario" >

            <input type="submit" value="Insert">

        </form>

    </div>

    <div id="update-form" >

        <form action="UpdateTreno" method="POST">

            <h5>Update Treno</h5>

            Numero: <input type="text" name="numero" id="numero" ><br /><br />
            Stazione di Partenza: <input type="text" name="stazionePartenza" id="stazionePartenza" ><br /><br />
            Stazione di Arrivo: <input type="text" name="stazioneArrivo" id="stazioneArrivo" ><br /><br />
            Giorno: <input type="text" name="giorno" id="giorno" ><br /><br />
            Ora Partenza: <input type="text" name="oraPartenza" id="oraPartenza" ><br /><br />
            Binario: <input type="text" name="binario" id="binario" >

            <%--    <input type="radio" name="sala" value="Sala_1" id="sala"> Sala 1 <br />--%>
            <%--    <input type="radio" name="sala" value="Sala_2" id="sala"> Sala 2 <br />--%>
            <%--    <input type="radio" name="sala" value="Sala_3" id="sala"> Sala 3 <br />--%>
            <%--    <input type="radio" name="sala" value="Sala_4" id="sala"> Sala 4 <br />--%>

            <input type="submit" value="Update">

            <% for ( Stazione stazione : StazioneController.getAllStazioni() ) {
                out.println(stazione.getNomeStazione());
            } %>

        </form>

    </div>

    <div id="delete-form">

        <form action="DeleteTreno" method="POST">

            <h5>Delete Treno</h5>

            Numero: <input type="text" name="numero" id="numero" ><br /><br />
            Stazione di Partenza: <input type="text" name="stazionePartenza" id="stazionePartenza" ><br /><br />
            Stazione di Arrivo: <input type="text" name="stazioneArrivo" id="stazioneArrivo" ><br /><br />
            Giorno: <input type="text" name="giorno" id="giorno" ><br /><br />
            Ora Partenza: <input type="text" name="oraPartenza" id="oraPartenza" ><br /><br />
            Binario: <input type="text" name="binario" id="binario" >

            <%--    <input type="radio" name="sala" value="Sala_1" id="sala"> Sala 1 <br />--%>
            <%--    <input type="radio" name="sala" value="Sala_2" id="sala"> Sala 2 <br />--%>
            <%--    <input type="radio" name="sala" value="Sala_3" id="sala"> Sala 3 <br />--%>
            <%--    <input type="radio" name="sala" value="Sala_4" id="sala"> Sala 4 <br />--%>

            <input type="submit" value="Delete">

            <% for ( Stazione stazione : StazioneController.getAllStazioni() ) {
                out.println(stazione.getNomeStazione());
            } %>

        </form>
    </div>
</div>
</body>

<script>

    var stazioni = {};
    $(document).ready(function() {

        $.get("admin", function(responseJson) {
            stazioni = responseJson;
        });

        $(forms).children('div').each(function () {
            $(this).hide();
        });

        appendStazioniToSelect("stazionePartenza");
        appendStazioniToSelect("stazioneArrivo");

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

    function appendStazioniToSelect(selectId) {
        var $select = $(selectId);
        $.each(stazioni, function(index, category) {
            $("<option>").val(category.idStazione).text(category.nomeStazione).appendTo($select);
        });
    }

    function addStazioneIntermedia() {
        var node = document.createElement("select");
        var textNode = document.createTextNode("TESTO");
        node.appendChild(textNode);
        document.getElementById("scali").appendChild(node);
    }

    function closeOthers(nonChiudere) {
        $(forms).children('div').each(function () {
            if($(this).is(":visible") && $(this).attr('id') != nonChiudere){
                $(this).hide();
            }
        });
    }

</script>

</html>
