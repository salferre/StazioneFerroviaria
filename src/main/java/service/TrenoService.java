package service;

import com.google.gson.Gson;
import controller.TrenoController;
import dao.models.TrenoForm;
import validation.InsertValidator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/treno")
public class TrenoService extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String toUpdate = request.getParameter("toUpdate");
        TrenoForm treno = TrenoController.getTreno(toUpdate);
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
            Boolean insert = TrenoController.insertTreno(numeroTreno, tratta, tappe, giornoPartenza, oraPartenza, binario);
            request.setAttribute("result", true);
            request.setAttribute("insert", insert);
            if(!insert){
                request.setAttribute("errors", "Errore nell'inserimento del treno nel database! ID duplicato!");
            }
        } else {
            request.setAttribute("result", false);
            request.setAttribute("insert", false);
            request.setAttribute("errors", errors);
        }
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
        String jsonString = br.readLine();

        String toDelete = jsonString.split("=")[1];
        try {
            Boolean result = TrenoController.deleteTreno(toDelete);
            if(!result)
                throw new Exception("IMPOSSIBILE ELIMINARE TRENO N." + toDelete);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
        String jsonString = br.readLine();

        String numeroTreno = jsonString.split("&")[0].split("=")[1];
        String giornoPartenza = jsonString.split("&")[1].split("=")[1].replace("%2F", "/");
        String oraPartenza = jsonString.split("&")[2].split("=")[1].replace("%3A", ":");
        String binario = jsonString.split("&")[3].split("=")[1];
        try {
            Boolean result = TrenoController.updateTreno(numeroTreno, giornoPartenza, oraPartenza, binario);
            if(!result)
                throw new Exception("IMPOSSIBILE MODIFICARE TRENO N." + numeroTreno);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String checkTipoForm (String tipoForm){
        String result = "";
        if(tipoForm != null && !tipoForm.equalsIgnoreCase("")){
            if(tipoForm.equalsIgnoreCase("Inserisci treno"))
                result = "Insert";
            else
                result = "Update";
        }
        return result;
    }

}
