package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.DBConnection;

public class EditLostItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String dateLost = request.getParameter("dateLost");
        String locationLost = request.getParameter("locationLost");
        String contactInfo = request.getParameter("contactInfo");
        String courierService = request.getParameter("courierService");
        String parcelStatus = request.getParameter("parcelStatus");

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userID");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE LOST_ITEMS SET ITEM_NAME=?, CATEGORY=?, DESCRIPTION=?, DATE_LOST=?, LOCATION_LOST=?, CONTACT_INFO=?, COURIER_SERVICE=?, PARCEL_STATUS=? WHERE ID=? AND USER_ID=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, itemName);
            stmt.setString(2, category);
            stmt.setString(3, description);
            stmt.setDate(4, Date.valueOf(dateLost));
            stmt.setString(5, locationLost);
            stmt.setString(6, contactInfo);
            stmt.setString(7, courierService);
            stmt.setString(8, parcelStatus);
            stmt.setInt(9, id);
            stmt.setInt(10, userId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                session.setAttribute("lostSuccess", "Lost item updated successfully.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("viewLostItems.jsp");
    }
}
