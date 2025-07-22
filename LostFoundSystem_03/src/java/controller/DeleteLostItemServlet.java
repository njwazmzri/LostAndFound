package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.DBConnection;

public class DeleteLostItemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userID");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM LOST_ITEMS WHERE ID=? AND USER_ID=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.setInt(2, userId);
            int deleted = stmt.executeUpdate();
            if (deleted > 0) {
                session.setAttribute("lostSuccess", "Lost item deleted successfully.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("viewLostItems.jsp");
    }
}
