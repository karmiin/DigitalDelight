<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="it.unisa.connection.DatabaseConnection"%>
<%
    try {
        boolean isConnected = DatabaseConnection.testConnection();
        if (!isConnected) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database connection failed");
            return;
        }
        request.setAttribute("isConnected", isConnected);
    } catch (Exception e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred: " + e.getMessage());
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <!-- Basic -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <!-- Site Metas -->
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">

    <title>Digital Delight</title>

    <%@include file="utils/imports.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>

<body>
<%@include file="utils/header.jsp" %>
<!------ Include the above in your HEAD tag ---------->

<div class="wrapper fadeInDown">
    <div id="formContent">
        <!-- Tabs Titles -->

        <!-- Icon -->
        <div class="fadeIn first">
            <img src="https://www.svgrepo.com/show/529284/user-id.svg" id="icon" alt="User Icon" height="50" width="50"/>
        </div>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/register" method="POST">
            <span id="error" style="color: #ff0000; display: none;"></span>
            <input type="text" id="firstname" class="fadeIn second" name="firstname" placeholder="first name" required>
            <input type="text" id="lastname" class="fadeIn second" name="lastname" placeholder="last name" required>
            <input type="text" id="username" class="fadeIn third" name="username" placeholder="username" required>
            <input type="text" id="email" class="fadeIn fourth" name="email" placeholder="email" required>
            <input type="text" id="password" class="fadeIn fourth" name="password" placeholder="password" required>
            <input type="submit" class="fadeIn fourth" value="Register">
        </form>
        <!-- Remind Passowrd -->
        <div id="formFooter">
            Already have an account?
            <a class="underlineHover" href="login">Log-in</a>
        </div>

    </div>
</div>

<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/register.js"></script>
</body>
</html>