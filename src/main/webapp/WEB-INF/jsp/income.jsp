<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><spring:message code="jsp.header.income" text="default"/></title>
    <jsp:include page="head.jsp"/>
    <style>
        .dropbtn {
            background-color: Transparent;
            color: white;
            text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;
            padding: 9px;
            font-size: 16px;
            border: none;
        }
        .dropdown {
            position: relative;
            display: inline-block;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f1f1f1;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        .dropdown-content a:hover {background-color: #ddd;}
        .dropdown:hover .dropdown-content {display: block;}
    </style>
</head>
<body style="background: linear-gradient(to bottom left, #a12636, #431c83)">
<header>
    <jsp:include page="header.jsp"/>
</header>
<c:choose>
    <c:when test="${totalPages > 0}">
        <table id="table" class="table table-striped table-hover table-dark">
            <thead class="thead-light">
            <tr>
                <th>#</th>
                <th><spring:message code="jsp.card.number" text="default"/></th>
                <th><spring:message code="jsp.sender" text="default"/></th>
                <th><a href="/income/${currentPage}?sortField=id&sortDir=${reverseSortDir}">
                    <spring:message code="jsp.number.payments" text="default"/></a>
                </th>
                <th><spring:message code="jsp.money" text="default"/></th>
                <th><spring:message code="jsp.balance" text="default"/></th>
                <th><a href="/income/${currentPage}?sortField=date&sortDir=${reverseSortDir}">
                    <spring:message code="jsp.date" text="default"/></a>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:set var="k" value="0"/>
            <c:forEach items="${listPayments}" var="payment">
                <c:set var="k" value="${k+1}"/>
                <tr>
                    <th scope="row"><c:out value="${k}"/></th>
                    <td>${payment.cardDestinationNumber}</td>
                    <td><c:if test="${payment.cardId != null && payment.cardId != 0}">
                        ${payment.cardNumber}</c:if>
                        <c:if test="${payment.cardId == null || payment.cardId == 0}"><spring:message code="jsp.refill" text="default"/></c:if>
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
    <c:if test="${totalPages > 0}">
        <nav aria-label="Page navigation example" style="margin:auto;">
            <ul class="pagination">
                <c:if test="${totalPages > 0}">
                    <li class='page-item <c:if test="${currentPage <= 1}">disabled</c:if>'>
                        <a class="page-link" href="/income/${currentPage - 1}?sortField=${sortField}&sortDir=${sortDir}">Prev</a></li>
                </c:if>
                <c:forEach var="i" begin="0" end="${totalPages - 1}">
                    <li class='page-item <c:if test="${currentPage eq i+1}">active</c:if>'>
                        <a class="page-link" href="/income/${i+1}?sortField=${sortField}&sortDir=${sortDir}">${i+1}</a>
                    </li>
                </c:forEach>
                <c:if test="${totalPages > 0}">
                    <li class='page-item <c:if test="${currentPage >= totalPages}">disabled</c:if>'>
                        <a class="page-link" href="/income/${currentPage + 1}?sortField=${sortField}&sortDir=${sortDir}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>
    <input type="hidden" name="currentPage" value="${currentPage}" id="currentPageNo">
</div>
</body>
</html>
