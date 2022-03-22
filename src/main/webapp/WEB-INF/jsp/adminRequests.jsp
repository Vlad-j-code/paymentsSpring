<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><spring:message code="jsp.requests" text="default"/></title>
    <jsp:include page="head.jsp"/>
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp"/>
</header>
<div id="container" class="container">
    <div class="table-responsive">
        <table id="request_table" class="table table-striped table-hover table-dark">
            <thead class="thead-light">
            <tr>
                <th scope="col">#</th>
                <th scope="col"><spring:message code="jsp.idUser" text="default"/></th>
                <th scope="col"><spring:message code="jsp.Name" text="default"/></th>
                <th scope="col"><spring:message code="jsp.card.number" text="default"/></th>
                <th scope="col"><spring:message code="jsp.money" text="default"/></th>
                <th scope="col"><spring:message code="jsp.activity" text="default"/></th>
                <th scope="col"><spring:message code="jsp.unblock" text="default"/></th>
                <th scope="col"><spring:message code="jsp.reject" text="default"/></th>
            </tr>
            </thead>
            <tbody>
            <c:set var="k" value="0"/>
            <c:forEach var="card" items="${cards}">
                <c:if test="${card.getActive() == 0}">
                    <c:set var="k" value="${k+1}"/>
                    <tr>
                    <td><c:out value="${k}"/></td>
                    <td>${card.userId}</td>
                    <td>${card.name}</td>
                    <td>${card.number}</td>
                    <td>${card.money}</td>
                    <td>
                            <c:if test="${card.getActive() == 1}"><spring:message code="jsp.activity.active" text="default"/></c:if>
                            <c:if test="${card.getActive() == 0}"><spring:message code="jsp.activity.blocked" text="default"/></c:if>
                    </td>
                    <td>
                        <form:form method="post" action="/requests" modelAttribute="card">
                            <form:input type="hidden" path="id" value="${card.id}"/>
                            <form:button type="submit" name="accept"
                                         class="btn btn-success shadow-lg "><spring:message code="jsp.accept" text="default"/></form:button>
                        </form:form>
                    </td>
                    <td>
                        <form:form method="post" action="/requests" modelAttribute="card">
                            <form:input type="hidden" path="id" value="${card.id}"/>
                            <form:button type="submit" name="reject"
                                         class="btn btn-danger shadow-lg "><spring:message code="jsp.reject" text="default"/></form:button>
                        </form:form>
                    </td>
                </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="success" id="message">
    ${message}
</div>
</body>
</html>
