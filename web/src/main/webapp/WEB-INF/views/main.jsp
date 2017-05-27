<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<sec:authentication var="userId" property="user.id"/>
<sec:authentication var="userFullName" property="user.name" htmlEscape="false"/>
<sec:authentication var="profileImageId" property="user.profileImageId" htmlEscape="false"/>
<!DOCTYPE html>
<html ng-app="jaldi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Jaldi - Book your local, trusted handyman</title>
    <jsp:include page="common/meta.jsp"/>

    <link href="/resources/main/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/main/css/simple-line-icons.css" rel="stylesheet">
    <link href="/resources/main/js/libs/ng-table/ng-table.min.css" rel="stylesheet" type="text/css">
    <link href="/resources/main/js/libs/img-crop/ng-img-crop.css" rel="stylesheet" type="text/css">

    <!-- Main styles for this application -->
    <link href="/resources/main/css/style.css" rel="stylesheet">

    <link href="/resources/main/css/override.css" rel="stylesheet">

    <link href="/resources/main/css/jaldi.css" rel="stylesheet">

    <script language="javascript" type="text/javascript">
        var contextPath = '${contextPath}';
        var userId = parseInt('${userId}');
        var userFullName = '${userFullName}';
        var profileImageId = '${profileImageId}';
        var isAdmin = false;
        var isOperator = false;
        <sec:authorize access="hasAuthority('ADMIN')">
            isAdmin = true;
        </sec:authorize>
        <sec:authorize access="hasAuthority('OPERATOR')">
            isOperator = true;
        </sec:authorize>
    </script>
</head>
<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
<header class="app-header navbar">
    <button class="navbar-toggler mobile-sidebar-toggler hidden-lg-up" type="button">☰</button>
    <a class="navbar-brand" href="#"></a>
    <ul class="nav navbar-nav hidden-md-down">
        <li class="nav-item">
            <a class="nav-link navbar-toggler sidebar-toggler" href="#">☰</a>
        </li>

    </ul>
    <ul class="nav navbar-nav ml-auto last">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                <img ng-src="{{utils.getProfilePictureUrl()}}" class="img-avatar">
                <span class="hidden-md-down" ng-bind="$root.user.userFullName"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-right">
                <a class="dropdown-item" ui-sref="profile"><i class="fa fa-user"></i> Profile</a>
                <a class="dropdown-item" href ng-click="$root.logout()"><i class="fa fa-lock"></i> Logout</a>
            </div>
        </li>
    </ul>
</header>

<div class="app-body">
    <div class="sidebar">
        <nav class="sidebar-nav">
            <ul class="nav">
                <li class="nav-item nav-item-box">
                    <img ng-src="{{utils.getProfilePictureUrl()}}" class="pull-left m-r-2 img-avatar border-round" style="width: 54px; height: 54px;">
                    <div class="font-size-13"><span class="font-weight-light">Welcome, </span><div><strong ng-bind="$root.user.userFullName"></strong></div></div>
                </li>
                <li ng-if="utils.isAdmin()" class="nav-item">
                    <a class="nav-link" ui-sref="dashboard" ui-sref-active="active"><i class="icon-speedometer"></i> Dashboard</a>
                </li>
                <li ng-if="utils.isOperator() || utils.isAdmin()" class="nav-item">
                    <a class="nav-link" ui-sref="orders" ui-sref-active="active"><i class="icon-calendar"></i> Orders</a>
                </li>
                <li ng-if="utils.isOperator() || utils.isAdmin()" class="nav-item">
                    <a class="nav-link" ui-sref="workers" ui-sref-active="active"><i class="icon-user-follow"></i> Workers</a>
                </li>
                <li class="nav-item nav-dropdown" ng-class="{'open':$state.is('profile')}">
                    <a class="nav-link nav-dropdown-toggle" href="#"><i class="icon-settings"></i> Settings</a>
                    <ul class="nav-dropdown-items">
                        <li class="nav-item">
                            <a class="nav-link" ui-sref="profile" ui-sref-active="active"><i class="icon-user"></i> Profile</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main content -->
    <main class="main">
        <div class="container-fluid pt-2" ui-view>
        </div>
    </main>

</div>

<footer class="app-footer">
    <a href="//jaldi.pro">Jaldi</a> © 2017. All rights reserved.
</footer>

<div ng-show="$root.showAjaxLoader" class="ajax-loader ng-cloak" loading>
    <i class="fa fa-circle-o-notch fa-spin fa-3x"></i>
</div>

<!-- Bootstrap and necessary plugins -->
<script src="/resources/main/js/libs/jquery.min.js"></script>
<script src="/resources/main/js/libs/tether.min.js"></script>
<script src="/resources/main/js/libs/bootstrap.min.js"></script>
<script src="/resources/main/js/libs/Chart.min.js"></script>

<script src="/resources/main/js/libs/pace.min.js"></script>

<script src="/resources/main/js/libs/iqapp.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.3/angular.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-sanitize/1.6.3/angular-sanitize.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-resource/1.6.3/angular-resource.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-router/0.4.2/angular-ui-router.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-mask/1.8.7/mask.min.js"></script>
<script src="/resources/main/js/libs/ui-bootstrap-tpls-2.5.0.min.js"></script>
<script src="/resources/main/js/libs/ng-table/ng-table.min.js"></script>
<script src="/resources/main/js/libs/img-crop/ng-img-crop.js"></script>

<script src="/resources/main/app/app.js"></script>
<script src="/resources/main/app/common/utils.js"></script>
<script src="/resources/main/app/common/directives.js"></script>
<script src="/resources/main/app/common/filters.js"></script>
<script src="/resources/main/app/common/common-controller.js"></script>
<script src="/resources/main/app/common/common-service.js"></script>
<script src="/resources/main/app/workers/workers.js"></script>
<script src="/resources/main/app/profile/profile.js"></script>
<script src="/resources/main/app/orders/orders.js"></script>
<script src="/resources/main/app/dashboard/dashboard.js"></script>

</body>
</html>
