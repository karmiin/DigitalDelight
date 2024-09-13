$(document).ready(function() {
    $('input[name="quantity"]').change(function() {
        let productId = $(this).attr('id').split('-')[1];
        let newQuantity = $(this).val();
        updateCart(productId, newQuantity);
    });
});

function updateCart(productId, newQuantity) {
    $.ajax({
        url: 'updateCart',
        type: 'POST',
        data: {
            productId: productId,
            quantity: newQuantity
        },
        success: function(response) {
            // Update the cart UI with the new quantity and price
            $('#quantity-' + productId).val(response.newQuantity);
            $('#quantity-display-' + productId).text(response.newQuantity);
            $('#total-price').text('€' + response.newTotalPrice);
        },
        error: function() {
            alert('Errore durante l\'aggiornamento del carrello.');
        }
    });
}