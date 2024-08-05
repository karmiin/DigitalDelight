package it.unisa.controller;

import it.unisa.dao.UserDAO;
import it.unisa.model.User;
import java.sql.*;

public class UserController {
    private UserDAO userDao;

    public UserController(Connection conn) {
        this.userDao = new UserDAO(conn);
    }

    public User getUser(int id) {
        try {
            return userDao.getUser(id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    // other methods for handling user-related requests
}
