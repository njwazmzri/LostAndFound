package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.DBConnection;

public class UpdateLostItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userID");
        int itemId = Integer.parseInt(request.getParameter("id"));
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String dateLost = request.getParameter("dateLost");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE LOST_ITEMS SET ITEM_NAME=?, DESCRIPTION=?, LOCATION=?, DATE_LOST=? WHERE ID=? AND USER_ID=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, itemName);
            stmt.setString(2, description);
            stmt.setString(3, location);
            stmt.setString(4, dateLost);
            stmt.setInt(5, itemId);
            stmt.setInt(6, userId);

            int updated = stmt.executeUpdate();
            if (updated > 0) {
                session.setAttribute("lostSuccess", "Lost item successfully updated.");
            } else {
                session.setAttribute("lostSuccess", "Failed to update lost item.");
            }

            response.sendRedirect("viewReports.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error updating item.");
            request.getRequestDispatcher("editLostItem.jsp?id=" + itemId).forward(request, response);
        }
    }
}
