<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Digital Delight ADMIN</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <%@include file="../utils/imports.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/adminPanel.css">
</head>
<body class="sub_page">
<%@include file="../utils/header.jsp" %>

<div class="container-fluid">
                        <div class="row">
                            <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar bg-white" style="margin-top:1vh;">
                                <div class="sidebar-sticky">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link active text-black" href="#" onclick="showSection('dashboard')">
                                                <i class="fa fa-home me-2"></i>
                                                Dashboard
                                            </a>
                                        </li>
                                        <li class="nav-item">
                        <a class="nav-link text-black" href="#" onclick="showSection('addProduct')">
                            <i class="fa fa-plus me-2"></i>
                            Aggiungi prodotto
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link black text-black" href="#" onclick="showSection('manageProducts')">
                            <i class="fa fa-cogs me-2"></i>
                            Gestisci prodotti
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <main role="main" class="col-md-9 ms-sm-auto col-lg-12 px-md-4">
            <div id="dashboard" class="content-section">
                <%@include file="dashboard.jsp"%>
            </div>
            <div id="addProduct" class="content-section" style="display:none;">
                <%@include file="addProductPage.jsp" %>
            </div>
            <div id="manageProducts" class="content-section" style="display:none;">
                <%@include file="manageProductsPage.jsp" %>
            </div>
        </main>
    </div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>var contextPath = '${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/js/admin/showSection.js"></script>
<script src="${pageContext.request.contextPath}/js/admin/scriptAdminPanel.js"></script>
<script src="${pageContext.request.contextPath}/js/admin/searchProducts.js"></script>
</body>
</html>