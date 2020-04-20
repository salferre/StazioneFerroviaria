package service;

import controller.LoginController;
import dao.models.Utente;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/OpzioniVisualizzazione")
public class OpzioniVisualizzazione extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String opzioniVisualizzazione = request.getParameter("opzioniVisualizzazione");
        String redirectURL = "";
        if(opzioniVisualizzazione != null && !opzioniVisualizzazione.trim().equalsIgnoreCase("")) {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            Cookie userVisualizzazione = new Cookie(username+"opzioniVisualizzazione", opzioniVisualizzazione);
            response.addCookie(userVisualizzazione);
            redirectURL = "/admin.jsp";
        } else {
            redirectURL = "/home.jsp";
        }
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectURL);
        dispatcher.forward(request, response);
    }
}
