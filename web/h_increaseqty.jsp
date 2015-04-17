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
        <c:set var="g_status_msg" value="Increase Quantity failed." scope="session" />
        
        <%-- ensure we have valid info before increasing the quantity --%>
        <c:if test="${not empty g_login_userid && not empty param.id && not empty g_myCart}">
            <jsp:setProperty name="g_myCart" property="increaseProduct" value="${param.id}" />
            <c:set var="g_status_msg" value="Increase Quantity successful." scope="session" />
        </c:if>
        <c:redirect url="${param.dest}" />
    </body>
</html>
