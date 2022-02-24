<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Refill</title>
    <jsp:include page="head.jsp" />
    <style>
        .success{
            color: #00ff33;
            text-align: center;
        }
    </style>
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp" />
</header>
<div class="login-page">
    <form method="post" action="/refill">
        <h1>Refill</h1>
        <label class="text-white" for="card">Select card for payment:</label>
        <input class="form-control" id="card" name="numberCard" type="text" required placeholder="Card number">
<%--        <select id="card" name="numberCard" class="form-control shadow-lg">--%>
<%--            <c:forEach var="card" items="${cards}">--%>
<%--                <option value="${card.id}">${card.number}</option>--%>
<%--            </c:forEach>--%>
<%--        </select>--%>
        <label class="text-white" for="sum">Sum payment:</label>
        <input class="form-control" id="sum" name="value" type="number" required placeholder="Amount">
        <form action="#">
            <br>
            <button type="submit" class="btn btn-success shadow-lg ">Submit</button>
        </form>
    </form>
</div>
<div class="success" id="message">
    ${message}
</div>
</body>
</html>
