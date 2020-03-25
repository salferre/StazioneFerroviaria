package controller;

import dao.models.Stazione;
import dao.models.Tratta;
import dao.models.Treno;
import dao.repositories.StazioneRepository;
import dao.repositories.TrattaRepository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TrattaController implements AbstractController {

    public TrattaController() {
    }

    public static List<Treno> getAllPartenze() {
        List<Treno> treni = new ArrayList<>();
        List<Tratta> tratte = new ArrayList<>();
        try{
            Class.forName(DRIVER).newInstance();
            Connection connection= DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            PreparedStatement statement = connection.prepareStatement(TrattaRepository.GET_PARTENZE_PA);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Tratta tratta = new Tratta( rs.getInt("idTratta") ,rs.getString("nomeTratta"));
                tratte.add(tratta);
            }

            List<Integer> idTreni = new ArrayList<>();
            for (Tratta t : tratte) {
                idTreni.add(CalendarioController.getIdTrenoFromIdTratta(connection, t.getIdTratta().toString()));
            }

            for (Integer id : idTreni){
                Integer numeroTreno = TrenoController.getCodiceTrenoFromIdTreno(connection, id.toString());
                treni.add(TrenoController.getTreno(numeroTreno.toString()));
            }

            rs.close();
            statement.close();
            connection.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return treni;
    }

    public static Integer getIdTrattaFromNomeTratta(Connection connection, String tratta) {
        Integer idTratta = 0;
        try{
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(TrattaRepository.GET_ID_TRATTA);
            statement.setString(1, tratta);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                idTratta = rs.getInt("idTratta");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return idTratta;
    }

    public static String getNomeTrattaFromIdTratta(Connection connection, String idTratta) {
        String nomeTratta = "";
        try{
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(TrattaRepository.GET_NOME_TRATTA);
            statement.setInt(1, Integer.valueOf(idTratta));
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                nomeTratta = rs.getString("nomeTratta");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return nomeTratta;
    }

}
