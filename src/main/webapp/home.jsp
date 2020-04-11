<%@ page import="dao.models.Utente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo</title>
    <link href="css/custom.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://unpkg.com/purecss@1.0.1/build/pure-min.css" integrity="sha384-" crossorigin="anonymous">
</head>
<body>
<%
    //allow access only if session exists
    Utente user = null;
    if(session.getAttribute("username") == null){
        response.sendRedirect("/StazioneFerroviaria/");
    }else user = (Utente) session.getAttribute("user");
    String userName = null;
    String sessionID = null;
    Cookie[] cookies = request.getCookies();
    if(cookies !=null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals(user)) userName = cookie.getValue();
        }
    }else{
        sessionID = session.getId();
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
        <div class="l-box-lrg pure-u-1 pure-u-md-2-5">
            <form class="pure-form pure-form-stacked little-white" action="/StazioneFerroviaria/OpzioniVisualizzazione" method="POST">
                <fieldset>

                    <label for="opzioniVisualizzazione">Scegliere una vista: </label>
                    <select class="centra" id="opzioniVisualizzazione" name="opzioniVisualizzazione" required>
                        <option selected disabled value> -- Seleziona una vista -- </option>
                        <%
                            java.util.ArrayList<String> userRoleList = (java.util.ArrayList<String>) request.getSession().getAttribute("privileges");
                            for(String role : userRoleList ) {
                        %>
                        <option value="<%=role%>"><%=role%></option>
                        <% } %>
                    </select>

                    <button id="impostaVisualizzazione" type="submit">Imposta Visualizzazione</button>
                    <form action="/StazioneFerroviaria/logout" method="POST">
                        <button type="submit" value="Logout">Logout</button>
                    </form>
                </fieldset>
            </form>
        </div>
    </div>
</div>

<script src="js/jquery-3.4.1.js"></script>

</body>
</html>
