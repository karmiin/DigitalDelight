<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <%@include file="utils/imports.jsp"%>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <link rel="icon" href="images/logo.png" type="image/x-icon" />
  <title>Digital Delight</title>
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
</head>

<body class="sub_page">

<%@include file="utils/header.jsp"%>

<section class="shop_section layout_padding">
  <div class="container">
    <div class="heading_container heading_center">
      <h2>
        Nuove uscite
      </h2>
    </div>
    <c:if test="${not empty param.error}">
      <div class="alert alert-danger">
        <c:out value="${param.error}"/>
      </div>
    </c:if>
    <c:if test="${not empty param.success}">
      <div class="alert alert-success">
        <c:out value="${param.success}"/>
      </div>
    </c:if>
    <div class="row">
      <c:forEach var="product" items="${products}">
        <div class="col-md-6 col-xl-3">
          <div class="box">
            <div class="img-box">
              <img src="${pageContext.request.contextPath}/image?id=${product.id}" alt="">
            </div>
            <div class="detail-box">
              <h6>
                  ${product.name}
              </h6>
              <h6>
                Prezzo:
                <span>
                      ${product.price}€
                  </span>
              </h6>
            </div>
            <form action="${pageContext.request.contextPath}/cart" method="post">
              <input type="hidden" name="productId" value="${product.id}">
              <input type="hidden" name="quantity" value="1">
              <button type="submit" class="btn btn-primary">Aggiungi al carrello</button>
            </form>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</section>

<%@include file="utils/footer.jsp"%>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/custom.js"></script>

</body>

</html>