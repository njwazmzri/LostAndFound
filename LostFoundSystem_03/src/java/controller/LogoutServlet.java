package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false); // ambil session jika ada
        if (session != null) {
            session.invalidate(); // tamatkan session
        }
        response.sendRedirect("logoutSuccess.jsp");
    }
}
