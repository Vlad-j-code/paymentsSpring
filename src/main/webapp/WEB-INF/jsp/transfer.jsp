<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><spring:message code="jsp.send.payment" text="default"/></title>
    <jsp:include page="head.jsp" />
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp" />
</header>
<div class="login-page">
    <form method="post" action="/transfer">
        <h1><spring:message code="jsp.send.payment" text="default"/></h1>
        <label class="text-white" for="card_from"><spring:message code="jsp.select_card_for_payment" text="default"/></label>
        <input class="form-control" id="card_from" name="numberCardFrom" type="text" required placeholder="<spring:message code="jsp.card.number" text="default"/>">
        <label class="text-white" for="card_to"><spring:message code="jsp.card.destination" text="default"/></label>
        <input class="form-control" id="card_to" name="numberCardTo" type="text" required placeholder="<spring:message code="jsp.card.number" text="default"/>">
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
