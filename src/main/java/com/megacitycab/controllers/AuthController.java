import com.megacitycab.dao.UserDAO;
import com.megacitycab.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/login")
public class AuthController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticate(username, password);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get the source parameter to determine the context
        String source = request.getParameter("source");
        String redirectOnFailure = "home.jsp"; // Default to admin login page for initial attempts

        // Determine the context based on the source parameter
        if ("customer".equalsIgnoreCase(source)) {
            redirectOnFailure = "customer_login.jsp";
        } else if ("driver".equalsIgnoreCase(source)) {
            redirectOnFailure = "drivers_login.jsp";
        }

        if (user != null) {
            // Store the full User object in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("profilePicture", user.getProfilePicture());

            System.out.println("DEBUG: Authenticated User: " + user.getUsername() + ", Role: " + user.getRole());

            // Determine redirect URL based on role
            String redirectUrl;
            if ("admin".equalsIgnoreCase(user.getRole())) {
                redirectUrl = "admin_dashboard.jsp";
            } else if ("driver".equalsIgnoreCase(user.getRole())) {
                redirectUrl = "driver_dashboard.jsp";
            } else if ("customer".equalsIgnoreCase(user.getRole())) {
                redirectUrl = "customer_dashboard.jsp";
            } else {
                System.out.println("DEBUG: Unknown role: " + user.getRole());
                redirectUrl = "home.jsp?error=Unknown role";
                out.println("<script type='text/javascript'>");
                out.println("alert('Unknown role assigned');");
                out.println("window.location.href = '" + redirectUrl + "';");
                out.println("</script>");
                return;
            }

            // Send JavaScript response to show alert and redirect
            out.println("<script type='text/javascript'>");
            out.println("alert('Successfully logged in');");
            out.println("window.location.href = '" + redirectUrl + "';");
            out.println("</script>");
        } else {
            System.out.println("DEBUG: Invalid credentials for username: " + username);
            out.println("<script type='text/javascript'>");
            out.println("alert('Invalid credentials');");
            out.println("window.location.href = '" + redirectOnFailure + "?error=Invalid credentials';");
            out.println("</script>");
        }
    }
}