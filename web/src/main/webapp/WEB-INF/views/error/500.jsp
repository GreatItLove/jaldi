<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <title>BtcInvest - Sign In</title>
    <jsp:include page="../common/meta.jsp"/>

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300&subset=latin" rel="stylesheet" type="text/css">
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

    <link href="/resources/main/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="/resources/main/css/pixeladmin-dark.min.css" rel="stylesheet" type="text/css">
    <link href="/resources/main/css/widgets.min.css" rel="stylesheet" type="text/css">

    <!-- Theme -->
    <link href="/resources/main/css/themes/clean.min.css" rel="stylesheet" type="text/css">

    <link href="/resources/main/css/error-page.css" rel="stylesheet" type="text/css">

</head>
<body>
<div class="page-500-bg bg-danger"></div>
<div class="page-500-header bg-white">
    <a class="px-demo-brand px-demo-brand-lg" href="/">
        <img src="/resources/main/img/logo-full-white.png" height="40">
    </a>
</div>
<h1 class="page-500-error-code"><strong>500</strong></h1>
<h2 class="page-500-subheader">OUCH!</h2>
<h3 class="page-500-text">
    SOMETHING IS NOT QUITE RIGHT
    <br>
    <br>
    <span class="font-size-16 font-weight-normal">We hope to solve it shortly</span>
</h3>
<form class="page-404-form" action="">
    <div class="text-xs-center m-t-2 font-weight-bold font-size-14 text-white">
        <a href="/" class="text-white"><u>Back to home</u></a>
    </div>
</form>

<jsp:useBean id="random" class="java.util.Random" scope="application" />
<c:set var="bgName" value="${random.nextInt(11) + 1}"></c:set>
<div class="px-responsive-bg">
    <div class="px-responsive-bg-overlay" style="background: rgb(0, 0, 0); opacity: 0.2;"></div>
    <img alt="" src="/resources/main/img/bgs/${bgName}.jpg" style="width: 100%; height: 958px; top: -94px; left: 0px;">
</div>
</body>
</html>
