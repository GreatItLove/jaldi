<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>404 - Page Not Found</title>
    <jsp:include page="../common/meta.jsp"/>

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
            <div class="clearfix">
                <h1 class="float-left display-3 mr-2">404</h1>
                <h4 class="pt-1">Oops! You're lost.</h4>
                <p class="text-muted">The page you are looking for was not found.</p>
            </div>
            <div class="text-center">
                <a href="/" class=""><u>Back to home</u></a>
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
