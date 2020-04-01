package service;

import com.google.gson.Gson;
import controller.TrenoController;
import dao.models.TrenoExtended;
import dao.repositories.TrattaRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/arrivi")
public class ArriviService extends HttpServlet  {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<TrenoExtended> arrivi = TrenoController.getArriviOrPartenzePA(TrattaRepository.GET_ARRIVI_PA);
        String json = new Gson().toJson(arrivi);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doPost(request, response);
    }

}

