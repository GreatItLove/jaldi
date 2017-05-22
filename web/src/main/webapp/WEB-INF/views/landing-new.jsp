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
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/landing/fonts/linearicons/style.css" rel="stylesheet" type="text/css">
    <link href="/resources/landing/fonts/jaldi/jaldi-icons.css" rel="stylesheet" type="text/css">

    <!-- Core stylesheets -->
    <link href="/resources/landing/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="/resources/landing/js/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css">
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
                <li><a href="#projects" class="scroll-to">OUR WORKS</a></li>
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
            <div class="col-md-4">
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
                    <div class="col-md-3 text-center">
                        <img src="/resources/landing/img/book-steps/Step 1 icon.png" height="150">
                    </div>
                    <div class="col-md-9 book-steps-title">You book a convenient worker in our application.</div>
                </div>
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-3 text-center">
                        <img src="/resources/landing/img/book-steps/Step 2 icon.png" height="150">
                    </div>
                    <div class="col-md-8 book-steps-title">Our worker comes in, surveys the job, briefs you about the details.</div>
                </div>
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-3 text-center">
                        <img src="/resources/landing/img/book-steps/Step 3 icon.png" height="150">
                    </div>
                    <div class="col-md-7 book-steps-title">You hire the worker and get the wheels rolling.</div>
                </div>
            </div>
            <div class="col-md-4 iphone">
            </div>
            <div class="col-md-12 text-center">
                <a href=""><img class="" src="/resources/landing/img/app-store.png" height="60"></a>
            </div>
        </div>
    </div>
</div>

<a class="position-relative" name="projects"></a>
<div class="landing-section" style="padding-bottom: 40px;">
    <div class="container">
        <h1 class="landing-heading text-xs-center jaldi-title">OUR WORKS</h1>
        <h2 class="landing-subheading text-xs-center text-muted" style="margin-bottom: 20px;">In a very short time thousands of projects successfully completed through Jaldi pros.</h2>
        <div class="row">
            <div class="col-md-12">
                <img src="/resources/landing/img/projects/our-works.png">
            </div>
        </div>
    </div>
</div>


<a class="position-relative" name="our-staff"></a>
<div id="our-staff" class="landing-section">
    <div class="">
        <h1 class="landing-heading text-xs-center jaldi-title">OUR STAFF</h1>

        <div class="row">
            <div class="col-md-1">
            </div>
            <div class="col-md-2">
                <div class="staff-item">
                    <div class="">
                        <img class="icon" src="resources/landing/img/staff/labor_img.png" />
                    </div>
                    <h1>1442</h1>
                    <h3>Skilled Labors</h3>
                </div>
            </div>
            <div class="col-md-2">
                <div class="staff-item">
                    <div class="">
                        <img class="icon" src="resources/landing/img/staff/plumber_img.png" />
                    </div>
                    <h1>472</h1>
                    <h3>Plumbers</h3>
                </div>
            </div>
            <div class="col-md-2">
                <div class="staff-item">
                    <div class="">
                        <img class="icon" src="resources/landing/img/staff/electrican_img.png" />
                    </div>
                    <h1>833</h1>
                    <h3>Electricians</h3>
                </div>
            </div>
            <div class="col-md-2">
                <div class="staff-item">
                    <div class="">
                        <img class="icon" src="resources/landing/img/staff/carpenter_img.png" />
                    </div>
                    <h1>662</h1>
                    <h3>Carpenters</h3>
                </div>
            </div>
            <div class="col-md-2">
                <div class="staff-item">
                    <div class="">
                        <img class="icon" src="resources/landing/img/staff/painter_img.png" />
                    </div>
                    <h1>57</h1>
                    <h3>Painters</h3>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->

<div class="px-footer">
    <div class="container p-t-3">
        <div class="row">

            <div class="col-sm-3">
                <h5 class="m-t-0 m-b-1">QUICK LINKS</h5>
                <div style="line-height: 1.7;">
                    <div><a href="#about-us" class="scroll-to">About</a></div>
                    <div><a href="#features" class="scroll-to">Services</a></div>
                    <div><a href="#book" class="scroll-to">How to book</a></div>
                    <div><a href="#projects" class="scroll-to">Our works</a></div>
                    <sec:authorize access="isAuthenticated()">
                        <div><a href="/portal">Member area</a></div>
                    </sec:authorize>
                    <sec:authorize access="isAnonymous()">
                        <div><a href="/login">Login</a></div>
                    </sec:authorize>
                </div>
            </div>

            <!-- spacer -->
            <div class="m-t-4 visible-xs"></div>

            <div class="col-sm-6">
                <h5 class="m-t-0 m-b-1">KEEP IN TOUCH</h5>
                <p>
                    <a target="_blank" href="https://www.google.com/maps?daddr=West+Bay,+P.O.+box+19573,+Zone+61,+Street+831,+Building+262,+Doha,+Qatar">
                        <i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;West Bay, P.O. box 19573, Zone 61, Street 831, Building 262, Doha, Qatar </a>
                </p>
                <p>
                    <a href="tel:555-555-5555"><i class="fa fa-phone" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;+974 4483 4423</a>
                </p>
                <p>
                    <a href="mailto:contact@jaldi.pro"><i class="fa fa-envelope" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;contact@jaldi.pro</a>
                </p>
            </div>

            <!-- spacer -->
            <div class="m-t-4 visible-xs"></div>

            <div class="col-sm-3">
                <div style="">
                    <a href="#"><i class="jaldi-icon jaldi-icon-ic-logo footer-logo"></i></a>
                </div>
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
<script src="/resources/landing/js/perfect-scrollbar/js/perfect-scrollbar.jquery.min.js"></script>
<script src="/resources/landing/js/pxadmin-light.js"></script>

<!-- Landing page dependencies -->
<script src="/resources/landing/js/jquery.waypoints.min.js"></script>
<script src="/resources/landing/js/jquery.scrollTo.min.js"></script>

<!-- Landing page JS -->
<script src="/resources/landing/js/landing.js"></script>
</body>
</html>
