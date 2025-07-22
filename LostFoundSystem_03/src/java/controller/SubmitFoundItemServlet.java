package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.DBConnection;

@WebServlet("/SubmitFoundItemServlet")
public class SubmitFoundItemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Debug statement (boleh buang bila production)
        System.out.println("=== [DEBUG] SubmitFoundItemServlet triggered ===");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            System.out.println("No session or user not logged in");
            response.sendRedirect("login.jsp");
            return;
        }

        // Ambil data dari borang
        int userId = (int) session.getAttribute("userID");
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String dateFound = request.getParameter("dateFound");
        String locationFound = request.getParameter("locationFound");
        String contactInfo = request.getParameter("contactInfo");
        String trackingNumber = request.getParameter("trackingNumber");
        String courierService = request.getParameter("courierService");
        String parcelStatus = "Pending"; // status default
        
        
        // Debug values
        System.out.println("userId: " + userId);
        System.out.println("itemName: " + itemName);
        System.out.println("category: " + category);
        System.out.println("description: " + description);
        System.out.println("dateFound: " + dateFound);
        System.out.println("locationFound: " + locationFound);
        System.out.println("contactInfo: " + contactInfo);
        System.out.println("courierService: " + courierService);
        System.out.println("parcelStatus: " + parcelStatus);

        // Simpan ke dalam database
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO FOUND_ITEMS (USER_ID, ITEM_NAME, CATEGORY, DESCRIPTION, DATE_FOUND, LOCATION_FOUND, CONTACT_INFO, TRACKING_NUMBER, COURIER_SERVICE, PARCEL_STATUS) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setString(2, itemName);
            stmt.setString(3, category);
            stmt.setString(4, description);
            stmt.setDate(5, Date.valueOf(dateFound));
            stmt.setString(6, locationFound);
            stmt.setString(7, contactInfo);
            stmt.setString(8, trackingNumber);
            stmt.setString(9, courierService);
            stmt.setString(10, parcelStatus);
            
            stmt.executeUpdate();

            // Paparkan mesej berjaya ke dashboard
            session.setAttribute("foundSuccess", "Found item report submitted successfully.");
            response.sendRedirect("dashboard.jsp");

        } catch (SQLException e) {
            // Jika gagal, papar mesej error di submitFoundItem.jsp
            System.out.println("=== [ERROR] SQLException ===");
            e.printStackTrace();
            request.setAttribute("error", "Failed to submit found item report.");
            request.getRequestDispatcher("submitFoundItem.jsp").forward(request, response);
        }
    }
}
