<!-- phones.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <%@include file="utils/imports.jsp"%>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">

  <title>Digital Delight</title>

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <!--owl slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
</head>

<body class="sub_page">

<!-- header section -->
<%@include file="utils/header.jsp"%>
<!-- shop section -->

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

<!-- end shop section -->

<!-- footer section -->
<%@include file="utils/footer.jsp"%>
<!-- footer section -->

<!-- jQery -->
<script src="js/jquery-3.4.1.min.js"></script>
<!-- popper js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js">
</script>
<!-- bootstrap js -->
<script src="js/bootstrap.js"></script>
<!-- owl slider -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
</script>
<!-- custom js -->
<script src="js/custom.js"></script>
<!-- Google Map -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap"></script>
<!-- End Google Map -->

</body>

</html>