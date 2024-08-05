package it.unisa.dao;

import java.sql.*;

import it.unisa.model.User;
import it.unisa.model.Address;
import it.unisa.model.Review;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public User getUser(int id) throws SQLException {
        String sql = "SELECT * FROM Users WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setEmail(rs.getString("email"));
            user.setFirstName(rs.getString("firstName"));
            user.setLastName(rs.getString("lastName"));
            user.setIsAdmin(rs.getBoolean("isAdmin"));
            return user;
        } else {
            return null;
        }
    }

    public void createUser(User user) throws SQLException {
        String sql = "INSERT INTO Users (username, password, email, firstName, lastName, isAdmin) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, user.getUsername());
        stmt.setString(2, user.getPassword());
        stmt.setString(3, user.getEmail());
        stmt.setString(4, user.getFirstName());
        stmt.setString(5, user.getLastName());
        stmt.setBoolean(6, user.getIsAdmin());
        stmt.executeUpdate();
    }

    public void updateUser(User user) throws SQLException {
        String sql = "UPDATE Users SET username = ?, password = ?, email = ?, firstName = ?, lastName = ?, isAdmin = ? WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, user.getUsername());
        stmt.setString(2, user.getPassword());
        stmt.setString(3, user.getEmail());
        stmt.setString(4, user.getFirstName());
        stmt.setString(5, user.getLastName());
        stmt.setBoolean(6, user.getIsAdmin());
        stmt.setInt(7, user.getId());
        stmt.executeUpdate();
    }

    public void deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM Users WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public int authenticate(String email, String password) throws SQLException {
        String sql = "SELECT id FROM Users WHERE email = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return rs.getInt("id");
        } else {
            return -1;
        }
    }

    public void createAddress(Address address) throws SQLException {
        String sql = "INSERT INTO Addresses (userId, addressLine1, addressLine2, city, state, postalCode, country) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, address.getUserId());
        stmt.setString(2, address.getAddressLine1());
        stmt.setString(3, address.getAddressLine2());
        stmt.setString(4, address.getCity());
        stmt.setString(5, address.getState());
        stmt.setString(6, address.getPostalCode());
        stmt.setString(7, address.getCountry());
        stmt.executeUpdate();
    }

    public void createReview(Review review) throws SQLException {
        String sql = "INSERT INTO Reviews (productId, userId, rating, comment, reviewDate) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, review.getProductId());
        stmt.setInt(2, review.getUserId());
        stmt.setInt(3, review.getRating());
        stmt.setString(4, review.getComment());
        stmt.setTimestamp(5, review.getReviewDate());
        stmt.executeUpdate();
    }
}