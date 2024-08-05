// ProductDAO.java
package it.unisa.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import it.unisa.connection.DatabaseConnection;
import it.unisa.model.Product;
import jakarta.servlet.http.Part;

public class ProductDAO {

    public void addProductWithImage(String name, String description, double price, int quantity, Part image) {
        String sql = "INSERT INTO Products (name, description, price, stock, image) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the values
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setDouble(3, price);
            stmt.setInt(4, quantity);

            // Handle the image upload
            InputStream inputStream = image.getInputStream();
            byte[] imageBytes = new byte[(int) image.getSize()];
            inputStream.read(imageBytes, 0, imageBytes.length);
            inputStream.close();

            stmt.setBytes(5, imageBytes);

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> getProducts() throws Exception {
        List<Product> products = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM Products";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setStock(resultSet.getInt("stock"));
                product.setBrand(resultSet.getString("brand"));
                product.setModel(resultSet.getString("model"));
                product.setImage(resultSet.getBytes("image")); // Retrieve image
                products.add(product);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }

        return products;
    }
}