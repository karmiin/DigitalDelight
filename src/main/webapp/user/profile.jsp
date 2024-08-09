<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="it.unisa.model.User, it.unisa.dao.UserDAO, it.unisa.model.Order, it.unisa.model.Product" %>
<%@ page import="it.unisa.connection.DatabaseConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserDAO userDAO = null;
    User user = null;
    try {
        userDAO = new UserDAO(DatabaseConnection.getConnection());
        user = userDAO.getUser(userId);
    } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
    }

    int itemsInCart = 0;
    try {
        itemsInCart = userDAO.getItemsInCart(user.getId());
    } catch (Exception e) {
        e.printStackTrace();
    }
    int ordersPlaced = 0;
    try {
        ordersPlaced = userDAO.getOrdersPlaced(user.getId());
    } catch (Exception e) {
        e.printStackTrace();
    }
    List<Order> recentOrders = null;
    try {
        recentOrders = userDAO.getRecentOrders(user.getId());
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/profile.css">
    <title>Profile</title>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <%@include file="/utils/imports.jsp" %>
</head>
<body>
<%@ include file="/utils/header.jsp" %>
<div class="container mt-4">
    <div class="row">
        <div class="col-lg-3 my-lg-0 my-md-1">
            <div id="sidebar" class="bg-purple">
                <div class="h4 text-white">Account</div>
                <ul>
                    <li class="active">
                        <a href="#" class="text-decoration-none d-flex align-items-start">
                            <div class="fas fa-box pt-2 me-3"></div>
                            <div class="d-flex flex-column">
                                <div class="link">My Account</div>
                                <div class="link-desc">View & Manage orders and returns</div>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="text-decoration-none d-flex align-items-start">
                            <div class="fas fa-box-open pt-2 me-3"></div>
                            <div class="d-flex flex-column">
                                <div class="link">My Orders</div>
                                <div class="link-desc">View & Manage orders and returns</div>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="text-decoration-none d-flex align-items-start">
                            <div class="far fa-address-book pt-2 me-3"></div>
                            <div class="d-flex flex-column">
                                <div class="link">Address Book</div>
                                <div class="link-desc">View & Manage Addresses</div>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="text-decoration-none d-flex align-items-start">
                            <div class="far fa-user pt-2 me-3"></div>
                            <div class="d-flex flex-column">
                                <div class="link">My Profile</div>
                                <div class="link-desc">Change your profile details & password</div>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="text-decoration-none d-flex align-items-start">
                            <div class="fas fa-headset pt-2 me-3"></div>
                            <div class="d-flex flex-column">
                                <div class="link">Help & Support</div>
                                <div class="link-desc">Contact Us for help and support</div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-lg-9 my-lg-0 my-1">
            <div id="main-content" class="bg-white border">
                <div class="d-flex flex-column">
                    <div class="h5">Benvenuto <c:out value="${user.firstName}"/>,</div>
                </div>
                <div class="d-flex my-4 flex-wrap">
                    <div class="box me-4 my-1 bg-light">
                        <img src="https://www.freepnglogos.com/uploads/box-png/cardboard-box-brown-vector-graphic-pixabay-2.png"
                             alt="">
                        <div class="d-flex align-items-center mt-2">
                            <div class="tag">Orders placed</div>
                            <div class="ms-auto number"><%= ordersPlaced %></div>
                        </div>
                    </div>
                    <div class="box me-4 my-1 bg-light">
                        <img src="https://www.freepnglogos.com/uploads/shopping-cart-png/shopping-cart-campus-recreation-university-nebraska-lincoln-30.png"
                             alt="">
                        <div class="d-flex align-items-center mt-2">
                            <div class="tag">Items in Cart</div>
                            <div class="ms-auto number"><%= itemsInCart %></div>
                        </div>
                    </div>
                </div>
                <div class="text-uppercase">My recent orders</div>
                <c:forEach var="order" items="${recentOrders}">
                    <div class="order my-3 bg-light">
                        <div class="row">
                            <div class="col-lg-4">
                                <div class="d-flex flex-column justify-content-between order-summary">
                                    <div class="d-flex align-items-center">
                                        <div class="text-uppercase">Order #<c:out value="${order.id}"/></div>
                                        <div class="blue-label ms-auto text-uppercase"><c:out value="${order.status}"/></div>
                                    </div>
                                    <div class="fs-8">Products #<c:out value="${order.products.size()}"/></div>
                                    <div class="fs-8"><c:out value="${order.orderDate}"/></div>
                                    <div class="rating d-flex align-items-center pt-1">
                                        <img src="https://www.freepnglogos.com/uploads/like-png/like-png-hand-thumb-sign-vector-graphic-pixabay-39.png"
                                             alt=""><span class="px-2">Rating:</span>
                                        <span class="fas fa-star"></span>
                                        <span class="fas fa-star"></span>
                                        <span class="fas fa-star"></span>
                                        <span class="fas fa-star"></span>
                                        <span class="far fa-star"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <div class="d-sm-flex align-items-sm-start justify-content-sm-between">
                                    <div class="status">Status : <c:out value="${order.status}"/></div>
                                    <div class="btn btn-primary text-uppercase">order info</div>
                                </div>
                                <div class="progressbar-track">
                                    <ul class="progressbar">
                                        <li id="step-1-<c:out value="${order.id}"/>" class="text-muted green">
                                            <span class="fas fa-gift"></span>
                                        </li>
                                        <li id="step-2-<c:out value="${order.id}"/>" class="text-muted green">
                                            <span class="fas fa-check"></span>
                                        </li>
                                        <li id="step-3-<c:out value="${order.id}"/>" class="text-muted green">
                                            <span class="fas fa-box"></span>
                                        </li>
                                        <li id="step-4-<c:out value="${order.id}"/>" class="text-muted green">
                                            <span class="fas fa-truck"></span>
                                        </li>
                                        <li id="step-5-<c:out value="${order.id}"/>" class="text-muted green">
                                            <span class="fas fa-box-open"></span>
                                        </li>
                                    </ul>
                                    <div id="tracker-<c:out value="${order.id}"/>"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script type='text/javascript' src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js'></script>
</body>
</html>