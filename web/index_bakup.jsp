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
        <title>JSP Page</title>
    </head>
    <body>
        <%-- Login and Logout Block --%>
        <div class="odd">
            <h1>Login / Logout Block</h1>
            <!-- has the user logged in? -->
            <c:choose>
                <%-- show the login form, if user has not logged in --%>
                <c:when test="${empty g_login_userid}">
                    <form name="frm_login" action="h_login.jsp?dest=${redirect}" method="post">
                        <div>UserID: <input type="text" name="userid" value="${param.userid}" /> </div>
                        <div>Password: <input type="password" name="password" value="${param.password}" /> </div>
                        <div>
                            <input type="submit" value="Login" name="login" />                            
                        </div>
                    </form>
                </c:when>
                
                <%-- show logout link, if user has logged in --%>
                <c:otherwise>
                    Welcome ${g_login_name}, <a href="h_logout.jsp?dest=${redirect}">Logout</a>
                </c:otherwise>
            </c:choose>
        </div>
        
        <%--display system messages (if any) --%>
        <c:if test="${not empty g_status_msg}">
            <div>
                <h2>Message Block</h2>
                <p>${g_status_msg}</p>
                <c:remove var="g_status_msg" scope="session" />
            </div>
        </c:if>
        
        <%-- Product Listing Block --%>
        <div>
            <h2>Product Listing Block</h2>
            
            <%-- query the database for product categories --%>
            <sql:query var="categories" dataSource="jdbc/phones">
                SELECT DISTINCT category FROM product
            </sql:query>
            
            <h3>Select a category</h3>
            <%-- did the user submit a choice? --%>            
            <c:if test="${pageContext.request.method=='POST'}">                
                <c:set var="selected_category" value="${param.f_category}" />
            </c:if>
            
            <%-- main form user to choose a category, pick a default category --%>
            <form name="frm_category" method="post" action="index.jsp">
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
            </form>
            
            <%-- get the products in the selected category --%>
            <c:choose>
                <%-- select all products --%>
                <c:when test="${selected_category == 'all'}">
                    <sql:query var="products" dataSource="jdbc/phones">
                        SELECT * FROM product                    
                    </sql:query>
                </c:when>
                        
                <%-- select products which belong to a particular category --%>
                <c:otherwise>
                    <sql:query var="products" dataSource="jdbc/phones">
                        SELECT * FROM product WHERE category=?
                        <sql:param value="${selected_category}" />
                    </sql:query>
                </c:otherwise>
            </c:choose>
                        
            <%-- and display the results --%>
            <table width="100%">
                <%-- build the header row --%>
                <td>ID</td>
                <td>Picture</td>
                <td>Name</td>
                <td>Description</td>
                <td>Price</td>
                
                <%-- add a buy header if we have a valid member --%>
                <c:if test="${not empty g_login_userid}">
                    <td>Purchase</td>
                </c:if>
                    
                <%-- build the products row --%>
                <c:forEach var="row" items="${products.rows}">
                    <tr>
                        <td>${row.id}</td>
                        <td><img src="pictures/${row.image}"/></td>
                        <td><a href="detailedview.jsp?id=${row.id}">${row.name}</a></td>
                        <td>${row.description}</td>
                        <td>${row.price}</td>
                        
                        <%-- add a buy option if we have a valid member --%>
                        <c:if test="${not empty g_login_userid}">
                            <td><a href="h_addproduct.jsp?id=${row.id}&dest=${redirect}">Buy</a></td>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
        </div>      
        
        <%-- display the cart contents only if we have a login member and a valu --%>
        <c:if test="${not empty g_login_userid && not empty g_myCart}">
            <div>
                <h2>Shopping Cart Block</h2>
                <%-- some message to show --%>
                
                <%-- is there anything in the shopping cart --%>
                <c:choose>
                    <%-- empty cart? --%>
                    <c:when test="${g_myCart.noItems == 0}">
                        <p>Shopping cart is empty.</p>                        
                    </c:when>
                    <%-- cart has something --%>
                    <c:otherwise>
                        <table>
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
                                </tr>
                            </c:forEach>
                        </table>
                            
                        <%-- displays checkout link here --%>
                        <p><a href="checkout.jsp">Checkout</a></p>
                    </c:otherwise>
                </c:choose> 
            </div>
        </c:if>
    </body>
</html>

