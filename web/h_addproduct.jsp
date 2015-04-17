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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:set var="g_status_msg" value="Add Product failed." scope="session" />
        
        <c:if test="${not empty g_login_userid && not empty param.id && not empty g_myCart}">
            <sql:query var="rs" dataSource="jdbc/phones">
                SELECT * FROM product WHERE id=?
                <sql:param value="${param.id}" />
            </sql:query>

            <c:if test="${rs.rowCount == 1}" >
                <jsp:useBean id="product" class="myShop.ProductBean" />
                
                <jsp:setProperty name="product" property="prodID" value="${rs.rows[0].id}"/>
                <jsp:setProperty name="product" property="prodName" value="${rs.rows[0].name}"/>
                <jsp:setProperty name="product" property="prodDesc" value="${rs.rows[0].description}"/>
                <jsp:setProperty name="product" property="prodPrice" value="${rs.rows[0].price}"/>
                <jsp:setProperty name="product" property="prodQty" value="1"/>
                <jsp:setProperty name="product" property="extraField1" value="${rs.rows[0].image}"/>
                <jsp:setProperty name="product" property="extraField2" value="extra details"/>
                
                <jsp:setProperty name="g_myCart" property="addProduct" value="${product}" />
                <c:set var="g_status_msg" value="Add Product successful." scope="session" />
            </c:if>
        </c:if>
                
        <c:set var="surl" value="${fn:replace(param.dest, '^', '?')}" />
        <c:redirect url="${surl}" />
    </body>
</html>
