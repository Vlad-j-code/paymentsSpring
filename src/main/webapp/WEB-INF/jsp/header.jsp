<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background-color: #20252A">
    <c:if test="${not empty pageContext.request.userPrincipal}">
        <a href="/" class="navbar-brand ">
            <img src="../../img/auth.png" alt="logo" width="30" height="30">
        </a>
    </c:if>
    <b style="color: floralwhite" class="navbar-brand">MONEY TRANSFER</b>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;" href="/">Home
                    <span class="sr-only">(current)</span></a>
            </li>
            <c:if test="${pageContext.request.userPrincipal.name == 'admin'}">
                <li class="nav-item active">
                    <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                       href="/activity">Activity</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                       href="/requests">Requests</a>
                </li>
            </c:if>
            <c:if test="${empty pageContext.request.userPrincipal}">
                <li class="nav-item active">
                    <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                       href="/login">Login</a>
                </li>
            </c:if>
            <c:if test="${not empty pageContext.request.userPrincipal}">
                <c:if test="${pageContext.request.userPrincipal.name != 'admin'}">
                    <li class="nav-item active">
                        <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                           href="/cards">Cards</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                           href="/payments">Payments</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                           href="/income">Income</a>
                    </li>
                    <div class="dropdown">
                        <button class="dropbtn">All functions</button>
                        <div class="dropdown-content">
                            <a href="/createCard">Create Card</a>
                            <a href="/refill">Replenish balance</a>
                            <a href="/transfer">Send payment</a>
                        </div>
                    </div>
                </c:if>
                <li class="nav-item active">
                    <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                       href="/logout">${pageContext.request.userPrincipal.name} <i>(Logout)</i></a>
                </li>
            </c:if>
        </ul>
    </div>
</nav>