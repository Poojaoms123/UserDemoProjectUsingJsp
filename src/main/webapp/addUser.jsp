<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="master.jsp"/>
<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Add User</title>
    </head>
<body>
<h2>Add User</h2>
<form action="/addUser" method="post">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required><br><br>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br><br>
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br><br>
    <label for="role">Role:</label>
    <input type="text" id="role" name="role" required><br><br>
    <input type="submit" value="Add User">
</form>

<p style="color:red;">
    <%= request.getParameter("error") != null ? request.getParameter("error") : "" %>
</p>

<p style="color:green;">
    <%= request.getAttribute("success") != null ? request.getAttribute("success") : "" %>
</p>

</body>
</html>
