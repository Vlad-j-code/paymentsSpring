<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cards</title>
    <jsp:include page="head.jsp" />
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp" />
</header>
<div class="container p5percent">
    <br>
    <div class="row">
        <c:forEach var="card" items="${cards}">
            <c:set var="bg" value="bg-success"/>
            <div class="card text-white ${bg}  mb-3" style="height: 16rem; width: 27rem;">
                <h5 class="card-header text-uppercase">
                        ${card.name}</h5>
                <div class="card-body">
                    <h6 class="card-title">Card number: ${card.number}</h6>
                    <p class="card-text">Balance: ${card.money} UAH</p>
                </div>
            </div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
</div>
</body>
</html>
