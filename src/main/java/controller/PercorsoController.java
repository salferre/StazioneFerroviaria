package controller;

import dao.models.Calendario;
import dao.models.Percorso;
import dao.repositories.CalendarioRepository;
import dao.repositories.PercorsoRepository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PercorsoController implements AbstractController {

    public static List<Percorso> getPercorsoFromidTratta(Connection connection, String idTratta) {

        List<Percorso> percorsi = new ArrayList<>();

        try {
            if (connection == null) {
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            }

            Class.forName(DRIVER).newInstance();
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

}
