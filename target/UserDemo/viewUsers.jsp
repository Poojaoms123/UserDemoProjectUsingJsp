<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="master.jsp"/>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Users</title>
</head>
<body>
<h2>Users List</h2>
<%
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    if (message != null) {
%>
<p style="color:green;"><%= message %></p>
<%
} else if (error != null) {
%>
<p style="color:red;"><%= error %></p>
<%
    }
%>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Role</th>
        <th>Action</th>
    </tr>
    <%
        List<User> users = (List<User>) request.getAttribute("users");
        if (users != null && !users.isEmpty()) {
            for (User user : users) {
    %>
    <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getUsername() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getRole() %></td>
        <td>
            <a href="updateUserForm.jsp?id=<%= user.getId() %>">Update</a>
            <form action="deleteUser" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= user.getId() %>">
                <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this user?');">
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="5">No users found</td>
    </tr>
    <%
        }
    %>
</table>
<a href="/View">View Users</a>
</body>
</html>
