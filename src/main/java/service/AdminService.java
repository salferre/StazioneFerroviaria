package service;

import com.google.gson.Gson;
import controller.LoginController;
import controller.StazioneController;
import controller.TrenoController;
import dao.models.Stazione;
import validation.InsertValidator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
        Boolean result = false;
        request.setAttribute("result", result);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numeroTreno = request.getParameter("numeroTreno");
        String stazionePartenza = request.getParameter("stazionePartenza");
        String[] tappaIntermedia = request.getParameterValues("tappaIntermedia");
        String stazioneArrivo = request.getParameter("stazioneArrivo");
        String giornoPartenza = request.getParameter("giornoPartenza");
        String oraPartenza = request.getParameter("oraPartenza");
        String binario = request.getParameter("binario");
        List<String> tappe = new ArrayList<>();
        tappe.add(stazionePartenza);
        if (tappaIntermedia != null && tappaIntermedia.length > 0){
            for ( String s : tappaIntermedia ) {
                tappe.add(s);
            }
        }
        tappe.add(stazioneArrivo);

        Map<String, String> errors = InsertValidator.validate(numeroTreno, stazionePartenza, stazioneArrivo, giornoPartenza, oraPartenza, binario, tappe);
        if(errors.isEmpty()){

            String tratta = stazionePartenza.substring(0, 2).toUpperCase() + "_" + stazioneArrivo.substring(0, 2).toUpperCase();
            Boolean result = TrenoController.insertTreno(numeroTreno, tratta, tappe, giornoPartenza, oraPartenza, binario);
            request.setAttribute("result", result);
            if(!result){
                request.setAttribute("errors", "Impossibile inserire treno! Errore DB!");
            }
        } else {
            Boolean result = false;
            request.setAttribute("result", result);
            request.setAttribute("errors", errors);
        }
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
        dispatcher.forward(request, response);
    }
}
