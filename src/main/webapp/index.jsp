<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Stazione di Palermo</title>
  </head>
  <body>
    Benvenuti nella Stazione Ferroviaria di Palermo!
    <form action="/StazioneFerroviaria/Login" method="POST">
      <h5>LOGIN </h5>
      Username: <input type="text" name="username">
      <br/><br/>
      Password: <input type="password" name="password">
      <br/><br/>
      <input type="submit" value="Accedi">

      <c:choose>
        <c:when test="${not empty loginResult && loginResult == false}">
          BANANA!!!
        </c:when>
        <c:otherwise>
        </c:otherwise>
      </c:choose>
    </form>
  </body>
</html>
