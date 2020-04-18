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
    if(session.getAttribute("username") == null){
        response.sendRedirect("/StazioneFerroviaria/");
        return;
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

    java.util.ArrayList<String> userRoleList = (java.util.ArrayList<String>) request.getSession().getAttribute("privileges");
    if (userRoleList == null || userRoleList.isEmpty()){
        response.sendRedirect("/StazioneFerroviaria/");
    }

%>

<div class="header">
    <div class="home-menu pure-menu pure-menu-horizontal pure-menu-fixed">
        <a class="pure-menu-heading" style="padding: 0;"><img src="./img/logo.png"></a>

        <ul class="pure-menu-list">
            <li class="pure-menu-item cursor-pointer"><a onclick="logoutFunction()" class="pure-menu-link">Logout</a></li>
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
                            for(String role : userRoleList ) {
                        %>
                        <option value="<%=role%>"><%=role%></option>
                        <% } %>
                    </select>

                    <button id="impostaVisualizzazione" class="pure-button pure-button-primary" type="submit">Imposta Visualizzazione</button>
                </fieldset>
            </form>
        </div>
    </div>
</div>

<script src="js/jquery-3.4.1.js"></script>
<script>
    function logoutFunction() {
        $.ajax({
            url: "logout",
            type: "POST", //send it through get method
            success: function(responseJson) {
                window.location.href = "/StazioneFerroviaria/";
            },
            error: function(xhr) {
                //Do Something to handle error
            }
        });
    }
</script>

</body>
</html>
