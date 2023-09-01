/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.model;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ovind
 */
public class Employee implements Serializable{
    private String firstname;
    private String lastname;
    private String email;
    private String employee_type;
    private String username;
    private String password;

    /**
     * Get the value of password
     *
     * @return the value of password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Set the value of password
     *
     * @param password new value of password
     */
    public void setPassword(String password) {
        this.password = MD5.getMd5(password);
    }


    /**
     * Get the value of username
     *
     * @return the value of username
     */
    public String getUsername() {
        return username;
    }

    /**
     * Set the value of username
     *
     * @param username new value of username
     */
    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmployee_type() {
        return employee_type;
    }

    public void setEmployee_type(String employee_type) {
        this.employee_type = employee_type;
    }

    /**
     * Get the value of lastname
     *
     * @return the value of lastname
     */
    public String getLastname() {
        return lastname;
    }

    /**
     * Set the value of lastname
     *
     * @param lastname new value of lastname
     */
    public void setLastname(String lastname) {
        this.lastname = lastname;
    }


    /**
     * Get the value of firstname
     *
     * @return the value of firstname
     */
    public String getFirstname() {
        return firstname;
    }

    /**
     * Set the value of firstname
     *
     * @param firstname new value of firstname
     */
    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public Employee() {
    }
    
    public boolean Register(DBConnector dbc) throws Exception{
        String query = "INSERT INTO employee(firstname, lastname, email, employee_type, username, password) VALUES(?,?,?,?,?,?)";
        Connection conn;
        PreparedStatement pstmt;
        
        conn = dbc.getConn();
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, firstname);
        pstmt.setString(2, lastname);
        pstmt.setString(3, email);
        pstmt.setString(4, employee_type);
        pstmt.setString(5, username);
        pstmt.setString(6, password);
        
        int a = pstmt.executeUpdate();
        return (a>0);
    }
    
    public static Employee authenticate(String username, String password, DBConnector dbCon) throws SQLException, Exception {
    Employee authenticatedUser = null;

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        connection = dbCon.getConn();

        // Assuming you have a table called "user" with columns "username" and "password"
        String query = "SELECT * FROM employee WHERE username = ? AND password = ?";
        statement = connection.prepareStatement(query);
        statement.setString(1, username);
        statement.setString(2, MD5.getMd5(password)); // Assuming you're using MD5 to store passwords

        resultSet = statement.executeQuery();

        if (resultSet.next()) {
            // If a matching record is found in the database, create the authenticated user object
            authenticatedUser = new Employee();
            authenticatedUser.setUsername(resultSet.getString("username"));
            authenticatedUser.setPassword(resultSet.getString("password"));
            authenticatedUser.setFirstname(resultSet.getString("firstname"));
            authenticatedUser.setLastname(resultSet.getString("lastname"));
            authenticatedUser.setEmail(resultSet.getString("email"));
            authenticatedUser.setEmployee_type(resultSet.getString("employee_type"));
        } else {
            System.out.println("No User");
        }
    } catch (SQLException ex) {
        // Properly handle any SQL exceptions that may occur
        Logger.getLogger(Employee.class.getName()).log(Level.SEVERE, "Error while executing query", ex);
        throw ex;
    } finally {
        // Close all resources to prevent leaks
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(Employee.class.getName()).log(Level.SEVERE, "Error while closing resources", ex);
        }
    }

    return authenticatedUser;
}

}
