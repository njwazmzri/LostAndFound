package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.DBConnection;

public class EditFoundItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("id"));
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String dateFound = request.getParameter("dateFound");
        String location = request.getParameter("location");
        String contact = request.getParameter("contact");
        String courierService = request.getParameter("courierService");
        String parcelStatus = request.getParameter("parcelStatus");

        int userId = (int) request.getSession().getAttribute("userID");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE FOUND_ITEMS SET ITEM_NAME=?, CATEGORY=?, DESCRIPTION=?, DATE_FOUND=?, LOCATION_FOUND=?, CONTACT_INFO=?, COURIER_SERVICE=?, PARCEL_STATUS=? WHERE ID=? AND USER_ID=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, itemName);
            stmt.setString(2, category);
            stmt.setString(3, description);
            stmt.setDate(4, Date.valueOf(dateFound));
            stmt.setString(5, location);
            stmt.setString(6, contact);
            stmt.setString(7, courierService);
            stmt.setString(8, parcelStatus);
            stmt.setInt(9, itemId);
            stmt.setInt(10, userId);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                request.getSession().setAttribute("foundUpdateSuccess", "Found item updated successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("viewFoundItems.jsp");
    }
}
