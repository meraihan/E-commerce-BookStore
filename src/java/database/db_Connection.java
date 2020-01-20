/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

/**
 *
 * @author Sayed Mahmud Raihan
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class db_Connection {

    private String dburl = "jdbc:mysql://localhost:3306/shop";
    private String dbUserName = "root";
    private String dbUserPassword = "";
    Connection con;

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(dburl, dbUserName, dbUserPassword);
        return con;

    }

}
