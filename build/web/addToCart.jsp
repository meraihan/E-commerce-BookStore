<%-- 
    Document   : addToCart
    Created on : 16 Nov, 2012, 1:42:23 AM
    Author     : chirag
--%>

<%@page import="user.user"%>
<%@page import="cart.cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.db_Connection"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title>Online Book Store</title>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
        <link rel="shortcut icon" href="css/images/favicon.ico" />
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
        <script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="js/jquery.jcarousel.min.js"></script>
        <!--[if IE 6]>
                <script type="text/javascript" src="js/png-fix.js"></script>
        <![endif]-->
        <script type="text/javascript" src="js/functions.js"></script>
    </head>
    <body>
        <jsp:useBean id="cart" scope="session" class="Cart.cart"></jsp:useBean>
        <!-- Header -->
        <div id="header" class="shell">
            <div id="logo"><h1><a href="#">Online Book Store</a></h1><span><a href="#">Get old and new books here</a></span></div>
            <!-- Navigation -->
            <div id="navigation">
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="product.jsp">Products</a></li>
                    <li><a href="postBook.jsp">Post Book</a></li>
                    <li><a href="old_book.jsp">Old Book</a></li>
                    <li><a href="#">About Us</a></li>
                    <li><a href="Contact.jsp">Contacts</a></li>
                </ul>
            </div>
            <!-- End Navigation -->
            <div class="cl">&nbsp;</div>
            <!-- Login-details -->
            <div id="login-details">
                <%
                    if (session.getAttribute("userName") == null) {
                %>
                <p><a href="_joinNow.jsp" id="user">Join Now</a> .</p><p><a href="#" class="cart" ><img src="css/images/cart-icon.png" alt="" /></a>Shopping Cart (0) <a href="#" class="sum">TK:0.00</a></p>
                <%
                } else {
                %>
                <p>Welcome, <a href="#" id="user"><%= session.getAttribute("userName")%><a href="logoutServlet">Logout</a></a> .</p><p><a href="#" class="cart" ><img src="css/images/cart-icon.png" alt="" /></a>Shopping Cart (0) <a href="#" class="sum">TK:0.00</a></p>

                <%
                    }
                %>

            </div>
            <!-- End Login-details -->
        </div>
        <!-- End Header -->
        <!-- Slider -->
        
        <!-- End Slider -->
        <!-- Main -->
        <div id="main" class="shell">
            <!-- Sidebar -->
            <div id="sidebar">
                <ul class="categories">
                    <li>
                        <h4><li><a href="#"><strong>Categories</strong></a></li></h4>
                        <ul>
                            <%
                                Connection c = new db_Connection().getConnection();
                                Statement st = c.createStatement();
                                String getCategory = "SELECT * FROM  `category`  ";

                                ResultSet rs = st.executeQuery(getCategory);
                            %>
                            <div>
                                <ul id="leftsideNav">


                                    <%
                                        while (rs.next()) {
                                            String category = rs.getString("cat_name");
                                    %>
                                    <li><a href="viewProducts_.jsp"><%= category%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </div>
                        </ul>
                    </li>
                    <li>
                        <h4><li><a href="#"><strong>Authors</strong></a></li></h4>
                        <ul>
                            <%
                                c = new db_Connection().getConnection();
                                st = c.createStatement();
                                String getAuthor = "SELECT * FROM  `book`  ";

                                rs = st.executeQuery(getAuthor);
                            %>
                            <div>
                                <ul id="leftsideNav">


                                    <%
                                        while (rs.next()) {
                                            String author = rs.getString("author");
                                    %>
                                    <li><a href="viewProducts_.jsp"><%= author%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </div>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- End Sidebar -->
            <!-- Content -->
            <div id="content">
                <!-- Products -->
               
                
                
                
                <div class="container_16">
            <div class="grid_16" id="whiteBox">
                <div class="grid_8 push_3" >
                    <h1 class="push_2" style="padding:10px 00px">Products In your Cart</h1>

                    <%
                        user User = new user();
                        session.getAttribute("userName");
                        //out.println(session.getAttribute("user"));
                        User = (user) session.getAttribute("userName");
                        if (session.getAttribute("userName") == null) {
                    %>
                    <h3 class="showForm" id="loginBtn" style="padding:10px 00px">Please Login before buying...</h3>

                    <%                } else {
                        //out.println("login by " + User.getUserEmail());

                    %>
                    <h3 class="push_2" >Your Cart contains following...</h3>


                    <%
                        String sid = request.getParameter("id");
                        int id;
                        if (request.getParameter("id") == null) {
                            response.sendRedirect("viewProduct_.jsp");
                        } else {
                            id = Integer.parseInt(sid);

                            boolean b = cart.addProduct(id);

                            if (b == true) {
                                out.println(id + " " + cart.getProductName(id) + " added !! with price of " + cart.getProductPrice(id));
                            } else {
                                out.println("Not added !!");
                            }

                            out.println("<br/>Total value price of the cart " + cart.getTotalPriceOfCart());
                            ArrayList<String> productNames = new ArrayList();
                            ArrayList<Double> productPrices = new ArrayList();
                            ArrayList<Integer> Qty = new ArrayList();
                            ArrayList<Integer> ids = new ArrayList();

                            productNames = cart.getProductNames();
                            productPrices = cart.getPrices();
                            Qty = cart.getQty();
                            ids = cart.getId();
                    %>


                    <div id="CartTable" style="padding:10px 00px" class="grid_11">
                        <div class="grid_5">
                            <h2>Name Of Product</h2> 
                        </div>
                        <div class="grid_2">
                            <h2>Price</h2>
                        </div>
                        <div class="grid_2">
                            <h2>Quantity</h2>
                        </div>

                        <%
                            for (int i = 0; i < productNames.size(); i++) {
                        %>

                        <div class="grid_5">
                            <%=productNames.get(i)%>
                        </div>
                        <div class="grid_2">
                            Rs. <%=productPrices.get(i)%>
                        </div>
                        <div class="grid_1">
                            x<%=Qty.get(i)%>
                        </div>
                        <div class="grid_2">
                            Rs. <%= Qty.get(i) * productPrices.get(i)%>
                        </div>

                        <%
                            }
                            productNames.clear();
                            productPrices.clear();

                        %>
                        <br/>

                        <div class="grid_5">
                            <strong>Total Price of your Cart</strong>
                        </div>

                        <div class="grid_3 push_3">
                            Rs <%= Math.ceil(cart.getTotalPriceOfCart()) %>
                        </div>
                        <div class="clear"></div>

                        <br/>
                        <br/>
                        <a href="buyItems.jsp">
                            <div class="grid_3" id="greenBtn">
                                Buy These Items
                            </div>
                        </a>
                        <a href="viewProducts_.jsp">
                            <div class="grid_3" id="greenBtn">
                                Continue Shopping
                            </div>
                        </a>
                    </div>

                    <br/>
                    <br/>
                    
                    
                    <br/>
                    <%
                            }
                        }
                    %>
                </div>

            </div>
        </div>
                
                
                    <!-- End Products -->
                </div>
                <div class="cl">&nbsp;</div>
                <!-- Best-sellers -->
               
                <!-- End Best-sellers -->
            </div>
            <!-- End Content -->
            <div class="cl">&nbsp;</div>
        </div>
        <!-- End Main -->
        <!-- Footer -->
        <div id="footer" class="shell">
            <div class="top">
                <div class="cnt">
                    <div class="col about">
                        <h4>About BestSellers</h4>
                        <p>Nulla porttitor pretium mattis. Mauris lorem massa, ultricies non mattis bibendum, semper ut erat. Morbi vulputate placerat ligula. Fusce <br />convallis, nisl a pellentesque viverra, ipsum leo sodales sapien, vitae egestas dolor nisl eu tortor. Etiam ut elit vitae nisl tempor tincidunt. Nunc sed elementum est. Phasellus sodales viverra mauris nec dictum. Fusce a leo libero. Cras accumsan enim nec massa semper eu hendrerit nisl faucibus. Sed lectus ligula, consequat eget bibendum eu, consequat nec nisl. In sed consequat elit. Praesent nec iaculis sapien. <br />Curabitur gravida pretium tincidunt.  </p>
                    </div>
                    <div class="col store">
                        <h4>Store</h4>
                        <ul>
                            <li><a href="index.jsp">Home</a></li>
                            <li><a href="product.jsp">Product</a></li>
                            <li><a href="_joinNow.jsp">Log In</a></li>
                            <li><a href="profile.jsp">Account</a></li>
                            <li><a href="old_book.jsp">Old Book</a></li>
                            <li><a href="Contact.jsp">Contact</a></li>
                        </ul>
                    </div>
                    <div class="col" id="newsletter">
                        <h4>Newsletter</h4>
                        <p>Lorem ipsum dolor sit amet  consectetur. </p>
                        <form action="" method="post">
                            <input type="text" class="field" value="Your Name" title="Your Name" />
                            <input type="text" class="field" value="Email" title="Email" />
                            <div class="form-buttons"><input type="submit" value="Submit" class="submit-btn" /></div>
                        </form>
                    </div>
                    <div class="cl">&nbsp;</div>
                    <div class="copy">
                        <p>&copy; <a href="#">BookStore.com</a>. Design by <a href="http://facebook.com/irenpony">Iren Sultana Pony</a></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Footer -->
    </body>
</html>