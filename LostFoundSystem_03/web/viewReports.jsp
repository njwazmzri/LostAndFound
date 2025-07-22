<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    if (session == null || session.getAttribute("userID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Reports - Lost & Found</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f4f8fb;
            font-family: 'Segoe UI', sans-serif;
        }

        h3, h5 {
            font-family: 'Playfair Display', serif;
        }

        .section-title {
            color: #1f7a8c;
            font-weight: bold;
        }

        .card-option {
            transition: 0.3s;
            border: 1px solid #e0e0e0;
            border-radius: 15px;
        }

        .card-option:hover {
            transform: translateY(-5px);
            box-shadow: 0px 8px 16px rgba(0,0,0,0.1);
            background-color: #f9fcff;
        }

        .btn {
            border-radius: 30px;
            font-weight: 500;
            padding: 8px 20px;
        }

        .card h6 {
            font-size: 1.1rem;
            font-weight: 600;
            color: #444;
        }

        .header-text {
            margin-top: 30px;
            margin-bottom: 40px;
            text-align: center;
        }

        .header-text h3 {
            font-size: 2.2rem;
            font-weight: bold;
            color: #1f7a8c;
        }

        .emoji {
            font-size: 1.5rem;
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

        .top-left {
            position: absolute;
            top: 20px;
            left: 20px;
        }
    </style>
</head>
<body>

<!-- Back to Dashboard button -->
<div class="top-left">
    <a href="dashboard.jsp" class="btn btn-outline-secondary">← Back to Dashboard</a>
</div>

<div class="container">
    <div class="header-text">
        <h3>📂 View Lost & Found Reports</h3>
        <p class="text-muted">Access your personal and public reports here</p>
    </div>

    <!-- My Reports -->
    <div class="mb-5">
        <h5 class="section-title">🧍‍♀️ My Reports</h5>
        <div class="row g-4 mt-2">
            <div class="col-md-6">
                <div class="card card-option p-4 text-center">
                    <div class="emoji">📉</div>
                    <h6>My Lost Reports</h6>
                    <a href="viewLostItems.jsp" class="btn btn-outline-success mt-3">View</a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card card-option p-4 text-center">
                    <div class="emoji">📈</div>
                    <h6>My Found Reports</h6>
                    <a href="viewFoundItems.jsp" class="btn btn-outline-success mt-3">View</a>
                </div>
            </div>
        </div>
    </div>

    <!-- All Reports -->
    <div class="mb-5">
        <h5 class="section-title">🌐 All Reports</h5>
        <div class="row g-4 mt-2">
            <div class="col-md-6">
                <div class="card card-option p-4 text-center">
                    <div class="emoji">🔍</div>
                    <h6>All Lost Reports</h6>
                    <a href="viewAllLostItems.jsp" class="btn btn-outline-primary mt-3">View</a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card card-option p-4 text-center">
                    <div class="emoji">🛡️</div>
                    <h6>All Found Reports</h6>
                    <a href="viewAllFoundItems.jsp" class="btn btn-outline-primary mt-3">View</a>
                </div>
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
