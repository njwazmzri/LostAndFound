package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.DBConnection;

public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String email = request.getParameter("email");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM USERS WHERE EMAIL = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String password = rs.getString("PASSWORD");
                request.setAttribute("message", "Your password is: " + password);
            } else {
                request.setAttribute("error", "Email not found in the system.");
            }

            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }
}
