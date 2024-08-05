package it.unisa.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;

import it.unisa.connection.DatabaseConnection;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {

    /**
     *
     */
    private static final long serialVersionUID = 4640602774649187338L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id"); // Assume you're passing the image ID as a parameter.

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT image FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                byte[] imgData = rs.getBytes("image"); // Can be Blob, Clob, Binary, VarBinary etc.
                response.setContentType("image/jpeg"); // Or whatever format you're dealing with.
                response.setContentLength(imgData.length);

                OutputStream out = response.getOutputStream();
                out.write(imgData);
                out.flush();
            } else {
                // Handle case where no image was found.
            }
        } catch (SQLException | ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
