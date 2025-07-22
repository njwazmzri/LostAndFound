package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.DBConnection;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

            // 1. Semak dahulu jika email wujud
            String emailCheckSQL = "SELECT * FROM USERS WHERE EMAIL=?";
            PreparedStatement emailStmt = conn.prepareStatement(emailCheckSQL);
            emailStmt.setString(1, email);
            ResultSet emailRs = emailStmt.executeQuery();

            if (!emailRs.next()) {
                // Email tidak wujud dalam DB
                request.setAttribute("error", "Email not registered. Please sign up first.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                // Email wujud, sekarang semak password
                String passwordCheckSQL = "SELECT * FROM USERS WHERE EMAIL=? AND PASSWORD=?";
                PreparedStatement passStmt = conn.prepareStatement(passwordCheckSQL);
                passStmt.setString(1, email);
                passStmt.setString(2, password);
                ResultSet passRs = passStmt.executeQuery();

                if (passRs.next()) {
                    // Login berjaya
                    HttpSession session = request.getSession();
                    session.setAttribute("userID", passRs.getInt("ID"));
                    session.setAttribute("username", passRs.getString("FULLNAME"));
                    response.sendRedirect("dashboard.jsp");
                } else {
                    // Password salah
                    request.setAttribute("error", "Incorrect password. Please try again.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Login failed due to database error.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
