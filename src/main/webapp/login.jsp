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

  <title>Timups</title>

<%@include file="utils/imports.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>

<body>
    <%@include file="utils/header.jsp" %>
    
    
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
      <img src="https://www.svgrepo.com/show/529284/user-id.svg" id="icon" alt="User Icon" height="50" width="50" />
    </div>

    <!-- Login Form -->
   <form action="${pageContext.request.contextPath}/login" method="POST">
      <input type="text" id="email" class="fadeIn second" name="email" placeholder="email">
      <input type="text" id="password" class="fadeIn third" name="password" placeholder="password">
      <input type="submit" class="fadeIn fourth" value="Log In">
    </form>

    <!-- Remind Passowrd -->
    <div id="formFooter">
      <a class="underlineHover" href="#">Forgot Password?</a>
        <br>
        Dont have an account? <a  class="underlineHover" href="${pageContext.request.contextPath}/register">Register</a>
    </div>

  </div>
</div>
</body>
</html>