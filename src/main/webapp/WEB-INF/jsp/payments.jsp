<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payments</title>
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
                    <th>Card number</th>
                    <th>Recipient</th>
                    <th>
                        <a href="/payments/${currentPage}?sortField=id&sortDir=${reverseSortDir}">
                            Payments</a>
                    </th>
                    <th>Date</th>
                    <th>Money</th>
                    <th>
                        <a href="/payments/${currentPage}?sortField=balance&sortDir=${reverseSortDir}">
                            Balance after payment</a>
                    </th>
                    <th>Download report</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="k" value="0"/>
                <c:forEach var="payment" items="${listPayments}">
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
    <c:if test="${totalPages > 0}">
        <nav aria-label="Page navigation example" style="margin:auto;">
            <ul class="pagination">
                <c:if test="${totalPages > 0}">
                    <li class='page-item <c:if test="${currentPage <= 1}">disabled</c:if>'>
                        <a class="page-link" href="/payments/${currentPage - 1}?sortField=${sortField}&sortDir=${sortDir}">Prev</a></li>
                </c:if>
                <c:forEach var="i" begin="0" end="${totalPages - 1}">
                    <li class='page-item <c:if test="${currentPage eq i+1}">active</c:if>'>
                        <a class="page-link" href="/payments/${i+1}?sortField=${sortField}&sortDir=${sortDir}">${i+1}</a>
                    </li>
                </c:forEach>
                <c:if test="${totalPages > 0}">
                    <li class='page-item <c:if test="${currentPage >= totalPages}">disabled</c:if>'>
                        <a class="page-link" href="/payments/${currentPage + 1}?sortField=${sortField}&sortDir=${sortDir}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>
    <input type="hidden" name="currentPage" value="${currentPage}" id="currentPageNo">
</div>
</body>
</html>
