package it.unisa.controller;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.UserDAO;
import it.unisa.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.Serial;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 3527207757698776852L;
    private static final Logger LOGGER = Logger.getLogger(RegisterController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String firstName = request.getParameter("firstname");
            String lastName = request.getParameter("lastname");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (firstName == null || lastName == null || username == null || email == null || password == null ||
                    firstName.isEmpty() || lastName.isEmpty() || username.isEmpty() || email.isEmpty() || password.isEmpty()) {
                request.setAttribute("errorMessage", "All fields are required.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                System.out.println("empty fields");
                System.out.println(firstName + " " + lastName + " " + username + " " + email + " " + password);
                return;
            }

            User user = new User();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);


            try {
                UserDAO userDAO = new UserDAO(DatabaseConnection.getConnection());
                userDAO.saveUser(user);
                response.sendRedirect("login");
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Errore durante la registrazione", e);
                request.setAttribute("errorMessage", "Errore, riprova.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            } catch (ClassNotFoundException e) {
                LOGGER.log(Level.SEVERE, "Error registering user", e);
                request.setAttribute("errorMessage", "Errore, Riprova.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
    }
}