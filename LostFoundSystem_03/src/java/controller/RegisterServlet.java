package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.DBConnection;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

            // ✅ Semak jika email sudah wujud
            String checkSQL = "SELECT * FROM USERS WHERE EMAIL = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSQL);
            checkStmt.setString(1, email);
            ResultSet checkResult = checkStmt.executeQuery();

            if (checkResult.next()) {
                // ⚠️ Email telah didaftarkan
                request.setAttribute("error", "Email already registered. Please login or use a different email.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Masukkan user baru ke database
            String sql = "INSERT INTO USERS (FULLNAME, EMAIL, PASSWORD) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullname);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.executeUpdate();

            // Auto-login user (simpan dalam session)
            HttpSession session = request.getSession();
            session.setAttribute("username", fullname);
            session.setAttribute("userID", getUserID(email));

            // Pergi ke registerSuccess.jsp
            response.sendRedirect("registerSuccess.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed due to a database error.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // Fungsi untuk ambil user ID dari email
    private int getUserID(String email) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT ID FROM USERS WHERE EMAIL=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("ID");
            }
        }
        return -1;
    }
}
