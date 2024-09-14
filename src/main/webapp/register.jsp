<!-- register.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="it.unisa.connection.DatabaseConnection"%>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" href="images/logo.png" type="image/x-icon" />
    <title>Digital Delight</title>

    <%@include file="utils/imports.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fixAuth.css">
</head>

<body>
<%@include file="utils/header.jsp" %>

<div class="wrapper fadeInDown">
    <div id="formContent">
        <div class="fadeIn first">
            <img src="https://www.svgrepo.com/show/529284/user-id.svg" id="icon" alt="User Icon" height="50" width="50"/>
        </div>


        <form id="registerForm" class="form-group" action="${pageContext.request.contextPath}/register" method="POST">
            <span id="messageError" style="color: #ff0000; display: none;"></span>
            <input type="text" id="firstname" class="fadeIn second" name="firstname" placeholder="first name" required>
            <input type="text" id="lastname" class="fadeIn second" name="lastname" placeholder="last name" required>
            <input type="text" id="username" class="fadeIn third" name="username" placeholder="username" required>
            <input type="text" id="email" class="fadeIn fourth" name="email" placeholder="email" required>
            <input type="password" id="password" class="fadeIn fourth" name="password" placeholder="password" required>
            <input type="submit" class="fadeIn fourth" value="Register">
        </form>

        <div id="formFooter">
            Hai giá un account?
            <a class="underlineHover" href="login">Log-in</a>
        </div>

    </div>
</div>

<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/register.js"></script>
</body>
</html>