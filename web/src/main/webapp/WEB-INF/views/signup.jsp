<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Jaldi - Sign Up</title>
    <jsp:include page="common/meta.jsp"/>

    <link href="/resources/main/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/main/css/simple-line-icons.css" rel="stylesheet">

    <!-- Main styles for this application -->
    <link href="/resources/main/css/style.css" rel="stylesheet">

    <link href="/resources/main/css/override.css" rel="stylesheet">

    <script src="/resources/main/js/libs/jquery.min.js"></script>
    <script src="/resources/main/js/libs/tether.min.js"></script>
    <script src="/resources/main/js/libs/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#phone')
            .keydown(function (e) {
                var key = e.which || e.charCode || e.keyCode || 0;
                $phone = $(this);

                // Don't let them remove the starting '('
                if ($phone.val().length === 1 && (key === 8 || key === 46)) {
                    $phone.val('(');
                    return false;
                }
                // Reset if they highlight and type over first char.
                else if ($phone.val().charAt(0) !== '(') {
                    $phone.val('('+String.fromCharCode(e.keyCode)+'');
                }

                // Auto-format- do not expose the mask as the user begins to type
                if (key !== 8 && key !== 9) {
                    if ($phone.val().length === 4) {
                        $phone.val($phone.val() + ')');
                    }
                    if ($phone.val().length === 5) {
                        $phone.val($phone.val() + ' ');
                    }
                    if ($phone.val().length === 10) {
                        $phone.val($phone.val() + '-');
                    }
                }

                // Allow numeric (and tab, backspace, delete) keys only
                return (key == 8 ||
                key == 9 ||
                key == 46 ||
                (key >= 48 && key <= 57) ||
                (key >= 96 && key <= 105));
            })

            .bind('focus click', function () {
                $phone = $(this);

                if ($phone.val().length === 0) {
                    $phone.val('(');
                }
                else {
                    var val = $phone.val();
                    $phone.val('').val(val); // Ensure cursor remains at the end
                }
            })

            .blur(function () {
                $phone = $(this);

                if ($phone.val() === '(') {
                    $phone.val('');
                }
            });
        });
    </script>
</head>
<body class="app flex-row align-items-center">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card mx-2">
                <div class="card-block p-2">
                    <c:if test="${ not empty createdSuccessfully }">
                        <div class="panel-body">
                            <h2 class="m-t-0 text-success">${createdSuccessfully}</h2>
                        </div>
                        <script>
                            $(document).ready(function () {
                                window.setTimeout(function () {
                                    location.href = "/login";
                                }, 3000);
                            });
                        </script>
                    </c:if>
                    <c:if test="${ empty createdSuccessfully }">
                        <form action="/signup" method="post">
                            <h1>Register</h1>
                            <p class="text-muted">Create your Jaldi account</p>
                            <div class="input-group mb-1">
                                    <span class="input-group-addon"><i class="icon-user"></i>
                                    </span>
                                <input type="text" required name="name" value="${user.name}" class="form-control" placeholder="Full Name">
                            </div>

                            <div class="input-group ${not empty emailExist ? 'has-danger' : ''}">
                                <span class="input-group-addon">@</span>
                                <input type="email" required name="email" value="${user.email}" class="form-control" placeholder="Email">


                            </div>
                            <div class="mb-1 has-danger">
                                <c:if test="${ not empty emailExist }">
                                    <div class="error form-control-feedback">${emailExist}</div>
                                </c:if>
                            </div>

                            <div class="input-group mb-1">
                                <span class="input-group-addon"><i class="icon-phone"></i>
                                </span>
                                <input type="text" id="phone" required autocomplete="off" name="phone" value="${user.phone}" maxlength="15" class="form-control" placeholder="Phone (___) ____-____">
                            </div>

                            <div class="input-group">
                                <span class="input-group-addon"><i class="icon-lock"></i>
                                </span>
                                <input type="password" name="password" minlength="8" autocomplete="off" class="form-control" placeholder="Password">
                            </div>
                            <div class="mb-1">
                                <small class="text-muted">Minimum 8 characters</small>
                            </div>

                            <button type="submit" class="btn btn-block btn-success">Create Account</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
