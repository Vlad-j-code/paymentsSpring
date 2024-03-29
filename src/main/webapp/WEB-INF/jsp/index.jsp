<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Money transfer</title>
    <jsp:include page="head.jsp" />
    <c:if test="${empty user and title ne 'Login'}">
        <style>
        body {
        background: linear-gradient(to bottom left, #a12636, #431c83);
        }
        </style>
    </c:if>
    <c:if test="${not empty pageContext.request.userPrincipal}">
        <style>
            body {
                background: black;
            }
        </style>
    </c:if>
</head>
<body>
<header>
    <jsp:include page="header.jsp" />
</header>

<c:if test="${not empty pageContext.request.userPrincipal}">

<img src="../../img/mainScreen.png" class="d-block w-100" alt="...">
</c:if>
</body>
</html>