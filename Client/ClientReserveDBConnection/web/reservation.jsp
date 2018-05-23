<%-- 
    Document   : clientReservation
    Created on : May 16, 2018, 5:47:21 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CarGo Reservation</title>
        <link href="style/bootstrap.min.css" rel="stylesheet">
        
    <link href="style/product.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/material-kit.min.css" />
    </head>
    <body background="img/car.jpg">
                <nav class="site-header sticky-top py-1">
      <div class="container d-flex flex-column flex-md-row justify-content-between">
        <a class="navbar-brand" href="/">CarGo</a>
       
        <a class="py-2 d-none d-md-inline-block" href="#home">Home</a>
        <a class="py-2 d-none d-md-inline-block" href="landingpage/contactus.jsp">Contact Us</a>
        <a class="py-2 d-none d-md-inline-block" href="registration.jsp">Register</a>
        <a class="py-2 d-none d-md-inline-block" href="Login_v16/index.html">Login</a>
      </div>
    </nav>
        <style>
           @font-face{
                font-family:Bromine;
                src: url('../fonts/Bromine.ttf');
            }
            
            @font-face{font-family: clearlight; src: url('../fonts/clearlight.ttf')}
            
            .h2R{font-family: Bromine;}
            
            .formcontainer{
                display: grid;
                grid-template-columns: auto auto auto auto;
                grid-gap: 5px;
                padding: 15px;
            }
            
            .formcontainer > div{
                background-color: rgba(255, 255, 255, 0.8);
                padding: 80px 80px;
                margin-left: 30%;
            }
        </style>
        <center><form name="reserveForm" action="insert.jsp" method="POST">
            
                <div class="formcontainer"><div><h1 class="h2R">Reserve a Car</h1><br><br>
                                            DELIVERY LOCATION
                                            <input type="text" name="locationAdd" class="form-control" placeholder="Please enter the COMPLETE address of the location">
                                            <br>
                                            
                                             Purpose<input type="text" name="purpose" class="form-control" placeholder="Please enter your purpose here (i.e. vacation, business)">
                                       <br>
                                       <!--Pick-up Time:<input name="startDate" type="datetime-local">
										<select name="startTime">
										  <option>6:00:00</option>
										  <option>6:30:00</option>
										  <option>7:00:00</option>
										  <option>7:30:00</option>
										  <option selected>8:00:00</option>
										  <option>8:30:00</option>
										  <option>9:00:00</option>
										  <option>9:30:00</option>
										  <option>10:00:00</option>
                                                                                  <option>10:30:00</option>
                                                                                  <option>11:00:00</option>
                                            <option>11:30:00</option>
                                            <option>12:00:00</option>
											<option>12:30:00</option>
											<option>13:00:00</option>
											<option>13:30:00</option>
											<option>14:00:00</option>
											<option>14:30:00</option>
											<option>15:00:00</option>
											<option >15:30:00</option>
											<option>16:00:00</option>
											<option>16:30:00</option>
											<option>17:00:00</option>
											<option>17:30:00</option>
											<option>18:00:00</option>
											<option>18:30:00</option>
											<option>19:00:00</option>
											<option>19:30:00</option>
                                        </select>-->
                                           
						Pick-up Date and Time:
						<input type="datetime-local" name="endDate"><br><br>
                                    
                                           
                                         	<!--Return Time:
										<select name="endTime">
										  <option>6:00:00</option>
										  <option>6:30:00</option>
										  <option>7:00:00</option>
										  <option>7:30:00</option>
										  <option selected>8:00:00</option>
										  <option>8:30:00</option>
										  <option>9:00:00</option>
										  <option>9:30:00</option>
										  <option>10:00:00</option>
                                                                                  <option>10:30:00</option>
                                                                                  <option>11:00:00</option>
                                            <option>11:30:00</option>
                                            <option>12:00:00</option>
											<option>12:30:00</option>
											<option>13:00:00</option>
											<option>13:30:00</option>
											<option>14:00:00</option>
											<option>14:30:00</option>
											<option>15:00:00</option>
											<option >15:30:00</option>
											<option>16:00:00</option>
											<option>16:30:00</option>
											<option>17:00:00</option>
											<option>17:30:00</option>
											<option>18:00:00</option>
											<option>18:30:00</option>
											<option>19:00:00</option>
											<option>19:30:00</option>
										</select>-->
                                      
                                            Return Date and Time:
						<input type="datetime-local" name="endDate" required><br><br>
                                                
                                                <p class="info-title"><strong>NOTE: The rented car should be returned to where it was picked up. Thank you!</strong></p>
                                                
                                            </label>
                                        
                                        
           
                                <input type="reset" value="CANCEL"> <input type="submit" action="action" value="Submit">
                        </div></div>
            </form></center>
    
    </body>
</html>