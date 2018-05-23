<%@ page import="java.sql.*"
         import= "java.text.SimpleDateFormat" 
         import= "java.util.Date" %>

<% 
   String action=request.getParameter("action");
   if (action.equals("Register")){
       String first_name=request.getParameter("first_name");
       String last_name = request.getParameter("last_name");
       String address= request.getParameter("address");
       String email = request.getParameter("email");
       String phone = request.getParameter("phone");
       String password = request.getParameter("password");
       String confirmPassword = request.getParameter("confirmPassword");
       String birth_month = request.getParameter("birth_month");
       String birth_day = request.getParameter("birth_day");
       String birth_year = request.getParameter("birth_year");
       
      
       
       if(password != confirmPassword){
           response.setHeader("Location", "../webpages/registration.jsp?password+unmatched");
       }
       try{
           Class.forName("com.mysql.jdbc.Driver");
           Connection con = DriverManager.getConnection("jdbc:mysql://localhost/cargo_database", "root", "");
           PreparedStatement pStatement;
           Statement stm = con.createStatement();
           ResultSet rs ;//while (rs.next()){
           String query= "INSERT INTO users (first_name, last_name, email, phone, password,license_number, birth_month, birth_day, birth_year) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) ;";
           pStatement = con.prepareStatement(query);
           pStatement.setString(1, first_name);
           pStatement.setString(2, last_name);
           pStatement.setString(3, email);
           pStatement.setString(4, phone);
           pStatement.executeUpdate();
           
           query= "select user_id from users where username = '"+email+"' ;";
           rs = stm.executeQuery(query);
           rs.next();
           int temp = rs.getInt("user_id");
         
           
       }catch(SQLException e){
           out.println(e);
       }catch(Exception e){
           out.println(e);
       }
       
   }
%>

<%-- 
    Document   : RegistrationConnect
    Created on : May 23, 2018, 5:46:10 AM
    Author     : Shaira Andrea
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import="java.io.File"%>
<!DOCTYPE html>
<html>
    <head>
          <title> carGo </title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <link rel="icon" href="pics/favicon.png">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
  <style>
      #headimg{
        width: 100%;
      }
      .headimg{
            background-image: url(/images/login.jpg);
            background-attachment: fixed;
            background-position: 50px 150px; 
      }
    </style>
</head>

<body style="background-color:beige ; margin-top:20px">
</html>
