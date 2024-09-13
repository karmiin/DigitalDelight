package it.unisa.controller;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.ProductDAO;
import it.unisa.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.OptionalInt;

@WebServlet("/")
public class IndexController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DatabaseConnection.getConnection()){
            ProductDAO productDAO = new ProductDAO(conn);
            List<Product> products = productDAO.getProducts(OptionalInt.of(4));
            request.setAttribute("products", products);
        } catch (Exception e) {
            throw new ServletException("Cannot obtain products from DB", e);
        }
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}