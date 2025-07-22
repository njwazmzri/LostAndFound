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
    <title>Give Feedback</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: #f4f9ff;
        }

        .form-box {
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.05);
        }

        h2 {
            color: #0d6efd;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-weight: 700;
        }

        label.form-label {
            font-weight: 600;
        }

        .btn-submit {
            background-color: #0d6efd;
            border-color: #0d6efd;
            font-weight: 500;
            font-size: 1.1rem;
        }

        .btn-submit:hover {
            background-color: #0b5ed7;
            border-color: #0b5ed7;
        }

        .btn-cancel {
            background-color: #adb5bd;
            border-color: #adb5bd;
            font-weight: 500;
        }

        .btn-cancel:hover {
            background-color: #6c757d;
            border-color: #6c757d;
        }
    </style>
</head>
<body>

<div class="container mt-5 col-md-8">
    <div class="form-box">
        <h2 class="text-center mb-4">Give Feedback</h2>

        <%-- ✅ Display error if exists --%>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
            }
        %>

        <form action="FeedbackServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Your Name</label>
                <input type="text" name="customerName" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Rating (1 to 5)</label>
                <select name="rating" class="form-select" required>
                    <option value="" disabled selected>Select rating</option>
                    <option value="1">1 - Poor 😞</option>
                    <option value="2">2 - Fair 😐</option>
                    <option value="3">3 - Good 🙂</option>
                    <option value="4">4 - Very Good 😃</option>
                    <option value="5">5 - Excellent 🤩</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Comments</label>
                <textarea name="comments" class="form-control" rows="4" required></textarea>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-submit">Submit Feedback</button>
                <a href="dashboard.jsp" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
