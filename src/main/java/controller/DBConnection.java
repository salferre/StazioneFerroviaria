package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection initializeDB() throws SQLException, ClassNotFoundException, IllegalAccessException, InstantiationException {

        String DRIVER = "com.mysql.cj.jdbc.Driver";
        String JDBC_URL = "jdbc:mysql://127.0.0.1:3306/StazioneFerroviaria?serverTimezone=CET";
        String USERNAME = "root";
        String PASSWORD = "Suazami94";

        Class.forName(DRIVER).newInstance();

        return DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

    }

}
