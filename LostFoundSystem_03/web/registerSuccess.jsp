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
    <title>Registration Successful</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f4f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .success-box {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            font-family: 'Segoe UI', sans-serif;
            color: #2e7d32;
        }

        p.lead {
            font-size: 1.2rem;
            color: #555;
        }

        .btn-primary {
            background-color: #1b4e4f; 
            border-color: #0d47a1;
            padding: 10px 25px;
            font-weight: bold;
            border-radius: 30px;
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #153c3d; 
            border-color: #08306b;
        }
        .background-text {
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
            font-family: 'Playfair Display', serif;
            color: #7a7a7a;
            font-size: 1.25rem;
            opacity: 0.9;
        }
        .headline {
            position: absolute;
            top: 100px;
            width: 100%;
            text-align: center;
            z-index: 0;
        }

        .headline h1 {
            font-family: 'Playfair Display', serif;
            font-size: 60px;
            font-weight: 700;
            color: rgba(32, 92, 94, 0.6);
            text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.1);
            margin: 0;
            line-height: 1.0;
        }

    </style>
</head>
<body>

<div class="success-box">
    <h2>Registration Successful! 🎉</h2>
    <p class="lead">Welcome, <%= session.getAttribute("username") %>! You are now logged in.</p>
    <a href="dashboard.jsp" class="btn btn-primary mt-3">Go to Dashboard</a>
</div>
    
    <div class="headline">
        <h1>Find it fast,<br>Recover it Effortlessly</h1>
    </div>
</body>

</body>
</html>
