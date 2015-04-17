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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            <c:if test="${empty g_login_userid}">
                <c:redirect url="${param.dest}" />
            </c:if>
            <tr>
                <td class="banner">
                    <table class="navigator">
                        <tr>                     
                            <td><a href="index.jsp">Home</a></td>
                            <td>|</td>
                            <td><a href="index.jsp">Store</a></td>
                            <td>|</td>
                            <td><a href="feedback.jsp">Feedback</a></td>
                            <td width="100%" align="right">
                                <table class="welcomeuser">
                                    <tr>
                                        <td>
                                            <c:if test="${not empty g_login_userid}">
                                                Welcome ${g_login_name} | <a href="h_logout.jsp?dest=${redirect}">Logout</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </table>    
                            </td>
                        </tr>
                    </table>                    
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table width="100%" border="0">
                        <tr>
                            <td valign="top" id="td_product" width="90%">
                                <table width="100%" border="0">
                                    <tr>
                                        <td valign="top">
                                            <table width="100%" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td valign="top">
                                                        <%-- get the products in the selected category --%>
                                                        <c:choose>
                                                            <%-- select all products --%>
                                                            <c:when test="${selected_category == 'all'}">
                                                                <sql:query var="products" dataSource="jdbc/phones">
                                                                    SELECT * FROM APP.PURCHASE WHERE CUSTOMER_EMAIL=? ORDER BY P_TIMESTAMP DESC
                                                                    <sql:param value="${g_LoginCustomer.email}" />
                                                                </sql:query>
                                                            </c:when>

                                                            <%-- select products which belong to a particular category --%>
                                                            <c:otherwise>
                                                                <sql:query var="products" dataSource="jdbc/phones">
                                                                    SELECT * FROM APP.PURCHASE WHERE CUSTOMER_EMAIL=? AND DELIVERY_STATUS=? ORDER BY P_TIMESTAMP DESC

                                                                    <sql:param value="${g_LoginCustomer.email}" />
                                                                    <sql:param value="${selected_category}" />
                                                                </sql:query>
                                                            </c:otherwise>
                                                        </c:choose>
                                                                    
                                                        <c:if test="${param.pid != null}">
                                                            <sql:query var="purchase" dataSource="jdbc/phones">
                                                                SELECT * FROM APP.PURCHASE WHERE PURCHASE_REFNO=?
                                                                <sql:param value="${param.pid}" />
                                                            </sql:query>
                                                        
                                                            <%-- and display the results --%>
                                                            <c:if test="${! empty purchase}">
                                                                <table valign="top" bgcolor="black"cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td>
                                                                            <table width="100%" style="empty-cells: show;" border="0" bgcolor="whitesmoke" cellspacing="1" cellpadding="4">
                                                                                <tr>
                                                                                    <td colspan="3"><a href="purchasehistory.jsp?selected_category=${param.selected_category}">Back</a></td>
                                                                                </tr>
                                                                                <tr class="checkoutheader">
                                                                                    <td colspan="3">
                                                                                        Purchase info...
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Ref.No</td>
                                                                                    <td>:</td>
                                                                                    <td>${purchase.rows[0].PURCHASE_REFNO}</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Shipping To.</td>
                                                                                    <td>:</td>
                                                                                    <td>${purchase.rows[0].SHIPPING_ADDRESS}</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Date/time</td>
                                                                                    <td>:</td>   
                                                                                    <td><fmt:formatDate value="${purchase.rows[0].P_TIMESTAMP}" pattern="dd/MM/yyyy EEE" />, <fmt:formatDate type="time" value="${purchase.rows[0].P_TIMESTAMP}" /></td>
                                                                                </tr>
                                                                                <tr>                                                                       
                                                                                    <td>Delivery Status</td>
                                                                                    <td>:</td>
                                                                                    <td>${purchase.rows[0].DELIVERY_STATUS}</td>
                                                                                </tr>
                                                                            </table>  
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </c:if>
                                                            
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top">
                                                        <%-- get the products in the selected category --%>
                                                        <c:if test="${param.pid != null}">
                                                            <sql:query var="items" dataSource="jdbc/phones">
                                                                SELECT * FROM APP.PURCHASE_ITEMS
                                                                INNER JOIN APP.PRODUCT
                                                                ON APP.PURCHASE_ITEMS.PRODUCT_ID=APP.PRODUCT.ID
                                                                WHERE APP.PURCHASE_ITEMS.PURCHASE_REFNO=?
                                                                <sql:param value="${param.pid}" />
                                                            </sql:query>
                                                            <%-- and display the results --%>
                                                            <table valign="top" bgcolor="black" width="100%" cellspacing="0" cellpadding="0">
                                                                <tr>
                                                                    <td>
                                                                        <table width="100%" style="empty-cells: show;" border="0" bgcolor="whitesmoke" cellspacing="1" cellpadding="2">
                                                                            <tr class="checkoutheader">
                                                                                <td>Sr.No</td>
                                                                                <td>Name</td>
                                                                                <td>Price</td>
                                                                                <td>Quantity</td>
                                                                                <td>Amount</td>
                                                                            </tr>
                                                                            <c:set var="icount" value="0" />
                                                                            <c:set var="gtotal" value="0"/>
                                                                            <c:set var="qtotal" value="0"/>
                                                                            <c:forEach var="row" items="${items.rows}">                                                                                                                                                                                                                                            
                                                                                <c:if test="${icount % 2 == 0}">
                                                                                    <tr class="checkoutitemrow">    
                                                                                </c:if>
                                                                                <c:if test="${icount % 2 != 0}">
                                                                                    <tr class="checkoutitemalternaterow">    
                                                                                </c:if>                                                                                                                                                    
                                                                                <c:set var="icount" value="${icount+1}"/>                                                                                                                                            
                                                                                    <td>${icount}</td>
                                                                                    <td>${row.NAME}</td>
                                                                                    <td>${row.PRICE}</td>
                                                                                    <td>${row.QUANTITY}</td>
                                                                                    <td>${row.PRICE * row.QUANTITY}</td>
                                                                                </tr>
                                                                                <c:set var="qtotal" value="${qtotal+row.QUANTITY}"/>
                                                                                <c:set var="gtotal" value="${gtotal+(row.PRICE * row.QUANTITY)}"/>
                                                                            </c:forEach>
                                                                            <tr>
                                                                                <td colspan="5"><hr></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="3"><b>Total:</b></td>
                                                                                <td><b>${qtotal}</b></td>
                                                                                <td><b>${gtotal} S$</b></td>
                                                                            </tr>
                                                                        </table>  
                                                                    </td>
                                                                </tr>
                                                            </table> 
                                                        </c:if>                                                        
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
