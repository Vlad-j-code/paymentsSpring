<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Requests</title>
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
                <th scope="col">User id</th>
                <th scope="col">Card name</th>
                <th scope="col">Number</th>
                <th scope="col">Money</th>
                <th scope="col">Activity</th>
                <th scope="col">Unblock</th>
                <th scope="col">Reject</th>
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
                            <c:if test="${card.getActive() == 1}">Active</c:if>
                            <c:if test="${card.getActive() == 0}">Blocked</c:if>
                    </td>
                    <td>
                        <form:form method="post" action="/requests" modelAttribute="card">
                            <form:input type="hidden" path="id" value="${card.id}"/>
                            <form:button type="submit" name="accept"
                                         class="btn btn-success shadow-lg ">Unblock</form:button>
                        </form:form>
                    </td>
                    <td>
                        <form:form method="post" action="/requests" modelAttribute="card">
                            <form:input type="hidden" path="id" value="${card.id}"/>
                            <form:button type="submit" name="reject"
                                         class="btn btn-danger shadow-lg ">Reject</form:button>
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
