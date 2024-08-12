package servlet;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/addUser")
public class AddUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        if (username == null || password == null || email == null || role == null) {
            response.sendRedirect("error.html?error=All fields are required");
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(hashPassword(password));  // Hash the password
        user.setEmail(email);
        user.setRole(role);

        try (Connection connection = getConnection()) {
            UserDAO userDAO = new UserDAO(connection);
            boolean success = userDAO.insertUser(user);

            if (success) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("error.html?error=Failed to add user");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.html?error=Database error: " + e.getMessage());
        }
    }


    /* private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true", "root", "oms123");
    }*/
   private Connection getConnection() throws SQLException {
       try {
           Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure driver is loaded
       } catch (ClassNotFoundException e) {
           e.printStackTrace(); // Handle exception
           throw new SQLException("JDBC Driver not found");
       }
       return DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true", "root", "oms123");
   }


    private String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("addUser.jsp");
    }

}
