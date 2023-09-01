/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ovind
 */
public class DBConnector implements Serializable{
    
    private String driver;
    private String url;
    private String username;
    private String password;
    private Connection conn;

    /**
     * Get the value of conn
     *
     * @return the value of conn
     * @throws java.lang.Exception
     */
    public Connection getConn() throws Exception {
        Class.forName(driver);
        conn = DriverManager.getConnection(url, username, password);
        return conn;
    }

    /**
     * Set the value of password
     *
     * @param password new value of password
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Set the value of username
     *
     * @param username new value of username
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Set the value of url
     *
     * @param url new value of url
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * Set the value of driver
     *
     * @param driver new value of driver
     */
    public void setDriver(String driver) {
        this.driver = driver;
    }

    public DBConnector() {
    }
}
