<%-- 
    Document   : display
    Created on : May 17, 2018, 9:47:57 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1 class="d1">Reservation Details</h1>
        
        <%
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String locationAdd = request.getParameter("locationAdd");
            String license = request.getParameter("license");
        %>
        
        <table border="0">
            <tbody>
                
                <tr>
                    <td>Start Date: </td>
                    <td><%= startDate%></td>
                </tr>
                <tr>
                    <td>End Date: </td>
                    <td><%= endDate%></td>
                </tr>
                <tr>
                    <td>Pick-up Time: </td>
                    <td><%= startTime%></td>
                </tr>
                <tr>
                    <td>Return Time: </td>
                    <td><%= endTime%></td>
                </tr>
                <tr>
                    <td>Location: </td>
                    <td><%= locationAdd%></td>
                </tr>
                <tr>
                    <td>License No: </td>
                    <td><%= license%></td>
                </tr>
            </tbody>
        </table>

    </body>
</html>
