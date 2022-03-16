<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Income</title>
    <jsp:include page="head.jsp"/>
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp"/>
</header>
<c:choose>
    <c:when test="${payments.totalPages > 0}">
        <table id="table" class="table table-striped table-hover table-dark">
            <thead class="thead-light">
            <tr>
                <th>#</th>
                <th>Card number</th>
                <th>Sender</th>
                <th>Number payment</th>
                <th>Money</th>
                <th>Balance</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="k" value="0"/>
            <c:forEach items="${payments.content}" var="payment">
                <c:set var="k" value="${k+1}"/>
                <tr>
                    <th scope="row"><c:out value="${k}"/></th>
                    <td>${payment.cardDestinationNumber}</td>
                    <td><c:if test="${payment.cardId != null && payment.cardId != 0}">
                        ${payment.cardNumber}</c:if>
                        <c:if test="${payment.cardId == null || payment.cardId == 0}">Refill</c:if>
                    </td>
                    <td>${payment.id}</td>
                    <td>${payment.money}</td>
                    <td>${payment.balance}</td>
                    <td>${payment.date}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <h5 style="text-align: center">No incomes Found... Search again!</h5>
    </c:otherwise>
</c:choose>
<div style="float: right">
    <c:if test="${payments.totalPages > 0}">
        <nav aria-label="Page navigation example" style="margin:auto;">
            <ul class="pagination">
                <c:set var="prev" value="0"/>
                <c:if test="${param.page > 0}">
                    <c:set var="prev" value="${param.page -1}"/>
                </c:if>
                <c:if test="${payments.totalPages > 0}">
                    <li class='page-item <c:if test="${empty param.page || param.page eq 0}">disabled</c:if>'>
                        <a class="page-link" href="/income?page=${prev}&size=${maxTraySize}">Prev</a></li>
                </c:if>
                <c:forEach var="i" begin="0" end="${payments.totalPages -1}">
                    <li class='page-item <c:if test="${param.page eq i || (empty param.page && i eq 0)}">active</c:if>'>
                        <a class="page-link" href="/income?page=${i}&size=${maxTraySize}">${i+1}</a>
                    </li>
                </c:forEach>
                <c:if test="${payments.totalPages > 0}">
                    <li class='page-item <c:if test="${payments.totalPages <= (param.page + 1)}">disabled</c:if>'>
                        <a class="page-link" href="/income?page=${param.page + 1}&size=${maxTraySize}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>
    <input type="hidden" name="currentPage" value="${currentPage}" id="currentPageNo">
</div>
</body>
</html>
