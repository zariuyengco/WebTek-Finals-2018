<%@page import="java.sql.*"%>
<%!
        public class Reserve{
           String URL = "jdbc:mysql://localhost:3306/cargo_database";
           String USERNAME = "root";
           String PASSWORD = "";

           Connection connect = null;
           PreparedStatement insertReservation = null;
           ResultSet resultSet = null;

           public Reserve(){
           
           try{
            connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            insertReservation = connect.prepareStatement("INSERT INTO reservation( startDate, endDate, startTime, endTime, locationAdd, license)" + " VALUES (?, ?, ?, ?, ?, ?)");

            }catch (SQLException e){
                e.printStackTrace();
            }//catch
            }//Reserve

             public int setReservation( String startDate, String endDate, String startTime, String endTime, String locationAdd, String license){
                int result = 0;

                try {
                        insertReservation.setString(1, startDate);
                        insertReservation.setString(2, endDate);
                        
                        insertReservation.setString(3, startTime);
                        insertReservation.setString(4, endTime);
                        insertReservation.setString(5, locationAdd);
                        insertReservation.setString(6, license);
                        result = insertReservation.executeUpdate();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                return result;
             }
        }
    %>
        
        <%
            int result = 0;
            
            
            String startD = new String();
            String endD = new String();
            String startT = new String();
            String endT = new String();
            String locationA = new String();
            String lice = new String();
            
            if (request.getParameter("startDate") != null){
                startD = request.getParameter("startDate");
            }
            
            if (request.getParameter("endDate") != null){
                endD = request.getParameter("endDate");
            }
            
            if (request.getParameter("startDate") != null){
                startT = request.getParameter("startDate");
            }
            
            if (request.getParameter("endDate") != null){
                endT = request.getParameter("endDate");
            }
            
            
            if (request.getParameter("locationAdd") != null){
                locationA = request.getParameter("locationAdd");
            }
            
            if (request.getParameter("license") != null){
                lice = request.getParameter("license");
            }
            
            Reserve reserve = new Reserve();
            result = reserve.setReservation(startD, endD, startT, endT, locationA, lice);
        %>