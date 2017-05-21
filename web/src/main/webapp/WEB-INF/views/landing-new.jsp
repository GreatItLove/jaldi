<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <title>Jaldi - Book your local, trusted handyman</title>
    <jsp:include page="common/meta.jsp"/>

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300&subset=latin" rel="stylesheet" type="text/css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/landing/fonts/linearicons/style.css" rel="stylesheet" type="text/css">
    <link href="/resources/landing/fonts/jaldi/jaldi-icons.css" rel="stylesheet" type="text/css">

    <!-- Core stylesheets -->
    <link href="/resources/landing/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="/resources/landing/css/pixeladmin.min.css" rel="stylesheet" type="text/css">
    <link href="/resources/landing/css/widgets.min.css" rel="stylesheet" type="text/css">

    <!-- Theme -->
    <link href="/resources/landing/css/themes/clean.min.css" rel="stylesheet" type="text/css">

    <!-- Landing page CSS -->
    <link href="/resources/landing/css/landing.css" rel="stylesheet" type="text/css">
</head>
<body>

<!-- Navbar -->

<nav class="navbar px-navbar">
    <div class="container">
        <div class="navbar-header">
            <a href="#home" class="scroll-to navbar-brand landing-logo">
                <img src="/resources/main/img/jaldi-logo.png" height="30">
            </a>
        </div>

        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse" aria-expanded="false"><i class="navbar-toggle-icon"></i></button>

        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#about-us" class="scroll-to">ABOUT US</a></li>
                <li><a href="#features" class="scroll-to">SERVICES</a></li>
                <li><a href="#book" class="scroll-to">HOW TO BOOK</a></li>
                <li><a href="#faq" class="scroll-to">FAQ</a></li>
                <sec:authorize access="isAuthenticated()">
                    <li><a href="/portal">MEMBER AREA</a></li>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <li><a href="/login">LOGIN</a></li>
                    <li><a href="/signup">SIGNUP</a></li>
                </sec:authorize>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero block -->

<a class="position-relative" name="home"></a>
<div id="landing-hero" class="text-xs-center clearfix">
    <div class="container">
        <!-- Header -->
        <h1 class="font-weight-semibold">Book your local, trusted handyman</h1>
        <h2 class="font-weight-light">
            <p>Friendly, vetted professionals at your doorstep.</p>
            <p>Just pick a time and we'll do the rest.</p>
        </h2>

        <!-- Buttons -->
        <div>
            <a href="#book" class="btn btn-xl primary-button m-x-1">BOOK NOW</a>
            <a href="#features" class="btn btn-xl default-button m-x-1 scroll-to">
                SEE ALL SERVICES
            </a>
        </div>
        <div class="icon-large-font" style="padding-top: 30px;">
            <i class="jaldi-icon jaldi-icon-ic-scroll"></i>
        </div>
        <!-- App sample -->
        <div class="sample">

        </div>
    </div>
</div>

<!-- Features -->
<a class="position-relative" name="about-us"></a>
<div class="landing-section landing-features-grid bg-white">
    <div class="container">
        <h1 class="landing-heading text-xs-center jaldi-title">ABOUT US</h1>
        <h2 class="landing-subheading text-xs-center text-muted"></h2>

        <div class="row">
            <div class="col-xs-3 col-md-4">
                <div class="hwa-item">
                    <img class="icon" src="resources/landing/img/who-we-are/ic_team.svg" />
                    <%--<i class="icon bg-primary lnr lnr-users"></i>--%>
                    <h3>BIG PROFESIONAL TEAM</h3>
                    <p>Pros using the Jaldi platform are experienced, friendly, and background-checked.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="hwa-item">
                    <img class="icon" src="resources/landing/img/who-we-are/ic_response.svg"/>
                    <h3>FAST RESPONSE</h3>
                    <p>Schedule your home service for as early as tomorrow.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="hwa-item">
                    <img class="icon" src="resources/landing/img/who-we-are/ic_guarantee.svg" />
                    <h3>SATISFACTION GUARANTEE</h3>
                    <p>Your happiness is our goal. If you’re not happy, we’ll work to make it right.</p>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Features -->

<a class="position-relative" name="features"></a>
<div class="landing-section landing-features-grid torn-paper-bg">
    <div class="">
        <h1 class="landing-heading text-xs-center jaldi-title">SERVICES</h1>
        <h2 class="landing-subheading text-xs-center text-muted"></h2>

        <div class="row">
            <div class="col-md-1">
            </div>
            <div class="col-md-2">
                <div class="service-item">
                    <div class="icon-circle icon-large-font handyman grow">
                        <i class="jaldi-icon jaldi-icon-ic-handyman"></i>
                    </div>
                    <%--<i class="icon bg-primary lnr lnr-users"></i>--%>
                    <h3>Handyman</h3>
                    <p>Get your to do list taken care of by a trusted professional.</p>
                </div>
            </div>
            <div class="col-md-2">
                <div class="service-item">
                    <div class="icon-circle icon-large-font electrician grow">
                        <i class="jaldi-icon jaldi-icon-ic-electrician"></i>
                    </div>
                    <h3>Electrician</h3>
                    <p>Book trusted and expert electricians for all electrical installation and repair tasks.</p>
                </div>
            </div>
            <div class="col-md-2">
                <div class="service-item">
                    <div class="icon-circle icon-large-font painter grow">
                        <i class="jaldi-icon jaldi-icon-ic-painter"></i>
                    </div>
                    <%--<i class="icon bg-primary lnr lnr-users"></i>--%>
                    <h3>Painter</h3>
                    <p>Book painters for renovation tasks and give your home/office a new look.</p>
                </div>
            </div>
            <div class="col-md-2">
                <div class="service-item">
                    <div class="icon-circle icon-large-font plumber grow">
                        <i class="jaldi-icon jaldi-icon-ic-plumber"></i>
                    </div>
                    <h3>Plumber</h3>
                    <p>Book plumbers for all your plumbing/pipeline repair and installation tasks.</p>
                </div>
            </div>
            <div class="col-md-2">
                <div class="service-item">
                    <div class="icon-circle icon-large-font cleaning grow">
                        <i class="jaldi-icon jaldi-icon-ic-cleaning"></i>
                    </div>
                    <h3>Cleaning</h3>
                    <p>Let your home shine. You'll be matched with an experienced, background-checked professional.</p>
                </div>
            </div>
        </div>

    </div>
</div>

<hr class="m-a-0">

<!-- Pricing -->

<a class="position-relative" name="book"></a>
<div class="landing-section">
    <div class="container">
        <h1 class="landing-heading text-xs-center jaldi-title">HOW TO BOOK</h1>

        <div class="row">
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-3">
                        <img src="/resources/landing/img/book-steps/Step 1 icon.png" height="150">
                    </div>
                    <div class="col-md-9 book-steps-title">You book a convenient worker in our application.</div>
                </div>
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-3">
                        <img src="/resources/landing/img/book-steps/Step 2 icon.png" height="150">
                    </div>
                    <div class="col-md-8 book-steps-title">You book a convenient worker in our application.</div>
                </div>
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-3">
                        <img src="/resources/landing/img/book-steps/Step 3 icon.png" height="150">
                    </div>
                    <div class="col-md-7 book-steps-title">You book a convenient worker in our application.</div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <img class="pull-right" src="/resources/landing/img/app-store.png" height="60">
                    </div>
                </div>
            </div>
            <div class="col-md-4 iphone">
            </div>
        </div>
    </div>
</div>

<!--Numbers section-->
<a class="position-relative" name="about-us"></a>
<div class="landing-section bg-primary p-y-3">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 col-md-3 margin-b-30 text-center">
                <h3 class="text-default counter-title">Total Users</h3>
                <i class="fa fa-users fa-5x" aria-hidden="true"></i>
                <h1 class="counter">${totalUsers}</h1>
            </div><!--col-->
            <div class="col-sm-6 col-md-3 margin-b-30 text-center">
                <h3 class="text-default counter-title">Total Investments</h3>
                <i class="fa fa-rocket fa-5x" aria-hidden="true"></i>
                <h1 class="counter">${totalBtcInvested}</h1>
            </div><!--col-->
            <div class="col-sm-6 col-md-3 margin-b-30 text-center">
                <h3 class="text-default counter-title">Total Withdrawals</h3>
                <i class="fa fa-money fa-5x" aria-hidden="true"></i>
                <h1 class="counter">${totalBtcWithdrawal}</h1>
            </div><!--col-->
            <div class="col-sm-6 col-md-3 margin-b-30 text-center">
                <h3 class="text-default counter-title">Days Online</h3>
                <i class="fa fa-calendar fa-5x" aria-hidden="true"></i>
                <h1 class="counter">${daysOnline}</h1>
            </div><!--col-->

        </div><!--row-->
    </div><!--container-->
</div>
<!--Numbers section end-->

<div class="landing-section">
    <div class="container">
        <h1 class="landing-heading text-xs-center">About Us</h1>

        <p class="landing-subheading text-muted">BTC INVEST LTD based in United Kingdom in March of 2017. The company is focusing on generating profits exclusively from the Crypto-Currency trading.
            BTC INVEST LTD is most profitable investment company which generating highly profitable return.</p>
        <p class="landing-subheading text-muted">Our mission is to provide the most profitable, safest investment platform to our investors.</p>
        <hr/>
        <div class="row">
            <div class="col-md-8">
                <h2>Our Location</h2>

            </div>
            <div class="col-md-4">
                <h3> <strong>Contact Info</strong></h3>
                <p><strong>Company Headquarters:</strong></p>
                <p>BTC INVEST LTD.<br>24 Handel St Bloomsbury<br>London<br>United Kingdom WC1N</p>
                <p>
                    <a href="mailto:contact@btcinvest.org?Subject=Help%20needed"
                       class="display-block text-nowrap">
                        <i class="fa fa-envelope"></i>&nbsp;&nbsp;contact@btcinvest.org
                    </a>
                </p><br>
                <h3>Follow Us</h3>
                <a href="https://www.facebook.com/btclnvest" target="_blank" class="btn btn-primary btn-outline"><i class="fa fa-facebook"></i></a>
                &nbsp;&nbsp;&nbsp;
                <a href="https://twitter.com/btclnvest" target="_blank" class="btn btn-primary btn-outline"><i class="fa fa-twitter"></i></a>
                &nbsp;&nbsp;&nbsp;
                <a href="https://plus.google.com/u/0/113185163378767733527" target="_blank" class="btn btn-primary btn-outline"><i class="fa fa-google"></i></a>
            </div>
        </div>
    </div>
</div>

<!-- Social buttons -->
<div class="landing-section bg-white darker b-t-1 m-y-4">
    <div class="container text-xs-center">
        <h1 class="landing-heading">Ready To Book Now?</h1>
        <a href="#" class="btn btn-rounded btn-xl btn-primary m-x-1">Book a Cleaning</a>
        <a href="#features" class="btn btn-primary btn-xl btn-outline btn-rounded m-x-1 scroll-to">
            See All Services
        </a>
    </div>
</div>

<!-- Footer -->

<div class="px-footer">
    <div class="container p-t-3">
        <div class="row">

            <div class="col-sm-3">
                <h5 class="m-t-0 m-b-1">QUICK LINKS</h5>
                <div style="line-height: 1.7;">
                    <a href="#">About</a><br>
                    <a href="#">Home</a><br>
                    <a href="#">Blog</a><br>
                    <a href="#">Support Center</a><br>
                    <a href="#">Contact</a><br>
                    <a href="#">Terms</a><br>
                    <a href="#">Privacy</a>
                </div>
            </div>

            <!-- spacer -->
            <div class="m-t-4 visible-xs"></div>

            <div class="col-sm-3">
                <h5 class="m-t-0 m-b-1">CATEGORIES</h5>
                <div style="line-height: 1.7;">
                    <a href="#">Business</a><br>
                    <a href="#">Fashion</a><br>
                    <a href="#">Featured</a><br>
                    <a href="#">Food for thought</a><br>
                    <a href="#">Gaming</a><br>
                    <a href="#">Music</a><br>
                </div>
            </div>

            <!-- spacer -->
            <div class="m-t-4 visible-xs"></div>

            <div class="col-sm-6">
                <h5 class="m-t-0 m-b-1">POPULAR SERVICES</h5>
                <p>
                    <a href="#">Lorem ipsum dolor sit amet, consectetur</a>
                </p>
                <p>
                    <a href="#">Lorem ipsum dolor sit amet, consectetur</a>
                </p>
                <p>
                    <a href="#">Lorem ipsum dolor sit amet, consectetur</a>
                </p>
            </div>
        </div>
        <hr>
        <span class="text-muted">Copyright © 2017 Jaldi. All rights reserved.</span>
    </div>
</div>

<!-- ==============================================================================
|
|  SCRIPTS
|
=============================================================================== -->

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<!-- Core scripts -->
<script src="/resources/landing/js/bootstrap.min.js"></script>
<script src="/resources/landing/js/pixeladmin.compressed.js"></script>

<!-- Landing page dependencies -->
<script src="/resources/landing/js/jquery.waypoints.min.js"></script>
<script src="/resources/landing/js/jquery.scrollTo.min.js"></script>
<script src="/resources/landing/js/lazysizes.min.js"></script>
<script src="/resources/landing/js/jquery.counterup.min.js"></script>

<!-- Landing page JS -->
<script src="/resources/landing/js/landing.js"></script>
</body>
</html>
