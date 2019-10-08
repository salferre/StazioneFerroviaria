package controller;

import javax.servlet.http.HttpSession;
import java.sql.*;

public class LoginController {

    public LoginController() {
    }

    public static Boolean checkUser(String username, String password) {

        try{
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            String jdbcUrl="jdbc:mysql://127.0.0.1:3306/StazioneFerroviaria?serverTimezone=UTC";
            Connection connection= DriverManager.getConnection(jdbcUrl, "root", "Suazami94");
            String query = "SELECT * FROM Utenti u WHERE u.username = ? AND u.password = ?;";
            PreparedStatement statement = connection.prepareStatement(query);
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

}

