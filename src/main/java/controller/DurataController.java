package controller;

import dao.repositories.DurataRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DurataController{

    public static Integer getDurata(Connection connection, String nomeTratta) {
        Integer durata = 0;
        try{
            PreparedStatement statement = connection.prepareStatement(DurataRepository.GET_DURATA);
            statement.setString(1, nomeTratta);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                durata = rs.getInt("durata");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return durata;
    }

}
