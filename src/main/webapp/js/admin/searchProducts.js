function searchProducts() {
    var searchQuery = document.getElementById('search').value;
    $.ajax({
        url: contextPath + '/adminPanel',
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