package controller;

import dao.repositories.DurataRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DurataController implements AbstractController {

    public static Integer getDurata(Connection connection, String nomeTratta) {
        Integer duarata = 0;
        try{
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(DurataRepository.GET_DURATA);
            statement.setString(1, nomeTratta);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                duarata = rs.getInt("durata");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return duarata;
    }

}
