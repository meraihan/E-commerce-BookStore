
<%@page import="product.product"%>
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
                <div class="container_16">
                    <div id = "contents">
                        <!-- LeftSide -->
                        <%
                            /*
                             *       FILTERING OF PRODUCTS AS OF FOLLOWS
                             * 1) Retrieve Category 
                             *      if Category set 
                             *      Show 
                             *          SubCategory
                             *          Company
                             *          Pricing
                             *              SQL select * from products WHERE category = 'cat';
                             *      2) Retrieve Sub Category 
                             if SubCategory is set
                             *                  Shw
                             *                  Company  
                             *                  Pricing
                             *                  SQL select * from products WHERE subcategory = 'scat';
                             *     else  Show 
                             *          SubCategory
                             *          Company
                             *          Pricing
                             *      else 
                             *          Show
                             *          Category 
                             *          Pricing
                             *              SQL select * from products;
                             * 
                             * Accordingly set the SQL Statement 
                             */
                        %>

                        <div id="leftside" class="grid_3">

                            <%  String category, subcategory;
                                product pro = new product();
                                StringBuffer sql = new StringBuffer();
                                sql.append("SELECT * FROM  book INNER JOIN  images where book.b_name=images.b_name ");

                                category = "";
                                subcategory = "";
                                if (session.getAttribute("cat") != null) {
                                    category = (String) session.getAttribute("cat");
                                    ArrayList subCat = pro.getSubcategory(category);

                            %>
                            <div>
                                <ul id="leftsideNav">
                                    <li><a href="#"><strong>Sub-Categories</strong></a></li>
                                        <%                                for (int i = 0; i < subCat.size(); i++) {
                                        %>
                                    <li><a href="addProductFilters.jsp?scat=<%= subCat.get(i)%>"><%= subCat.get(i)%></a></li>      
                                        <%
                                            }
                                            subCat.clear(); %>
                                </ul>
                            </div>

                            <%
                                if (session.getAttribute("scat") != null) {
                                    subcategory = (String) session.getAttribute("scat");

                                }
                            } else {
                                //Show Category
                                ArrayList Cat = pro.getCategory();
                            %>
                            <div>
                                <ul id="leftsideNav">
                                    <li><a href="#"><strong>Categories</strong></a></li>
                                        <%
                                            for (int i = 0; i < Cat.size(); i++) {
                                        %>
                                    <li><a href="addProductFilters.jsp?cat=<%= Cat.get(i)%>"><%= Cat.get(i)%></a></li>      
                                        <%
                                            }
                                            Cat.clear();
                                        %>
                                </ul>
                            </div>
                            <%
                                }
                            %>
                            <!--
                            <div>
                                <ul id="leftsideNav">
                                    <li><a href="#"><strong>Categories</strong></a></li>
                                    <li><a href="#">Books</a></li>
                                    <li><a href="#">Calculators</a></li>
                                    <li><a href="#">Art Supplies</a></li>
                                    <li><a href="#">Office Supplies</a></li>
                                    <li><a href="#">School Supplies</a></li>
                                    <li><a href="#">Games</a></li>
                                    <li><a href="#">Movies</a></li>
                                </ul>
                            </div>
                            
                            <div>
                                <ul id="leftsideNav">
                                    <li><a href="#"><strong>Sub-Categories</strong></a></li>
                                    <li><a href="#">Books</a></li>
                                    <li><a href="#">Calculators</a></li>
                                    <li><a href="#">Art Supplies</a></li>
                                    <li><a href="#">Office Supplies</a></li>
                                    <li><a href="#">School Supplies</a></li>
                                    <li><a href="#">Games</a></li>
                                    <li><a href="#">Movies</a></li>
                                </ul>
                            </div>
                            
                            <div>
                                <ul id="leftsideNav">
                                    <li><a href="#"><strong>Pricing</strong></a></li>
                                    <li><a href="#">Low to High</a></li>
                                    <li><a href="#">High to Low</a></li>
                                </ul>
                            </div>
                            -->


                        </div>
                    </div>

                    <!-- Middle -->
                    <div id="middle" class="grid_13">
                        <div class=" grid_13" id="whiteBox">
                            <div class="ProductHeading">
                                <div class="grid_12">
                                    <h2 class="heading">Products >
                                        <%= category%> 
                                        <%= subcategory%>
                                    </h2>
                                </div>

                            </div>
                            <div class="grid_12 productListing">

                                <div class="clear"></div>
                                <%
                                    if (session.getAttribute("cat") != null) {
                                        category = (String) session.getAttribute("cat");
                                        /*
                                         WHERE  `category-name` =  'Games'
                                         AND  `sub-category-name` =  'Action-Adventure-Game'
                                         GROUP BY  `product-name` */

                                        sql.append(" WHERE  `cat_name` =  '" + category + "' ");
                                %>
                                <div class="grid_4 ">
                                    <a id="greenBtn" href="removeProductFilter.jsp?cat=<%= category%>">Category : <%= category%> [x]</a>
                                </div>
                                <%

                                %>

                                <%                                        if (session.getAttribute("scat") != null) {
                                        subcategory = (String) session.getAttribute("scat");
                                        sql.append(" AND  `subcat_name` =  '" + subcategory + "' ");
                                %>
                                <div class="grid_4 ">
                                    <a id="greenBtn" href="removeProductFilter.jsp?scat=<%= subcategory%>">Sub-Category : <%= subcategory%> [x]</a>
                                </div>
                                <%
                                    }
                                %>
                                <%
                                    }
                                %>

                                <%
                                    //String sql = "SELECT * FROM  `products` p "
                                    //           + "INNER JOIN  `images` i "
                                    //           + "USING (  `product-name` ) 
                                    //             +`product_qty` > 0
                                    //          + "GROUP BY  `product-name` ";
                                    db_Connection con = new db_Connection();
                                    c = con.getConnection();
                                    st = c.createStatement();

                                    String newSQL = "SELECT * FROM  book INNER JOIN  images WHERE book.b_name=images.b_name";
                                    //out.print("Equals "+sql.toString() +" "+newSQL);
                                    rs = st.executeQuery(newSQL);

                                    while (rs.next()) {
                                        /*
                                         product-name	product_id	sub-category-name	category-name	company-name	price	summary	image-id	image-name*/
                                        String product_id = rs.getString("b_id");

                                        String product_name = rs.getString("b_name");

                                        String sub_category_name = rs.getString("cat_name");

                                        String category_name = rs.getString("subcat_name");

                                        String company_name = rs.getString("price");

                                        String price = rs.getString("quantity");

                                        String summary = rs.getString("description");

                                        String image_name = rs.getString("image_name");
                                        /*
                                         out.println("<br/>"+product_id+
                                         "<br/>"+product_name+
                                         "<br/>"+sub_category_name+
                                         "<br/>"+category_name+
                                         "<br/>"+company_name+
                                         "<br/>"+price+
                                         "<br/>"+summary+
                                         "<br/>"+image_name);
                                         */
                                %>
                                <div class="clear"></div>
                                <div class="grid_2">
                                    <a href="product.jsp?id=<%=product_id%>"><img src="<%= image_name%>" /></a>
                                </div>
                                <div class="grid_9">
                                    <div class="grid_5">
                                        <p id="info"><a href="product.jsp?id=<%=product_id%>"><h3><span class="blue"> <%=product_name%></span></h3></a>By <%= company_name + " " + category_name%><br/><span class="red">Rs. <%= price%></span></p>
                                    </div>
                                    <div class="grid_3 push_2">
                                        <p><%=sub_category_name%>  <a href="addToCart.jsp?id=<%= product_id%>" id="greenBtn">Add to cart</a></p><p>Will Be delivered in 3 Working days</p>
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <%
                                    }
                                    rs.close();
                                    st.close();
                                    c.close();
                                %>

                            </div>
                        </div>
                        <%
                //<jsp:include page="includesPage/mainHeaders/topMostViewedProducts_4.jsp"></jsp:include>
                        %>
                    </div>
                    <!--The Middle Content Div Closing -->
                </div>
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
                                <span class="price"><span class="low">TK</span>35<span class="high">00</span></span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="product">
                            <a href="#">
                                <img src="css/images/image-best02.jpg" alt="" />
                                <span class="book-name">Book Name </span>
                                <span class="author">by John Smith</span>
                                <span class="price"><span class="low">TK</span>45<span class="high">00</span></span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="product">
                            <a href="#">
                                <img src="css/images/image-best03.jpg" alt="" />
                                <span class="book-name">Book Name </span>
                                <span class="author">by John Smith</span>
                                <span class="price"><span class="low">TK</span>15<span class="high">00</span></span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="product">
                            <a href="#">
                                <img src="css/images/image-best04.jpg" alt="" />
                                <span class="book-name">Book Name </span>
                                <span class="author">by John Smith</span>
                                <span class="price"><span class="low">TK</span>27<span class="high">99</span></span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="product">
                            <a href="#">
                                <img src="css/images/image-best01.jpg" alt="" />
                                <span class="book-name">Book Name </span>
                                <span class="author">by John Smith</span>
                                <span class="price"><span class="low">TK</span>35<span class="high">00</span></span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="product">
                            <a href="#">
                                <img src="css/images/image-best02.jpg" alt="" />
                                <span class="book-name">Book Name </span>
                                <span class="author">by John Smith</span>
                                <span class="price"><span class="low">TK</span>45<span class="high">00</span></span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="product">
                            <a href="#">
                                <img src="css/images/image-best03.jpg" alt="" />
                                <span class="book-name">Book Name </span>
                                <span class="author">by John Smith</span>
                                <span class="price"><span class="low">TK</span>15<span class="high">00</span></span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="product">
                            <a href="#">
                                <img src="css/images/image-best04.jpg" alt="" />
                                <span class="book-name">Book Name </span>
                                <span class="author">by John Smith</span>
                                <span class="price"><span class="low">TK</span>27<span class="high">99</span></span>
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