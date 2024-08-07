<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.connection.DatabaseConnection"%>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database CRUD</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/adminPanel.css">
</head>
<body>
<!-- Header Section -->
<header class="bg-dark text-white text-center p-4">
    Database CRUD Operations
</header>

<!-- CRUD Form -->
<section id="crud" class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2>Create, Read, Update, and Delete Records</h2>
            <form id="crudForm" action="${pageContext.request.contextPath}/add-product" method="POST" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <input type="text" class="form-control" id="description" name="description" placeholder="Enter Description" required>
                </div>
                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="text" class="form-control" id="price" name="price" placeholder="Enter price" required>
                </div>
                <div class="form-group">
                    <label for="quantity">Quantity</label>
                    <input type="text" class="form-control" id="quantity" name="stock" placeholder="Enter quantity" required>
                </div>
                <div class="form-group">
                    <label for="brand">Brand</label>
                    <input type="text" class="form-control" id="brand" name="brand" placeholder="Enter brand" required>
                </div>
                <div class="form-group">
                    <label for="model">Model</label>
                    <input type="text" class="form-control" id="model" name="model" placeholder="Enter model" required>
                </div>
                <div class="form-group">
                    <input type="file" id="image" name="image" required>
                </div>
                <button type="submit" class="btn btn-primary w-100" value="Add Product">Add Product</button>
            </form>
        </div>
    </div>
    <div class="row mt-5">
        <div class="col-md-12">
            <h2>Records</h2>
            <form id="searchForm" action="${pageContext.request.contextPath}/adminPanel" method="GET">
                <div class="form-group">
                    <label for="search">Search:</label>
                    <input type="text" class="form-control" id="search" name="search" placeholder="Enter search">
                    <button type="submit" class="btn btn-primary w-100" value="Cerca">Search</button>
                </div>
            </form>
            <table class="table">
                <thead>
                <tr>
                    <th>Nome</th>
                    <th>Descrizione</th>
                    <th>Prezzo</th>
                    <th>Stock</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Immagine</th>
                    <th>Azioni</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${product.name}</td>
                        <td>${product.description}</td>
                        <td>${product.price}</td>
                        <td>${product.stock}</td>
                        <td>${product.brand}</td>
                        <td>${product.model}</td>
                        <td><img src="${pageContext.request.contextPath}/image?id=${product.id}" width="100" height="100"></td>
                        <td>
                            <button type="button" class="btn btn-primary edit-product-btn" data-id="${product.id}" data-name="${product.name}" data-description="${product.description}" data-price="${product.price}" data-stock="${product.stock}" data-brand="${product.brand}" data-model="${product.model}">Modifica</button>
                            <form action="delete-product" method="post">
                                <input type="hidden" name="id" value="${product.id}" />
                                <button type="submit" class="btn btn-primary">Elimina</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</section>

<!-- Modal for editing product -->
<div class="modal fade" id="editProductModal" tabindex="-1" role="dialog" aria-labelledby="editProductModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProductModalLabel">Modifica Prodotto</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editProductForm" action="${pageContext.request.contextPath}/edit-product" method="POST" enctype="multipart/form-data">
                    <input type="hidden" id="editProductId" name="id">
                    <div class="form-group">
                        <label for="editName">Name:</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Description:</label>
                        <input type="text" class="form-control" id="editDescription" name="description" required>
                    </div>
                    <div class="form-group">
                        <label for="editPrice">Price:</label>
                        <input type="text" class="form-control" id="editPrice" name="price" required>
                    </div>
                    <div class="form-group">
                        <label for="editStock">Quantity:</label>
                        <input type="text" class="form-control" id="editStock" name="stock" required>
                    </div>
                    <div class="form-group">
                        <label for="editBrand">Brand:</label>
                        <input type="text" class="form-control" id="editBrand" name="brand" required>
                    </div>
                    <div class="form-group">
                        <label for="editModel">Model:</label>
                        <input type="text" class="form-control" id="editModel" name="model" required>
                    </div>
                    <div class="form-group">
                        <input type="file" id="editImage" name="image">
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Update Product</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap & jQuery JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin/scriptAdminPanel.js"></script>
</body>
</html>