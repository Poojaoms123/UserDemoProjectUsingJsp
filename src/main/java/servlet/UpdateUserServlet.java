package servlet;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        if (idStr == null || username == null || password == null || email == null || role == null) {
            response.sendRedirect("error.html?error=All fields are required");
            return;
        }

        int id = Integer.parseInt(idStr);

        User user = new User();
        user.setId(id);
        user.setUsername(username);
        user.setPassword(hashPassword(password));  // Hash the password
        user.setEmail(email);
        user.setRole(role);

        try (Connection connection = getConnection()) {
            UserDAO userDAO = new UserDAO(connection);
            boolean success = userDAO.updateUser(user);

            if (success) {
                request.setAttribute("message", "User updated successfully!");
                request.getRequestDispatcher("updateUserForm.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.html?error=Failed to update user");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.html?error=Database error: " + e.getMessage());
        }
    }

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("JDBC Driver not found");
        }
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true", "root", "oms123");
    }

    private String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("viewUsers.jsp");
    }
}
