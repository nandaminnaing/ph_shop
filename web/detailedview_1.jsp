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
        
        <%-- Detailed Product View Block --%>
        <div>
            <h2>Detailed Product View Block</h2>
            
            <%-- do we have any product ID --%>
            <c:choose>
                <%-- only attempt to load the product when we have an id --%>
                <c:when test="${not empty param.id}">
                    <%-- get the product with the passed in ID --%>
                    <sql:query var="rs" dataSource="jdbc/phones">
                        SELECT * FROM product
                        WHERE id=?
                        
                        <sql:param value="${param.id}" />
                    </sql:query>
                        
                    <%-- did we find any product with that ID? --%>
                    <c:choose>
                        <%-- show the product if we found it --%>
                        <c:when test="${rs.rowCount == 1}">
                            <table>
                                <%-- build the header row --%>  
                                <tr>
                                    <td>ID</td>
                                    <td>Picture</td>
                                    <td>Name</td>
                                    <td>Description</td>
                                    <td>Price</td>

                                    <%-- add a buy header if we have a valid member --%>
                                    <c:if test="${not empty g_login_userid}">
                                        <td>Purchase</td>
                                    </c:if>
                                </tr>
                                
                                <%-- show the product's full details --%> 
                                <tr>
                                    <td>${rs.rows[0].id}</td>
                                    <td>${rs.rows[0].name}</td>
                                    <td><img src="pictures/${rs.rows[0].image}"/></td>
                                    <td>${rs.rows[0].description}</td>
                                    <td>${rs.rows[0].price}</td>

                                    <%-- add a buy option if we have a valid member --%>
                                    <c:if test="${not empty g_login_userid}">
                                        <td><a href="h_addproduct.jsp?id=${rs.rows[0].id}&dest=${redirect}">Buy</a></td>
                                    </c:if>                                
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
        </div>
    </body>
</html>
