
<div class="container mt-5" style="max-width: 600px;">
    <div class="card shadow-sm mx-auto">
        <div class="card-body">
            <form id="crudForm" action="${pageContext.request.contextPath}/add-product" method="POST" enctype="multipart/form-data">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="name" name="name" placeholder="Inserisci nome" required>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="description" name="description" placeholder="Inserisci descrizione" required>
                </div>
                <div class="form-floating mb-3">
                    <input type="number" class="form-control" id="price" name="price" placeholder="Inserisci prezzo" step="0.01" required>
                </div>
                <div class="form-floating mb-3">
                    <input type="number" class="form-control" id="quantity" name="stock" placeholder="Inserisci stock" required>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="brand" name="brand" placeholder="Inserisci brand" required>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="model" name="model" placeholder="Inserisci modello" required>
                </div>
                <div class="mb-3">
                    <input class="form-control" type="file" id="image" name="image" required>
                </div>
                <button type="submit" class="btn btn-light w-100 rounded-pill">
                    <i class="fa fa-plus font-weight-bolder"> Aggiungi prodotto</i>
                </button>
            </form>
        </div>
    </div>
</div>