
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author User
 */
public class ClientReservationDB {
    Connection connect;
    public Connection getConnect(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
             DriverManager.getConnection("jdbc:mysql://localhost:3306/cargo_database","root","");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ClientReservationDB.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ClientReservationDB.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        
        return connect;
    }
}
