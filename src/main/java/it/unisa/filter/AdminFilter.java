package it.unisa.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter({"/admin/*", "/adminPanel"})
public class AdminFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if needed
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        if (session != null && Boolean.TRUE.equals(session.getAttribute("isAdmin"))) {
            chain.doFilter(request, response); // User is admin, continue request
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp"); // Redirect to login page
        }
    }

    public void destroy() {
        // Cleanup code, if needed
    }
}