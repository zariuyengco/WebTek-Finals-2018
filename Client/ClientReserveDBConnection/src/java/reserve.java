/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name="reserve", urlPatterns={"/reserve"})
public class reserve extends HttpServlet {

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
        response.setContentType("text/jsp;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String locationAdd = request.getParameter("locationAdd");
            String license = request.getParameter("license");
            ClientReservationDB dbase = new ClientReservationDB();
            PreparedStatement ps;
            Connection connect = dbase.getConnect();
            Statement stmt = connect.createStatement();
            stmt.executeUpdate("insert into reservation ( startDate, endDate,  startTime, endTime, locationAdd, license) values(?,?,?,?,?,?,?,?,?,?,?,?)");
            String query = "insert into reservation ( startDate, endDate, startTime, endTime, locationAdd, license) values(?,?,?,?,?,?,?,?,?,?,?,?);";
            ps = connect.prepareStatement(query);
            ps.setString(5, startDate);
            ps.setString(6, endDate);
            
            ps.setString(9, startTime);
            ps.setString(10, endTime);
            ps.setString(11, locationAdd);
            ps.setString(12, license);
            ps.executeUpdate("insert into reservation (locationAdd, startTime, endTime, startDate, endDate, license) values()");
            out.println("Data successfully added!");
        } catch (SQLException ex) {
            Logger.getLogger(reserve.class.getName()).log(Level.SEVERE, null, ex);
        }
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
