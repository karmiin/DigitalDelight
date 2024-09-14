<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <%@include file="../utils/imports.jsp"%>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Digital Delight</title>
    <link rel="icon" href="images/logo.png" type="image/x-icon" />
</head>

<body class="sub_page">
<%@include file="../utils/header.jsp"%>

<section class="h-100 gradient-custom">
    <div class="container py-5">
        <div class="row d-flex justify-content-center my-4">
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">
                    <c:out value="${param.error}"/>
                </div>
            </c:if>
            <div class="col-md-8">
                <c:if test="${empty cart.items}">
                    <div class="alert alert-warning" role="alert">
                        Non ci sono prodotti presenti nel carrello
                    </div>
                </c:if>
                <div class="card mb-4">
                    <div class="card-header py-3">
                        <h5 class="mb-0">Carrello</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty cart.items}">
                            <c:forEach var="entry" items="${cart.items}">
                                <div class="row mb-4">
                                    <div class="col-lg-3 col-md-12 mb-4 mb-lg-0">
                                        <div class="bg-image hover-overlay hover-zoom ripple rounded" data-mdb-ripple-color="light">
                                            <img src="${pageContext.request.contextPath}/image?id=${entry.key.id}" class="w-50" alt="${entry.key.name}" />
                                            <a href="#!">
                                                <div class="mask" style="background-color: rgba(251, 251, 251, 0.2)"></div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-lg-5 col-md-6 mb-4 mb-lg-0">
                                        <p><strong><c:out value="${entry.key.name}"/></strong></p>
                                        <form action="cart" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="remove" />
                                            <input type="hidden" name="productId" value="${entry.key.id}" />
                                            <button type="submit" class="btn btn-light btn-sm me-1 mb-2" title="Remove item">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                    <div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
                                        <div class="d-flex mb-4" style="max-width: 300px">
                                            <input id="quantity-${entry.key.id}" min="1" max="${itemsWithAvailability[entry.key]}" name="quantity" value="${entry.value}" type="number" class="form-control col-sm-3 text-center" />
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-4" />
                            </c:forEach>
                            <div class="d-flex justify-content-end">
                            <form action="cart" method="post">
                                <input type="hidden" name="action" value="clear" />
                                <button type="submit" class="btn btn-danger me-1 mb-2" title="Clear cart">
                                <i class="fa fa-trash"></i>
                                </button>
                            </form>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="card mb-4 mb-lg-0">
                    <div class="card-body">
                        <p><strong>Accettiamo</strong></p>
                        <img class="me-2" width="45px" src="https://mdbcdn.b-cdn.net/wp-content/plugins/woocommerce-gateway-stripe/assets/images/visa.svg" alt="Visa" />
                        <img class="me-2" width="45px" src="https://mdbcdn.b-cdn.net/wp-content/plugins/woocommerce-gateway-stripe/assets/images/amex.svg" alt="American Express" />
                        <img class="me-2" width="45px" src="https://mdbcdn.b-cdn.net/wp-content/plugins/woocommerce-gateway-stripe/assets/images/mastercard.svg" alt="Mastercard" />
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header py-3">
                        <h5 class="mb-0">Riepilogo</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <c:forEach var="entry" items="${cart.items}">
            <span class="list-group-item d-flex align-items-center border-0 px-0 pb-0">
              <span class="me-2">
                 <c:out value="${entry.key.name}" /> x
                    <span id="quantity-display-${entry.key.id}">
                <c:out value="${entry.value}" />
            </span>
         </span>
        <span class="ms-auto">
             €<c:out value="${entry.key.price}" />
            </span>
    </span>

                                </c:forEach>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
                                <div>
                                    <strong>Totale</strong>
                                    <strong>
                                        <p class="mb-0">(IVA inclusa)</p>
                                    </strong>
                                </div>
                                <span id="total-price"><strong>€<c:out value="${cart.grandTotal}"/></strong></span>
                            </li>
                        </ul>
                        <form action="checkout" method="post">
                            <button type="submit" class="btn btn-primary btn-lg btn-block">Go to checkout</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="../utils/footer.jsp"%>

<!-- jQery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/cartScript.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>