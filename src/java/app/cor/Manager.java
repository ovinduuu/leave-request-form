/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.cor;

import app.model.DBConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ovind
 */
public class Manager implements LeaveHandler {

    @Override
    public void processLeaveRequest(String id, String action, DBConnector dbCon) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = dbCon.getConn();
            String query = "UPDATE leaverequest SET status = ? WHERE id = ?";
            statement = connection.prepareStatement(query);
            
            if ("Accept".equalsIgnoreCase(action)) {
                statement.setString(1, "Approved");
            } else if ("Decline".equalsIgnoreCase(action)) {
                statement.setString(1, "DeclinedByManager");
            } else {
                statement.setString(1, "");
            }
            
            statement.setString(2, id);

            statement.executeUpdate();

        } catch (Exception ex) {
            Logger.getLogger(Supervisor.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
