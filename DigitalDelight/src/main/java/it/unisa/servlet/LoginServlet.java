package it.unisa.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import it.unisa.connection.DatabaseConnection;
import it.unisa.dao.UserDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 3527207757698776852L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        // Utilizza il tuo DAO per verificare l'username e la password
        UserDAO userDAO = null;
		try {
			userDAO = new UserDAO(DatabaseConnection.getConnection());
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Errore nella connessione");
			e.printStackTrace();
		}
        boolean isAuthenticated = false;
		try {
			isAuthenticated = userDAO.authenticate(email, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            response.sendRedirect("index.jsp"); // reindirizza l'utente alla pagina home dopo il login corretto
            System.out.println("Login riuscito");
        } else {
            // Gestisci il caso in cui l'autenticazione fallisce
            response.sendRedirect("login.jsp"); // reindirizza l'utente alla pagina di login
            System.out.println("Login fallito");
        }
    }
}
