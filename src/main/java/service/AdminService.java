package service;

import com.google.gson.Gson;
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
        String tipoForm = request.getParameter("tipoForm");
        tipoForm = checkTipoForm(tipoForm);

        String numeroTreno = request.getParameter("numeroTreno"+tipoForm);
        String stazionePartenza = request.getParameter("stazionePartenza"+tipoForm);
        String[] tappaIntermedia = request.getParameterValues("tappaIntermedia"+tipoForm);
        String stazioneArrivo = request.getParameter("stazioneArrivo"+tipoForm);
        String giornoPartenza = request.getParameter("giornoPartenza"+tipoForm);
        String oraPartenza = request.getParameter("oraPartenza"+tipoForm);
        String binario = request.getParameter("binario"+tipoForm);
        List<String> tappe = new ArrayList<>();
        tappe.add(stazionePartenza);
        if (tappaIntermedia != null && tappaIntermedia.length > 0){
            for ( String s : tappaIntermedia ) {
                tappe.add(s);
            }
        }
        tappe.add(stazioneArrivo);

        Map<String, String> errors = InsertValidator.validate(numeroTreno, stazionePartenza, stazioneArrivo,
                                                                giornoPartenza, oraPartenza, binario, tappe);
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

    private String checkTipoForm (String tipoForm){
        String result = "";
        if(tipoForm != null && !tipoForm.equalsIgnoreCase("")){
            if(tipoForm.equalsIgnoreCase("Inserisci treno")){
                result = "Insert";
            } else if (tipoForm.equalsIgnoreCase("Modifica treno")){
                result = "Update";
            } else if (tipoForm.equalsIgnoreCase("Elimina treno")){
                result = "Delete";
            }
        }
        return result;
    }

}
