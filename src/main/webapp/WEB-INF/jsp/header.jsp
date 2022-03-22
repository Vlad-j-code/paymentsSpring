<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js">
</script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#locales").change(function () {
            var selectedOption = $('#locales').val();
            if (selectedOption != ''){
                window.location.replace('?lang=' + selectedOption);
            }
        });
    });
</script>
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
        <c:if test="${not empty pageContext.request.userPrincipal}">
        <select style="height:30px" id="locales">
            <option value=""><spring:message code="jsp.header.language" text="default"/></option>
            <option value="en"><spring:message code="English" text="default"/> </option>
            <option value="uk"><spring:message code="Ukrainian" text="default"/> </option>
            <option value="ru"><spring:message code="Russian" text="default"/> </option>
        </select>
        </c:if>
        <ul class="navbar-nav ml-auto">
            <c:if test="${pageContext.request.userPrincipal.name == 'admin'}">
                <li class="nav-item active">
                    <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                       href="/activity"><spring:message code="jsp.activity" text="default"/></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                       href="/requests"><spring:message code="jsp.requests" text="default"/></a>
                </li>
            </c:if>
            <c:if test="${empty pageContext.request.userPrincipal}">
                <li class="nav-item active">
                    <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;" href="/">Home
                        <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                       href="/login">Login</a>
                </li>
            </c:if>
            <c:if test="${not empty pageContext.request.userPrincipal}">
                <c:if test="${pageContext.request.userPrincipal.name != 'admin'}">
                    <li class="nav-item active">
                        <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                           href="/cards"><spring:message code="jsp.cards" text="default"/></a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                           href="/payments"><spring:message code="jsp.header.payments" text="default"/></a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                           href="/income"><spring:message code="jsp.header.income" text="default"/></a>
                    </li>
                    <div class="dropdown">
                        <button class="dropbtn"><spring:message code="jsp.header.all.functions" text="default"/></button>
                        <div class="dropdown-content">
                            <a href="/createCard"><spring:message code="jsp.creating.card" text="default"/></a>
                            <a href="/refill"><spring:message code="jsp.add.balance" text="default"/></a>
                            <a href="/transfer"><spring:message code="jsp.send.payment" text="default"/></a>
                        </div>
                    </div>
                </c:if>
                <li class="nav-item active">
                    <a class="nav-link" style="text-shadow:3px 3px 2px black, 0 0 40px yellow, 0 0 10px darkblue;"
                       href="/logout">${pageContext.request.userPrincipal.name} <i>(<spring:message code="jsp.header.logout" text="default"/>)</i></a>
                </li>
            </c:if>
        </ul>
    </div>
</nav>