package service;

import com.google.gson.Gson;
import controller.LoginController;
import controller.StazioneController;
import dao.models.Stazione;
import validation.InsertValidator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin")
public class AdminService extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Stazione> stazioni = StazioneController.getAllStazioni();
        String json = new Gson().toJson(stazioni);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numeroTreno = request.getParameter("numeroTreno");
        String stazionePartenza = request.getParameter("stazionePartenza");
        String stazioneArrivo = request.getParameter("stazioneArrivo");
        String giornoPartenza = request.getParameter("giornoPartenza");
        String oraPartenza = request.getParameter("oraPartenza");
        String binario = request.getParameter("binario");
        Map<String, String> errors = InsertValidator.validate(numeroTreno, stazionePartenza, stazioneArrivo, giornoPartenza, oraPartenza, binario);
        if(errors.isEmpty()){
            Boolean result = true;
            request.setAttribute("result", result);
        } else {
            Boolean result = false;
            request.setAttribute("result", result);
            request.setAttribute("errors", errors);
        }
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
        dispatcher.forward(request, response);
    }
}
