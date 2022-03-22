<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><spring:message code="jsp.cards" text="default"/></title>
    <jsp:include page="head.jsp"/>
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="container p5percent">
    <br>
    <div class="row">
        <c:forEach var="card" items="${cards}">
            <c:set var="bg" value="bg-success"/>
            <c:if test="${card.getActive() == 0}">
                <c:set var="bg" value="bg-danger"/>
                <c:if test="${card.getRequest() == 1}">
                    <c:set var="bg" value="bg-secondary"/>
                </c:if>
            </c:if>
            <div class="card text-white ${bg}  mb-3" style="height: 16rem; width: 27rem;">
                <h5 class="card-header text-uppercase">
                        ${card.name}</h5>
                <div class="card-body">
                    <h6 class="card-title"><spring:message code="jsp.card.number" text="default"/>: ${card.number}</h6>
                    <p class="card-text"><spring:message code="jsp.balance" text="default"/>: ${card.money} UAH</p>
                </div>
                <div class="card-footer">
                    <form:form method="post" action="/cards" modelAttribute="card">
                        <form:input type="hidden" path="id" value="${card.id}"/>
                        <c:if test="${card.getActive() == 1}">
                            <form:button type="submit" name="activity"
                                         class="btn btn-danger shadow-lg "><spring:message code="jsp.block" text="default"/></form:button>
                        </c:if>
                    </form:form>
                    <c:if test="${card.getRequest() == 0}">
                        <form:form method="post" action="/cards" modelAttribute="card">
                            <form:input type="hidden" path="id" value="${card.id}"/>
                            <c:if test="${card.getActive() == 0}">
                                <form:button type="submit" name="unblock"
                                             class="btn btn-success shadow-lg "><spring:message code="jsp.unblock.request" text="default"/></form:button>
                            </c:if>
                        </form:form>
                    </c:if>
                    <c:if test="${card.getRequest() == 1}">
                        <spring:message code="jsp.consideration" text="default"/>
                    </c:if>
                </div>
            </div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
</div>
<div class="success" id="message">
    ${message}
</div>
</body>
</html>
