<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Lost & Found Hub</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-image: url('images/background.jpg'); 
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .main-box {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.2);
            text-align: center;
        }

        h1 {
            color: #1f7a8c; /* turquoise theme */
        }

        .btn-custom {
            min-width: 150px;
        }
    </style>
</head>
<body>

<div class="main-box">
    <h1 class="mb-4">Welcome to Lost & Found Hub</h1>
    <p class="lead mb-4">Please register or login to continue.</p>
    
    <div class="d-flex justify-content-center gap-3">
        <a href="register.jsp" class="btn btn-success btn-custom">Register</a>
        <a href="login.jsp" class="btn btn-primary btn-custom">Login</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
