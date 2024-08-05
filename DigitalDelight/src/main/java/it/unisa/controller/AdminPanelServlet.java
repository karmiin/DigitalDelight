package it.unisa.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import it.unisa.dao.ProductDAO;
import it.unisa.model.Product;

@WebServlet("/adminPanel")
public class AdminPanelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        ProductDAO productDAO = new ProductDAO();
	        List<Product> products = productDAO.getProducts();
	        request.setAttribute("products", products); // Set the products as request attribute
	        request.getRequestDispatcher("/admin/adminPanel.jsp").forward(request, response); // Forward the request to the JSP page
	    } catch(Exception e) {
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
	    }
	}
    }
