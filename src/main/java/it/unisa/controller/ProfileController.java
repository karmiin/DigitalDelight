// ProfileServlet.java
package it.unisa.controller;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.OrderDAO;
import it.unisa.dao.UserDAO;
import it.unisa.model.Order;
import it.unisa.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.Serial;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(ProfileController.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login?error=Devi essere loggato per accedere al profilo");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        UserDAO userDAO = null;
        User user = null;
        try {
            userDAO = new UserDAO(DatabaseConnection.getConnection());
            user = userDAO.getUser(userId);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Database connection error", e);
            response.sendRedirect("500.jsp");
            return;
        }
        List<Order> orders = null;
        request.setAttribute("user", user);
        try {
            OrderDAO orderDAO = new OrderDAO(DatabaseConnection.getConnection());
            orders = orderDAO.getOrdersByUserId(userId);

        }
        catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error getting recent orders", e);
            return;
        }
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("user/profile.jsp").forward(request, response);
    }
}