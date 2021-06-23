<%-- 
    Document   : search.jsp
    Created on : Mar 3, 2021, 8:05:20 PM
    Author     : phamv
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
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
        <title>Search SmartPhone</title>
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
                margin-left:200px;
            }
            .n{
                border-radius:5px;

            }
            .ba{
                margin-top: 25px;
            }
            .row{
                margin-top: 50px;
            }
            .kichthuoc{
                width: 800px;
                height: 150px;
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
                            <a class="nav-link" href="CartServlet">Cart</a>
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
           </nav><form action="ProductManagement" class="ba">
           <input type="text" name="search" class="link" placeholder="Tìm kiếm sản phẩm..." />
           <input type="submit" name="action"  value="search"><br/>
           </form>
           
                <%
             List<Product> search=(List<Product>)request.getAttribute("List_Search");
            if(search!=null){
             %>
          
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
                                                            <%
                                                                for (Product p : search) {
                                                            %>
                                                            
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
                                                                    <% if (role == null || role.equals("user")) { %>
                                                                  
                                                                    <a class="card_button" href="CartServlet?action=buy&productID=<%=p.getProductID()%>">Add to cart</a>
                                                                    <%}
                                                                         else {%>
                                                                    <p><button class="card_button">Edit</button></p>
                                                                    <p><button class="card_button">Delete</button></p>
                                                                    <% } %>
                                                                </div>
                                                            </div>
                                                                
                                                            <%
                                                                }
                                                            %>
                                                            
                                                        </div>
             </div>
                                                            
             <%}%>
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
