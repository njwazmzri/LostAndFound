<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = Integer.parseInt(session.getAttribute("userID").toString());
    int itemId = Integer.parseInt(request.getParameter("id"));

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String itemName = "", category = "", description = "", location = "", contact = "";
    String courierService = "", parcelStatus = "";
    Date dateFound = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/lostfoundsystem", "app", "app");

        String sql = "SELECT * FROM FOUND_ITEMS WHERE ID = ? AND USER_ID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, itemId);
        stmt.setInt(2, userId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            itemName = rs.getString("ITEM_NAME");
            category = rs.getString("CATEGORY");
            description = rs.getString("DESCRIPTION");
            dateFound = rs.getDate("DATE_FOUND");
            location = rs.getString("LOCATION_FOUND");
            contact = rs.getString("CONTACT_INFO");
            courierService = rs.getString("COURIER_SERVICE");
            parcelStatus = rs.getString("PARCEL_STATUS");
        } else {
            response.sendRedirect("viewFoundItems.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Found Item</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5 col-md-6">
    <h2 class="text-center mb-4">Edit Found Item Report</h2>
    <form action="EditFoundItemServlet" method="post">
        <input type="hidden" name="id" value="<%= itemId %>">

        <div class="mb-3">
            <label class="form-label">Item Name</label>
            <input type="text" name="itemName" value="<%= itemName %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Category</label>
            <input type="text" name="category" value="<%= category %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" required><%= description %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Date Found</label>
            <input type="date" name="dateFound" value="<%= dateFound %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Location Found</label>
            <input type="text" name="location" value="<%= location %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Contact Info</label>
            <input type="text" name="contact" value="<%= contact %>" class="form-control" required>
        </div>

        <!-- Courier Service -->
        <div class="mb-3">
            <label class="form-label">Courier Service</label>
            <select name="courierService" class="form-control">
                <option value="J&T" <%= "J&T".equals(courierService) ? "selected" : "" %>>J&T</option>
                <option value="PosLaju" <%= "PosLaju".equals(courierService) ? "selected" : "" %>>PosLaju</option>
                <option value="Shopee Express" <%= "Shopee Express".equals(courierService) ? "selected" : "" %>>Shopee Express</option>
                <option value="DHL" <%= "DHL".equals(courierService) ? "selected" : "" %>>DHL</option>
                <option value="Ninja Van" <%= "Ninja Van".equals(courierService) ? "selected" : "" %>>Ninja Van</option>
            </select>
        </div>

        <!-- Parcel Status -->
        <div class="mb-3">
            <label class="form-label">Parcel Status</label>
            <select name="parcelStatus" class="form-control">
                <option value="Not Claimed" <%= "Not Claimed".equals(parcelStatus) ? "selected" : "" %>>Not Claimed</option>
                <option value="Already Claimed" <%= "Already Claimed".equals(parcelStatus) ? "selected" : "" %>>Already Claimed</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Update</button>
        <a href="viewFoundItems.jsp" class="btn btn-secondary w-100 mt-2">Cancel</a>
    </form>
</div>
</body>
</html>
