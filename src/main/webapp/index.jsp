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

  <title>Timups</title>


  <!--owl slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
</head>

<body class="sub_page">

<!-- header section -->
<%@include file="utils/header.jsp"%>
<!-- shop section -->

<section class="shop_section layout_padding">
  <%@include file="utils/sideSocialBar.jsp"%>
  <div class="container">
    <div class="heading_container heading_center">
      <h2>
        Latest Phones
      </h2>
    </div>

    <div class="row">
      <c:forEach var="product" items="${products}">
        <div class="col-md-6 col-xl-3">
          <div class="box">
            <a href="">
              <div class="img-box">
                <img src="${pageContext.request.contextPath}/image?id=${product.id}" alt="">
              </div>
              <div class="detail-box">
                <h6>
                    ${product.name}
                </h6>
                <h6>
                  Price:
                  <span>
                      ${product.price}
                  </span>
                </h6>
              </div>
            </a>
          </div>
        </div>
      </c:forEach>
    </div>

    <div class="btn-box">
      <a href="phones">
        View All
      </a>
    </div>
  </div>
</section>


<section class="about_section layout_padding mb-5">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-lg-5 ">
        <div class="img-box">
          <img src="images/contact.webp" alt="">
        </div>
      </div>
      <div class="col-md-6 col-lg-7">
        <div class="detail-box">
          <div class="heading_container">
            <h2>
              About Us
            </h2>
          </div>
          <p>
            There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration
            in some form, by injected humour, or randomised words which don't look even slightly believable. If you
            are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in
            the middle of text. All
          </p>
          <a href="">
            Read More
          </a>
        </div>
      </div>
    </div>
  </div>
</section>


<!-- contact section -->
<section class="contact_section section_spacing mb-5">
  <div class="container">
    <div class="row">
      <div class="col-md-6">
        <div class="form_container">
          <div class="heading_container">
            <h2>
              Contattaci
            </h2>
          </div>
          <form action="">
            <div>
              <input type="text" placeholder="Nome e Cognome " />
            </div>
            <div>
              <input type="email" placeholder="Email" />
            </div>
            <div>
              <input type="text" placeholder="Numero di telefono" />
            </div>
            <div>
              <input type="text" class="message-box" placeholder="Messaggio" />
            </div>
            <div class="d-flex ">
              <button>
                INVIA
              </button>
            </div>
          </form>
        </div>
      </div>
      <div class="col-md-6">
        <div class="img-box">
          <img src="images/contact.webp" alt="">
        </div>
      </div>
    </div>
  </div>
</section>
<!-- footer section -->
<%@include file="utils/footer.jsp"%>
<!-- footer section -->

<!-- jQery -->
<script src="js/jquery-3.4.1.min.js"></script>
<!-- popper js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js">
</script>
<!-- bootstrap js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
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