package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.DBConnection;

public class FeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String name = request.getParameter("customerName");
        String email = request.getParameter("email");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comments = request.getParameter("comments");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO FEEDBACK (customer_name, email, rating, comments) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setInt(3, rating);
            stmt.setString(4, comments);
            stmt.executeUpdate();

            HttpSession session = request.getSession();
            session.setAttribute("feedbackSuccess", "Thank you for your feedback!");
            response.sendRedirect("dashboard.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to submit feedback. Please try again.");
            request.getRequestDispatcher("feedback.jsp").forward(request, response);
        }
    }
}
