package controller;

import dao.repositories.TrattaRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TrattaController{

    public TrattaController() {
    }

    public static Integer getIdTrattaFromNomeTratta(Connection connection, String tratta) {
        Integer idTratta = 0;
        try{
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
