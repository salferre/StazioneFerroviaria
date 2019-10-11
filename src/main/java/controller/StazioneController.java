package controller;

import com.google.gson.Gson;
import dao.models.Stazione;
import dao.repositories.StazioneRepository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class StazioneController implements AbstractController {

    public StazioneController() {
    }

    public static List<Stazione> getAllStazioni() {

        List<Stazione> stazioni = new ArrayList<>();
        try{
            Class.forName(DRIVER).newInstance();
            Connection connection= DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            PreparedStatement statement = connection.prepareStatement(StazioneRepository.GET_ALL_STAZIONI);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Stazione stazione = new Stazione(rs.getString("nomeStazione"));
                stazioni.add(stazione);
            }
            rs.close();
            statement.close();
            connection.close();
            return stazioni;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

}
