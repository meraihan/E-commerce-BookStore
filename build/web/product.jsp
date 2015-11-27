<%-- 
    Document   : product
    Created on : Nov 1, 2015, 8:44:01 AM
    Author     : Sayed Mahmud Raihan
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.db_Connection"%>
<%@page import="java.sql.Statement"%>
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
                        <h4>Categories</h4>
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
                        <h4>Authors</h4>
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
                <div class="products">
                    <h3>Featured Products</h3>

                    <%
                        String id = request.getParameter("id");
                        if (request.getParameter("id") != null) {
                            response.sendRedirect("viewProducts_.jsp");
                        } else {
                            db_Connection con = new db_Connection();
                            c = con.getConnection();
                            st = c.createStatement();
                            String mySQL = "select b_name,author,image_name,description,price from book inner join images using (b_name) where book.b_name=images.b_name";
                            rs = st.executeQuery(mySQL);

                            while (rs.next()) {

                                String book_name = rs.getString("b_name");

                                String author = rs.getString("author");

                                //String pb_image = rs.getString("pb_images");
                                String images = rs.getString("image_name");
                                String descrip = rs.getString("description");
                                String price = rs.getString("price");

                    %>
                    <ul>
                        <li>
                            <div class="product">
                                <a href="viewProducts_.jsp" class="info">
                                    <span class="holder">

                                        <img class="BigProductBox" alt="<%= book_name%>" src="<%= images%>" />
                                        <span class="book-name"><%= book_name%></span>
                                        <span class="author">by <%= author%></span>
                                        <span class="description"><%= descrip%></span>
                                    </span>
                                </a>
                                <a href="#" class="buy-btn">BUY<span class="price"><span class="low">TK</span><%= price%><span class="high">00</span></span></a>
                            </div>
                        </li>

                    </ul>
                    <%
                        }
                        rs.close();
                        st.close();
                        c.close();
                    %>
                    <%
                        }
                    %>

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