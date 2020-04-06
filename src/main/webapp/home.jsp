<%@ page import="dao.models.Utente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Stazione di Palermo</title>
  </head>
  <body>
    Benvenuti nella Stazione Ferroviaria di Palermo!
    <br/>
    <br/>
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
    <form action="/StazioneFerroviaria/OpzioniVisualizzazione" method="POST">
      <label for="opzioniVisualizzazione">Scegliere una vista: </label>
      <select id="opzioniVisualizzazione" name="opzioniVisualizzazione" required>
        <option selected disabled value> -- Seleziona una vista -- </option>
              <%
                  java.util.ArrayList<String> userRoleList = (java.util.ArrayList<String>) request.getSession().getAttribute("privileges");
                  for(String role : userRoleList ) {
              %>
              <option value="<%=role%>"><%=role%></option>
              <% } %>

      </select>

      <br/>
      <br/>
      <button id="impostaVisualizzazione" type="submit">Imposta Visualizzazione</button>
      <br/><br/>
    </form>
  </body>
</html>
