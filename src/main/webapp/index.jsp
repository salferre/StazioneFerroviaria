<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.models.Utente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo</title>
    <link href="css/custom.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
    if(session.getAttribute("username") != null){
        response.sendRedirect("/StazioneFerroviaria/home.jsp");
    }
%>

<div class="header">
    <div class="home-menu salvo-menu salvo-menu-horizontal salvo-menu-fixed">
        <a class="salvo-menu-heading" style="padding: 0;"><img src="./img/logo.png"></a>

        <ul class="salvo-menu-list">

        </ul>
    </div>
</div>

<div class="splash-container">
    <div class="splash">
        <h1 class="splash-head">Stazione Palermo Centrale</h1>
        <div class="l-box-lrg salvo-u-1 white-center salvo-u-md-2-5">
            <form class="salvo-form salvo-form-aligned" action="/StazioneFerroviaria/Login" method="POST">
                <fieldset>
                    <legend>Effettua il login per accedere ai servizi a te dedicati.</legend>

                    <div class="salvo-control-group">
                        <label for="username">Username</label>
                        <input required id="username" name="username" type="text" placeholder="Inserisci l'username...">
                    </div>
                    <div class="salvo-control-group">
                        <label for="password">Password</label>
                        <input required id="password" name="password" type="password" placeholder="Inserisci la password...">
                    </div>

                    <button type="submit" class="salvo-button salvo-button-primary">Accedi</button>
                </fieldset>
            </form>
            <c:if test="${not empty loginResult}">
                <div class="alert-login">
                    <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
                    <strong>Attenzione!</strong> Username e/o password errati.
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="js/jquery-3.4.1.js"></script>

</body>
</html>
