package controller;

import com.google.gson.Gson;
import dao.models.Calendario;
import dao.models.Stazione;
import dao.repositories.CalendarioRepository;
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
                Stazione stazione = new Stazione( rs.getInt("idStazione") ,rs.getString("nomeStazione"));
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

    public static String getNomeStazioneFromidStazione (Connection connection, String idStazione){

        String nomeStazione = "";

        try {
            if (connection == null) {
                Class.forName(DRIVER).newInstance();
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            }

            PreparedStatement statement = connection.prepareStatement(StazioneRepository.GET_NOME_STAZIONE);
            statement.setString(1, idStazione);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                nomeStazione = rs.getString("nomeStazione");
            }
            rs.close();
            statement.close();
            connection.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return nomeStazione;
    }

}
