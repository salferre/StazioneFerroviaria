package controller;

import dao.models.Calendario;
import dao.models.Stazione;
import dao.repositories.CalendarioRepository;
import dao.repositories.StazioneRepository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CalendarioController implements AbstractController {

    public CalendarioController() {
    }

    public static Calendario getCalendarioFromidTreno(Connection connection, String idTreno) {

        Calendario calendario = null;

        try {
            if (connection == null) {
                Class.forName(DRIVER).newInstance();
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
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
            connection.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return calendario;
    }

}
