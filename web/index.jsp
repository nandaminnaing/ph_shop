<%-- 
    Document   : index
    Created on : Nov 29, 2012, 7:49:54 PM
    Author     : P1257506
--%>
<%-- 
    Name            : Nanda Min Naing
    Course          : ST8016
    Class           : SECT\VC\1A\02
    Admission No    : P1257506
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<link href="main.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html>
<%-- construct our current URI, complete with query string --%>
<%
    String querystring="";
    if (request.getQueryString() != null)
        querystring="?" + request.getQueryString();
    
        pageContext.setAttribute("redirect", request.getRequestURL() + querystring);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>P1257506</title>
    </head>
    <body>
        <table align="center" border="0" width="960px" class="maintable">
            <tr>
                <td class="banner">
                    <table>
                        <tr>                     
                            <td class="navigator"><a href="index.jsp">Home</a></td>
                            <td class="navigator">|</td>
                            <td class="navigator"><a href="index.jsp">Store</a></td>
                            <td class="navigator">|</td>
                            <td class="navigator"><a href="feedback.jsp">Feedback</a></td>
                            <c:if test="${not empty g_login_userid}">
                                <td class="navigator">|</td>    
                                <td class="navigator">
                                    <a href="purchasehistory.jsp"><nobr>Purchase history</nobr></a>
                                </td>
                            </c:if>
                            <td width="100%" align="right">
                                <table class="welcomeuser">
                                    <tr>
                                        <c:if test="${not empty g_login_userid}">
                                            <td>Welcome ${g_login_name}</td>
                                            <td>|</td>
                                            <td class="navigator">
                                                <a href="h_logout.jsp?dest=${redirect}">Logout</a>
                                            </td>
                                        </c:if>
                                        <c:if test="${empty g_login_userid}">
                                            <td>New to MyPhoneShop?</td>
                                            <td>|</td>
                                            <td class="navigator"><a href="registeruser.jsp">Click here to register.</a></td>
                                        </c:if>                                                                                        
                                    </tr>
                                </table>    
                            </td>
                        </tr>
                    </table>                    
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td id="td_product" width="90%">
                                <table width="100%" border="0">
                                    <tr>
                                        <td id="td_category">
                                            <table border="0">
                                                <tr>
                                                    <%-- main form user to choose a category, pick a default category --%>
                                                    <form name="frm_category" method="post" action="index.jsp">
                                                        
                                                    <%-- query the database for product categories --%>
                                                    <sql:query var="categories" dataSource="jdbc/phones">
                                                        SELECT DISTINCT category FROM APP.product
                                                    </sql:query>
                                                    
                                                    <%-- did the user submit a choice? --%>            
                                                    <c:if test="${pageContext.request.method=='POST'}">                
                                                        <c:set var="selected_category" value="${param.f_category}" />
                                                    </c:if>
                                                    <td valign="middle" class="label">Select a category</td>
                                                    <td valign="middle">:</td>
                                                    <td valign="middle">                                                        
                                                       <select name="f_category" onchange="document.frm_category.submit()" >
                                                            <c:set var="selected" value="" />

                                                            <%-- setting a default choice --%>
                                                            <c:if test="${empty selected_category}">
                                                                <c:set var="selected_category" value="all" />
                                                                <c:set var="selected" value="selected" />
                                                            </c:if>

                                                            <%-- did the user select all? --%>
                                                            <c:if test="${selected_category == 'all'}">
                                                                <c:set var="selected" value="selected" />
                                                            </c:if>

                                                            <option value="all" ${selected}>All</option>

                                                            <%-- adding the rest of the categories --%>
                                                            <c:forEach var="row" items="${categories.rowsByIndex}" varStatus="vs">
                                                                <c:set var="selected" value="" />

                                                                <c:if test="${row[0] == selected_category}">
                                                                    <c:set var="selected" value="selected" />
                                                                </c:if>
                                                                <option value="${row[0]}" ${selected}>${row[0]}</option>
                                                            </c:forEach>                   
                                                        </select>  
                                                    </td>  
                                                    </form>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="100%" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td>
                                                        <%-- get the products in the selected category --%>
                                                        <c:choose>
                                                            <%-- select all products --%>
                                                            <c:when test="${selected_category == 'all'}">
                                                                <sql:query var="products" dataSource="jdbc/phones">
                                                                    SELECT * FROM APP.product ORDER BY Category                   
                                                                </sql:query>
                                                            </c:when>

                                                            <%-- select products which belong to a particular category --%>
                                                            <c:otherwise>
                                                                <sql:query var="products" dataSource="jdbc/phones">
                                                                    SELECT * FROM APP.product WHERE category=? ORDER BY Name
                                                                    <sql:param value="${selected_category}" />
                                                                </sql:query>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <%-- and display the results --%>
                                                        <table bgcolor="black" width="100%" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td>
                                                                    <table width="100%" style="empty-cells: show;" border="0" bgcolor="whitesmoke" cellspacing="1" cellpadding="2">
                                                                        <!--tr-->
                                                                            <c:set var="icount" value="0"/>
                                                                            <c:forEach var="row" items="${products.rows}">
                                                                                <c:if test="${icount == 0}">
                                                                                    <tr>
                                                                                </c:if>
                                                                                <c:set var="icount" value="${icount+1}"/>
                                                                                <td valign="top" bgcolor="white">
                                                                                    <table width="100%" cellpadding="2" border="0">
                                                                                        <tr>
                                                                                            <td valign="top">
                                                                                                <img src="stockpics/${row.image}"/>
                                                                                            </td>
                                                                                            <td valign="top" width="100%">
                                                                                                <table width="100%" class="phonebox" border="0">
                                                                                                    <tr>
                                                                                                        <td valign="top">ID</td>
                                                                                                        <td valign="top">:</td>
                                                                                                        <td valign="top">${row.id}</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td valign="top">Name</td>
                                                                                                        <td valign="top">:</td>
                                                                                                        <td valign="top"><a href="detailedview.jsp?id=${row.id}">${row.name}</a></td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td valign="top">Description</td>
                                                                                                        <td valign="top">:</td>
                                                                                                        <td valign="top" width="100%">${row.description}</td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td valign="top">Price</td>
                                                                                                        <td valign="top">:</td>
                                                                                                        <td valign="top">${row.price}</td>
                                                                                                    </tr>
                                                                                                    <c:if test="${not empty g_login_userid}">
                                                                                                        <tr>
                                                                                                            <td colspan="3" align="right">
                                                                                                                <a href="h_addproduct.jsp?id=${row.id}&dest=${redirect}">Buy</a>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </c:if>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                                <c:if test="${icount == 3}">
                                                                                    </tr>
                                                                                    <c:set var="icount" value="0"/>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        <!--/tr-->
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" width="10%" height="100%">
                                <table style="border-color:whitesmoke;border-style: solid; border-width: 1px;height: 100%;">
                                    <tr>
                                        <td id="td_login" valign="top">
                                            <c:choose>
                                                <%-- show the login form, if user has not logged in --%>
                                                <c:when test="${empty g_login_userid}">
                                                    <form name="frm_login" action="h_login.jsp?dest=${redirect}" method="post">
                                                        <table>
                                                            <tr>
                                                                <td class="loginheader" colspan="3">Login</td>
                                                            </tr>
                                                            <tr>
                                                                <td>User ID</td>
                                                                <td>:</td>
                                                                <td><input type="text" style="width:100px" name="userid" value="${param.userid}" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Password</td>
                                                                <td>:</td>
                                                                <td><input type="password"  style="width:100px" name="password" value="${param.password}" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">&nbsp;</td>
                                                                <td><input type="submit" value="Login" name="login" /></td>
                                                            </tr>
                                                            <%--display system messages (if any) --%>
                                                            <c:if test="${not empty g_status_msg}">
                                                                <tr>
                                                                    <td colspan="2">&nbsp;</td>
                                                                    <td>
                                                                        <p><font color="red">${g_status_msg}</font></p>
                                                                        <c:remove var="g_status_msg" scope="session" />
                                                                    </td>
                                                                </tr>
                                                            </c:if>                                                            
                                                        </table>
                                                    </form>
                                                </c:when>

                                                <%-- show logout link, if user has logged in --%>
                                                <c:otherwise>
                                                    <%--table>
                                                        <tr>
                                                            <td>Welcome ${g_login_name}, <a href="h_logout.jsp?dest=${redirect}">Logout</a></td>
                                                        </tr>
                                                    </table--%>      
                                                </c:otherwise>
                                            </c:choose>                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="td_cart" valign="top">
                                            <table cellspacing="1" cellpadding="4" bgcolor="white">
                                            <%-- display the cart contents only if we have a login member and a valu --%>
                                            <c:if test="${not empty g_login_userid && not empty g_myCart}">
                                                <div>
                                                    <%-- is there anything in the shopping cart --%>
                                                    <c:choose>
                                                        <%-- empty cart? --%>
                                                        <c:when test="${g_myCart.noItems == 0}">
                                                            <tr>
                                                                <td>
                                                                    <table>
                                                                        <tr>
                                                                            <td><img src="images/shopping-cart-icon-small.jpg"></td>
                                                                            <td><p>Shopping cart is empty.</p></td>  
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </c:when>
                                                        <%-- cart has something --%>
                                                        <c:otherwise>
                                                            <tr style="background-color: grey; color:whitesmoke;">
                                                                <td style="display: none">ID</td>
                                                                <td>Name</td>
                                                                <td style="display: none">Desc</td>
                                                                <td>Price</td>
                                                                <td>Qty</td>
                                                                <td style="display: none">..</td>
                                                                <td style="display: none">..</td>
                                                                <td></td>
                                                            </tr>
                                                            <%-- list out all the items in the shopping cart --%>
                                                            <c:forEach items="${g_myCart.products}" var="curProd">
                                                                <tr style="background-color:whitesmoke;">
                                                                    <jsp:useBean id="curProd" class="myShop.ProductBean" />
                                                                    <td style="display: none">${curProd.prodID}</td>
                                                                    <td><nobr>${curProd.prodName}</nobr></td>
                                                                    <td style="display: none">${curProd.prodDesc}</td>
                                                                    <td>${curProd.prodPrice}</td>
                                                                    <td>${curProd.prodQty}</td>
                                                                    <td style="display: none">${curProd.extraField1}</td>
                                                                    <td style="display: none">${curProd.extraField2}</td>
                                                                    <td><img alt="remove item" onclick="javascript: location.href('h_removeproduct.jsp?id=${curProd.prodID}&dest=${redirect}');" style="cursor: pointer" src="images/delete_small_grey.png"></td>
                                                                </tr>
                                                            </c:forEach>
                                                            <%-- displays checkout link here --%>
                                                            <tr>
                                                                <td colspan="7">
                                                                    <table>
                                                                        <tr>
                                                                            <td><img src="images/shopping-cart-icon-small.jpg"></td>
                                                                            <td><p><a href="checkout.jsp">Checkout</a></p></td>  
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </c:otherwise>
                                                    </c:choose> 
                                                </div>
                                            </c:if> 
                                            </table>                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="td_myinfo" valign="bottom">
                                            <table>
                                                <tr>
                                                    <td>Name</td>
                                                    <td>:</td>
                                                    <td>Nanda Min Naing</td>
                                                </tr>
                                                <tr>
                                                    <td>Class</td>
                                                    <td>:</td>
                                                    <td>SECT\VC\1A\02</td>
                                                </tr>
                                                <tr>
                                                    <td>Admission Number</td>
                                                    <td>:</td>
                                                    <td>P1257506</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <p class="img_privacy_info">
                        All images and other copyrighted materials used in this project are for educational
                        purposes, and the copyright of the materials remain the property of the respective owners.<br>
                        Refer <a class="imgfooterlink" href="http://www.gsmarena.com/">here</a> for the list of materials used. Email <a class="imgfooterlink" href="mailto:ndminnaing@gmail.com">me</a> if you are the owner and you would like
                        to have them removed on this site.
                    </p>                    
                </td>
            </tr>            
        </table>
    </body>
</html>
