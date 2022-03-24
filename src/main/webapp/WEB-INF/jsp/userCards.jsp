<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><spring:message code="jsp.cards" text="default"/></title>
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
        .p5percent {
            padding-left: 5%;
            padding-right: 5%;
        }
    </style>
</head>
<body style="background: linear-gradient(to bottom left, #a12636, #431c83);">
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="container-fluid p5percent">
    <h4><spring:message code="jsp.sort" text="default"/></h4>
    <a href="/cards/${currentPage}?sortField=name&sortDir=${reverseSortDir}" class="btn btn-primary">
        <spring:message code="jsp.sorting.name" text="default"/></a>
    <a href="/cards/${currentPage}?sortField=number&sortDir=${reverseSortDir}" class="btn btn-primary">
        <spring:message code="jsp.sorting.number" text="default"/></a>
    <a href="/cards/${currentPage}?sortField=money&sortDir=${reverseSortDir}" class="btn btn-primary">
        <spring:message code="jsp.sorting.money" text="default"/></a>
</div>
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
