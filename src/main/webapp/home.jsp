<%@ page import="dao.models.Utente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stazione di Palermo</title>
    <link href="css/custom.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
    if(session.getAttribute("username") == null){
        response.sendRedirect("/StazioneFerroviaria/");
        return;
    }

    java.util.ArrayList<String> userRoleList = (java.util.ArrayList<String>) request.getSession().getAttribute("privileges");
    if (userRoleList == null || userRoleList.isEmpty()){
        response.sendRedirect("/StazioneFerroviaria/");
    }
%>

<div class="header">
    <div class="home-menu salvo-menu salvo-menu-horizontal salvo-menu-fixed">
        <a class="salvo-menu-heading" style="padding: 0;"><img src="./img/logo.png"></a>

        <ul class="salvo-menu-list">
            <li class="salvo-menu-item cursor-pointer"><a onclick="logoutFunction()" class="salvo-menu-link">Logout</a></li>
        </ul>
    </div>
</div>

<div class="splash-container">
    <div class="splash">
        <div class="l-box-lrg salvo-u-1 salvo-u-md-2-5">
            <form class="salvo-form salvo-form-stacked little-white" action="/StazioneFerroviaria/OpzioniVisualizzazione" method="POST">
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

                    <button id="impostaVisualizzazione" class="salvo-button salvo-button-primary" type="submit">Imposta Visualizzazione</button>
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
