<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>Admin page</title>
    <jsp:include page="head.jsp"/>
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="container-wrapper">
    <div class="container">
        <div class="page-header">
            <h2>&nbsp;</h2>
            <h1 style="text-align: center"><spring:message code="jsp.header.users" text="default"/></h1>
        </div>
        <c:choose>
        <c:when test="${users.totalPages > 0}">
        <table id="table" class="table table-striped table-hover table-dark">
            <thead class="thead-light">
            <tr>
                <th><spring:message code="jsp.username" text="default"/></th>
                <th><spring:message code="jsp.activity" text="default"/></th>
                <th><spring:message code="jsp.action" text="default"/></th>
                <th><spring:message code="jsp.check" text="default"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${users.content}" var="user">
                <c:if test="${user.login != 'admin'}">
                    <tr>
                        <td>${user.login}</td>
                        <td>
                            <c:if test="${user.getActive() == 1}"><spring:message code="jsp.activity.active" text="default"/></c:if>
                            <c:if test="${user.getActive() == 0}"><spring:message code="jsp.activity.blocked" text="default"/></c:if>
                        </td>
                        <td>
                            <form:form method="post" action="/activity" modelAttribute="user">
                                <form:input type="hidden" path="login" value="${user.login}"/>
                                <c:if test="${user.getActive() == 1}">
                                    <form:button type="submit" name="block"
                                                 class="btn btn-danger shadow-lg "><spring:message code="jsp.block" text="default"/></form:button>
                                </c:if>
                                <c:if test="${user.getActive() == 0}">
                                    <form:button type="submit" name="block"
                                                 class="btn btn-success shadow-lg "><spring:message code="jsp.unblock" text="default"/></form:button>
                                </c:if>
                            </form:form>
                        </td>
                        <td>
                            <form:form method="post" action="/activity" modelAttribute="user">
                                <form:input type="hidden" path="userId" value="${user.userId}"/>
                                <form:button type="submit" name="cards"
                                             class="btn btn-info shadow-lg "><spring:message code="jsp.cards" text="default"/></form:button>
                            </form:form>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
        </c:when>
            <c:otherwise>
                <h5 style="text-align: center">No users Found... Search again!</h5>
            </c:otherwise>
        </c:choose>
        <div style="float: right">
            <c:if test="${users.totalPages > 0}">
                <nav aria-label="Page navigation example" style="margin:auto;">
                    <ul class="pagination">
                        <c:set var="prev" value="0"/>
                        <c:if test="${param.page > 0}">
                            <c:set var="prev" value="${param.page -1}"/>
                        </c:if>
                        <c:if test="${users.totalPages > 0}">
                            <li class='page-item <c:if test="${empty param.page || param.page eq 0}">disabled</c:if>'>
                                <a class="page-link" href="/activity?page=${prev}&size=${maxTraySize}">Prev</a></li>
                        </c:if>
                        <c:forEach var="i" begin="0" end="${users.totalPages -1}">
                            <li class='page-item <c:if test="${param.page eq i || (empty param.page && i eq 0)}">active</c:if>'>
                                <a class="page-link" href="/activity?page=${i}&size=${maxTraySize}">${i+1}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${users.totalPages > 0}">
                            <li class='page-item <c:if test="${users.totalPages <= (param.page + 1)}">disabled</c:if>'>
                                <a class="page-link" href="/activity?page=${param.page + 1}&size=${maxTraySize}">Next</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
            <input type="hidden" name="currentPage" value="${currentPage}" id="currentPageNo">
        </div>
    </div>
</div>
<div class="success" id="message">
    ${message}
</div>
</body>
</html>