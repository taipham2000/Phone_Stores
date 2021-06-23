<%@page import="dto.OrderDetails"%>
<%@page import="dto.Orders"%>
<%@page import="java.util.List"%>
<%@page import="dto.User"%>
<%@page import="dto.Category"%>
<%@page import="java.util.Vector"%>
<%@page import="dto.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Order Customer</title>
         <!-- Bootstrap core CSS -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/shop-homepage.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
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
            .nav-item{
                margin-Left: 70px;
            }
            .link{
                width:280px;
                height: 40px;
                border-radius:10px;
                text-align: left;
                margin-left: 200px;
            }
            .n{
                border-radius:5px;

            }
            .ba{
                margin-top: 25px;
            }
            .nin{
                margin-top: 50px;
                margin-left: 350px;
                border:1px solid black;
                width: 900px;
            }
            
            .head{
                margin-top: 30px;
                margin-left: 350px;
                font-size: 90px;
                
            }
          
        </style> 
    </head>
    <body><!-- Navigation -->
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
                    <header  class="head"><b  style="color:black">Customers' orders</b></header>
                    <table border="1" class="nin">
                        <tr  style="background-color:skyblue">
                            <th>No</th>
                            <th>Order Detail ID</th>
                            <th>Order ID</th>
                            <th>Product ID</th>
                            <th>Price ID</th>
                            <th>Quantity</th>
                           
                        </tr>
                        
                        <c:forEach items="${View}" var="oder" varStatus="counter">
                        
                        <tr>
                            <td>${counter.count}</td>
                            <td>${oder.orderDetailID}</td>
                            <td>${oder.orderID}</td>
                            <td>${oder.productID}</td>
                            <td>${oder.price}</td>
                            <td>${oder.quantity}</td>
                        </tr>
                        </c:forEach>

                    </table>
    </body>
</html>

         <%--
            
            User user = (User) request.getAttribute("user");
            String role = (String) request.getAttribute("role");
        --%>


       <%-- 
    Document   : search.jsp
    Created on : Mar 3, 2021, 8:05:20 PM
    Author     : phamv
--%>
age import="dto.Product"%> 