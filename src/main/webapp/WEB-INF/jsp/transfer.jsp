<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Transfer</title>
    <jsp:include page="head.jsp" />
</head>
<body class="background-gradient">
<header>
    <jsp:include page="header.jsp" />
</header>
<div class="login-page">
    <form method="post" action="/transfer">
        <h1>Transfer</h1>
        <label class="text-white" for="card_from">Select card for transfer:</label>
        <input class="form-control" id="card_from" name="numberCardFrom" type="text" required placeholder="Card number">
        <label class="text-white" for="card_to">Select card for payment:</label>
        <input class="form-control" id="card_to" name="numberCardTo" type="text" required placeholder="Destination card number">
        <label class="text-white" for="sum">Sum payment:</label>
        <input class="form-control" id="sum" name="value" type="number" required placeholder="Amount">
        <form action="#">
            <br>
            <button type="submit" class="btn btn-success shadow-lg ">Submit</button>
        </form>
    </form>
</div>
<div class="success" id="message">
    ${message}
</div>
<div class="warning" id="warning">
    ${warning}
</div>
</body>
</html>
