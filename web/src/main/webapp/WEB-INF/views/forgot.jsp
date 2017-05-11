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

</head>
<body class="app flex-row align-items-center">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card mx-2">
                <div class="card-block p-2">
                    <form action="/forgot" method="post" class="p-a-4">
                        <h4 class="m-t-0 m-b-4 text-xs-center font-weight-semibold">Password reset</h4>
                        <c:if test="${not empty msg}">
                            <div class="alert alert-info">
                                    ${msg}
                            </div>
                        </c:if>
                        <fieldset class="page-signin-form-group form-group form-group-lg">
                            <div class="page-signin-icon text-muted"><i class="ion-at"></i></div>
                            <input type="email" name="email" required class="page-signin-form-control form-control" placeholder="Your Email">
                        </fieldset>

                        <button type="submit" class="btn btn-block btn-lg btn-primary m-t-3">Send password reset link</button>
                        <div class="m-t-2 text-muted">
                            <a href="/login" id="page-signin-forgot-back">&larr; Back</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
