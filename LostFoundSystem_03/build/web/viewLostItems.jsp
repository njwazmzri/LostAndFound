<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = Integer.parseInt(session.getAttribute("userID").toString());
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>📉 My Lost Item Reports</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table td {
            vertical-align: middle;
        }
        .location-muted {
            font-size: 0.9rem;
            color: #6c757d;
            display: block;
            margin-top: 4px;
        }
        .btn-sm {
            padding: 5px 10px;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>

<div class="container mt-5">

    <a href="viewReports.jsp" class="btn btn-secondary mb-3">← Back to View Reports</a>

    <h2 class="text-center mb-4">📉 My Lost Item Reports</h2>

    <%-- Alert --%>
    <%
        String lostSuccess = (String) session.getAttribute("lostSuccess");
        if (lostSuccess != null) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= lostSuccess %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <%
            session.removeAttribute("lostSuccess");
        }
    %>

    <table class="table table-bordered table-hover mt-3 align-middle">
        <thead class="table-warning">
            <tr>
                <th>#</th>
                <th>Item Info</th>
                <th>Details</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/lostfoundsystem", "app", "app");

                String sql = "SELECT * FROM LOST_ITEMS WHERE USER_ID = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                rs = stmt.executeQuery();

                int count = 1;
                while (rs.next()) {
                    int itemId = rs.getInt("ID");
        %>
            <tr>
                <td><%= count++ %></td>
                <td>
                    <strong><%= rs.getString("ITEM_NAME") %></strong><br>
                    <span class="badge bg-secondary"><%= rs.getString("CATEGORY") %></span><br>
                    <span class="text-muted"><%= rs.getString("DESCRIPTION") %></span>
                </td>
                <td>
                    <div><strong>Date Lost:</strong> <%= rs.getDate("DATE_LOST") %></div>
                    <div><strong>Contact:</strong> <%= rs.getString("CONTACT_INFO") %></div>
                    <div class="location-muted"><strong>📍</strong> <%= rs.getString("LOCATION_LOST") %></div>
                </td>
                <td>
                    <%= rs.getString("PARCEL_STATUS") != null ? rs.getString("PARCEL_STATUS") : "Pending" %>
                </td>
                <td>
                    <div class="btn-group" role="group">
                        <a href="editLostItem.jsp?id=<%= rs.getInt("ID") %>" class="btn btn-sm btn-warning me-1">Edit</a>
                        <a href="DeleteLostItemServlet?id=<%= rs.getInt("ID") %>" class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete this lost item?');">Delete</a>
                    </div>
                </td>

            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='4' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) {}
                if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
