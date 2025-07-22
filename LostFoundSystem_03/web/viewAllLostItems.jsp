<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>📉 All Lost Item Reports</title>
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
    </style>
</head>
<body>

<div class="container mt-5">

    <!-- Butang Back -->
    <div class="mb-3">
        <a href="viewReports.jsp" class="btn btn-secondary">← Back to View Reports</a>
    </div>

    <!-- Tajuk Tengah -->
    <h2 class="text-center mb-4">📉 All Lost Item Reports</h2>

    <table class="table table-bordered table-hover align-middle">
        <thead class="table-warning">
            <tr>
                <th>#</th>
                <th>Item Info</th>
                <th>Details</th>
                <th>Courier</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/lostfoundsystem", "app", "app");

                    String sql = "SELECT * FROM LOST_ITEMS ORDER BY DATE_LOST DESC";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();

                    int count = 1;
                    while (rs.next()) {
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
                <td><%= rs.getString("COURIER_SERVICE") %></td>
                <td><%= rs.getString("PARCEL_STATUS") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
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
