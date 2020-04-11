package service;

import controller.LoginController;
import dao.models.Utente;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/Login")
public class LoginService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Boolean result = LoginController.checkUser(username, password);
        request.setAttribute("loginResult", result);
        String redirectURL = "";
        if(result){
            HttpSession session = request.getSession();
            Utente utente = LoginController.checkUserPrivileges(username);
            session.setAttribute("username", utente.getUsername());
            session.setAttribute("privileges", utente.getPrivileges());
            session.setMaxInactiveInterval(30*60);
            Cookie userName = new Cookie("user", username);
            response.addCookie(userName);
//            String encodedURL = response.encodeRedirectURL("/admin.jsp");
//            response.sendRedirect(encodedURL);
            redirectURL = "/home.jsp";
            Cookie[] cookies = request.getCookies();
            if(cookies.length > 0){
                for ( Cookie c : cookies) {
                    if(c.getName().equalsIgnoreCase("opzioniVisualizzazione"))
                        redirectURL = "/admin.jsp";
                }
            }
        } else {
            redirectURL = "/";
        }
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectURL);
        dispatcher.forward(request, response);
    }
}
