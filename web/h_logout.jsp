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
        <%-- clear all the global variables --%>
        <c:remove var="g_login_userid" scope="session" />
        <c:remove var="g_login_name" scope="session" />
        <c:remove var="g_myCart" scope="session" />
        <c:remove var="g_LoginCustomer" scope="session" />
        <c:set var="g_status_msg" value="Logout successful." scope="session" />
        <c:redirect url="${param.dest}" />
    </body
</html>
