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
                <img src="/resources/main/img/logo-full-white.png" height="30">
            </a>
        </div>

        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse" aria-expanded="false"><i class="navbar-toggle-icon"></i></button>

        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#features" class="scroll-to">SERVICES</a></li>
                <li><a href="#pricing" class="scroll-to">PLANS</a></li>
                <li><a href="#about-us" class="scroll-to">ABOUT US</a></li>
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
            <a href="#" class="btn btn-rounded btn-xl btn-primary m-x-1">Book a Cleaning</a>
            <a href="#features" class="btn btn-xl btn-outline btn-outline-colorless-inverted btn-rounded m-x-1 scroll-to">
                See All Services
            </a>
        </div>

        <!-- App sample -->
        <div class="sample">

        </div>
    </div>
</div>

<!-- Features -->

<a class="position-relative" name="features"></a>
<div class="landing-section landing-features-grid bg-white b-y-1">
    <div class="container">
        <h1 class="landing-heading text-xs-center">Services</h1>
        <h2 class="landing-subheading text-xs-center text-muted"></h2>

        <div class="row">
            <div class="col-xs-3 col-md-4">
                <div class="service-item grow">
                    <img class="icon" src="resources/landing/img/services/screwdriver.png" />
                    <%--<i class="icon bg-primary lnr lnr-users"></i>--%>
                    <h3>Electrician</h3>
                    <p>Book trusted and expert electricians for all electrical installation and repair tasks. All electricians are verified, skilled in wiring and electrical knowledge.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="service-item grow">
                    <img class="icon" src="resources/landing/img/services/plunger.png"/>
                    <h3>Plumber</h3>
                    <p>Book plumbers for all your plumbing/pipeline repair and installation tasks. All our plumbers are background verified, arrive within 6-8 working hours.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="service-item grow">
                    <img class="icon" src="resources/landing/img/services/saw.png" />
                    <h3>Carpenter</h3>
                    <p>Book carpenters for your furniture repair and installation/fixation issues. Our carpenters are also experienced in making new furniture items from the scratch.</p>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-3 col-md-4">
                <div class="service-item grow">
                    <img class="icon" src="resources/landing/img/services/trowel.png" />
                    <%--<i class="icon bg-primary lnr lnr-users"></i>--%>
                    <h3>Mason</h3>
                    <p>Book masons for construction and tiling/flooring purposes. Masons at Sukoon are 100% verified and available on same day as of booking.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="service-item grow">
                    <img class="icon" src="resources/landing/img/services/paint-brush.png"/>
                    <h3>Painter</h3>
                    <p>Book painters for renovation tasks and give your home/office a new look. Our painters are also background verified, at your doorstep within 6-8 hours of booking.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="service-item grow">
                    <img class="icon" src="resources/landing/img/services/broom.png" />
                    <h3>Cleaning</h3>
                    <p>Let your home shine. You'll be matched with an experienced, background-checked professional. If you love your pro, you can keep requesting them as your favorite!</p>
                </div>
            </div>
        </div>

    </div>
</div>

<hr class="m-a-0">

<!-- Pricing -->

<a class="position-relative" name="pricing"></a>
<div class="landing-section">
    <div class="container">
        <h1 class="landing-heading text-xs-center">What we offer</h1>
        <%--<h2 class="landing-heading text-xs-center">Anytime cancellation after 24 h with 5% Initial Deposit Fee</h2>--%>

        <div class="widget-pricing widget-pricing-simple widget-pricing-expanded">
            <div class="widget-pricing-inner row">
                <div class="col-md-4">
                    <div class="widget-pricing-item">
                        <h2 class="widget-pricing-plan m-a-0">NEWBIE</h2>
                        <div class="widget-pricing-section p-y-2 b-y-1 bg-white darken">
                            <div class="widget-pricing-price font-size-24 font-weight-bold">3.5% DAILY</div>
                        </div>
                        <div class="widget-pricing-section font-size-15">
                            <p>For 40 calendar days</p>
                            <p>Total Return 140%</p>
                            <p>Net profit 40%</p>
                            <p>Limits BTC 0.01 - 0.49 ₿TC</p>
                            <p>Limits USD $10 - $499 </p>
                        </div>
                        <div class="widget-pricing-section"><a href="/signup" type="button" class="btn btn-lg btn-primary">Make Deposit!</a></div>
                    </div>
                </div>

                <!-- spacer -->
                <div class="p-t-3 visible-xs visible-sm"></div>

                <div class="col-md-4">
                    <div class="widget-pricing-item">
                        <h2 class="widget-pricing-plan m-a-0">GROWING</h2>
                        <div class="widget-pricing-section p-y-2 b-y-1 bg-primary">
                            <div class="widget-pricing-price font-size-24 font-weight-bold">4% DAILY</div>
                        </div>
                        <div class="widget-pricing-section font-size-15">
                            <p>For 60 calendar days</p>
                            <p>Total Return 240%</p>
                            <p>Net profit 140%</p>
                            <p>Limits BTC 0.5 - 4.5 ₿TC</p>
                            <p>Limits USD $500 - $4999 </p>
                        </div>
                        <div class="widget-pricing-section"><a href="/signup" type="button" class="btn btn-lg btn-primary">Make Deposit!</a></div>
                    </div>
                </div>

                <!-- spacer -->
                <div class="p-t-3 visible-xs visible-sm"></div>

                <div class="col-md-4">
                    <div class="widget-pricing-item">
                        <h2 class="widget-pricing-plan m-a-0">PRO</h2>
                        <div class="widget-pricing-section p-y-2 b-y-1 bg-white darken">
                            <div class="widget-pricing-price font-size-24 font-weight-bold">4.5% DAILY</div>
                        </div>
                        <div class="widget-pricing-section font-size-15">
                            <p>For 90 calendar days</p>
                            <p>Total Return 405%</p>
                            <p>Net profit 305%</p>
                            <p>Limits BTC 4.51 - </p>
                            <p>Limits USD $5000 -  </p>
                        </div>
                        <div class="widget-pricing-section"><a href="/signup" type="button" class="btn btn-lg btn-primary">Make Deposit!</a></div>
                    </div>
                </div>

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

<!--FAQ section-->
<a class="position-relative" name="faq"></a>
<div class="landing-section">
    <div class="container">
        <hr>
        <h1 class="m-y-4 text-xs-center font-weight-normal">Frequently Asked Questions</h1>
        <div class="row">
            <div class="col-md-4 col-lg-3">
                <ul class="nav nav-sm nav-pills nav-stacked m-b-3">
                    <li class="active"><a href="#tabs-general" data-toggle="tab">General</a></li>
                    <li><a href="#tabs-setup" data-toggle="tab">Deposits</a></li>
                    <li><a href="#tabs-licensing" data-toggle="tab">Withdrawal</a></li>
                    <li><a href="#tabs-account" data-toggle="tab">Account Security</a></li>
                </ul>
            </div>
            <div class="col-md-8 col-lg-9">
                <div class="tab-content p-a-0">
                    <div class="tab-pane fade in active" id="tabs-general">
                        <div class="panel-group" id="accordion-general">
                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-general" href="#accordion-general-1">
                                    What is btcinvest.org?
                                </a>
                                <div id="accordion-general-1" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        btcinvest.org is the official website of BTC INVEST LTD, which offers investment services.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-general" href="#accordion-general-2">
                                    Is BTC INVEST Ltd an officially registered and legal company?
                                </a>
                                <div id="accordion-general-2" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Yes, BTC INVEST LTD is registered and works according to United Kingdom laws.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-general" href="#accordion-general-3">
                                    How can I earn on BTC Invest?
                                </a>
                                <div id="accordion-general-3" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Everything that you need to do is to <a href="/signup">register</a> an account and start investing.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-general" href="#accordion-general-4">
                                    How are you able to pay those returns?
                                </a>
                                <div id="accordion-general-4" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        BTC Invest is one of the most innovative and most profitable asset management companies and it generates highly profitable returns. BTC Invest is dedicated to a focus on generating profits exclusively from CryptoCurrency trading.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-general" href="#accordion-general-5">
                                    What are the risks of loss of funds for investors?
                                </a>
                                <div id="accordion-general-5" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        BTC Invest proposes a risk-free activity. However, to avoid possible loss, the company continuously updates its contingency fund. In the case of force majeure situations, all of the company's investors can expect to receive money back minus the profits they received earlier.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-general" href="#accordion-general-6">
                                    Who can participate in BTC Invest?
                                </a>
                                <div id="accordion-general-6" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Any person or company from any country may open an account with us.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-general" href="#accordion-general-7">
                                    What do I need to do to become a member of BTC Invest?
                                </a>
                                <div id="accordion-general-7" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Click on <a href="/signup">Registration</a> link and fill a form and then click on the "Sign Up" button.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-general" href="#accordion-general-8">
                                    What if I don't find the answer to my question here?
                                </a>
                                <div id="accordion-general-8" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Please contact us for help. Or ask your question in live chat you will find
                                        on bottom right corner.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="tabs-setup">
                        <div class="panel-group" id="accordion-setup">
                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-setup" href="#accordion-setup-1">
                                    Which currencies do you accept?
                                </a>
                                <div id="accordion-setup-1" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        We accept Bitcoin for deposits in BTC currency.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-setup" href="#accordion-setup-2">
                                    What is the minimum amount for deposit?
                                </a>
                                <div id="accordion-setup-2" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        The minimum amount for deposit is 0.01 BTC.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-setup" href="#accordion-setup-3">
                                    Do you pay interest 7 days in a week?
                                </a>
                                <div id="accordion-setup-3" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Yes, we pay interest everyday.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-setup" href="#accordion-setup-4">
                                    How can I make my first investments?
                                </a>
                                <div id="accordion-setup-4" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        To make investments with us, at first, you should become our registered user. As soon as you are registered, you can always enter into your personal account using your email and password and make your investments.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-setup" href="#accordion-setup-5">
                                    How long does it take for my deposit to be added to my account?
                                </a>
                                <div id="accordion-setup-5" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Deposits will be updated instantly. If you did not see you deposit in your account inform us your problem and we will add it to your account as soon as possible.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-setup" href="#accordion-setup-6">
                                    How many active investments should I have?
                                </a>
                                <div id="accordion-setup-6" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Each member can have an unlimited number of active deposits at one time but each of them will be processed separately.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-setup" href="#accordion-setup-7">
                                    Can I make a deposit directly from my account balance?
                                </a>
                                <div id="accordion-setup-7" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Yes you can make a deposit from your account balance. Log in to your account and click on the "MAKE DEPOSIT" then select "Account balance (payment method)". Note: (your partner will not earn affiliate commission from you this time).
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-setup" href="#accordion-setup-8">
                                    How do you calculate the interest on my deposit?
                                </a>
                                <div id="accordion-setup-8" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        % or your daily earning will be credited to your BTC Invest account balance at the same time when you made deposit in every 24 hours everyday.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="tabs-licensing">
                        <div class="panel-group" id="accordion-licensing">

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-licensing" href="#accordion-licensing-4">
                                    How can I withdraw funds?
                                </a>
                                <div id="accordion-licensing-4" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Log in your account and click on the "Withdraw" button then choose payment system and enter amount.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-licensing" href="#accordion-licensing-5">
                                    How long does it take to receive money after a withdrawal request?
                                </a>
                                <div id="accordion-licensing-5" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        You will receive money almost instant. Maximum time frame is 24 hours.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-licensing" href="#accordion-licensing-6">
                                    Will I be paid on weekends?
                                </a>
                                <div id="accordion-licensing-6" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Yes, withdrawal processed automatically.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-licensing" href="#accordion-licensing-7">
                                    What is minimum amount I can withdraw?
                                </a>
                                <div id="accordion-licensing-7" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        The minimum withdrawal amount is 0.001 BTC.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-licensing" href="#accordion-licensing-8">
                                    What is maximum amount I can withdraw?
                                </a>
                                <div id="accordion-licensing-8" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        There is no maximum amount for withdrawal.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-licensing" href="#accordion-licensing-9">
                                    Are there any fees for withdrawal?
                                </a>
                                <div id="accordion-licensing-9" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        We do not charge any fee for your withdrawals.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="tabs-account">
                        <div class="panel-group" id="accordion-account">
                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-account" href="#accordion-account-1">
                                    What if I can't access my account because I forgot my password?
                                </a>
                                <div id="accordion-account-1" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Click on the <a href="/forgot">Forgot your password?</a> link, type in your email and you'll receive your account information.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-account" href="#accordion-account-2">
                                    What if I can't access my account because my email has been hacked?
                                </a>
                                <div id="accordion-account-2" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        Please contact us for the recovery of your account.
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <a class="panel-title p-y-2 font-size-14 accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion-account" href="#accordion-account-3">
                                    How can I change my email address?
                                </a>
                                <div id="accordion-account-3" class="panel-collapse collapse">
                                    <hr class="m-y-0">
                                    <div class="panel-body">
                                        For security reasons an email address can not be changed by users. You must contact us for more details.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
