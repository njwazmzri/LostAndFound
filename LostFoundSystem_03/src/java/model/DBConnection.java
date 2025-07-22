package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException {
        String url = "jdbc:derby://localhost:1527/lostfoundsystem";
        String user = "app";
        String password = "app";
        return DriverManager.getConnection(url, user, password);
    }
}
