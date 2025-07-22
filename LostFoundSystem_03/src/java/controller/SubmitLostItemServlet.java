package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.DBConnection;

public class SubmitLostItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        // Dapatkan parameter daripada borang
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String dateLost = request.getParameter("dateLost");
        String locationLost = request.getParameter("locationLost");
        String contactInfo = request.getParameter("contactInfo");
        String trackingNumber = request.getParameter("trackingNumber");
        String courierService = request.getParameter("courierService");

        // Dapatkan user ID dari session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userID");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO LOST_ITEMS (ITEM_NAME, CATEGORY, DESCRIPTION, DATE_LOST, LOCATION_LOST, CONTACT_INFO, USER_ID, TRACKING_NUMBER, COURIER_SERVICE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, itemName);
            stmt.setString(2, category);
            stmt.setString(3, description);
            stmt.setDate(4, Date.valueOf(dateLost)); 
            stmt.setString(5, locationLost);
            stmt.setString(6, contactInfo);
            stmt.setInt(7, userId);
            stmt.setString(8, trackingNumber);
            stmt.setString(9, courierService);
 
            stmt.executeUpdate();

            session.setAttribute("lostSuccess", "Lost item successfully reported!");
            response.sendRedirect("dashboard.jsp");

        } catch (Exception e) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
}
