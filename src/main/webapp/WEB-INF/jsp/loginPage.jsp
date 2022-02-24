<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<head>
    <title>Login</title>
    <jsp:include page="head.jsp"/>
    <style>
        body {
            background: linear-gradient(to bottom left, #a12636, #431c83);
        }
        .login-page {
            color: #06051b;
            text-align: center;
            position: relative;
            width: 250px;
            padding: 10% 0 0;
            margin: 0 auto;

        }
        .form-login {
            position: relative;
            width: 330px;
            height: 330px;
            top: 50%;
            left: 50%;
            margin-top: -220px;
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
<body>
<header>
    <jsp:include page="header.jsp"/>
</header>
<div class="form-login">
    <div class="login-page">
        <form action="/login" method="post">
            <div class="form-group ">
                <label for="login">Username</label>
                <div class="input-group shadow-lg">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                    </div>
                    <input type="text" id="login" name="login" class="form-control" placeholder="username">
                </div>
            </div>
            <div class="form-group ">
                <label for="password">Password</label>
                <div class="input-group shadow-lg">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                    </div>
                    <input type="password" id="password" name="password" class="form-control"
                           placeholder="password">
                </div>
            </div>
            <%--                    <div class="row align-items-center remember">--%>
            <%--                        <input type="checkbox" name="remember-me">Remember Me--%>
            <%--                    </div>--%>
            <div class="form-group">
                <input type="submit" value="Login" class="btn btn-success btn-block shadow-lg ">
            </div>
            <c:if test="${not empty error}">
                <div class="error" style="font-weight:bold; color: #ff0000;">${error}</div>
            </c:if>
            <%--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />--%>
        </form>
        <p class="mt-2" style="font-size: small">
            Don't have an account? <a href="/registration">Sign Up</a>
        </p>
    </div>
</div>
</body>
