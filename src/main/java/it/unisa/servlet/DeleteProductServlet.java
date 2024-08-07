package it.unisa.servlet;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {
    private ProductDAO productDAO;



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try{
            productDAO = new ProductDAO(DatabaseConnection.getConnection());
            productDAO.deleteProduct(id);

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }


        response.sendRedirect("adminPanel");
    }
}