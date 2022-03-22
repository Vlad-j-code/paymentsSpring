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
    <table id="cards_table" class="table table-dark table-hover table-striped">
        <thead class="thead-light">
        <tr>
            <th scope="col">#</th>
            <th scope="col"><spring:message code="jsp.Name" text="default"/></th>
            <th scope="col"><spring:message code="jsp.card.number" text="default"/></th>
            <th scope="col"><spring:message code="jsp.money" text="default"/></th>
            <th scope="col"><spring:message code="jsp.activity" text="default"/></th>
            <th scope="col"><spring:message code="jsp.action" text="default"/></th>
        </tr>
        </thead>
        <tbody>
        <c:set var="k" value="0"/>
        <c:forEach var="card" items="${cards}">
            <c:set var="k" value="${k+1}"/>
            <tr>
                <th scope="row"><c:out value="${k}"/></th>
                <td>${card.name}</td>
                <td>${card.number}</td>
                <td>${card.money}</td>
                <td>
                    <c:if test="${card.getActive() == 1}"><spring:message code="jsp.activity.active" text="default"/></c:if>
                    <c:if test="${card.getActive() == 0}"><spring:message code="jsp.activity.blocked" text="default"/></c:if>
                </td>
                <td>
                    <form:form method="post" action="/activity" modelAttribute="card">
                        <form:input type="hidden" path="id" value="${card.id}"/>
                        <c:if test="${card.getActive() == 1}">
                            <form:button type="submit" name="activity"
                                         class="btn btn-danger shadow-lg "><spring:message code="jsp.block" text="default"/></form:button>
                        </c:if>
                        <c:if test="${card.getActive() == 0}">
                            <form:button type="submit" name="activity"
                                         class="btn btn-success shadow-lg "><spring:message code="jsp.unblock" text="default"/></form:button>
                        </c:if>
                    </form:form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
<div class="success" id="message">
    ${message}
</div>
</body>
</html>
