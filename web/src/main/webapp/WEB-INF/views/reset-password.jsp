<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Jaldi - Password Reset</title>
    <jsp:include page="common/meta.jsp"/>

    <link href="/resources/main/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/main/css/simple-line-icons.css" rel="stylesheet">

    <!-- Main styles for this application -->
    <link href="/resources/main/css/style.css" rel="stylesheet">

    <link href="/resources/main/css/override.css" rel="stylesheet">

    <script src="/resources/main/js/libs/jquery.min.js"></script>

</head>
<body class="app flex-row align-items-center">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card mx-2">
                <div class="card-block p-2">
                    <!-- Reset form -->
                    <form action="/reset-password" method="post" class="p-a-4">
                        <h4 class="m-t-0 m-b-4 text-xs-center font-weight-semibold">Password reset</h4>
                        <c:if test="${ not empty successfullyChanged }">
                            <div class="alert alert-info">
                                    ${successfullyChanged}
                            </div>
                            <script>
                                $(document).ready(function () {
                                    window.setTimeout(function () {
                                        location.href = "/login";
                                    }, 3000);
                                });
                            </script>
                        </c:if>
                        <c:if test="${ empty successfullyChanged }">
                            <input type="hidden" name="token" value="${token}">
                            <fieldset class="page-signin-form-group form-group form-group-lg">
                                <div class="page-signin-icon text-muted"><i class="ion-asterisk"></i></div>
                                <input type="password" name="password" autocomplete="off" required minlength="8" class="page-signin-form-control form-control" placeholder="Password">
                            </fieldset>
                            <fieldset class="page-signin-form-group form-group form-group-lg form-message-dark ${not empty doesntMatch ? 'has-danger' : ''}">
                                <div class="page-signin-icon text-muted"><i class="ion-asterisk"></i></div>
                                <input type="password" name="password2" autocomplete="off" required minlength="8" class="page-signin-form-control form-control" placeholder="Repeat password">
                                <c:if test="${ not empty doesntMatch }">
                                    <div class="form-message has-danger">
                                        <span>${doesntMatch}</span>
                                    </div>
                                </c:if>
                            </fieldset>
                            <button type="submit" class="btn btn-block btn-lg btn-primary m-t-3">Change password</button>
                        </c:if>
                        <div class="m-t-2 text-muted">
                            <a href="/login" id="page-signin-forgot-back">&larr; Back</a>
                        </div>
                    </form>
                    <!-- / Reset form -->
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
