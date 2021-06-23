<%-- 
    Document   : CustomerOrder
    Created on : Mar 6, 2021, 8:40:41 AM
    Author     : phamv
--%>

<%@page import="dto.User"%>
<%@page import="dto.Category"%>
<%@page import="java.util.Vector"%>
<%@page import="dto.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            .shopper-infor{
                margin-top: 25px;
                margin-left: 50px;
                font-size: 20px;
            }
            .select{
                font-size:13px;
            }
        </style> 
    </head>
    <body>
        <%
            Vector<Product> listProduct = (Vector<Product>) request.getAttribute("listProduct");
            Vector<Category> listCategory = (Vector<Category>) request.getAttribute("listCategory");
            String categoryName = (String) request.getAttribute("categoryName");
            User user = (User) request.getAttribute("user");
            String role = (String) request.getAttribute("role");
        %>


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

                        <% if (user == null && role == null) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="UI_Login.jsp">Login</a>
                        </li>
                        <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link" href="ProductManagement?action=logout">Logout</a>
                        </li>
                        <% } %>
                        <li class="nav-item">
                            <a class="nav-link" href="UI_Login.jsp">&nbsp;</a>
                        </li>
                        <li class="nav-item">
                            <i class="fa fa-user" style="font-size:40px;color:white"></i>
                        </li>
                        <% if (user != null && role != null) {%>
                        <li class="nav-item">
                            <p class="nav-link"><%=user.getUserName()%> (<%=role%>)<p>
                        </li>
                        <% }%>
                    </ul>
                </div>
            </div>
        </nav>
    <session>
        <table class="cachtop" cellpadding="0" cellspacing="0" border="1" align="center" width="75%">
            <h1 style="color:green">${requestScope.SUCCESS}<h1>
                    <h1 style="color:green">${requestScope.ERROR}<h1>
                            <tr>
                                <%--th>Product ID </th--%>
                                <th>Name </th>
                                <th>Image URL </th>
                                <th>Price </th>
                                <th>Quantity </th>                               
                                <th colspan="2">Total </th>
                                <th></th>
                            </tr>

                            <tr>

                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>

                            <tr>
                                <td colspan="4" align="right"> <b>Total    :<b/></td>
                                <td colspan="2"></td>

                            </tr>
                            </table>




                            </session>   
                            </body>
                            </html>
