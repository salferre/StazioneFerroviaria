package controller;

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
                Stazione stazione = new Stazione( rs.getInt("idStazione") ,rs.getString("nomeStazione"), rs.getString("provinciaStazione"));
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
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            }

            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(StazioneRepository.GET_NOME_STAZIONE_FROM_IDSTAZIONE);
            statement.setString(1, idStazione);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                nomeStazione = rs.getString("nomeStazione");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return nomeStazione;
    }

    public static String getNomeStazioneFromProvinciaStazione (Connection connection, String provinciaStazione){

        String nomeStazione = "";

        try {
            if (connection == null) {
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            }

            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(StazioneRepository.GET_NOME_STAZIONE_FROM_PROVINCIASTAZIONE);
            statement.setString(1, provinciaStazione);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                nomeStazione = rs.getString("nomeStazione");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return nomeStazione;
    }

    public static Integer getIdStazione(Connection connection, String nomeStazione) {
        Integer idStazione = 0;
        try{
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(StazioneRepository.GET_ID_STAZIONE);
            statement.setString(1, nomeStazione);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                idStazione = rs.getInt("idStazione");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return idStazione;
    }

}
