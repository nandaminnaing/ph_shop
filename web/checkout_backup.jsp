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
        <title>JSP Page</title>
    </head>
    <body>
        <%-- since this is a checkout page, we need to make sure only a valid
        login user can access it --%>
        <c:if test="${empty g_login_userid}">
            <%-- since this is an anonymous user, we redirect back to main page
            with an useful message --%>
            <c:set var="g_status_msg" value="Unauthorised Access." scope="session" />
            <c:redirect url="index.jsp" />
        </c:if>
        
        <%-- Login / Logout Block --%>
        <div>
            <h2>Login / Logout Block</h2>
            
            <%-- show logout link, if user has logged in --%>
            <c:if test="${not empty g_login_userid}">
                <a href="h_logout.jsp?dest=index.jsp">Logout</a>
            </c:if>
        </div>
            
        <%-- Shopping Cart Block --%>
        <div>
            <h2>Shopping Cart Block</h2>
            
            <%-- do we have a valid cart? --%>
            <c:if test="${not empty g_myCart}">
                <%-- is there anything in the shopping cart? --%>
                <c:choose>
                    <%-- empty cart? --%>
                    <c:when test="${g_myCart.noItems == 0}">
                        <p>Shopping cart is empty.</p>                        
                    </c:when>
                    <%-- cart has something --%>
                    <c:otherwise>
                        <table border="1">
                            <%-- list out all the items in the shopping cart --%>
                            <c:forEach items="${g_myCart.products}" var="curProd">
                                <tr>
                                    <jsp:useBean id="curProd" class="myShop.ProductBean" />
                                    <td>${curProd.prodID}</td>
                                    <td>${curProd.prodName}</td>
                                    <td>${curProd.prodDesc}</td>
                                    <td>${curProd.prodPrice}</td>
                                    <td>${curProd.prodQty}</td>
                                    <td>${curProd.extraField1}</td>
                                    <td>${curProd.extraField2}</td>
                                    <td>${curProd.prodQty * curProd.prodPrice}</td>
                                    <td><a href="h_removeproduct.jsp?id=${curProd.prodID}&dest=${redirect}">Remove</a></td>
                                    <td><a href="h_increaseqty.jsp?id=${curProd.prodID}&dest=${redirect}">More</a></td>
                                    <td><a href="h_decreaseqty.jsp?id=${curProd.prodID}&dest=${redirect}">Less</a></td>
                                </tr>
                            </c:forEach>
                        </table>
                        Total: ${g_myCart.total}
                    </c:otherwise>
                </c:choose> 
            </c:if>
        </div>
    </body>
</html>
