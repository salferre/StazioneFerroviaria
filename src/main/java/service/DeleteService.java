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

@WebServlet("/deleteTreno")
public class DeleteService extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String toDelete = request.getParameter("toDelete");
        try {
            Boolean result = TrenoController.deleteTreno(toDelete);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

}
