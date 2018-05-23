<%-- 
    Document   : insert
    Created on : May 22, 2018, 9:31:52 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import ="java.sql.*"%>
<!DOCTYPE html>
<% 
    String resID = request.getParameter("resID");
    String carID = request.getParameter("carID");
    String custID = request.getParameter("custID");
    String spID = request.getParameter("spID");
    String purpose = request.getParameter("purpose");
    String reservedDate = request.getParameter("reservedDate");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String locationAdd = request.getParameter("locationAdd");
    
    
    String url = "jdbc:mysql://localhost/cargo_database";

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, "root", "");
    PreparedStatement pStatement;
    ResultSet result;
    String query;
    
    
    query = "INSERT INTO reservation(resID, carID, custID, spID, purpose, reservedDate, startDate, endDate, locationAdd) VALUES (?, ?, ?, ?, ?, ?, CURRENT_DATE(), CURRENT_DATE(), ?);";
    pStatement = con.prepareStatement(query);
    pStatement.setString(1, resID);
    pStatement.setString(2, carID);
    pStatement.setString(3, custID);
    pStatement.setString(4, spID);
    pStatement.setString(5, purpose);
    pStatement.setString(6, reservedDate);
    //pStatement.setString(7, startDate);
   // pStatement.setString(8, endDate);
    pStatement.setString(7, locationAdd);
    pStatement.executeUpdate();
%>