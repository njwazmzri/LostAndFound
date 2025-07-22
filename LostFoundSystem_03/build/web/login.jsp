<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Lost & Found System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-image: url('images/bg.jpg'); /* Optional: boleh tukar gambar */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.2);
        }

        h2 {
            color: #1f7a8c;
        }

        .form-text-link {
            font-size: 0.9em;
        }
    </style>
</head>
<body>

<div class="container col-md-5">
    <div class="card">
        <h2 class="text-center mb-4">User Login</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-1">
                <label for="password" class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <!-- Forgot Password Link -->
            <div class="text-end mb-3">
                <a href="forgotPassword.jsp" class="text-decoration-none text-muted form-text-link">Forgot Password?</a>
            </div>

            <button type="submit" class="btn btn-success w-100">Login</button>
        </form>

        <p class="mt-3 text-center">Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
