<%@ page import="java.sql.*, javax.sql.*, javax.servlet.http.HttpSession" %>
<%
    if (session == null || session.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("userID");
    String username = (String) session.getAttribute("username");

    int totalLost = 0, totalFound = 0, myLost = 0, myFound = 0;
    try {
        Connection conn = model.DBConnection.getConnection();

        PreparedStatement stmt1 = conn.prepareStatement("SELECT COUNT(*) FROM lost_items");
        ResultSet rs1 = stmt1.executeQuery();
        if (rs1.next()) totalLost = rs1.getInt(1);

        PreparedStatement stmt2 = conn.prepareStatement("SELECT COUNT(*) FROM found_items");
        ResultSet rs2 = stmt2.executeQuery();
        if (rs2.next()) totalFound = rs2.getInt(1);

        PreparedStatement stmt3 = conn.prepareStatement("SELECT COUNT(*) FROM lost_items WHERE user_id = ?");
        stmt3.setInt(1, userId);
        ResultSet rs3 = stmt3.executeQuery();
        if (rs3.next()) myLost = rs3.getInt(1);

        PreparedStatement stmt4 = conn.prepareStatement("SELECT COUNT(*) FROM found_items WHERE user_id = ?");
        stmt4.setInt(1, userId);
        ResultSet rs4 = stmt4.executeQuery();
        if (rs4.next()) myFound = rs4.getInt(1);

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Lost & Found Hub</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet">
    <style>
        body {
            position: relative;
            min-height: 100vh;
            background-color: #f9f9f9;
        }
        .welcome-box {
            text-align: center;
            margin-top: 40px;
            margin-bottom: 30px;
        }
        .welcome-box h2 {
            font-family: 'Playfair Display', serif;
            font-size: 4.0rem;
            font-weight: bold;
            color: #1f7a8c;
        }
        .welcome-box p {
            font-size: 1.5rem;
            color: #444;
            font-weight: normal;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.05);
        }
        .btn-section {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 80px;
            margin-bottom: 60px;
        }
        .btn-section .btn {
            padding: 12px 20px;
            font-size: 1rem;
            font-weight: 500;
            margin: 10px;
            border-radius: 25px;
        }
        footer {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            color: #888;
            text-align: center;
            font-size: 0.9rem;
        }
        .stats-section {
            margin-top: 50px; 
        }
        .logout-bar {
            position: absolute;
            top: 20px;
            right: 30px;
            z-index: 1000;
        }
        .btn-logout {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 25px;
            font-weight: 500;
            transition: 0.3s;
        }
        .btn-logout:hover {
            background-color: white;
            color: #dc3545;
            border: 1px solid #dc3545;
        }
        .option-card {
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease-in-out;
        }

        .option-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            background-color: #f9fcff;
        }

        .container {
            flex: 1;
            padding-top: 50px;
            padding-bottom: 80px;
        }
    </style>
</head>
<body>

<!-- Logout Button -->
<div class="logout-bar">
    <a href="LogoutServlet" class="btn btn-logout">Logout</a>
</div>

<div class="container">

    <%-- ? Display success messages from Lost or Found item submission --%>
    <%
        String lostSuccess = (String) session.getAttribute("lostSuccess");
        if (lostSuccess != null) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <span class="me-2 text-success">&#10004;</span> <%= lostSuccess %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
            session.removeAttribute("lostSuccess");
        }

        String foundSuccess = (String) session.getAttribute("foundSuccess");
        if (foundSuccess != null) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <span class="me-2 text-success">&#10004;</span> <%= foundSuccess %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
            session.removeAttribute("foundSuccess");
        }
    %>
    <%
        String feedbackSuccess = (String) session.getAttribute("feedbackSuccess");
        if (feedbackSuccess != null) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= feedbackSuccess %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
            session.removeAttribute("feedbackSuccess");
        }
    %>

    <div class="welcome-box">
        <h2>Welcome, <%= username %> </h2>
        <p>Manage your lost & found reports here</p>
    </div>

    <!-- Statistik -->
    <div class="row g-4 stats-section">
        <div class="col-md-3">
            <div class="card text-white bg-danger p-3">
                <h5>Total Lost Items</h5>
                <h3><%= totalLost %></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-white bg-primary p-3">
                <h5>Total Found Items</h5>
                <h3><%= totalFound %></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-white bg-success p-3">
                <h5>My Lost Reports</h5>
                <h3><%= myLost %></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-white bg-warning p-3">
                <h5>My Found Reports</h5>
                <h3><%= myFound %></h3>
            </div>
        </div>
    </div>

    <div class="row g-4 justify-content-center flex-wrap gap-3 mt-5 mb-5">
        <!-- View Reports -->
        <div class="col-md-5 col-lg-3">
            <div class="card option-card text-center p-4">
                <h5 class="mt-2">View Reports</h5>
                <p class="text-muted">Access all lost & found reports</p>
                <a href="viewReports.jsp" class="btn btn-outline-primary mt-2">Open</a>
            </div>
        </div>

        <!-- Report Lost Item -->
        <div class="col-md-5 col-lg-3">
            <div class="card option-card text-center p-4">
                <h5 class="mt-2">Report Lost Item</h5>
                <p class="text-muted">Report an item you have lost</p>
                <a href="submitLostItem.jsp" class="btn btn-outline-danger mt-2">Report</a>
            </div>
        </div>

        <!-- Report Found Item -->
        <div class="col-md-5 col-lg-3">
            <div class="card option-card text-center p-4">
                <h5 class="mt-2">Report Found Item</h5>
                <p class="text-muted">Found something? Let us know</p>
                <a href="submitFoundItem.jsp" class="btn btn-outline-success mt-2">Report</a>
            </div>
        </div>

        <!-- Give Feedback -->
        <div class="col-md-5 col-lg-3">
            <div class="card option-card text-center p-4">
                <h5 class="mt-2">Give Feedback</h5>
                <p class="text-muted">Tell us what you think</p>
                <a href="feedback.jsp" class="btn btn-outline-secondary mt-2">Send</a>
            </div>
        </div>
    </div>

</div>

<footer>
    &copy; 2025 Lost & Found Hub. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
