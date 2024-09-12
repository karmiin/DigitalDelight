// CheckoutController.java
package it.unisa.controller;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.OrderDAO;
import it.unisa.dao.ProductDAO;
import it.unisa.dao.UserDAO;
import it.unisa.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(CheckoutController.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login?error=Devi essere loggato per effettuare il checkout");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            response.sendRedirect("cart?error=Carrello vuoto");
            return;
        }
        request.getRequestDispatcher("user/checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login?error=Devi essere loggato per effettuare il checkout");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart.getItems().isEmpty()) {
            response.sendRedirect("cart?error=Carrello vuoto");
            return;
        }

        try {
            ProductDAO productDAO = new ProductDAO(DatabaseConnection.getConnection());
            OrderDAO orderDAO = new OrderDAO(DatabaseConnection.getConnection());
            for (Product product : cart.getItems().keySet()) {
                int quantity = cart.getItems().get(product);
                int availableQuantity = productDAO.getAvailableQuantity(product.getId());
                if (quantity > availableQuantity) {
                    response.sendRedirect("checkout?error=" + product.getName() + " non disponibile in quantità sufficiente");
                    return;
                }
            }

            // Creo l'ordine
            Order order = new Order();
            order.setUserId(userId);
            order.setOrderDate(new Date());
            order.setStatus("COMPLETATO");
            order.setTotalAmount(cart.getGrandTotal());
            orderDAO.saveOrder(order);

            // Aggiungo i prodotti all'ordine
            List<OrderItem> orderItems = new ArrayList<>();
            for (Product product : cart.getItems().keySet()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(order.getId());
                orderItem.setProductId(product.getId());
                orderItem.setQuantity(cart.getItems().get(product));
                orderItem.setPrice(product.getPrice());
                orderItems.add(orderItem);
            }
            orderDAO.saveOrderItems(orderItems);

            //aggiorno lo stock nel database dei prodotti
            for(Product product: cart.getItems().keySet()){
                int quantity = cart.getItems().get(product);
                productDAO.updateAvailableQuantity(product.getId(), quantity);
            }

            // Imposto gli attributi dell'ordine e degli oggetti dell'ordine
            User user = null;
            try {
                UserDAO userDAO = new UserDAO(DatabaseConnection.getConnection());
                user = userDAO.getUser(userId);
            }catch (ClassNotFoundException | SQLException e) {
                LOGGER.log(Level.SEVERE, "Database connection error", e);
                response.sendError(500);
            }
            request.setAttribute("user", user);
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);

            cart.clear();
            request.getRequestDispatcher("user/checkout.jsp?success=Ordine completato con successo").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Database connection error", e);
            response.sendRedirect("500.jsp");
        }
    }
}