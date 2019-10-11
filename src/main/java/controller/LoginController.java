package controller;

import javax.servlet.http.HttpSession;
import java.sql.*;

public class LoginController implements AbstractController {

    public LoginController() {
    }

    public static Boolean checkUser(String username, String password) {

        try{
            Class.forName(DRIVER).newInstance();
            Connection connection= DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            String query = "SELECT * FROM Utenti u WHERE u.username = ? AND u.password = ?";
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

