<%-- 
    Document   : index
    Created on : Feb 22, 2023, 9:35:18 AM
    Author     : ovind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <style>
            .divider:after,
            .divider:before {
                content: "";
                flex: 1;
                height: 1px;
                background: #eee;
            }
            .h-custom {
                height: calc(100% - 73px);
            }
            @media (max-width: 450px) {
                .h-custom {
                    height: 100%;
                }
            }
        </style>
        <title>Sign Up | Leave Approval System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <section class="vh-100">
            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-md-9 col-lg-6 col-xl-5">
                        <img src="assets/mobile-login-animate.svg" class="img-fluid" alt="Sample image">
                    </div>
                    <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                        <h2 class="fw-bold">Hello!</h2>
                        <p class="mb-4">Please create a account to continue</p>
                        <form action="RegisterController" method="POST">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <input type="text" class="form-control" name="firstname" placeholder="First Name" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <input type="text" class="form-control" name="lastname" placeholder="Last Name" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="email" class="form-control mb-4" name="email" placeholder="Email Address" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" name="username" placeholder="Username" required>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" name="password" placeholder="Password" required>
                            </div>
                            <button type="submit" class="btn btn-outline-primary btn-block mb-4">Create an Account</button>
                        </form>
                        <%
                            if (request.getParameter("success") != null) {
                                if (Integer.parseInt(request.getParameter("success")) == 1) {
                        %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert" id="close_div">
                            <strong>Congratulations!</strong> You're now part of our community.
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close" id="closeButton">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <%
                        } else {
                        %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert" id="close_div">
                            <strong>Oops!</strong> Something went wrong. Please try again later.
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close" id="closeButton">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <%
                                }
                            }
                        %>

                        <!-- Your other HTML content goes here -->

                        <script>
                            document.getElementById("closeButton").addEventListener("click", function () {
                                document.getElementById("close_div").style.display = "none";
                            });
                        </script>
                            <div class="text-center">
                                <p>Already have an account? <a href="login.jsp">Login</a></p>
                            </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>