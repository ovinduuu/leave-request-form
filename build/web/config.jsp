<%-- 
    Document   : config
    Created on : Feb 22, 2023, 10:24:43 AM
    Author     : ovind
--%>

<jsp:useBean id="dbCon" scope="session" class="app.model.DBConnector"/>
<jsp:setProperty name="dbCon" property="driver" value="com.mysql.jdbc.Driver"/>
<jsp:setProperty name="dbCon" property="username" value="root"/>
<jsp:setProperty name="dbCon" property="password" value=""/>
<jsp:setProperty name="dbCon" property="url" value="jdbc:mysql://localhost:3306/leaveform"/>