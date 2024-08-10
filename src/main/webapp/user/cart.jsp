<!-- cart.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <%@include file="../utils/imports.jsp"%>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="shortcut icon" href="../images/contact.webp" type="image/x-icon">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <title>Digital Delight</title>
</head>
<body class="sub_page">
<%@include file="../utils/header.jsp"%>

<div class="container mt-5 min-vh-100">
    <h1 class="mb-4">Carrello</h1>
    <c:if test="${empty cart.items}">
        <div class="alert alert-warning" role="alert">
            Non ci sono prodotti presenti nel carrello
        </div>
    </c:if>
    <c:if test="${not empty cart.items}">
        <table class="table">
            <thead class="thead-dark">
            <tr>
                <th>Prodotto</th>
                <th>Quantitá</th>
                <th>Prezzo</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="grandTotal" value="0" />
            <c:forEach var="entry" items="${cart.items}">
                <tr>
                    <td><c:out value="${entry.key.name}"/></td>
                    <td><c:out value="${entry.value}"/></td>
                    <td><c:out value="${entry.key.price}"/></td>
                </tr>
                <c:set var="grandTotal" value="${grandTotal + (entry.key.price * entry.value)}" />
            </c:forEach>
            </tbody>
        </table>
        <div class="text-right">
            <strong>Total: $<c:out value="${grandTotal}"/></strong>
        </div>
        <form action="checkout" method="post">
            <button type="submit" class="btn btn-primary">Checkout</button>
        </form>
    </c:if>
</div>

<%@include file="../utils/footer.jsp"%>
<!-- footer section -->

<!-- jQery -->
<script src="js/jquery-3.4.1.min.js"></script>
<!-- popper js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<!-- bootstrap js -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- owl slider -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<!-- custom js -->
<script src="js/custom.js"></script>
<!-- Google Map -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap"></script>
<!-- End Google Map -->

</body>

</html>