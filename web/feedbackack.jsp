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
        <table align="center" style="border-color:whitesmoke;border-style: solid; border-width: 1px;" width="960px">
            <tr>
                <td class="banner">
                    <table>
                        <tr>
                            <td class="navigator"><a href="index.jsp">Home</a></td>
                            <td class="navigator">|</td>
                            <td class="navigator"><a href="index.jsp">Store</a></td>
                            <td class="navigator">|</td>
                            <td class="navigator"><a href="feedback.jsp">Feedback</a></td>
                            <td width="100%" align="right">
                                <table class="welcomeuser">
                                    <tr>
                                        <c:if test="${not empty g_login_userid}">
                                            <td class="navigator">
                                                Welcome ${g_login_name} | <a href="h_logout.jsp?dest=${redirect}">Logout</a>
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
                    <table align="center" width="100%" border="0" style="border-color:whitesmoke;border-style: solid; border-width: 1px;height: 500px;">
                        <tr>
                            <td id="checkout" width="90%" align="center">
                                <p>Thank you for your feedback ${param.name}.<br>We love to respond you as soon as possible.</p>                                                     
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
                        Refer <a href="http://www.gsmarena.com/">here</a> for the list of materials used. Email <a href="mailto:ndminnaing@gmail.com">me</a> if you are the owner and you would like
                        to have them removed on this site.
                    </p>                    
                </td>
            </tr>            
        </table>
    </body>
</html>
