<%@ page import="dao.models.Utente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo</title>
    <link href="css/custom.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
    //allow access only if session exists
    Utente user = null;
    if(session.getAttribute("username") != null && session.getAttribute("user") != null){
        response.sendRedirect("/StazioneFerroviaria/home.jsp");
    }
%>

<div class="header">
    <div class="home-menu pure-menu pure-menu-horizontal pure-menu-fixed">
        <a class="pure-menu-heading" style="padding: 0;"><img src="./img/logo.png"></a>

        <ul class="pure-menu-list">
            <%--          <li class="pure-menu-item pure-menu-selected"><a href="#" class="pure-menu-link">Home</a></li>--%>
            <%--          <li class="pure-menu-item"><a href="#" class="pure-menu-link">Tour</a></li>--%>
            <%--          <li class="pure-menu-item"><a href="#" class="pure-menu-link">Sign Up</a></li>--%>
        </ul>
    </div>
</div>

<div class="splash-container">
    <div class="splash">
        <h1 class="splash-head">Stazione Palermo Centrale</h1>
        <div class="l-box-lrg pure-u-1 white-center pure-u-md-2-5">
            <%--            <h4 class="content-subhead">--%>
            <%--                Effettua il login per accedere ai servizi a te dedicati.--%>
            <%--            </h4>--%>
            <form class="pure-form pure-form-aligned" action="/StazioneFerroviaria/Login" method="POST">
                <fieldset>
                    <legend>Effettua il login per accedere ai servizi a te dedicati.</legend>

                    <div class="pure-control-group">
                        <label for="username">Username</label>
                        <input required id="username" name="username" type="text" placeholder="Inserisci l'username...">
                    </div>
                    <div class="pure-control-group">
                        <label for="password">Password</label>
                        <input required id="password" name="password" type="password" placeholder="Inserisci la password...">
                    </div>

                    <button type="submit" class="pure-button pure-button-primary">Accedi</button>
                </fieldset>
            </form>
            <c:choose>
                <c:when test="${not empty loginResult && loginResult == false}">
                    BANANA!!!
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>

            <%--
                    Boolean result = (Boolean) request.getAttribute("result");
                    if(result != null && !result) {
                        out.println("ERRATO!");
                    }
            --%>

        </div>
    </div>
</div>

<script src="js/jquery-3.4.1.js"></script>

</body>
</html>
