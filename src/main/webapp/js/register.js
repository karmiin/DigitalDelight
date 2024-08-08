$(document).ready(function() {
    $('#registerForm').on('submit', function(event) {
        event.preventDefault(); // Prevent the default form submission

        var email = $('#email').val(); // Get the email value
        var username = $('#username').val(); // Get the username value

        $.ajax({
            type: 'POST', // Ensure it is POST
            url: '/DigitalDelight/checkRegister', // Correct URL
            data: { email: email, username: username },
            dataType: 'json',
            success: function(response) {
                if (response.emailExists) {
                    $('#messageError').text('Email already exists').show();
                } else if (response.usernameExists) {
                    $('#messageError').text('Username already exists').show();
                } else {
                    $('#messageError').hide();
                    $('#registerForm').off('submit').submit(); // Allow form submission
                }
            },
            error: function() {
                $('#messageError').text('An error occurred while checking the email and username').show();
            }
        });
    });
});