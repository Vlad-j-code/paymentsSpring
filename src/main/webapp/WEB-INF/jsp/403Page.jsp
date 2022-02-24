<head>
    <title>Access Denied</title>
    <jsp:include page="head.jsp" />
</head>

<body class="background-gradient">
<header>
    <jsp:include page="header.jsp" />
</header>

<h3 style="color: red;">Access Denied!!!</h3>
<h3>Sorry :  ${pageContext.request.userPrincipal.name}</h3>

</body>
