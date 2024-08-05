package it.unisa.servlet;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import it.unisa.dao.ProductDAO;

import java.io.IOException;


@WebServlet("/add-product")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Part image = request.getPart("image");

        productDAO.addProductWithImage(name, description, price, quantity, image);

        response.sendRedirect("admin/adminPanel.jsp");
    }
}