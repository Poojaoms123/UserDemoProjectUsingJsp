<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession session = request.getSession(false); // Retrieve current session, do not create if not exists
    if (session != null) {
        session.invalidate(); // Invalidate the session if it exists
    }
    response.sendRedirect("login.jsp"); // Redirect to the login page
%>
