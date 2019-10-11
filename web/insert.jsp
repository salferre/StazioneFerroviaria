<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione Ferroviaria</title>
</head>
<body>
<form action="InsertTreno" method="POST" >

    <h5>Insert Treno</h5>

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

    <input type="submit" value="Insert">
</form>
</body>
</html>
