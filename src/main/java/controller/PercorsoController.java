package controller;

import dao.models.Percorso;
import dao.repositories.PercorsoRepository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PercorsoController{

    public static List<Percorso> getPercorsoFromidTratta(Connection connection, String idTratta) {

        List<Percorso> percorsi = new ArrayList<>();

        try {
            if (connection == null) {
                connection = DBConnection.initializeDB();
            }

            PreparedStatement statement = connection.prepareStatement(PercorsoRepository.GET_PERCORSO_FROM_IDTRATTA);
            statement.setString(1, idTratta);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Percorso percorso = new Percorso( String.valueOf(rs.getInt("idPercorso")),
                        String.valueOf(rs.getInt("idTratta")),
                        String.valueOf(rs.getInt("idStazione")),
                        String.valueOf(rs.getInt("progressivo")),
                        String.valueOf(rs.getInt("durata"))
                );
                percorsi.add(percorso);
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return percorsi;
    }

    public static Integer getDurataViaggio(Connection connection, String idTratta) {

        Integer durata = 0;

        try {
            if (connection == null) {
                connection = DBConnection.initializeDB();
            }

            PreparedStatement statement = connection.prepareStatement(PercorsoRepository.GET_DURATA_VIAGGIO);
            statement.setString(1, idTratta);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                durata = rs.getInt("cnt");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return durata;
    }

}
