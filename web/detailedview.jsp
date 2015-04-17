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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>P1257506</title>
    </head>
<body>
        <table align="center" width="960px" class="maintable">
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
                                <%-- do we have any product ID --%>
                                <c:choose>
                                    <%-- only attempt to load the product when we have an id --%>
                                    <c:when test="${not empty param.id}">
                                        <%-- get the product with the passed in ID --%>
                                        <sql:query var="rs" dataSource="jdbc/phones">
                                            SELECT * FROM APP.product
                                            WHERE id=?

                                            <sql:param value="${param.id}" />
                                        </sql:query>

                                        <%-- did we find any product with that ID? --%>
                                        <c:choose>
                                            <%-- show the product if we found it --%>
                                            <c:when test="${rs.rowCount == 1}">
                                                <table width="100%">
                                                    <tr>
                                                        <td valign="top">
                                                            <img src="stockpics/b_${rs.rows[0].image}"/>
                                                        </td>
                                                        <td valign="top" width="100%">
                                                            <table width="100%">
                                                                <%-- build the header row --%>  
                                                                <tr bgcolor="lightgray">
                                                                    <td>ID</td>
                                                                    <td>Name</td>
                                                                    <td width="100%">Description</td>
                                                                    <td>Price</td>

                                                                    <%-- add a buy header if we have a valid member --%>
                                                                    <c:if test="${not empty g_login_userid}">
                                                                        <td>Purchase</td>
                                                                    </c:if>
                                                                </tr>

                                                                <%-- show the product's full details --%> 
                                                                <tr>
                                                                    <td valign="top">${rs.rows[0].id}</td>
                                                                    <td valign="top"><nobr>${rs.rows[0].name}</nobr></td>
                                                                    <td valign="top">${rs.rows[0].detail_info}</td>
                                                                    <td valign="top">${rs.rows[0].price}</td>

                                                                    <%-- add a buy option if we have a valid member --%>
                                                                    <c:if test="${not empty g_login_userid}">
                                                                        <%--td><a href="h_addproduct.jsp?id=${rs.rows[0].id}&dest=${redirect}">Buy</a></td--%>
                                                                        <td valign="top" align="center"><a href="h_addproduct.jsp?id=${rs.rows[0].id}&dest=detailedview.jsp^id=${param.id}">Buy</a></td>
                                                                    </c:if>                                
                                                                </tr>    
                                                            </table>                                                            
                                                        </td>
                                                    </tr>
                                                </table>                                                
                                            </c:when>

                                            <%-- inform the user that we did not find it --%>
                                            <c:otherwise>
                                                <div>No such product found.</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <%-- No ID, display the error message --%>
                                    <c:otherwise>
                                        <div>No ID parameter passed in.</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td valign="top" width="10%">
                                <table cellspacing="1px" style="border-color:whitesmoke;border-style: solid; border-width: 1px;">
                                    <tr>
                                        <td id="td_login">
                                            <c:choose>
                                                <%-- show the login form, if user has not logged in --%>
                                                <c:when test="${empty g_login_userid}">
                                                    <form name="frm_login" action="h_login.jsp?dest=detailedview.jsp^id=${param.id}" method="post">
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
                                        <td id="td_cart">
                                            <table cellspacing="1px" cellpadding="4">
                                            <%-- display the cart contents only if we have a login member and a valu --%>
                                            <c:if test="${not empty g_login_userid && not empty g_myCart}">
                                                <div>
                                                    <%-- is there anything in the shopping cart --%>
                                                    <c:choose>
                                                        <%-- empty cart? --%>
                                                        <c:when test="${g_myCart.noItems == 0}">
                                                            <table>
                                                                <tr>
                                                                    <td><img src="images/shopping-cart-icon-small.jpg"></td>
                                                                    <td><p>Shopping cart is empty.</p></td>  
                                                                </tr>
                                                            </table>
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
