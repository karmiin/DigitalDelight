package it.unisa.servlet;

import it.unisa.dao.UserDAO;
import it.unisa.connection.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/checkRegister")
public class CheckRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        try {
            UserDAO userDAO = new UserDAO(DatabaseConnection.getConnection());
            boolean emailExists = userDAO.emailExists(email);
            boolean usernameExists = userDAO.usernameExists(username);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"emailExists\": " + emailExists + ", \"usernameExists\": " + usernameExists + "}");
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}