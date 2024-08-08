<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
  HttpSession sessionForLogout = request.getSession(false);
  boolean loggedIn = (sessionForLogout!= null && sessionForLogout.getAttribute("userId") != null);
%>

<header class="header_section">
  <div class="container-fluid">
    <nav class="navbar navbar-expand-lg custom_nav-container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        <span>Digital Delight</span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav">
          <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}/">Home <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="phones">Phones</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="about">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="contact">Contact Us</a>
          </li>
        </ul>
        <div class="user_option-box">
          <a href="profile">
            <i class="fa fa-user" aria-hidden="true"></i>
          </a>
          <a href="">
            <i class="fa fa-cart-plus" aria-hidden="true"></i>
          </a>
          <a href="">
            <i class="fa fa-search" aria-hidden="true"></i>
          </a>
          <% if (loggedIn) { %>
          <a href="logout">
            <i class="fa fa-sign-out" aria-hidden="true"></i>
          </a>
          <% } %>
        </div>
      </div>
    </nav>
  </div>
</header>