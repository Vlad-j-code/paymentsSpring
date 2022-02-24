<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Create card</title>
    <jsp:include page="head.jsp"/>
    <style>
        .success{
            color: #00ff33;
            text-align: center;
        }
    </style>
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="login-page">
    <form:form method="post" action="${pageContext.request.contextPath}/createCard"
               modelAttribute="card">
        <h1>Create card</h1>
        <div class="form-group">
            <label class="text-white" for="name">Name new card:</label>
            <div class="cols-sm-10">
                <div class="input-group-prepend">
                    <form:input type="name" class="form-control" path="name" id="name"
                                placeholder="Name"/>
                </div>
            </div>
        </div>
        <div class="form-group ">
            <button type="submit" value="submit" class="btn btn-success shadow-lg ">
                Submit
            </button>
        </div>
    </form:form>
</div>
<div class="success" id="message">
    ${message}
</div>
</body>
</html>
