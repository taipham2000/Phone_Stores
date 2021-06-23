
<%@page import="dto.Category"%>
<%@page import="java.util.Vector"%>
<%@page import="dto.User"%>
<%@page import="dto.Product"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Shop Điện Thoại</title>

        <!-- Bootstrap core CSS -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/shop-homepage.css" rel="stylesheet">
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        
        <style>
            div.ex1 {
                width: 100%;
                margin: auto;
            }
            
            .card_button {
            border: none;
            outline: 0;
            padding: 12px;
            color: white;
            background-color: #00BFFF;
            text-align: center;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
            }

            .card_button:hover {
                opacity: 0.7;
            }
            
            .card_button2 {
            border: none;
            outline: 0;
            padding: 12px;
            color: white;
            background-color: #00BFFF;
            text-align: center;
            cursor: pointer;
            width: 180px;
            font-size: 18px;
            }

            .card_button2:hover {
                opacity: 0.7;
            }
        </style>
        
        <script>
            function isInt(value) {
                return !isNaN(value) &&
                        parseInt(Number(value)) == value &&
                        !isNaN(parseInt(value, 10));
            }
            
            function validateForm() {
                document.getElementById("productIDError").innerHTML = "";
                document.getElementById("productNameError").innerHTML = "";
                document.getElementById("priceError").innerHTML = "";
                document.getElementById("quantityError").innerHTML = "";
                document.getElementById("shortDescriptionError").innerHTML = "";
                document.getElementById("descriptionError").innerHTML = "";
                document.getElementById("categoryIDError").innerHTML = "";
                
                var productID = document.forms["f1"]["productID"].value;
                if (productID.trim().length == 0) {
                    document.getElementById("productIDError").innerHTML = "Product ID phải được nhập!";
                    return false;
                }
                if (productID.trim().length > 50) {
                    document.getElementById("productIDError").innerHTML = "Product ID phải bé hơn 50 kí tự!!";
                    return false;
                }

                var productName = document.forms["f1"]["productName"].value;
                if (productName.trim().length == 0) {
                    document.getElementById("productNameError").innerHTML = "Product name phải được nhập!";
                    return false;
                }
                if (productName.trim().length > 100) {
                    document.getElementById("productNameError").innerHTML = "Product name phải bé hơn 100 kí tự!!";
                    return false;
                }

                var price = document.forms["f1"]["price"].value;
                if (isInt(price) == false) {
                    document.getElementById("priceError").innerHTML = "Price phải là số!!";
                    return false;
                }
                if (price < 0 || price > 100000000) {
                    document.getElementById("priceError").innerHTML = "Price phải là số lớn hơn bằng 0 và bé hơn 100000000!!";
                    return false;
                }
                
                var quantity = document.forms["f1"]["quantity"].value;
                if (isInt(quantity) == false) {
                    document.getElementById("quantityError").innerHTML = "Quantity phải là số!!";
                    return false;
                }
                if (quantity < 0 || quantity > 100000000) {
                    document.getElementById("quantityError").innerHTML = "Quantity phải là số lớn hơn bằng 0 và bé hơn 100000000!!";
                    return false;
                }
                
                var shortDescription = document.forms["f1"]["shortDescription"].value;
                if (shortDescription.trim().length > 500) {
                    document.getElementById("shortDescriptionError").innerHTML = "Short description phải bé hơn 500 kí tự!!";
                    return false;
                }
                
                var description = document.forms["f1"]["description"].value;
                if (description.trim().length > 100000) {
                    document.getElementById("descriptionError").innerHTML = "Product description phải bé hơn 100000 kí tự!!";
                    return false;
                }

                var categoryID = document.forms["f1"]["categoryID"].value;
                if (categoryID == "0") {
                    document.getElementById("categoryIDError").innerHTML = "Category name phải được chọn!!";
                    return false;
                }
            }
        </script>
    </head>

    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="ProductManagement">Shop Điện Thoại VTT</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="ProductManagement">Home
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Services</a>
                        </li>
                        <c:if test="${requestScope.user==null && requestScope.role==null}">
                            <li class="nav-item">
                                <a class="nav-link" href="UI_Login.jsp">Login</a>
                            </li>
                        </c:if>
                        <c:if test="${requestScope.user!=null || requestScope.role!=null}">
                            <li class="nav-item">
                                <a class="nav-link" href="ProductManagement?action=logout">Logout</a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="UI_Login.jsp">&nbsp;</a>
                        </li>
                        <li class="nav-item">
                            <i class="fa fa-user" style="font-size:40px;color:white"></i>
                        </li>
                        <c:if test="${requestScope.user!=null || requestScope.role!=null}">
                            <li class="nav-item">
                                <p class="nav-link">${requestScope.user.userName} (${requestScope.role})<p>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Page Content -->
        <div class="container">

            <div class="row">
                                
                <div class="ex1">  
                    <center>
                        <br><br>
                        <form action="ProductManagement" method="post" name="f1" onsubmit="return validateForm()" enctype="multipart/form-data">
                            <input type="hidden" name ="action" value="insert">

                            <table width="60%" border="0px solid">
                            <tr>  
                                <td>
                                    <c:if test="${requestScope.error!=null}">
                                        <i style="color:red;">Error: ${requestScope.error}</i>
                                    </c:if>
                                </td>
                            </tr>
                                
                            <tr> 
                                <td>Product ID:</td>
                                <td><input type="text" name="productID" value="${requestScope.product.productID}" required/><i id="productIDError" style="color:red;"></i></td>
                            </tr>
                            <tr>
                                <td>Product name:</td>
                                <td><input type="text" name="productName" value="${requestScope.product.productName}" required/><i id="productNameError" style="color:red;"></i></td>
                            </tr>
                            <tr>
                                <td>Image:</td>
                                <td><input type="file" name="photo" accept="images/*" required/></td>
                            </tr>
                            <tr>
                                <td>Price:</td>
                                <td><input type="text" name="price" value="${requestScope.product.price}" required/><i id="priceError" style="color:red;"></i></td>
                            </tr> 
                            <tr>
                                <td>Quantity:</td>
                                <td><input type="text" name="quantity" value="${requestScope.product.quantity}" required/><i id="quantityError" style="color:red;"></i></td>
                            </tr> 
                            <tr>
                                <td>Short description:</td>
                                <td><textarea name="shortDescription" rows="4" cols="40">${requestScope.product.shortDescription}</textarea><i id="shortDescriptionError" style="color:red;"></i></td>
                            </tr>
                            <tr>
                                <td>Product description:</td>
                                <td><textarea name="description" rows="10" cols="60">${requestScope.product.productDescription}</textarea><i id="descriptionError" style="color:red;"></i></td>
                            </tr>
                            <tr>
                                <td>Image description:</td>
                                <td><input type="file" name="photos" multiple="multiple"/></td>
                            </tr>
                            <tr>
                                <td>Category name:</td>
                                <td>
                                    <select name="categoryID">
                                    <option value="0">- Select supplier -</option>
                                    <c:forEach items="${requestScope.listCategory}" var="category">
                                        <c:if test="${category.categoryID eq requestScope.product.categoryID}">
                                            <option value="${category.categoryID}" selected>${category.categoryName}</option>
                                        </c:if>
                                        <c:if test="${category.categoryID ne requestScope.product.categoryID}">
                                            <option value="${category.categoryID}">${category.categoryName}</option>
                                        </c:if>
                                    </c:forEach>
                                    </select>
                                    <i id="categoryIDError" style="color:red;"></i>
                                </td>
                            </tr>
                            <tr> 
                                <td colspan="2" align="center"> 
                                <input type="submit" name="s1" value="Create"/>
                                <input type="reset" name="s2" value="Reset"/>
                            </td> 
                            </tr>
                            </table>
                        </form>
                    </center>
                </div>                     
                
            </div>
            <!-- /.row -->

        </div>
        <!-- /.container -->
        
        <h1><br></h1>

        <!-- Footer -->
        <footer class="py-5 bg-dark">
            <div class="container">
                <p class="m-0 text-center text-white">Copyright &copy; Shop Điện Thoại VTT 2021</p>
            </div>
            <!-- /.container -->
        </footer>

        <!-- Bootstrap core JavaScript -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    </body>

</html>

