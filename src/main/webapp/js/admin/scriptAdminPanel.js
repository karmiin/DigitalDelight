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