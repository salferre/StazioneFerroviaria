<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo</title>
</head>
<body>
<form action="/StazioneFerroviaria/Login" method="POST">
    <h5>REGISTRAZIONE </h5>
    Username: <input type="text" name="username">
    <br/><br/>
    Password: <input type="password" name="password">
    <br/><br/>
    <input type="submit" value="Accedi">

    <c:if test="${not empty result}">
        ERRATO!!!
    </c:if>

<%--    <%--%>
<%--        Boolean result = (Boolean) request.getAttribute("result");--%>
<%--        if(result != null && !result) {--%>
<%--            out.println("ERRATO!");--%>
<%--        }--%>
<%--    %>--%>
</form>
</body>
</html>
