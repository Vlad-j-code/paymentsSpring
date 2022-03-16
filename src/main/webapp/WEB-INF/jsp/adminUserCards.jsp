<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User cards</title>
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
            <th scope="col">Name</th>
            <th scope="col">Number</th>
            <th scope="col">Money</th>
            <th scope="col">Activity</th>
            <th scope="col">Block/Unblock</th>
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
                    <c:if test="${card.getActive() == 1}">Active</c:if>
                    <c:if test="${card.getActive() == 0}">Blocked</c:if>
                </td>
                <td>
                    <form:form method="post" action="/activity" modelAttribute="card">
                        <form:input type="hidden" path="id" value="${card.id}"/>
                        <c:if test="${card.getActive() == 1}">
                            <form:button type="submit" name="activity"
                                         class="btn btn-danger shadow-lg ">Block</form:button>
                        </c:if>
                        <c:if test="${card.getActive() == 0}">
                            <form:button type="submit" name="activity"
                                         class="btn btn-success shadow-lg ">Unblock</form:button>
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
