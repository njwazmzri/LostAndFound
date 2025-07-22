package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.DBConnection;

public class DeleteFoundItemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("id"));
        int userId = (int) request.getSession().getAttribute("userID");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM FOUND_ITEMS WHERE ID=? AND USER_ID=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, itemId);
            stmt.setInt(2, userId);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                request.getSession().setAttribute("foundDeleteSuccess", "Found item deleted successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("viewFoundItems.jsp");
    }
}
