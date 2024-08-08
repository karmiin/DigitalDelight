document.addEventListener("DOMContentLoaded", function() {
    const emailInput = document.getElementById("email");
    const errorSpan = document.getElementById("error");

    emailInput.addEventListener("blur", function() {
        const email = emailInput.value;

        if (email) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", `${window.location.origin}/checkEmail`, true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        const data = JSON.parse(xhr.responseText);
                        if (data.exists) {
                            errorSpan.textContent = "Email already registered.";
                            errorSpan.style.display = "block";
                        } else {
                            errorSpan.style.display = "none";
                        }
                    } else {
                        console.error("Error checking email:", xhr.statusText);
                        errorSpan.textContent = "An error occurred while checking the email.";
                        errorSpan.style.display = "block";
                    }
                }
            };

            xhr.send(`email=${encodeURIComponent(email)}`);
        }
    });
});