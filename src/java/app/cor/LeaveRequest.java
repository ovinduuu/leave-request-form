/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.cor;

import app.model.DBConnector;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ovind
 */
public class LeaveRequest implements Serializable{

    private String id;
    private String employee;
    private String reason;
    private String startDate;
    private String endDate;
    private String status;

    public static List<LeaveRequest> viewLeaveRequests(String employee, String employee_type, DBConnector dbCon) throws Exception {
        
        List<LeaveRequest> leaveRequests = new ArrayList<>();

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = dbCon.getConn();
            String query;
            
            if ("Employee".equals(employee_type)){
                query = "SELECT * FROM leaverequest WHERE username = '" + employee + "'";
            } else if ("Supervisor".equals(employee_type)){
                query = "SELECT * FROM leaverequest WHERE status = 'SubmittedToSupervisor'";
            } else if ("Manager".equals(employee_type)){
                query = "SELECT * FROM leaverequest WHERE status = 'SubmittedToManager'";
            } else {
                query = "";
            }
            
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                LeaveRequest leaveRequest = new LeaveRequest();
                leaveRequest.setId(resultSet.getString("id"));
                leaveRequest.setEmployee(resultSet.getString("username"));
                leaveRequest.setReason(resultSet.getString("reason"));
                leaveRequest.setStartDate(resultSet.getString("start_date"));
                leaveRequest.setEndDate(resultSet.getString("end_date"));
                
                if ("SubmittedToSupervisor".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Need Supervisor Recommendation");
                } else if ("DeclinedBySupervisor".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Supervisor Declined the Request");
                } else if ("SubmittedToManager".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Need Manager Approval");
                } else if ("DeclinedByManager".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Manager Declined the Request");
                } else if ("Approved".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Leave Approved");
                } else {
                    leaveRequest.setStatus("");                    
                }
                
                leaveRequests.add(leaveRequest);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
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
                throw ex;
            }
        }
        return leaveRequests;
    }
    
    public static List<LeaveRequest> viewOwnLeaveRequests(String employee, String employee_type, DBConnector dbCon) throws Exception {
        
        List<LeaveRequest> leaveRequests = new ArrayList<>();

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = dbCon.getConn();
            String query;
            
            query = "SELECT * FROM leaverequest WHERE username = '" + employee + "'";
            
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                LeaveRequest leaveRequest = new LeaveRequest();
                leaveRequest.setId(resultSet.getString("id"));
                leaveRequest.setEmployee(resultSet.getString("username"));
                leaveRequest.setReason(resultSet.getString("reason"));
                leaveRequest.setStartDate(resultSet.getString("start_date"));
                leaveRequest.setEndDate(resultSet.getString("end_date"));
                
                if ("SubmittedToSupervisor".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Need Supervisor Recommendation");
                } else if ("DeclinedBySupervisor".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Supervisor Declined the Request");
                } else if ("SubmittedToManager".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Need Manager Approval");
                } else if ("DeclinedByManager".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Manager Declined the Request");
                } else if ("Approved".equals(resultSet.getString("status"))){
                    leaveRequest.setStatus("Leave Approved");
                } else {
                    leaveRequest.setStatus("");                    
                }
                
                leaveRequest.setStatus(resultSet.getString("status"));
                
                leaveRequests.add(leaveRequest);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
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
                throw ex;
            }
        }

        return leaveRequests;
    }
    
    public boolean Save(DBConnector dbc) throws Exception{
        String query = "INSERT INTO leaverequest (username, reason, start_date, end_date, status, req_date) VALUES (?, ?, ?, ?, ?, ?);";
        Connection conn;
        PreparedStatement pstmt;
        
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentDateTime.format(formatter);
        
        conn = dbc.getConn();
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, employee);
        pstmt.setString(2, reason);
        pstmt.setString(3, startDate);
        pstmt.setString(4, endDate);
        pstmt.setString(5, status);
        pstmt.setString(6, formattedDateTime);
        
        int a = pstmt.executeUpdate();
        return (a>0);
    }
    
    public LeaveRequest() {

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmployee() {
        return employee;
    }

    public String getReason() {
        return reason;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setEmployee(String employee) {
        this.employee = employee;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
