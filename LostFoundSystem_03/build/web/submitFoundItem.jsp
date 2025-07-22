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
    <title>Report Found Item</title>
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
            color: #198754;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-weight: 700;
        }

        label.form-label {
            font-weight: 600;
        }

        .btn-submit {
            background-color: #198754;
            border-color: #198754;
            font-weight: 500;
            font-size: 1.1rem;
        }

        .btn-submit:hover {
            background-color: #157347;
            border-color: #157347;
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
        <h2 class="text-center mb-4">Report Found Item</h2>

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

        <form action="SubmitFoundItemServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Item Name</label>
                <input type="text" name="itemName" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Category</label>
                <input type="text" name="category" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" rows="3" required></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Date Found</label>
                <input type="date" name="dateFound" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Location Found</label>
                <input type="text" name="locationFound" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Your Contact Info</label>
                <input type="text" name="contactInfo" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Tracking Number</label>
                <input type="text" name="trackingNumber" class="form-control" required>
            </div>
            
                <div class="mb-3">
                    <label class="form-label">Courier Service</label>
                    <select name="courierService" class="form-control" required>
                    <option value="">-- Select Courier --</option>
                    <option value="J&T">J&T</option>
                    <option value="PosLaju">PosLaju</option>
                    <option value="Shopee Express">Shopee Express</option>
                    <option value="DHL">DHL</option>
                    <option value="Ninja Van">Ninja Van</option>
                </select>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-submit">Submit Found Item Report</button>
                <a href="dashboard.jsp" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
