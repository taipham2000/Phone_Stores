
<%@page import="java.text.NumberFormat"%>
<%@page import="dto.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.User"%>
<%@page import="dto.Category"%>
<%@page import="java.util.Vector"%>
<%@page import="dto.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add to Cart</title>
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
            }
            .n{
                border-radius:5px;

            }
            .button_order{
                font-size:28px;
                opacity: 0.7;
                margin-left: 1230px;
                margin-top: 30px;
                border-radius: 5px;
            }
            .cachtop{
                margin-top: 50px;
            }
        </style> 
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
                        <c:if test="${user==null && role==null}">
                            <li class="nav-item">
                                <a class="nav-link" href="UI_Login.jsp">Login</a>
                            </li></c:if>
                        <c:if test="${user!=null || role!=null}">
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

                        <c:if test="${user!=null && role!=null}">
                            <li class="nav-item">
                                <p class="nav-link">${user.userName} (${role})<p>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
    <session>
        <table class="cachtop" cellpadding="0" cellspacing="0" border="1" align="center" width="75%">
            <tr>
                <%--th>Product ID </th--%>
                <th>Name </th>
                <th>Image URL </th>
                <th>Price </th>
                <th>Quantity </th>                               
                <th colspan="2">Total </th>
                <th></th>
            </tr>

            <c:set var = "total2" scope = "session" value = "${0}"/>

            <c:forEach items="${cart}" var="d">
                <c:set var="total" value="0"/>
                <tr>
                    <%--td>${d.sanpham.productID}</td--%>
                    <td>${d.sanpham.productName}</td>
                    <td><img src="images/${d.sanpham.imageUrl}" width="100"</td>
                        <fmt:parseNumber var = "i" type = "number" value = "${d.sanpham.price/10}" />
                    <td>${i}</td>

                    <td class="cart_quantity">
                        <div class="cart_quantity_button">

                            <input class="cart_quantity_input" type="number" value="${d.quantities}" autocomplete="off" size="2"/>

                        </div>
                    </td>
                    <c:choose>

                        <c:when test = "${d.quantities==0}">
                            <td>your cart is empty!</td>
                        </c:when>

                        <c:when test = "${(d.sanpham.price*d.quantities)!=0}">
                            <fmt:parseNumber var = "i" type = "number" value = "${(d.sanpham.price*d.quantities)/100}" />
                            <td >${i}0</td> <!-- comment -->

                            <c:set var = "total2" scope = "session" value = "${total2+i}"/>
                            <c:set var="totalUnitPrice" value="${d.sanpham.price*d.quantities}"/>

                            <c:set var="totalPrice" value="${totalPrice + totalUnitPrice}"/>
                        </c:when>

                        <c:otherwise>
                            <td>your cart is empty!</td>
                        </c:otherwise>
                    </c:choose>


                    <td align="center">
                        <a href="CartServlet?action=remove&productID=${d.sanpham.productID}"
                           class="card_button" onclick="return confirm('Are you sure product?')">Remove</a>
                    <td>
                </tr>

            </c:forEach>
            <tr>
                <td colspan="4" align="right"> <b>Total    :<b/></td>
                <td colspan="2">${total2}0</td>

            </tr>
            <c:if test ="${empty(cart)}">
                <td style="color:red"><b>Your cart is empty!</b></td>
            </c:if>

        </table>

        <a  href="OrderController?action=checkout&totalPrice=${totalPrice}"
            class="button_order" >CheckOut</a>




    </session>
</body>
</html>
