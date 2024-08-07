package it.unisa.servlet;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.ProductDAO;
import it.unisa.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/add-product")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String stock = request.getParameter("stock");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        Part filePart = request.getPart("image");

        if (name == null || description == null || price == null || stock == null || brand == null || model == null || filePart == null) {
            response.sendRedirect("adminPanel?error=Invalid input");
            return;
        }

        InputStream inputStream = filePart.getInputStream();

        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(Double.parseDouble(price));
        product.setStock(Integer.parseInt(stock));
        product.setBrand(brand);
        product.setModel(model);
        product.setImage(inputStream.readAllBytes());

        try (Connection conn = DatabaseConnection.getConnection()) {
            ProductDAO productDAO = new ProductDAO(conn);
            productDAO.addProduct(product);
            response.sendRedirect("adminPanel?success=Product added successfully");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminPanel?error=Database error");
        }
    }
}