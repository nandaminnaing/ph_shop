<%-- 
    Document        : index
    Created on      : Nov 29, 2012, 7:49:54 PM
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
        <c:if test="${empty g_login_userid}">
            <c:redirect url="${param.dest}" />
        </c:if>
        <table align="center" class="maintable" width="960px">
            <tr>
                <td class="banner">
                    <table class="navigator">
                        <tr>
                            <td><a href="index.jsp">Home</a></td>
                            <td>|</td>
                            <td><a href="index.jsp">Store</a></td>
                            <td>|</td>
                            <td>Feedback</td>
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
                <td>
                    <table width="100%" border="0" style="border-color:whitesmoke;border-style: solid; border-width: 1px;">
                        <tr>
                            <td id="checkout" width="90%">
                                <c:if test="${not empty g_myCart}">
                                    <%-- is there anything in the shopping cart? --%>
                                    <c:choose>
                                        <%-- empty cart? --%>
                                        <c:when test="${g_myCart.noItems == 0}">
                                            <p>Shopping cart is empty.</p>                        
                                        </c:when>
                                        <%-- cart has something --%>
                                        <c:otherwise>
                                            <table class="checkouttable" border="0" cellpadding="4">
                                                <tr class="checkoutheader">
                                                    <td>Sr.No</td>
                                                    <td>Name</td>
                                                    <td>Description</td>
                                                    <td>Price</td>
                                                    <td>Quantity</td>
                                                    <td style="display: none">F1</td>
                                                    <td style="display: none">F2</td>
                                                    <td>Amount</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                    
                                                <c:set var="icount" value="0"/>
                                                <%-- list out all the items in the shopping cart --%>
                                                <c:forEach items="${g_myCart.products}" var="curProd">
                                                        <c:if test="${icount % 2 == 0}">
                                                            <tr class="checkoutitemrow">    
                                                        </c:if>
                                                        <c:if test="${icount % 2 != 0}">
                                                            <tr class="checkoutitemalternaterow">    
                                                        </c:if>                                                                
                                                        <jsp:useBean id="curProd" class="myShop.ProductBean" />
                                                        <c:set var="icount" value="${icount+1}"/>                                                        
                                                        <!--${curProd.prodID} -->
                                                        <td>${icount}</td>
                                                        <td>${curProd.prodName}</td>
                                                        <td>${curProd.prodDesc}</td>
                                                        <td>${curProd.prodPrice}</td>
                                                        <td>${curProd.prodQty}</td>
                                                        <td style="display: none">${curProd.extraField1}</td>
                                                        <td style="display: none">${curProd.extraField2}</td>
                                                        <td>${curProd.prodQty * curProd.prodPrice}</td>
                                                        <td><a href="h_removeproduct.jsp?id=${curProd.prodID}&dest=${redirect}">Remove</a></td>
                                                        <td><a href="h_increaseqty.jsp?id=${curProd.prodID}&dest=${redirect}">More</a></td>
                                                        <td><a href="h_decreaseqty.jsp?id=${curProd.prodID}&dest=${redirect}">Less</a></td>
                                                    </tr>
                                                </c:forEach>
                                                <tr>
                                                    <td colspan="11">
                                                        <br><b>Total: ${g_myCart.total}</b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="11">
                                                        <br><input type="button" onclick="javascript:location.assign('payment.jsp');" value="Proceed checkout" />
                                                    </td>
                                                </tr>
                                            </table>                                            
                                        </c:otherwise>
                                    </c:choose> 
                                </c:if>                            
                            </td>
                            <c:choose>                                
                            <c:when test="${empty g_login_userid}">
                            <td valign="top" width="10%">
                                <table border="1">
                                    <tr>
                                        <td id="td_login">
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
                                </table>
                            </td>
                            </c:when>
                            </c:choose>
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
