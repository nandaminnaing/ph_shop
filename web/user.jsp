<%-- 
    Document   : user
    Created on : Dec 10, 2012, 11:14:16 AM
    Author     : nanda.minnaing
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
        <h1>Hello World!</h1>
        <sql:query var="myRecords" dataSource="jdbc/phones">
            SELECT * FROM USERS WHERE name like ?
            <sql:param value="%%" />
        </sql:query>
        <%--Using Data and Showing by looping--%>
        <c:forEach var="currentRow" items="${myRecords.rows}">
            ${currentRow.id} - ${currentRow.name} <br>
        </c:forEach>   
        <form action="user.jsp" method="post">
            <c:set var="uid" value="${param.txtuid}" />
            <c:set var="pwd" value="${param.txtpwd}" />
            <!--${uid} - ${pwd}-->
            <sql:query var="myRecords" dataSource="jdbc/phones">
                SELECT * FROM USERS WHERE name = ? AND password = ?
                <sql:param value="${uid}" />
                <sql:param value="${pwd}" />
            </sql:query>
            <c:forEach var="currentRow" items="${myRecords.rows}">
                
            </c:forEach> 
            <c:choose>
            <c:when test="${myRecords.rowCount > 0}">
                    <c:set var="showlogin" value="false" /> 
                    <c:set var="username" scope="session" 
                        value="${myRecords.rows[0].name}" />
            </c:when>                                 
            </c:choose>
            <c:choose>
                <c:when test="${sessionScope.username == null || sessionScope.username == ''}">
                    <input type="text" id="txtuid" name="txtuid" />
                    <input type="password" id="txtpwd" name="txtpwd" />
                    <input type="submit" id="btnsubmit" value="login" />
                </c:when>
                <c:otherwise>
                    found user: ${username} <br>
                </c:otherwise>
            </c:choose>             
        </form>
    </body>
</html>
