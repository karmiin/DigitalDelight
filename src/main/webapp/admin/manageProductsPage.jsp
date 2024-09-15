

<div class="container mt-5">
    <form id="searchForm" action="${pageContext.request.contextPath}/adminPanel" method="GET" onsubmit="return false;">
        <div class="form-group d-flex">
            <input type="text" class="form-control" id="search" name="search" placeholder="Cerca prodotto">
            <button type="button" class="btn btn-dark" onclick="searchProducts()"><i class="fa fa-search"></i></button>
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
            <th>Modello</th>
            <th>Immagine</th>
            <th>Azioni</th>
        </tr>
        </thead>
        <tbody id="productTableBody">
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
                    <button type="button" class="btn btn-light edit-product-btn" data-id="${product.id}" data-name="${product.name}" data-description="${product.description}" data-price="${product.price}" data-stock="${product.stock}" data-brand="${product.brand}" data-model="${product.model}">
                        <i class="fa fa-edit"></i>
                    </button>
                    <form action="delete-product" method="post">
                        <input type="hidden" name="id" value="${product.id}" />
                        <button type="submit" class="btn btn-danger"><i class="fa fa-trash"></i></button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

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
                        <label for="editName">Nome</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Descrizione</label>
                        <input type="text" class="form-control" id="editDescription" name="description" required>
                    </div>
                    <div class="form-group">
                        <label for="editPrice">Prezzo</label>
                        <input type="text" class="form-control" id="editPrice" name="price" required>
                    </div>
                    <div class="form-group">
                        <label for="editStock">Stock</label>
                        <input type="text" class="form-control" id="editStock" name="stock" required>
                    </div>
                    <div class="form-group">
                        <label for="editBrand">Brand</label>
                        <input type="text" class="form-control" id="editBrand" name="brand" required>
                    </div>
                    <div class="form-group">
                        <label for="editModel">Modello</label>
                        <input type="text" class="form-control" id="editModel" name="model" required>
                    </div>
                    <div class="form-group">
                        <input type="file" id="editImage" name="image">
                    </div>
                    <button type="submit" class="btn btn-light w-100">Aggiorna</button>
                </form>
            </div>
        </div>
    </div>
</div>
