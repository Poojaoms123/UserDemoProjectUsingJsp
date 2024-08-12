<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<jsp:include page="master.jsp"/>

<%
    String idStr = request.getParameter("id");
    int id = Integer.parseInt(idStr);

    User user = null;
    try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true", "root", "oms123")) {
        UserDAO userDAO = new UserDAO(connection);
        user = userDAO.getUserById(id);
    } catch (Exception e) {
        e.printStackTrace();
    }

    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update User</title>
</head>
<body>
<h2>Update User</h2>
<% if (message != null) { %>
<p style="color: green;"><%= message %></p>
<% } %>
<form action="updateUser" method="post">
    <input type="hidden" name="id" value="<%= user.getId() %>"/>
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required/><br/>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required/><br/>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required/><br/>

    <label for="role">Role:</label>
    <input type="text" id="role" name="role" value="<%= user.getRole() %>" required/><br/>

    <input type="submit" value="Update User"/>
</form>
</body>
</html>
