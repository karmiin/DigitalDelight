// CartServlet.java
package it.unisa.controller;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.ProductDAO;
import it.unisa.model.Cart;
import it.unisa.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(CartController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        try {
            ProductDAO productDAO = new ProductDAO(DatabaseConnection.getConnection());
            Map<Product, Integer> itemsWithAvailability = new HashMap<>();
            for (Map.Entry<Product, Integer> entry : cart.getItems().entrySet()) {
                int availableQuantity = productDAO.getAvailableQuantity(entry.getKey().getId());
                itemsWithAvailability.put(entry.getKey(), availableQuantity);
            }
            request.setAttribute("itemsWithAvailability", itemsWithAvailability);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Database connection error", e);
            response.sendRedirect("500.jsp");
            return;
        }

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("user/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try {
            ProductDAO productDAO = new ProductDAO(DatabaseConnection.getConnection());
            Product product = productDAO.getProductById(productId);
            int availableQuantity = productDAO.getAvailableQuantity(productId);
            int totalQuantityInCart = cart.getTotalQuantity(product);
            if (totalQuantityInCart + quantity <= availableQuantity) {
                cart.addItem(product, quantity);
                response.sendRedirect("phones?success=" + product.getName() + " aggiunto al carrello");
            } else {
                response.sendRedirect("phones?error=" + product.getName() + " non disponibile");
            }
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Database connection error", e);
            response.sendRedirect("500.jsp");
        }
    }
}