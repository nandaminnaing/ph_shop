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
        <%-- have a variable to store some useful message to be displayed later --%>
        <c:set var="g_status_msg" value="Login failed." scope="session" />
        
        <%-- did the user attempt to login, and do we have all the login info --%>
        <c:if test="${ pageContext.request.method == 'POST' &&
                      not empty param.userid &&
                      not empty param.password}">
              <%-- authorise login info, let's try to find if there's such an user --%>
              <%--sql:query var="db_result" dataSource="jdbc/phones">
                  SELECT username, password, name FROM USERS
                  WHERE username=? AND password=?
                  <sql:param value="${param.userid}"></sql:param>
                  <sql:param value="${param.password}"></sql:param>
              </sql:query--%> 

              <sql:query var="db_result" dataSource="jdbc/phones">
                  SELECT userid, password, name, email, contactnumber, address, isadmin FROM APP.CUSTOMERS
                  WHERE userid=? AND password=? AND activated=1
                  <sql:param value="${param.userid}"></sql:param>
                  <sql:param value="${param.password}"></sql:param>
              </sql:query>
                    
              <%-- we should only have on result for a good match --%>
              <%-- let's set the global userid and card for use --%>
              <%--<c:if test="${db_result.rowCount == 1}">
                  <c:set var="g_login_userid" value="${db_result.rows[0].username}" scope="session" />
                  <c:set var="g_login_name" value="${db_result.rows[0].name}" scope="session" />
                  <jsp:useBean id="g_myCart" class="myShop.CartBean" scope="session" />
                  
                  <c:set var="g_status_msg" value="Login successful." scope="session" />
              </c:if>
              --%>
              
                <c:if test="${db_result.rowCount == 1}">
                    <c:set var="g_isadminuser" value="0" scope="session" />
                    <c:if test="${db_result.rows[0].isadmin == 1}">
                        <c:set var="g_isadminuser" value="1" scope="session" />
                    </c:if>
                    <%-- let's set the global userid and card for use --%>
                    <c:set var="g_login_userid" value="${db_result.rows[0].userid}" scope="session" />
                    <c:set var="g_login_name" value="${db_result.rows[0].name}" scope="session" />
                    <jsp:useBean id="g_myCart" class="myShop.CartBean" scope="session" />
                    <jsp:useBean id="g_LoginCustomer" class="myShop.CustomerBean" scope="session" />

                    <jsp:setProperty name="g_LoginCustomer" property="email" value="${db_result.rows[0].email}"/>
                    <jsp:setProperty name="g_LoginCustomer" property="name" value="${db_result.rows[0].name}"/>
                    <jsp:setProperty name="g_LoginCustomer" property="userid" value="${db_result.rows[0].userid}"/>
                    <jsp:setProperty name="g_LoginCustomer" property="address" value="${db_result.rows[0].address}"/>
                    <jsp:setProperty name="g_LoginCustomer" property="contactnumber" value="${db_result.rows[0].contactnumber}"/>

                      <%--jsp:getProperty name="g_LoginCustomer" property="email" /--%>
                    <c:set var="g_status_msg" value="Login successful." scope="session" />
                </c:if>
                <c:if test="${db_result.rowCount<=0}">
                    <sql:query var="db_activate" dataSource="jdbc/phones">
                      SELECT userid, password, name, email, contactnumber, address, isadmin FROM APP.CUSTOMERS
                      WHERE userid=? AND password=? AND activated=0
                      <sql:param value="${param.userid}"></sql:param>
                      <sql:param value="${param.password}"></sql:param>
                    </sql:query>
                      <c:if test="${db_activate.rowCount==1}">
                        <c:set var="g_status_msg" value="Account not activated." scope="session" />
                    </c:if>
                </c:if>
        </c:if>
                        
        <c:set var="surl" value="${fn:replace(param.dest, '^', '?')}" />
         ${g_LoginCustomer.email} - ${db_result.rows[0].email}
        <c:redirect url="${surl}" />
    </body>
</html>
