<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo - Admin</title>
</head>
<body>
Cosa vuoi fare?
<div id="buttons">
    <button id="insert-button">Insert</button>
    <button id="update-button">Update</button>
    <button id="delete-button">Delete</button>
</div>

<div id="errors">

</div>

<div id="forms">
    <div id="insert-form" >

        <form action="/StazioneFerroviaria/admin" method="POST" onsubmit="return validateForm('insert')">

            <h5>Insert Treno</h5>

            <label for="numeroTreno">Numero: </label>
            <input required type="text" name="numeroTreno" id="numeroTreno" placeholder="Inserire numero treno">
            <br/><br/>

            <label for="stazionePartenza">Stazione di Partenza: </label>
            <select id="stazionePartenza" name="stazionePartenza" required>
                <option selected disabled value> -- Seleziona una stazione -- </option>
            </select>
            <button id="addStazione" type="button" onclick="addStazioneIntermedia()">Aggiungi stazione intermedia</button>
            <br/><br/>

            <div id="scali"></div>

            <label for="stazioneArrivo">Stazione di Arrivo: </label>
            <select id="stazioneArrivo" name="stazioneArrivo" required>
                <option selected disabled value> -- Seleziona una stazione -- </option>
            </select>
            <br/><br/>

            <label for="giornoPartenza">Giorno: </label>
            <input type="text" name="giornoPartenza" id="giornoPartenza" required placeholder="gg/mm/aaaa">
            <br/><br/>

            <label for="oraPartenza">Ora Partenza: </label>
            <input type="text" name="oraPartenza" id="oraPartenza" required placeholder="hh:mm">
            <br/><br/>

            <label for="binario">Binario: </label>
            <input type="text" name="binario" id="binario" required placeholder="Inserire binario">

            <input type="submit" id="insertButton" value="Inserisci treno">

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

<script>

    <%--var stazionePartenza = ${"stazionePartenza"};--%>
    <%--var stazioneArrivo = ${"stazioneArrivo"};--%>

</script>

<script src="js/jquery-3.4.1.js"></script>
<script src="js/admin.js" type="text/javascript"></script>

</body>

<script>
    $(document).ready(function() {

        $.get("admin", function(responseJson) {
            stazioni = responseJson;
            appendStazioniToSelect(${"stazionePartenza"});
            appendStazioniToSelect(${"stazioneArrivo"});
        });

    });
</script>

</html>
