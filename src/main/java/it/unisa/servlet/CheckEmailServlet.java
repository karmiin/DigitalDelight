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

@WebServlet("/checkEmail")
public class CheckEmailServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        try {
            UserDAO userDAO = new UserDAO(DatabaseConnection.getConnection());
            boolean exists = userDAO.emailExists(email);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"exists\": " + exists + "}");
            out.flush();
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}