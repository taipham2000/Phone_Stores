<%@page import="dto.User"%>
<%@page import="dto.Category"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Vector"%>
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
            .link{
                width:280px;
                height: 40px;
                border-radius:10px;
                text-align: left;
                margin-left:200px;
            }
            .card_button2:hover {
                opacity: 0.7;
            }
            .ba{
                margin-top: 25px;
            }
        </style> 

        <script>
            function myFunction(productID, productName) {
                var result = confirm("Bạn có muốn xóa điện thoại " + productName + " này không?");
                if (result == true) {
                    window.location.replace("ProductManagement?action=delete&productID=" + productID);
                }
            }
        </script>
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
        <form action="ProductManagement" class="ba">
            <input type="text" name="search" class="link" placeholder="Tìm kiếm sản phẩm..." />
            <input type="submit" name ="action" value="search">
           
            
        </form>
        <div class="container">

            <div class="row">

                <div class="col-lg-3">

                    <h1 class="my-4">${requestScope.categoryName}</h1>
                    <div class="list-group">
                        <c:if test="${requestScope.role!=null && role eq 'admin'}">
                            <p><button class="card_button" onclick="location.href = 'ProductManagement?action=addFormProduct'">Add a new phone</button></p>
                        </c:if>
                        <a href="ProductManagement" class="list-group-item">Smart Phone</a>
                        <c:forEach items="${requestScope.listCategory}" var="category">
                            <a href="ProductManagement?action=showCategory&categoryID=${category.categoryID}" class="list-group-item">${category.categoryName}</a>
                        </c:forEach>
                    </div>

                </div>
                <!-- /.col-lg-3 -->

                <div class="col-lg-9">

                    <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
                        <div class="carousel-inner" role="listbox">
                            <% for (int i = 0; i < listProduct.size(); i++) {
                                    if (i == 0) { %>
                            <div class="carousel-item active">
                                <% } else { %> 
                                <div class="carousel-item">
                                    <% }%> 
                                    <table>
                                        <tr>
                                            <td><h2>&nbsp; &nbsp; &nbsp; &nbsp;<h2></td>
                                                        <td><a href="ProductManagement?action=showDescription&productID=<%=listProduct.get(i).getProductID()%>"><img class="d-block img-fluid" src="images/<%=listProduct.get(i).getImageUrl()%>" width="300px" height="auto"></td>
                                                                <td>
                                                                    <a style="font-size:25px" href="ProductManagement?action=showDescription&productID=<%=listProduct.get(i).getProductID()%>"><%=listProduct.get(i).getProductName()%></a>
                                                                    <h4><%=formatPrice((long) listProduct.get(i).getPrice())%>đ</h4><br>
                                                                    <%  String s = listProduct.get(i).getShortDescription();
                                                                        String[] s1 = s.split("\\.");
                                                                        for (int j = 0; j < s1.length; j++) {%>
                                                                <li class="card-text"><%=s1[j]%></li>
                                                                    <% } %>
                                                                <br>
                                                               <%-- <% if (role == null || role.equals("user")) {%>
                                                                <p><a class="card_button" href="CartServlet?action=buy&productID=<%=listProduct.get(i).getProductID()%>">Add to Cart</a></p>
                                                                <% } else {%>
                                                                <p>
                                                                    <button class="card_button2" onclick="location.href = 'ProductManagement?action=editFormProduct&productID=<%=listProduct.get(i).getProductID()%>'">Edit</button>
                                                                    <button class="card_button2" onclick="myFunction('<%=listProduct.get(i).getProductID()%>', '<%=listProduct.get(i).getProductName()%>');">Delete</button>
                                                                </p>
                                                                <% } %>
                                                                --%>
                                                                <c:choose>
                                        <c:when test="${sessionScope.user.roleID eq 1}">
                                            <p>
                                                                    <button class="card_button2" onclick="location.href = 'ProductManagement?action=editFormProduct&productID=<%=listProduct.get(i).getProductID()%>'">Edit</button>
                                                                    <button class="card_button2" onclick="myFunction('<%=listProduct.get(i).getProductID()%>', '<%=listProduct.get(i).getProductName()%>');">Delete</button>
                                                                </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p><a class="card_button" href="CartServlet?action=buy&productID=<%=listProduct.get(i).getProductID()%>">Add to Cart</a></p>
                                                                
                                        </c:otherwise>
                                    </c:choose>
                                                        </td>
                                                        </tr>
                                                        </table>
                                                        </div>
                                                        <% } %>
                                                        </div>
                                                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                                                            <span class="carousel-control-prev-icon" aria-hidden="true" style="background-color:rgb(30,144,255);"></span>
                                                            <span class="sr-only">Previous</span>
                                                        </a>
                                                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                                                            <span class="carousel-control-next-icon" aria-hidden="true" style="background-color:rgb(30,144,255);"></span>
                                                            <span class="sr-only">Next</span>
                                                        </a>
                                                        </div>

                                                        <div class="row">

                                                            <% for (Product p : listProduct) {%>

                                                            <div class="col-lg-4 col-md-6 mb-4">
                                                                <div class="card h-100">
                                                                    <a href="ProductManagement?action=showDescription&productID=<%=p.getProductID()%>"><img class="card-img-top" src="images/<%=p.getImageUrl()%>" alt=""></a>
                                                                    <div class="card-body">
                                                                        <h4 class="card-title">
                                                                            <a href="ProductManagement?action=showDescription&productID=<%=p.getProductID()%>"><%=p.getProductName()%></a>
                                                                        </h4>
                                                                        <h5><%=formatPrice((long) p.getPrice())%>đ</h5>

                                                                        <%  String s = p.getShortDescription();
                                                                            String[] s1 = s.split("\\.");
                                                                            for (int i = 0; i < s1.length; i++) {
                                                                        %>
                                                                        <li class="card-text"><%=s1[i]%></li>
                                                                            <% } %>

                                                                    </div>
                                                                    <% if (role == null || role.equals("user")) {%>
                                                                    <a class="card_button" href="CartServlet?action=buy&productID=<%=p.getProductID()%>">Add to cart</a>
                                                                    <% } else {%>
                                                                    <p><button class="card_button" onclick="location.href = 'ProductManagement?action=editFormProduct&productID=<%=p.getProductID()%>'">Edit</button></p>
                                                                    <p><button class="card_button" onclick="myFunction('<%=p.getProductID()%>', '<%=p.getProductName()%>');">Delete</button></p>
                                                                    <% } %>
                                                                </div>
                                                            </div>

                                                            <%
                                                                }
                                                            %>

                                                        </div>
                                                        <!-- /.row -->

                                                        </div>
                                                        <!-- /.col-lg-9 -->

                                                        </div>
                                                        <!-- /.row -->

                                                        </div>
                                                        <!-- /.container -->

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

