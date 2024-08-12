<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
<h2>Welcome, <%= user.getUsername() %>!</h2>
<a href="addUser.jsp">Add User</a>
<a href="viewUsers">View Users</a>
<a href="logout">Logout</a>
</body>
</html>
