<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Conferma Checkout</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<section class="h-100 gradient-custom">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-lg-10 col-xl-8">
                <div class="card" style="border-radius: 10px;">
                    <div class="card-header px-4 py-5">
                        <c:choose>
                            <c:when test="${not empty param.success}">
                                <h5 class="text-muted mb-0">Grazie per il tuo ordine, <span style="color: #a8729a;"><c:out value="${user.firstName}"/></span>!</h5>
                            </c:when>
                            <c:when test="${not empty param.error}">
                                <h5 class="text-muted mb-0">Si è verificato un problema con il tuo ordine, <span style="color: #a8729a;"><c:out value="${user.firstName}"/></span>. Per favore, riprova.</h5>
                            </c:when>
                        </c:choose>
                    </div>
                    <div class="card-body p-4">
                        <c:choose>
                            <c:when test="${not empty param.success}">
                                <div class="alert alert-light" role="alert">
                                        ${param.success}
                                </div>
                                <div class="card shadow-0 border mb-4">
                                    <div class="card-body">
                                        <c:forEach var="item" items="${orderItems}">
                                            <div class="row mb-2">
                                                <div class="col-md-2">
                                                    <img src="${pageContext.request.contextPath}/image?id=${item.getProductId()}" class="img-fluid" alt="Product Image">
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0 small">Quantità: <c:out value="${item.quantity}"/></p>
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0 small">Prezzo: €<c:out value="${item.price}"/></p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <a href="index.jsp" class="btn btn-primary">Torna alla Home</a>
                            </c:when>
                            <c:when test="${not empty param.error}">
                                <div class="alert alert-danger" role="alert">
                                        ${param.error}
                                </div>
                                <p>Si è verificato un problema con il tuo ordine. Per favore, riprova.</p>
                                <a href="cart.jsp" class="btn btn-primary">Torna al Carrello</a>
                            </c:when>
                        </c:choose>
                    </div>
                    <div class="card-footer border-0 px-4 py-5" style="background-color: #a8729a; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;">
                        <h5 class="d-flex align-items-center justify-content-end text-white text-uppercase mb-0">Totale pagato: <span class="h2 mb-0 ms-2">€<c:out value="${order.totalAmount}"/></span></h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script type='text/javascript' src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js'></script>
</body>
</html>