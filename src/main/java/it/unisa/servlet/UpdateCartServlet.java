package it.unisa.servlet;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.ProductDAO;
import it.unisa.model.Cart;
import it.unisa.model.Product;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/updateCart")
public class UpdateCartServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try{
            productDAO = new ProductDAO(DatabaseConnection.getConnection());
        }catch (SQLException | ClassNotFoundException e){
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));

        Product product = null;
        try {
            product = productDAO.getProductById(productId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (product != null && newQuantity <= product.getStock()) {
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            if (cart != null) {
                cart.updateItem(product, newQuantity);
                double newTotalPrice = cart.getGrandTotal();

                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print("{\"newQuantity\": " + newQuantity + ", \"newTotalPrice\": " + newTotalPrice + "}");
                out.flush();
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quantità non valida");
        }
    }
}