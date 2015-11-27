<%-- 
    Document   : profile
    Created on : Nov 1, 2015, 9:47:51 AM
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
                <p><a href="_joinNow.jsp" id="user">Join Now</a> .</p><p><a href="#" class="cart" ><img src="css/images/cart-icon.png" alt="" /></a>Shopping Cart (0) <a href="#" class="sum">$0.00</a></p>
                <%
                } else {
                %>
                <p>Welcome, <a href="#" id="user"><%= session.getAttribute("userName")%><a href="logoutServlet">Logout</a></a> .</p><p><a href="#" class="cart" ><img src="css/images/cart-icon.png" alt="" /></a>Shopping Cart (0) <a href="#" class="sum">$0.00</a></p>

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
                                    <li><a href="#"><strong>Categories</strong></a></li>

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
                                    <li><a href="#"><strong>Categories</strong></a></li>

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
                    <ul>
                        <li>
                            <div class="product">
                                <a href="#" class="info">
                                    <span class="holder">
                                        <img src="css/images/image01.jpg" alt="" />
                                        <span class="book-name">Book Name</span>
                                        <span class="author">by John Smith</span>
                                        <span class="description">Maecenas vehicula ante eu enim pharetra<br />scelerisque dignissim <br />sollicitudin nisi</span>
                                    </span>
                                </a>
                                <a href="#" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>22<span class="high">00</span></span></a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#" class="info">
                                    <span class="holder">
                                        <img src="css/images/image02.jpg" alt="" />
                                        <span class="book-name">Book Name</span>
                                        <span class="author">by John Smith</span>
                                        <span class="description">Maecenas vehicula ante eu enim pharetra<br />scelerisque dignissim <br />sollicitudin nisi</span>
                                    </span>
                                </a>
                                <a href="#" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>22<span class="high">00</span></span></a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#" class="info">
                                    <span class="holder">
                                        <img src="css/images/image03.jpg" alt="" />
                                        <span class="book-name">Book Name</span>
                                        <span class="author">by John Smith</span>
                                        <span class="description">Maecenas vehicula ante eu enim pharetra<br />scelerisque dignissim <br />sollicitudin nisi</span>
                                    </span>
                                </a>
                                <a href="#" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>22<span class="high">00</span></span></a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#" class="info">
                                    <span class="holder">
                                        <img src="css/images/image04.jpg" alt="" />
                                        <span class="book-name">Book Name</span>
                                        <span class="author">by John Smith</span>
                                        <span class="description">Maecenas vehicula ante eu enim pharetra<br />scelerisque dignissim <br />sollicitudin nisi</span>
                                    </span>
                                </a>
                                <a href="#" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>22<span class="high">00</span></span></a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#" class="info">
                                    <span class="holder">
                                        <img src="css/images/image05.jpg" alt="" />
                                        <span class="book-name">Book Name</span>
                                        <span class="author">by John Smith</span>
                                        <span class="description">Maecenas vehicula ante eu enim pharetra<br />scelerisque dignissim <br />sollicitudin nisi</span>
                                    </span>
                                </a>
                                <a href="#" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>22<span class="high">00</span></span></a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#" class="info">
                                    <span class="holder">
                                        <img src="css/images/image06.jpg" alt="" />
                                        <span class="book-name">Book Name</span>
                                        <span class="author">by John Smith</span>
                                        <span class="description">Maecenas vehicula ante eu enim pharetra<br />scelerisque dignissim <br />sollicitudin nisi</span>
                                    </span>
                                </a>
                                <a href="#" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>22<span class="high">00</span></span></a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#" class="info">
                                    <span class="holder">
                                        <img src="css/images/image07.jpg" alt="" />
                                        <span class="book-name">Book Name</span>
                                        <span class="author">by John Smith</span>
                                        <span class="description">Maecenas vehicula ante eu enim pharetra<br />scelerisque dignissim <br />sollicitudin nisi</span>
                                    </span>
                                </a>
                                <a href="#" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>22<span class="high">00</span></span></a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#" class="info">
                                    <span class="holder">
                                        <img src="css/images/image08.jpg" alt="" />
                                        <span class="book-name">Book Name</span>
                                        <span class="author">by John Smith</span>
                                        <span class="description">Maecenas vehicula ante eu enim pharetra<br />scelerisque dignissim <br />sollicitudin nisi</span>
                                    </span>
                                </a>
                                <a href="#" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>22<span class="high">00</span></span></a>
                            </div>
                        </li>
                    </ul>
                    <!-- End Products -->
                </div>
                <div class="cl">&nbsp;</div>
                <!-- Best-sellers -->
                <div id="best-sellers">
                    <h3>Best Sellers</h3>
                    <ul>
                        <li>
                            <div class="product">
                                <a href="#">
                                    <img src="css/images/image-best01.jpg" alt="" />
                                    <span class="book-name">Book Name </span>
                                    <span class="author">by John Smith</span>
                                    <span class="price"><span class="low">$</span>35<span class="high">00</span></span>
                                </a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#">
                                    <img src="css/images/image-best02.jpg" alt="" />
                                    <span class="book-name">Book Name </span>
                                    <span class="author">by John Smith</span>
                                    <span class="price"><span class="low">$</span>45<span class="high">00</span></span>
                                </a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#">
                                    <img src="css/images/image-best03.jpg" alt="" />
                                    <span class="book-name">Book Name </span>
                                    <span class="author">by John Smith</span>
                                    <span class="price"><span class="low">$</span>15<span class="high">00</span></span>
                                </a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#">
                                    <img src="css/images/image-best04.jpg" alt="" />
                                    <span class="book-name">Book Name </span>
                                    <span class="author">by John Smith</span>
                                    <span class="price"><span class="low">$</span>27<span class="high">99</span></span>
                                </a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#">
                                    <img src="css/images/image-best01.jpg" alt="" />
                                    <span class="book-name">Book Name </span>
                                    <span class="author">by John Smith</span>
                                    <span class="price"><span class="low">$</span>35<span class="high">00</span></span>
                                </a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#">
                                    <img src="css/images/image-best02.jpg" alt="" />
                                    <span class="book-name">Book Name </span>
                                    <span class="author">by John Smith</span>
                                    <span class="price"><span class="low">$</span>45<span class="high">00</span></span>
                                </a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#">
                                    <img src="css/images/image-best03.jpg" alt="" />
                                    <span class="book-name">Book Name </span>
                                    <span class="author">by John Smith</span>
                                    <span class="price"><span class="low">$</span>15<span class="high">00</span></span>
                                </a>
                            </div>
                        </li>
                        <li>
                            <div class="product">
                                <a href="#">
                                    <img src="css/images/image-best04.jpg" alt="" />
                                    <span class="book-name">Book Name </span>
                                    <span class="author">by John Smith</span>
                                    <span class="price"><span class="low">$</span>27<span class="high">99</span></span>
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
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