<%@page import="dto.User"%>
<%@page import="dto.Category"%>
<%@page import="java.util.Vector"%>
<%@page import="dto.Product"%>
<%@page import="java.text.DecimalFormat"%>

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
        
        <style>
            div.ex1 {
                width: 90%;
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
    </head>

    <body> 

        <%
            Product product = (Product) request.getAttribute("product");
            Vector<Category> listCategory = (Vector<Category>) request.getAttribute("listCategory");
            String description = (String) request.getAttribute("description");
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
                        <c:choose>
                            <c:when test="${role==null || role eq 'user'}">
                                <li class="nav-item">
                                <a class="nav-link" href="CartServlet">Cart</a>
                            </li>
                            </c:when>                            
                            <c:otherwise>
                                 <li class="nav-item">
                                <a class="nav-link" href="ProductManagement?action=ViewOrder">View Order</a>
                            </li>
                            </c:otherwise>
                        </c:choose>
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

                <div class="col-lg-3">

                    <h3 class="my-4">${requestScope.product.productName}</h3>
                    <div class="list-group">
                        <c:if test="${requestScope.role!=null && role eq 'admin'}">
                            <p><button class="card_button" onclick="location.href='ProductManagement?action=addFormProduct'">Add a new phone</button></p>
                        </c:if>
                        <a href="ProductManagement" class="list-group-item">Smart Phone</a>
                        <c:forEach items="${requestScope.listCategory}" var="category">
                            <a href="ProductManagement?action=showCategory&categoryID=${category.categoryID}" class="list-group-item">${category.categoryName}</a>
                        </c:forEach>
                    </div>

                </div>
                    
                <div class="col-lg-9">
                    <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
                        <table>
                            <tr>
                                <td><h2>&nbsp; &nbsp; &nbsp; &nbsp;<h2></td>
                                <td><a href="ProductManagement?action=showDescription&productID=${requestScope.product.productID}"><img class="d-block img-fluid" src="images/${requestScope.product.imageUrl}" width="300px" height="auto"></td>
                                <td>
                                    <a style="font-size:25px" href="ProductManagement?action=showDescription&productID=${requestScope.product.productID}">${requestScope.product.productName}</a>
                                <h4><%=formatPrice((long) product.getPrice())%>đ</h4><br>
                                <%  String s = product.getShortDescription();
                                    String[] s1 = s.split("\\.");
                                    for (int j = 0; j < s1.length; j++) {
                                %>
                                <li class="card-text"><%=s1[j]%></li>
                                <% } %>
                                <br>
                                <% if(role==null || role.equals("user")) { %>
                                <p><a class="card_button" href="CartServlet?action=buy&productID=${requestScope.product.productID}">Add to Cart</a></p>
                                  
                                <% } else {%>
                                    <p>
                                        <button class="card_button2" onclick="location.href='ProductManagement?action=editFormProduct&productID=<%=product.getProductID()%>'">Edit</button>
                                        <button class="card_button2">Delete</button>
                                    </p>
                                <% } %>
                                </td>
                            </tr>
                        </table>
                                
                        <div class="ex1">  
                            <%  s = description;
                                s1 = s.split("_");
                                for (int i = 1; i < s1.length; i++) {
                                String s2 = s1[i];
                                String option = s2.substring(0, 5);
                                String content = s2.substring(5);
                                if (option.equals("tit: ")) {%>
                                    <h1><br></h1>
                                    <h3><%=content%></h3> 
                                <%  } else if (option.equals("txt: ")) {%>
                                    <p><%=content%></p> 
                                <%  } else if (option.equals("img: ")) {%> 
                                    <img src="images/<%=product.getProductID()%>/<%=content%>" width="100%"></td> 
                                <%  } %>
                            <%  }%>
                        </div>         
                    </div>
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

        <%!
            private String formatPrice(long price) {
                DecimalFormat formatter = new DecimalFormat("###,###,###");
                String priceVND = formatter.format(price);
                return priceVND;
            }
        %>

    </body>

</html>
