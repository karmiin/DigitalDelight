package it.unisa.dao;

import it.unisa.model.Order;
import it.unisa.model.OrderItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDAO {
    private final Connection connection;

    public OrderDAO(Connection connection) {
        this.connection = connection;
    }

    public List<Order> getAllOrders() throws Exception {
        String query = "SELECT o.*, u.username FROM orders o JOIN users u ON o.userId = u.id";
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            List<Order> orders = new ArrayList<>();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("userId"));
                order.setUsername(rs.getString("username"));
                order.setOrderDate(rs.getDate("orderDate"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setItems(getOrderItemsByOrderId(order.getId()));
                orders.add(order);
            }
            return orders;
        }
    }

    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM orders WHERE userId = ?";
        List<Order> orders = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("userId"));
                    order.setOrderDate(rs.getDate("orderDate"));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getDouble("totalAmount"));
                    order.setItems(getOrderItemsByOrderId(order.getId())); // Aggiungi gli oggetti dell'ordine
                    orders.add(order);
                }
            }
        }
        return orders;
    }
    public List<Order> filterOrders(Date startDate, Date endDate, String customer) throws SQLException {
        String query = "SELECT * FROM orders WHERE orderDate BETWEEN ? AND ? AND userId LIKE ?";
        List<Order> orders = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDate(1, new java.sql.Date(startDate.getTime()));
            stmt.setDate(2, new java.sql.Date(endDate.getTime()));
            stmt.setString(3, "%" + customer + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("userId"));
                    order.setOrderDate(rs.getDate("orderDate"));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getDouble("totalAmount"));
                    order.setItems(getOrderItemsByOrderId(order.getId()));
                    orders.add(order);
                }
            }
        }
        return orders;
    }



    public void saveOrder(Order order) throws SQLException {
        String query = "INSERT INTO orders (userId, orderDate, status, totalAmount) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getUserId());
            stmt.setDate(2, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setString(3, order.getStatus());
            stmt.setDouble(4, order.getTotalAmount());
            stmt.executeUpdate();

            try (var rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    order.setId(rs.getInt(1));
                }
            }
        }
    }
    public List<Order> searchOrdersByUsernameAndDate(String username, Date startDate, Date endDate) throws Exception {
        StringBuilder query = new StringBuilder("SELECT o.*, u.username FROM orders o JOIN users u ON o.userId = u.id WHERE 1=1");
        if (username != null && !username.isEmpty()) {
            query.append(" AND u.username LIKE ?");
        }
        if (startDate != null && endDate != null) {
            query.append(" AND o.orderDate BETWEEN ? AND ?");
        }

        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (username != null && !username.isEmpty()) {
                stmt.setString(paramIndex++, "%" + username + "%");
            }
            if (startDate != null && endDate != null) {
                stmt.setDate(paramIndex++, new java.sql.Date(startDate.getTime()));
                stmt.setDate(paramIndex, new java.sql.Date(endDate.getTime()));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                List<Order> orders = new ArrayList<>();
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("userId"));
                    order.setUsername(rs.getString("username"));
                    order.setOrderDate(rs.getDate("orderDate"));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getDouble("totalAmount"));
                    order.setItems(getOrderItemsByOrderId(order.getId()));
                    orders.add(order);
                }
                return orders;
            }
        }
    }


    private List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        String query = "SELECT * FROM orderitems WHERE orderId = ?";
        List<OrderItem> items = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("orderId"));
                    item.setProductId(rs.getInt("productId"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    items.add(item);
                }
            }
        }
        return items;
    }
    public void saveOrderItems(List<OrderItem> orderItems) throws SQLException {
        String query = "INSERT INTO orderitems (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            for (OrderItem item : orderItems) {
                stmt.setInt(1, item.getOrderId());
                stmt.setInt(2, item.getProductId());
                stmt.setInt(3, item.getQuantity());
                stmt.setDouble(4, item.getPrice());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }
}