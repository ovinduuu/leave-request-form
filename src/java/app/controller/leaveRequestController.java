/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.controller;

import app.model.DBConnector;
import app.cor.LeaveRequest;
import com.sun.xml.rpc.processor.modeler.j2ee.xml.emptyType;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ovind
 */
public class leaveRequestController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String view;
        HttpSession session = request.getSession();
        DBConnector dbCon = (DBConnector) session.getAttribute("dbCon");

        LeaveRequest leaveRequest = new LeaveRequest();
        leaveRequest.setEmployee(request.getParameter("username"));
        leaveRequest.setReason(request.getParameter("reason"));
        leaveRequest.setStartDate(request.getParameter("startDate"));
        leaveRequest.setEndDate(request.getParameter("endDate"));
        
        if ("Employee".equals(request.getParameter("usertype"))){
            leaveRequest.setStatus("SubmittedToSupervisor");
        } else if ("Supervisor".equals(request.getParameter("usertype"))){
            leaveRequest.setStatus("SubmittedToManager");
        } else {
            leaveRequest.setStatus("");
        }
        
        try {
            if (leaveRequest.Save(dbCon)) {
                view = "dashboard.jsp?leaveSuccess=1";
            } else {
                view = "dashboard.jsp?leaveSuccess=0";
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }

        response.sendRedirect(view);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
