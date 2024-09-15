<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <%@include file="utils/imports.jsp"%>
  <link rel="stylesheet" href="css/index.css" />
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" href="images/logo.png" type="image/x-icon" />
  <title>Digital Delight</title>

</head>
<body>
<%@include file="utils/header.jsp"%>
<div class="hero_area d-flex justify-content-center align-content-between">
  <div class="row">
    <div class="col-md-6 text-white">
      <h1>Il tuo prossimo smartphone ti aspetta!</h1>
      <p>Visita la nostra sezione 'Novitá' per scoprire i cellulari piú recenti, con design mozzafiato</p>

      <a href="#novita" class="btn btn-light btn-lg">Scopri di piú</a>
    </div>
    <div class="col-md-6">
      <img src="images/iphone14.png" class="w-75" alt="">
    </div>
  </div>
</div>


<section class="shop_section layout_padding">
  <div class="container" id="novita">
    <div class="heading_container heading_center">
      <h2>
        Novitá
      </h2>
    </div>
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
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</section>


<section class="about-section layout_margin">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 text-center">
        <h1 class="about-title">Chi Siamo</h1>
        <p class="about-text mt-4">Benvenuti su <span class="highlight">Digital Delight</span>!</p>
        <p class="about-text">Siamo un team di appassionati di tecnologia che vive e respira innovazione. La nostra missione è semplice: mettere a disposizione dei nostri clienti i migliori smartphone e accessori sul mercato, offrendo un'esperienza di acquisto senza eguali.</p>
        <p class="about-text">In un mondo in costante evoluzione, sappiamo quanto sia importante rimanere connessi. Ecco perché selezioniamo con cura ogni prodotto nel nostro catalogo, garantendo che solo il meglio arrivi nelle vostre mani. Dalle ultime novità in fatto di cellulari ai gadget più all'avanguardia, <span class="highlight">Digital Delight</span> è il vostro punto di riferimento per tutto ciò che riguarda la tecnologia mobile.</p>
        <p class="about-text">Crediamo che ogni dispositivo non sia solo un oggetto, ma un compagno di vita che riflette la vostra personalità e vi accompagna nelle sfide quotidiane. Per questo, ci impegniamo a offrirvi non solo i prodotti più innovativi, ma anche un servizio clienti dedicato, pronto a supportarvi in ogni fase del vostro acquisto.</p>
        <h3 class="mt-5 mb-4">Perché scegliere <span class="highlight">Digital Delight</span>?</h3>
        <ul class="list-unstyled about-text">
          <li><i class="fas fa-check-circle"></i> <strong>Qualità e Affidabilità:</strong> Collaboriamo con i migliori brand del settore per garantire prodotti di alta qualità e durata.</li>
          <li><i class="fas fa-check-circle"></i> <strong>Novità e Tendenze:</strong> Siamo sempre aggiornati sulle ultime uscite e vi portiamo le novità direttamente a casa.</li>
          <li><i class="fas fa-check-circle"></i> <strong>Servizio Clienti Eccellente:</strong> Il nostro team è qui per aiutarvi, dall'acquisto alla post-vendita, con supporto rapido e competente.</li>
        </ul>
        <p class="about-text mt-4">Unitevi alla nostra community e scoprite un mondo di tecnologia avanzata, design raffinato e innovazione continua. Con <span class="highlight">Digital Delight</span>, il futuro è a portata di mano.</p>
      </div>
    </div>
  </div>
</section>



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
          <img src="images/logo.png" alt="">

        </div>
      </div>
    </div>
  </div>
</section>
<%@include file="utils/footer.jsp"%>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js">
</script>
<script src="js/bootstrap.js"></script>
<script src="js/custom.js"></script>
</body>
</html>