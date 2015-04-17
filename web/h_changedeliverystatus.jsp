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
        <c:set var="g_status_msg" value="Increase Quantity failed." scope="session" />
        
        <%-- ensure we have valid info before increasing the quantity --%>
        <c:if test="${param.status!=null}">                
            <c:set var="selected_status" value="${param.status}" />
            ${param.pid} will be changed ${param.status}

            <c:catch var="exception">
                <sql:update dataSource="jdbc/phones" var="updatedTable">
                    UPDATE APP.PURCHASE SET DELIVERY_STATUS=?
                    WHERE PURCHASE_REFNO=?
                    <sql:param value="${param.status}" />
                    <sql:param value="${param.pid}" />
                </sql:update>
                <c:if test="${updatedTable>=1}">
                    <c:set var="surl" value="${fn:replace(param.dest, '^', '?')}" />
                    <c:redirect url="${surl}" />
                </c:if>
            </c:catch>
            <c:if test="${exception!=null}">
                ${exception}
            </c:if>   
        </c:if> 
        <%--c:redirect url="${param.dest}" /--%>
    </body>
</html>
