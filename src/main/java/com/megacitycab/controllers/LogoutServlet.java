package com.megacitycab.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get the session (do not create a new one if it doesn't exist)
        HttpSession session = request.getSession(false);
        String redirectUrl = "index.jsp"; // Default redirect URL

        if (session != null) {
            // Get the user's role before invalidating the session
            String role = (String) session.getAttribute("role");

            // Determine redirect URL based on role
            if (role != null) {
                if ("admin".equalsIgnoreCase(role)) {
                    redirectUrl = "index.jsp";
                } else if ("customer".equalsIgnoreCase(role)) {
                    redirectUrl = "customers_login.jsp";
                } else if ("driver".equalsIgnoreCase(role)) {
                    redirectUrl = "drivers_login.jsp";
                }
            }

            // Invalidate the session
            session.invalidate();
            System.out.println("DEBUG: User logged out, role was: " + role + ", redirecting to: " + redirectUrl);
        }

        // Remove the "username" cookie
        Cookie usernameCookie = new Cookie("username", null);
        usernameCookie.setMaxAge(0);
        response.addCookie(usernameCookie);

        // Send JavaScript response to show alert and redirect
        out.println("<script type='text/javascript'>");
        out.println("alert('Successfully logged out');");
        out.println("window.location.href = '" + redirectUrl + "';");
        out.println("</script>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}