<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String itemId = request.getParameter("id");
    int userId = Integer.parseInt(session.getAttribute("userID").toString());

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String itemName = "", category = "", description = "", dateLost = "", locationLost = "", contactInfo = "";
    String courierService = "", parcelStatus = "";

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/lostfoundsystem", "app", "app");

        String sql = "SELECT * FROM LOST_ITEMS WHERE ID=? AND USER_ID=?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(itemId));
        stmt.setInt(2, userId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            itemName = rs.getString("ITEM_NAME");
            category = rs.getString("CATEGORY");
            description = rs.getString("DESCRIPTION");
            dateLost = rs.getString("DATE_LOST");
            locationLost = rs.getString("LOCATION_LOST");
            contactInfo = rs.getString("CONTACT_INFO");
            courierService = rs.getString("COURIER_SERVICE");
            parcelStatus = rs.getString("PARCEL_STATUS");
        } else {
            response.sendRedirect("viewLostItems.jsp");
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
    <title>Edit Lost Item</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5 col-md-6">
    <h2 class="text-center mb-4">Edit Lost Item Report</h2>
    <form action="EditLostItemServlet" method="post">
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
            <label class="form-label">Date Lost</label>
            <input type="date" name="dateLost" value="<%= dateLost %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Location Lost</label>
            <input type="text" name="locationLost" value="<%= locationLost %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Contact Info</label>
            <input type="text" name="contactInfo" value="<%= contactInfo %>" class="form-control" required>
        </div>

        <!-- Courier Service -->
        <div class="mb-3">
            <label for="courierService" class="form-label">Courier Service</label>
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
            <label for="parcelStatus" class="form-label">Parcel Status</label>
            <select name="parcelStatus" class="form-control">
                <option value="Still Missing" <%= "Still Missing".equals(parcelStatus) ? "selected" : "" %>>Still Missing</option>
                <option value="Found " <%= "Found ".equals(parcelStatus) ? "selected" : "" %>>Found</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Update</button>
        <a href="viewLostItems.jsp" class="btn btn-secondary w-100 mt-2">Cancel</a>
    </form>
</div>
</body>
</html>
