package service;

import com.google.gson.Gson;
import controller.TrenoController;
import dao.models.TrenoForm;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/treno")
public class TrenoService extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numeroTreno = request.getParameter("numeroTrenoUpdate");
        TrenoForm treno = TrenoController.getTreno(numeroTreno);
        if (treno == null) {
            request.setAttribute("error", "Treno non trovato, inserire un treno esistente!!!");
        } else {
            String json = new Gson().toJson(treno);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doPost(request, response);
    }

}
