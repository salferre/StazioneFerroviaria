package controller;

import java.sql.*;

public class LoginController {

    public LoginController() {
    }

    public static Boolean checkUser(String username, String password) {

        try{
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            String jdbcUrl="jdbc:mysql://127.0.0.1:3306/StazioneFerroviaria?serverTimezone=UTC";
            Connection connection= DriverManager.getConnection(jdbcUrl, "root", "Suazami94");
            Statement statement = connection.createStatement();
            String query="SELECT * FROM UTENTI";
            ResultSet rs = statement.executeQuery(query);
            while (rs.next()) {
                if(rs.getString("username").equals(username)
                   && rs.getString("password").equals(password)) {
                    return true;
                }
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

}
