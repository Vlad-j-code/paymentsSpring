<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payments</title>
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
                    <th>Recipient</th>
                    <th>Payments</th>
                    <th>Date</th>
                    <th>Money</th>
                    <th>Balance after payment</th>
                    <th>Download report</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="k" value="0"/>
                <c:forEach var="payment" items="${payments.content}">
                    <c:set var="k" value="${k+1}"/>
                        <tr>
                            <th scope="row"><c:out value="${k}"/></th>
                            <td>${payment.cardNumber}</td>
                            <td>${payment.cardDestinationNumber}</td>
                            <td>${payment.id}</td>
                            <td>${payment.date}</td>
                            <td>${payment.money} UAH</td>
                            <td>${payment.balance}</td>
                            <td>
                                <form:form method="get" action="/payments" modelAttribute="payment">
                                    <form:input type="hidden" path="id" value="${payment.id}"/>
                                    <form:button type="submit" name="download"
                                                 class="btn btn-info shadow-lg ">Get Pdf</form:button>
                                </form:form>
                            </td>
                        </tr>
                </c:forEach>
                </tbody>
            </table>
    </c:when>
    <c:otherwise>
        <h5 style="text-align: center">No payments Found... Search again!</h5>
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
                        <a class="page-link" href="/payments?page=${prev}&size=${maxTraySize}">Prev</a></li>
                </c:if>
                <c:forEach var="i" begin="0" end="${payments.totalPages -1}">
                    <li class='page-item <c:if test="${param.page eq i || (empty param.page && i eq 0)}">active</c:if>'>
                        <a class="page-link" href="/payments?page=${i}&size=${maxTraySize}">${i+1}</a>
                    </li>
                </c:forEach>
                <c:if test="${payments.totalPages > 0}">
                    <li class='page-item <c:if test="${payments.totalPages <= (param.page + 1)}">disabled</c:if>'>
                        <a class="page-link" href="/payments?page=${param.page + 1}&size=${maxTraySize}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>
    <input type="hidden" name="currentPage" value="${currentPage}" id="currentPageNo">
</div>
</body>
</html>
