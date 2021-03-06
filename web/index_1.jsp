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
        <h1>Hello World!</h1>
        <%--JDBC query
        <sql:query var="myRecords" dataSource="jdbc/stocks">
            SELECT * FROM APP.PHOTO
        </sql:query>--%>
            
            
        <sql:query var="myRecords" dataSource="jdbc/stocks">
            SELECT * FROM PHOTO WHERE author like ?
            <sql:param value="%%" />
        </sql:query>
        <%--Using Data and Showing by looping--%>
        <c:forEach var="currentRow" items="${myRecords.rows}">
            ${currentRow.id} - ${currentRow.author} <br>
        </c:forEach>
    </body>
</html>
