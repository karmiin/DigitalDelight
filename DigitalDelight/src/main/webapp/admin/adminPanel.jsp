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
        <input type="text" class="form-control" id="quantity" name="quantity" placeholder="Enter quantity" required>
    </div>
    <div class="form-group">
        <input type="file" id="image" name="image"required>
    </div>
    <button type="submit" class="btn btn-primary w-100" value="Add Product">Create</button>
</form>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-md-12">
                <h2>Records</h2>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Image</th>
                        </tr>
                    </thead>
             
<form id="searchForm" action="${pageContext.request.contextPath}/adminPanel" method="GET">
<div class="form-group">
					<label for="search">Search:</label> 
					<input type="text" class="form-control" id="search" name="search" placeholder="Enter search">
					
					
						<button type="submit" class="btn btn-primary w-100" value="Cerca">Search</button>
</div>
</form>  

                    <tbody id="recordList">                  
<c:forEach var="product" items="${products}">
    <tr>
        <td>${product.name}</td>
        <td>${product.description}</td>
        <td>${product.price}</td>
        <td>${product.quantity}</td>
        <td><img id="showimg" src="${pageContext.request.contextPath}/image?id=${product.id}"></td>
    </tr>
</c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </section>  

        <!-- Bootstrap & jQuery JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="../js/admin/scriptAdminPanel.js"></script>
    
</body>
</html>
