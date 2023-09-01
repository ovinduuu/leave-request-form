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
public class Supervisor implements LeaveHandler{
    
    @Override
    public void processLeaveRequest(String id, String action, DBConnector dbCon) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = dbCon.getConn();
            String query = "UPDATE leaverequest SET status = ? WHERE id = ?";
            statement = connection.prepareStatement(query);

            // Check the action (accept/decline) and set the status accordingly
            //Handling chain of responsibility
            //if leave request in accepted -> Status is changed to "Submitted toManager"
            //--> then the responsibility is passed to the Manager. The next handler is Manager.
            //else leave request is not accpted request process is stopped
            if ("Accept".equalsIgnoreCase(action)) {
                statement.setString(1, "SubmittedToManager");
            } else if ("Decline".equalsIgnoreCase(action)) {
                statement.setString(1, "DeclinedBySupervisor");
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
