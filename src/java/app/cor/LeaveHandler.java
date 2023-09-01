/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.cor;

import app.cor.LeaveRequest;
import app.model.DBConnector;

/**
 *
 * @author ovind
 */
interface LeaveHandler {
    void processLeaveRequest(String id, String action, DBConnector dbCon);
}

