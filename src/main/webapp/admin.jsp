<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.models.Stazione" %>
<%@ page import="controller.StazioneController" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo - Admin</title>

    <script src="js/jquery-3.4.1.js"></script>

<%--    <link rel="stylesheet" href="jquery-ui.min.css">--%>
<%--    <script src="external/jquery/jquery.js"></script>--%>
<%--    <script src="jquery-ui.min.js"></script>--%>


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

            <label for="numero">Numero: </label> <input type="text" name="numero" id="numero" ><br /><br />

            <label for="stazionePartenza">Stazione di Partenza: </label>
            <select id="stazionePartenza">
                <option disabled selected value> -- Seleziona una stazione -- </option>
            </select>
            <button id="addStazione" type="button" onclick="addStazioneIntermedia()">Aggiungi stazione intermedia</button>
            <br /><br />

            <div id="scali"></div>

            <label for="stazioneArrivo">Stazione di Arrivo: </label>
            <select id="stazioneArrivo">
                <option disabled selected value> -- Seleziona una stazione -- </option>
            </select>
            <br /><br />

            <label for="giorno">Giorno: </label><input type="text" name="giorno" id="giorno" ><br /><br />

            <label for="oraPartenza">Ora Partenza: </label><input type="text" name="oraPartenza" id="oraPartenza" ><br /><br />

            <label for="binario">Binario: </label><input type="text" name="binario" id="binario" >

            <input type="submit" value="Insert">

        </form>

    </div>

    <div id="update-form" >

        <form action="UpdateTreno" method="POST">

            <h5>Update Treno</h5>

            <label for="numero">Numero:</label> <input type="text" name="numero" id="numero" ><br /><br />
            <label for="stazionePartenza">Stazione di Partenza:</label><input type="text" name="stazionePartenza" id="stazionePartenza" ><br /><br />
            <label for="stazioneArrivo">Stazione di Arrivo:</label><input type="text" name="stazioneArrivo" id="stazioneArrivo" ><br /><br />
            <label for="giorno">Giorno:</label><input type="text" name="giorno" id="giorno" ><br /><br />
            <label for="oraPartenza">Ora Partenza:</label><input type="text" name="oraPartenza" id="oraPartenza" ><br /><br />
            <label for="binario">Binario:</label><input type="text" name="binario" id="binario" >

            <input type="submit" value="Update">

        </form>

    </div>

    <div id="delete-form">

        <form action="DeleteTreno" method="POST">

            <h5>Delete Treno</h5>

            <label for="numero">Numero:</label> <input type="text" name="numero" id="numero" ><br /><br />
            <label for="stazionePartenza">Stazione di Partenza:</label><input type="text" name="stazionePartenza" id="stazionePartenza" ><br /><br />
            <label for="stazioneArrivo">Stazione di Arrivo:</label><input type="text" name="stazioneArrivo" id="stazioneArrivo" ><br /><br />
            <label for="giorno">Giorno:</label><input type="text" name="giorno" id="giorno" ><br /><br />
            <label for="oraPartenza">Ora Partenza:</label><input type="text" name="oraPartenza" id="oraPartenza" ><br /><br />
            <label for="binario">Binario:</label><input type="text" name="binario" id="binario" >

            <input type="submit" value="Delete">

        </form>
    </div>
</div>
</body>

<script>
    var stazioni = {};
    $(document).ready(function() {

        $.get("admin", function(responseJson) {
            stazioni = responseJson;
            appendStazioniToSelect(${"stazionePartenza"});
            appendStazioniToSelect(${"stazioneArrivo"});
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

    function appendStazioniToSelect(selectId) {
        $.each(stazioni, function(index, category) {
            $("<option>").val(category.idStazione).text(category.nomeStazione).appendTo(selectId);
        });
    }

    var idSelect = 0;

    function addStazioneIntermedia() {
        var select = document.createElement("select");
        select.id = "tappaIntermedia"+idSelect;
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

    function closeOthers(nonChiudere) {
        $(forms).children('div').each(function () {
            if($(this).is(":visible") && $(this).attr('id') != nonChiudere){
                $(this).hide();
            }
        });
    }

    // $( "#giorno" ).datepicker();

</script>

</html>
