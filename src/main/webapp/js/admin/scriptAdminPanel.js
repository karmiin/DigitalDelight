$(document).ready(function() {
    $('.edit-product-btn').on('click', function() {
        var id = $(this).data('id');
        var name = $(this).data('name');
        var description = $(this).data('description');
        var price = $(this).data('price');
        var stock = $(this).data('stock');
        var brand = $(this).data('brand');
        var model = $(this).data('model');

        $('#editProductId').val(id);
        $('#editName').val(name);
        $('#editDescription').val(description);
        $('#editPrice').val(price);
        $('#editStock').val(stock);
        $('#editBrand').val(brand);
        $('#editModel').val(model);

        $('#editProductModal').modal('show');
    });
});
function searchProducts() {
    let searchQuery = document.getElementById('search').value;
    $.ajax({
        url: '${pageContext.request.contextPath}/adminPanel',
        type: 'GET',
        data: { search: searchQuery },
        success: function(response) {
            $('#productTableBody').html($(response).find('#productTableBody').html());
        },
        error: function(xhr, status, error) {
            console.error('Error fetching products:', error);
        }
    });
}