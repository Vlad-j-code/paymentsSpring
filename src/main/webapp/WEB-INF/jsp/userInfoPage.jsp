<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <title>User Info</title>
    <jsp:include page="head.jsp" />
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp" />
</header>

<h2>User Info Page</h2>
<h3>Welcome :  ${pageContext.request.userPrincipal.name}</h3>
<b>This is protected page!</b>

<br/><br/>

<div></div>

</body>