<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione Ferroviaria</title>
</head>
<body>
<form action="/StazioneFerroviaria/Login" method="post">
    <h5>REGISTRAZIONE </h5>
    Username: <input type="text" name="username">
    <br/><br/>
    Password: <input type="password" name="password">
    <br/><br/>
    <input type="submit" value="Accedi">
    <%
        Boolean result = (Boolean) request.getAttribute("result");
        if(result != null && !result) {
            out.println("ERRATO!");
        }
    %>
</form>
</body>
</html>