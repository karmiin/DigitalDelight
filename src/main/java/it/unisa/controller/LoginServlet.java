package it.unisa.controller;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.Serial;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 3527207757698776852L;
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=Invalid input");
            return;
        }

        UserDAO userDAO = null;
        try {
            userDAO = new UserDAO(DatabaseConnection.getConnection());
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Database connection error", e);
            response.sendRedirect("login.jsp?error=Database connection error");
            return;
        }

        int userId = -1;
        try {
            userId = userDAO.authenticate(email, password);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Authentication error", e);
            response.sendRedirect("login.jsp?error=Authentication error");
            return;
        }

        if (userId != -1) {
            HttpSession session = request.getSession();
            session.invalidate(); // Invalidate old session
            session = request.getSession(true); // Create new session
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            session.setAttribute("userId", userId);
            response.sendRedirect("index");
            LOGGER.info("Login successful for user ID: " + userId);
        } else {
            response.sendRedirect("login.jsp?error=Invalid email or password");
            LOGGER.warning("Login failed for email: " + email);
        }
    }
}