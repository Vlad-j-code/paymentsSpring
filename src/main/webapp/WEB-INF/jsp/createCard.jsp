<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><spring:message code="jsp.creating.card" text="default"/></title>
    <jsp:include page="head.jsp"/>
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="login-page">
    <form:form method="post" action="${pageContext.request.contextPath}/createCard"
               modelAttribute="card">
        <h1><spring:message code="jsp.create.card" text="default"/></h1>
        <div class="form-group">
            <label class="text-white" for="name"><spring:message code="jsp.name.newCard" text="default"/>:</label>
            <div class="cols-sm-10">
                <div class="input-group-prepend">
                    <form:input type="name" class="form-control" path="name" id="name"
                                placeholder="Name"/>
                </div>
            </div>
        </div>
        <div class="form-group ">
            <button type="submit" value="submit" class="btn btn-success shadow-lg ">
                <spring:message code="jsp.accept" text="default"/>
            </button>
        </div>
    </form:form>
</div>
<div class="success" id="message">
    ${message}
</div>
</body>
</html>
