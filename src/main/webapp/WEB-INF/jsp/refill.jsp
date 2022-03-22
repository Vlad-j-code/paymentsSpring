<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><spring:message code="jsp.refill" text="default"/></title>
    <jsp:include page="head.jsp"/>
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="login-page">
    <form method="post" action="/refill">
        <h1><spring:message code="jsp.refill" text="default"/></h1>
        <label class="text-white" for="card"><spring:message code="jsp.select_card_for_payment" text="default"/></label>
        <input class="form-control" id="card" name="numberCard" type="text" required placeholder="<spring:message code="jsp.card.number" text="default"/>">
        <%--        <select id="card" name="numberCard" class="form-control shadow-lg">--%>
        <%--            <c:forEach var="card" items="${cards}">--%>
        <%--                <option value="${card.id}">${card.number}</option>--%>
        <%--            </c:forEach>--%>
        <%--        </select>--%>
        <label class="text-white" for="sum"><spring:message code="jsp.sum" text="default"/></label>
        <input class="form-control" id="sum" name="value" type="number" required placeholder="<spring:message code="jsp.sum" text="default"/>">
        <form action="#">
            <br>
            <button type="submit" class="btn btn-success shadow-lg "><spring:message code="jsp.accept" text="default"/></button>
        </form>
    </form>
</div>
<div class="success" id="message">
    ${message}
</div>
<div class="warning" id="warning">
    ${warning}
</div>
</body>
</html>
