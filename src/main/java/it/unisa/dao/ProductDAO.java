package it.unisa.dao;

import it.unisa.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.OptionalInt;

public class ProductDAO {
    private final Connection conn;

    public ProductDAO(Connection conn) {
        this.conn = conn;
    }
    public void deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    public void addProduct(Product product) throws SQLException {
        String sql = "INSERT INTO products (name, description, price, stock, brand, model, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getStock());
            stmt.setString(5, product.getBrand());
            stmt.setString(6, product.getModel());
            stmt.setBytes(7, product.getImage());
            stmt.executeUpdate();
        }
    }

    public void updateProduct(Product product) throws SQLException {
        String name = product.getName();
        String description = product.getDescription();
        double price = product.getPrice();
        int stock = product.getStock();
        String brand = product.getBrand();
        String model = product.getModel();
        int id = product.getId();
        byte[] image = product.getImage();
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, stock = ?, brand = ?, model = ?, image = ? WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setDouble(3, price);
            stmt.setInt(4, stock);
            stmt.setString(5, brand);
            stmt.setString(6, model);
            stmt.setBytes(7, image);
            stmt.setInt(8, id);
            stmt.executeUpdate();
        }

    }
    public Product getProductById(int id) throws SQLException {
        Product product = null;
        String sql = "SELECT * FROM products WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setStock(rs.getInt("stock"));
                    product.setBrand(rs.getString("brand"));
                    product.setModel(rs.getString("model"));
                    product.setImage(rs.getBytes("image"));
                }
            }
        }
        return product;
    }
    public void updateAvailableQuantity(int productId, int quantity) throws SQLException {
        String query = "UPDATE products SET stock = stock - ? WHERE id = ?";
        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, quantity);
            preparedStatement.setInt(2, productId);
            preparedStatement.executeUpdate();
        }
    }

    public int getAvailableQuantity(int productId) throws SQLException {
        String query = "SELECT stock FROM Products WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("stock");
            }
        }
        return 0;
    }

    public List<Product> getProducts(OptionalInt nProducts) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next() && (nProducts.isEmpty() || products.size() < nProducts.getAsInt())) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setStock(resultSet.getInt("stock"));
                product.setBrand(resultSet.getString("brand"));
                product.setModel(resultSet.getString("model"));
                product.setImage(resultSet.getBytes("image"));
                products.add(product);
            }
        }
        return products;
    }
}

