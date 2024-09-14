package it.unisa.controller;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.OrderDAO;
import it.unisa.dao.ProductDAO;
import it.unisa.model.Order;
import it.unisa.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.util.List;
import java.util.OptionalInt;

@WebServlet("/adminPanel")
public class AdminPanelController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try (Connection conn = DatabaseConnection.getConnection()) {
			ProductDAO productDAO = new ProductDAO(conn);
			OrderDAO orderDAO = new OrderDAO(conn);
			String searchQuery = request.getParameter("search");
			String searchUser = request.getParameter("searchUser");
			String startDateStr = request.getParameter("startDate");
			String endDateStr = request.getParameter("endDate");
			List<Order> orders;
			Date startDate = (startDateStr != null && !startDateStr.isEmpty()) ? java.sql.Date.valueOf(startDateStr) : null;
			Date endDate = (endDateStr != null && !endDateStr.isEmpty()) ? java.sql.Date.valueOf(endDateStr) : null;
			if ((searchUser != null && !searchUser.isEmpty()) || (startDate != null && endDate != null)) {
				orders = orderDAO.searchOrdersByUsernameAndDate(searchUser, startDate, endDate);
			} else {
				orders = orderDAO.getAllOrders();
			}
			List<Product> products;
			if (searchQuery != null && !searchQuery.isEmpty()) {
				products = productDAO.searchProductsByName(searchQuery);
			} else {
				products = productDAO.getProducts(OptionalInt.empty());
			}
			request.setAttribute("orders", orders);
			request.setAttribute("products", products);
				request.getRequestDispatcher("/admin/adminPanel.jsp").forward(request, response);
		} catch(Exception e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
		}
	}
}