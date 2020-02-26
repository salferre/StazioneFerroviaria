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

            <input type="submit" id="insertButton" value="Inserisci treno">

        </form>

    </div>

    <div id="update-form" >

        <form action="/StazioneFerroviaria/admin" method="POST" onsubmit="return validateForm('Update')">

            <h5>Update Treno</h5>

            <label for="numeroTrenoUpdate">Numero: </label>
            <input required type="text" name="numeroTrenoUpdate" id="numeroTrenoUpdate" placeholder="Inserire numero treno">
            <br/><br/>

            <label for="stazionePartenzaUpdate">Stazione di Partenza: </label>
            <select id="stazionePartenzaUpdate" name="stazionePartenzaUpdate" required>
                <option selected disabled value> -- Seleziona una stazione -- </option>
            </select>
            <button id="addStazioneUpdate" type="button" onclick="addStazioneIntermedia('Update')">Aggiungi stazione intermedia</button>
            <br/><br/>

            <div id="scaliUpdate"></div>

            <label for="stazioneArrivoUpdate">Stazione di Arrivo: </label>
            <select id="stazioneArrivoUpdate" name="stazioneArrivoUpdate" required>
                <option selected disabled value> -- Seleziona una stazione -- </option>
            </select>
            <br/><br/>

            <label for="giornoPartenzaUpdate">Giorno: </label>
            <input type="text" name="giornoPartenzaUpdate" id="giornoPartenzaUpdate" required placeholder="gg/mm/aaaa">
            <br/><br/>

            <label for="oraPartenzaUpdate">Ora Partenza: </label>
            <input type="text" name="oraPartenzaUpdate" id="oraPartenzaUpdate" required placeholder="hh:mm">
            <br/><br/>

            <label for="binarioUpdate">Binario: </label>
            <input type="text" name="binarioUpdate" id="binarioUpdate" required placeholder="Inserire binario">

            <input type="submit" id="updateButton" value="Modifica treno">

        </form>

    </div>

    <div id="delete-form">

        <form action="/StazioneFerroviaria/admin" method="POST" onsubmit="return validateForm('Delete')">

            <h5>Delete Treno</h5>

            <label for="numeroTrenoDelete">Numero: </label>
            <input required type="text" name="numeroTrenoDelete" id="numeroTrenoDelete" placeholder="Inserire numero treno">
            <br/><br/>

            <label for="stazionePartenzaDelete">Stazione di Partenza: </label>
            <select id="stazionePartenzaDelete" name="stazionePartenzaDelete" required>
                <option selected disabled value> -- Seleziona una stazione -- </option>
            </select>
            <button id="addStazioneDelete" type="button" onclick="addStazioneIntermedia('Delete')">Aggiungi stazione intermedia</button>
            <br/><br/>

            <div id="scaliDelete"></div>

            <label for="stazioneArrivoDelete">Stazione di Arrivo: </label>
            <select id="stazioneArrivoDelete" name="stazioneArrivoDelete" required>
                <option selected disabled value> -- Seleziona una stazione -- </option>
            </select>
            <br/><br/>

            <label for="giornoPartenzaDelete">Giorno: </label>
            <input type="text" name="giornoPartenzaDelete" id="giornoPartenzaDelete" required placeholder="gg/mm/aaaa">
            <br/><br/>

            <label for="oraPartenzaDelete">Ora Partenza: </label>
            <input type="text" name="oraPartenzaDelete" id="oraPartenzaDelete" required placeholder="hh:mm">
            <br/><br/>

            <label for="binarioDelete">Binario: </label>
            <input type="text" name="binarioDelete" id="binarioDelete" required placeholder="Inserire binario">

            <input type="submit" id="DeleteButton" value="Elimina treno">

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
            appendStazioniToSelect(${"stazionePartenzaInsert"});
            appendStazioniToSelect(${"stazioneArrivoInsert"});
        });

    });
</script>

</html>
