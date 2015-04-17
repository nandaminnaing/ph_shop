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
        <c:if test="${empty g_login_userid}">
            <c:redirect url="${param.dest}" />
        </c:if>
        <table align="center" style="border-color:whitesmoke;border-style: solid; border-width: 1px;" width="960px">
            <tr>
                <td class="banner">
                    <table class="navigator">
                        <tr>
                            <td><a href="index.jsp">Home</a></td>
                            <td>|</td>
                            <td><a href="index.jsp">Store</a></td>
                            <td>|</td>
                            <td><a href="feedback.jsp">Feedback</a></td>
                            <c:if test="${not empty g_login_userid}">
                            <td>|</td>    
                            <td>
                                <a href="purchasehistory.jsp"><nobr>Purchase history</nobr></a>
                            </td>
                            </c:if>
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
                    <table align="center" width="100%" border="0" style="border-color:whitesmoke;border-style: solid; border-width: 1px;height: 500px;">
                        <tr>
                            <td id="checkout" width="90%" align="center">
                                <c:if test="${not empty g_myCart}">
                                    <%-- is there anything in the shopping cart? --%>
                                    <c:choose>
                                        <%-- empty cart? --%>
                                        <c:when test="${g_myCart.noItems == 0}">
                                            <p>Thank you for shopping with us.</p>                        
                                        </c:when>
                                        <%-- cart has something --%>
                                        <c:otherwise>   
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
