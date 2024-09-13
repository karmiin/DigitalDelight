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

@WebServlet("/edit-product")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class EditProductServlet extends HttpServlet {
private ProductDAO productDAO;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            productDAO = new ProductDAO(DatabaseConnection.getConnection());
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        int id = Integer.parseInt(request.getParameter("id"));
        if (request.getParameter("id") == null) {
            response.sendRedirect("adminPanel?error=Invalid input");
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String stock = request.getParameter("stock");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        Part filePart = request.getPart("image");
        InputStream inputStream = filePart != null && filePart.getSize() > 0 ? filePart.getInputStream() : null;

        Product product = null;
        try {
            product = productDAO.getProductById(id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        product.setName(name);
        product.setDescription(description);
        product.setPrice(Double.parseDouble(price));
        product.setStock(Integer.parseInt(stock));
        product.setBrand(brand);
        product.setModel(model);
        if (inputStream != null) {
            product.setImage(inputStream.readAllBytes());
        }

        try {
            productDAO.updateProduct(product);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("adminPanel?success=Product updated successfully");
    }
    }
