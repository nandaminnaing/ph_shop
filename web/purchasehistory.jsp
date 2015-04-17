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
        <script language="javascript">
            function changedeliverystatus(url,sel){
                var sts=document.getElementById('f_category');
                var status='';
                if (sts!=null){
                    status=sts.options[sts.options.selectedIndex].value;
                }else{
                    sts=document.frm_purchasehistory.f_category;
                    if (sts!=null){
                        status=sts.options[sts.options.selectedIndex].value;    
                    }
                }
                
                //window.location.href(url + '&status=' + sel.options[sel.options.selectedIndex].value + '&dest=purchasehistory.jsp^selected_category='+status);                
                location.assign(url + '&status=' + sel.options[sel.options.selectedIndex].value + '&dest=purchasehistory.jsp^selected_category='+status);                
            }
        </script>
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
                                        <td id="td_category" valign="top">
                                            <table border="0">
                                                <tr>                                                  
                                                    <%-- main form user to choose a category, pick a default category --%>
                                                    <form name="frm_purchasehistory" method="post" action="purchasehistory.jsp">
                                                    <INPUT TYPE="HIDDEN" NAME="FormName" VALUE="frmDeliveryStatus">

                                                    <%-- query the database for product categories --%>
                                                    <sql:query var="categories" dataSource="jdbc/phones">
                                                        SELECT DISTINCT DELIVERY_STATUS FROM APP.PURCHASE
                                                    </sql:query>

                                                    <%-- did the user submit a choice? --%>             
                                                    <c:if test="${param.selected_category!=null}">                
                                                        <c:set var="selected_category" value="${param.selected_category}" />
                                                    </c:if>         
                                                    <c:if test="${pageContext.request.method=='POST'}">                
                                                        <c:set var="selected_category" value="${param.f_category}" />
                                                    </c:if>         
                                                    <c:if test="${pageContext.request.method=='POST' && param.FormName != 'frmDeliveryStatus' }">                
                                                        <c:if test="${param.selected_category!=null}">                
                                                            <c:set var="selected_category" value="${param.selected_category}" />
                                                        </c:if> 
                                                    </c:if>
                                                    <td valign="middle" class="label">Filter by delivery status</td>
                                                    <td valign="middle">:</td>
                                                    <td valign="middle">                                                        
                                                       <select name="f_category" onchange="document.frm_purchasehistory.submit()" >
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
                                        <td valign="top">
                                            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                                                <tr>
                                                    <td valign="top">                                                        
                                                        <%-- get the products in the selected category --%>
                                                        <c:choose>
                                                            <%-- select all products --%>
                                                            <c:when test="${selected_category == 'all'}">
                                                                <sql:query var="products" dataSource="jdbc/phones">
                                                                    <c:if test="${g_isadminuser!=null}">                                                                                    
                                                                        <c:if test="${g_isadminuser==1}">
                                                                            SELECT * FROM APP.PURCHASE ORDER BY P_TIMESTAMP DESC                                                                            
                                                                        </c:if>
                                                                    </c:if>  
                                                                    <c:if test="${g_isadminuser!=null}">                                                                                    
                                                                        <c:if test="${g_isadminuser!=1}">
                                                                            SELECT * FROM APP.PURCHASE WHERE CUSTOMER_EMAIL=? ORDER BY P_TIMESTAMP DESC
                                                                            <sql:param value="${g_LoginCustomer.email}" />
                                                                        </c:if>
                                                                    </c:if>                                                                            
                                                                </sql:query>
                                                            </c:when>

                                                            <%-- select products which belong to a particular category --%>
                                                            <c:otherwise>
                                                                <sql:query var="products" dataSource="jdbc/phones">
                                                                    <c:if test="${g_isadminuser!=null}">                                                                                    
                                                                        <c:if test="${g_isadminuser==1}">
                                                                            SELECT * FROM APP.PURCHASE WHERE DELIVERY_STATUS=? ORDER BY P_TIMESTAMP DESC
                                                                        
                                                                            <sql:param value="${selected_category}" />                                                                                                                                                        
                                                                        </c:if>
                                                                    </c:if>  
                                                                    <c:if test="${g_isadminuser!=null}">                                                                                    
                                                                        <c:if test="${g_isadminuser!=1}">
                                                                            SELECT * FROM APP.PURCHASE WHERE CUSTOMER_EMAIL=? AND DELIVERY_STATUS=? ORDER BY P_TIMESTAMP DESC
                                                                        
                                                                            <sql:param value="${g_LoginCustomer.email}" />
                                                                            <sql:param value="${selected_category}" />
                                                                        </c:if>
                                                                    </c:if> 
                                                                    
                                                                </sql:query>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <%-- and display the results --%>
                                                        <table valign="top" bgcolor="white" width="100%" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td valign="top">
                                                                    <table valign="top" width="100%" style="empty-cells: show;" border="0" bgcolor="whitesmoke" cellspacing="1" cellpadding="2">
                                                                        <tr class="checkoutheader">
                                                                            <td>Ref.No</td>
                                                                            <c:if test="${g_isadminuser!=null}">                                                                                    
                                                                                <c:if test="${g_isadminuser==1}">
                                                                                    <td>Member's email</td>
                                                                                </c:if>
                                                                            </c:if>    
                                                                            <td>Shipping To.</td>
                                                                            <td>Date/time</td>                                                                            
                                                                            <td>Delivery Status</td>
                                                                            <td></td>
                                                                        </tr>
                                                                        
                                                                        <INPUT TYPE="HIDDEN" NAME="FormName" VALUE="frmDeliveryStatusChange">
                                                                        <c:set var="icount" value="0"/>
                                                                        <c:forEach var="row" items="${products.rows}">                                                                                                                                                                                                                                            
                                                                            <c:if test="${icount % 2 == 0}">
                                                                                <tr class="checkoutitemrow">    
                                                                            </c:if>
                                                                            <c:if test="${icount % 2 != 0}">
                                                                                <tr class="checkoutitemalternaterow">    
                                                                            </c:if>                                                                                                                                                    
                                                                            <c:set var="icount" value="${icount+1}"/>                                                                                                                                            
                                                                            <td>${row.PURCHASE_REFNO}<input type="hidden" name="hidRefNo" value="${row.PURCHASE_REFNO}" /></td>
                                                                            <c:if test="${g_isadminuser!=null}">                                                                                    
                                                                                <c:if test="${g_isadminuser==1}">
                                                                                    <td>${row.CUSTOMER_EMAIL}</td>
                                                                                </c:if>
                                                                            </c:if>  
                                                                            <td>${row.SHIPPING_ADDRESS}</td>
                                                                            <td><fmt:formatDate value="${row.P_TIMESTAMP}" pattern="dd/MM/yyyy hh:mm EEE" />, <fmt:formatDate type="time" value="${row.P_TIMESTAMP}" /></td>
                                                                            <td>

                                                                                <c:if test="${g_isadminuser!=null}">                                                                                    
                                                                                    <c:if test="${g_isadminuser==1}">
                                                                                        <select name="cboStatus" onchange="changedeliverystatus('h_changedeliverystatus.jsp?pid=${row.PURCHASE_REFNO}',this);">
                                                                                            <option value="PENDING" selected=selected>PENDING</option>
                                                                                            <option value="SHIPPING" ${row.DELIVERY_STATUS == 'SHIPPING' ? 'selected' : ''}>SHIPPING</option>
                                                                                            <option value="DELIVERED" ${row.DELIVERY_STATUS == 'DELIVERED' ? 'selected' : ''}>DELIVERED</option>
                                                                                            <option value="CANCELLED" ${row.DELIVERY_STATUS == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                                                                                        </select>
                                                                                    </c:if>
                                                                                </c:if>

                                                                                <c:if test="${g_isadminuser!=1}">
                                                                                    ${row.DELIVERY_STATUS}
                                                                                </c:if>
                                                                            </td>
                                                                            <td><a href="purchasehistorydetails.jsp?pid=${row.PURCHASE_REFNO}&selected_category=${selected_category}">Details</a></td>
                                                                            </tr>
                                                                        </c:forEach>                                                                            
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
