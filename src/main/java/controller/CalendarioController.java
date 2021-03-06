package controller;

import dao.models.Calendario;
import dao.repositories.CalendarioRepository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CalendarioController{

    public CalendarioController() {
    }

    public static Calendario getCalendarioFromidTreno(Connection connection, String idTreno) {

        Calendario calendario = null;

        try {
            if (connection == null) {
                connection = DBConnection.initializeDB();
            }

            PreparedStatement statement = connection.prepareStatement(CalendarioRepository.GET_CALENDARIO_FROM_IDTRENO);
            statement.setString(1, idTreno);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                calendario = new Calendario( String.valueOf(rs.getInt("idCalendario")),
                        String.valueOf(rs.getInt("idTratta")),
                        String.valueOf(rs.getTimestamp("dataPartenza")),
                        String.valueOf(rs.getInt("idTreno")),
                        String.valueOf(rs.getInt("binario"))
                );
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return calendario;
    }


    public static Integer getIdTrenoFromIdTratta(Connection connection, String idTratta) {

        Integer idTreno = 0;

        try {
            if (connection == null) {
                connection = DBConnection.initializeDB();
            }

            PreparedStatement statement = connection.prepareStatement(CalendarioRepository.GET_IDTRENO_FROM_IDTRATTA);
            statement.setString(1, idTratta);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                idTreno = rs.getInt("idTreno");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return idTreno;
    }

}
