<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Admin page</title>
    <jsp:include page="head.jsp"/>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap4.min.css">
    <script type="text/javascript" charset="utf8"
            src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" charset="utf8"
            src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap4.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#table').DataTable({
                "pagingType": "full_numbers"
            });
        });
    </script>
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
<form:form method="POST" modelAttribute="user" action="/admin">
    <div class="container-wrapper">
        <div class="container">
            <div class="page-header">
                <h2>&nbsp;</h2>
                <h2>Users</h2>

                <p class="lead">Here you can check user details </p>
            </div>

            <table id="table" class="table table-striped table-hover table-dark">
                <thead class="thead-light">
                <tr>
                    <th>Users</th>
                    <th>Block</th>
                    <th>Unblock</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <c:if test="${user.login != 'admin'}">
                        <tr>
                            <td>${user.login}</td>
                            <td>
                                <c:if test="${user.getActive() == 1}">
                                    <form:radiobutton path="login" value="${user.login}"/>
                                </c:if>
                            </td>
                            <td>
                            <c:if test="${user.getActive() == 0}">
                                <form:radiobutton path="login" value="${user.login}"/>
                            </c:if>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
            <div class="form">
                <form action="">
                    <button type="submit" class="btn btn-danger shadow-lg ">Block/Unblock</button>
                </form>
            </div>
        </div>
    </div>
</form:form>
<div class="success" id="message">
    ${message}
</div>
</body>
</html>