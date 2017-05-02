<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Jaldi - Sign In</title>
    <jsp:include page="common/meta.jsp"/>

    <link href="/resources/main/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/main/css/simple-line-icons.css" rel="stylesheet">

    <!-- Main styles for this application -->
    <link href="/resources/main/css/style.css" rel="stylesheet">

    <link href="/resources/main/css/override.css" rel="stylesheet">

</head>
<body class="app flex-row align-items-center">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card-group mb-0">
                <div class="card p-2">
                    <div class="card-block">
                        <form action="/login.do" method="post">
                            <h1>Login</h1>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                        ${error}
                                </div>
                            </c:if>
                            <c:if test="${not empty msg}">
                                <div class="alert alert-info">
                                        ${msg}
                                </div>
                            </c:if>
                            <p class="text-muted">Sign In to your account</p>
                            <div class="input-group mb-1">
                                    <span class="input-group-addon"><i class="icon-user"></i>
                                    </span>
                                <input type="text" name="username" class="form-control" placeholder="Username">
                            </div>
                            <div class="input-group mb-2">
                                    <span class="input-group-addon"><i class="icon-lock"></i>
                                    </span>
                                <input type="password" name="password" class="form-control" placeholder="Password">
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <button type="submit" class="btn btn-primary px-2">Login</button>
                                </div>
                                <div class="col-6 text-right">
                                    <button type="button" class="btn btn-link px-0">Forgot password?</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="card card-inverse card-primary py-3 hidden-md-down" style="width:44%">
                    <div class="card-block text-center">
                        <div>
                            <h2>Sign up</h2>
                            <p>New to Jaldi?</p>
                            <button type="button" class="btn btn-primary active mt-1">Register Now!</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap and necessary plugins -->
<script src="/resources/main/js/libs/jquery.min.js"></script>
<script src="/resources/main/js/libs/tether.min.js"></script>
<script src="/resources/main/js/libs/bootstrap.min.js"></script>


</body>
</html>
