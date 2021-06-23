<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register a New Account</title>
        
        <!-- Bootstrap core CSS -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/shop-homepage.css" rel="stylesheet">

        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <style>
         body {
                margin: 0;
                padding: 0;
                height: 100vh;
            }
            #login .container #login-row #login-column #login-box {
                margin-top: 120px;
                max-width: 600px;
                height: 550px;
                border: 1px solid #9C9C9C;
                background-color: #EAEAEA;
            }
            #login .container #login-row #login-column #login-box #login-form {
                padding: 20px;
            }
            #login .container #login-row #login-column #login-box #login-form #register-link {
                margin-top: -85px;
            }
            footer {
                position:absolute;
                bottom:0;
                width:100%;
                height:60px;   /* Height of the footer */
                background:#6cf;
            }
            </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="ProductManagement">Shop Điện Thoại VTT</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="ProductManagement">Home</a>
                        </li>
                        
                        <li class="nav-item active">
                            <a class="nav-link" href="UI_Login.jsp">Login
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <div id="login">
            <div class="container">
                <div id="login-row" class="row justify-content-center align-items-center">
                    <div id="login-column" class="col-md-6">
                        <div id="login-box" class="col-md-12">
                            <form id="login-form" class="form" action="CreateAccountServlet" method="POST">
                               
                                
                                <h3 class="text-center text-info">Register Account</h3>
                                
                                <div class="form-group">
                                    <label for="username" class="text-info">Username:</label><br>
                                    
                                        <input type="text" name="userName" value="" id="username" class="form-control" required>
                                        <font color="red"> ${requestScope.INVALID.userError}</font>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="text-info">Password:</label><br>
                                    
                                        <input type="password" name="password" value="" id="password" class="form-control" required>
                                        <font color="red"> ${requestScope.INVALID.passwordError}</font>
                                </div>
                                
                                <div class="form-group">
                                    <label for="address" class="text-info">Address:</label><br>
                                    
                                        <input type="text" name="address" value="" id="address" class="form-control" required>

                                </div>
                                <div class="form-group">
                                    <label for="phone" class="text-info">Phone:</label><br>
                                    
                                        <input type="text" name="phone" value="" id="phone" class="form-control" required>
                                        <font color="red"> ${requestScope.INVALID.phone}</font>
                                </div>
                                <div class="form-group">
                                  
                                    <input type="submit" name="action" class="btn btn-info btn-md" value="Register">
                                    
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
