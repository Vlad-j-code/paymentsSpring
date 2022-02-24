<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Registration</title>
    <jsp:include page="head.jsp"/>
    <style>
        body {
            background: linear-gradient(to bottom left, #a12636, #431c83);
        }

        .register-page {
            color: #06051b;
            text-align: center;
            position: relative;
            width: 250px;
            padding: 7% 0 0;
            margin: 0 auto;
        }

        .form-register {
            position: relative;
            width: 330px;
            height: 470px;
            top: 50%;
            left: 50%;
            margin-top: -260px;
            margin-left: -170px;
            background: #ffffff;
            border-radius: 3px;
            border: 1px solid #ccc;
            box-shadow: 0 1px 2px rgba(0, 0, 0, .1);
            -webkit-animation-name: bounceIn;
            -webkit-animation-fill-mode: both;
            -webkit-animation-duration: 1s;
            -webkit-animation-iteration-count: 1;
            -webkit-animation-timing-function: linear;
            -moz-animation-name: bounceIn;
            -moz-animation-fill-mode: both;
            -moz-animation-duration: 1s;
            -moz-animation-iteration-count: 1;
            -moz-animation-timing-function: linear;
            animation-name: bounceIn;
            animation-fill-mode: both;
            animation-duration: 1s;
            animation-iteration-count: 1;
            animation-timing-function: linear;
        }
    </style>
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="form-register">
    <div id="main-container" class="register-page">
        <form:form method="post" action="${pageContext.request.contextPath}/registration"
                   modelAttribute="user">
            <h1>Sign up</h1>
            <div class="form-group">
                <span style="color: #ff0000; font-weight: bold">${loginMsg}</span>
                <form:errors path="login" cssStyle="color: #ff0000; font-weight: bold"/>
                <br>
                <label for="login">Username</label>
                <div class="cols-sm-10">
                    <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-envelope fa"
                                                                  aria-hidden="true"></i></span>
                        <form:input type="login" class="form-control" path="login" id="login"
                                    placeholder="Username"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <form:errors path="password" cssStyle="color: #ff0000; font-weight: bold"/>
                <br>
                <label for="password">Password</label>
                <div class="cols-sm-10">
                    <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-unlock fa-lg"
                                                                  aria-hidden="true"></i></span>
                        <form:password class="form-control" path="password" id="password"
                                       placeholder="Password"/>
                    </div>
                </div>
            </div>
            <div class="form-group ">
                <br>
                <button type="submit" value="submit" class="btn btn-primary btn-lg btn-block login-button">
                    Register
                </button>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>
