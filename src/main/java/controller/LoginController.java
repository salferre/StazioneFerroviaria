package controller;

import dao.models.Utente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LoginController{

    public LoginController() {
    }

    public static Boolean checkUser(String username, String password) {

        try{
            Connection connection = DBConnection.initializeDB();
            String queryLogin = "SELECT * FROM Utenti u WHERE u.username = ? AND u.password = ?";
            PreparedStatement statement = connection.prepareStatement(queryLogin);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return true;
            }
            rs.close();
            statement.close();
            connection.close();
            return false;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }

    }

    public static Utente checkUserPrivileges(String username) {
        Utente result = new Utente();
        try{
            Connection connection = DBConnection.initializeDB();
            String queryPrivileges = "SELECT * FROM Utenti u WHERE u.username = ?";
            PreparedStatement statement = connection.prepareStatement(queryPrivileges);
            statement.setString(1, username);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                result.setUsername(rs.getString("username"));
                List<String> privileges = new ArrayList<>();
                if(rs.getBoolean("isAdmin")){
                    privileges.add("Admin");
                };
                if(rs.getBoolean("isArrivi")){
                    privileges.add("Arrivi");
                }
                if(rs.getBoolean("isPartenze")){
                    privileges.add("Partenze");
                }
                if(rs.getBoolean("isBinari")){
                    privileges.add("Binario1");
                    privileges.add("Binario2");
                    privileges.add("Binario3");
                    privileges.add("Binario4");
                }
                result.setPrivileges(privileges);
            }
            rs.close();
            statement.close();
            connection.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }

}

