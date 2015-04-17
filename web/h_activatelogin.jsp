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
        <title>P1257506</title>
    </head>
    <body>
        <%-- have a variable to store some useful message to be displayed later --%>
        <c:set var="g_status_msg" value="Login failed." scope="session" />
        
        <%-- did the user attempt to login, and do we have all the login info --%>
        <c:if test="${not empty param.actid}">
            <sql:query var="db_activator" dataSource="jdbc/phones">
                SELECT userid, password, name, email, contactnumber, address, isadmin FROM APP.CUSTOMERS
                WHERE activationid=? AND activated=0
                <sql:param value="${param.actid}"></sql:param>
            </sql:query>
            <c:choose>
                  <c:when test="${!empty db_activator && db_activator.rowCount>0}">
                        <c:catch var="exception">
                            <sql:update dataSource="jdbc/phones" var="updatedTable">
                                UPDATE APP.CUSTOMERS SET ACTIVATED=1
                                WHERE ACTIVATIONID=?
                                <sql:param value="${param.actid}" />
                            </sql:update>
                            <c:if test="${updatedTable>=1}">
                                <c:set var="g_isadminuser" value="0" scope="session" />
                                <c:if test="${db_activator.rows[0].isadmin == 1}">
                                    <c:set var="g_isadminuser" value="1" scope="session" />
                                </c:if>
                                <%-- let's set the global userid and card for use --%>
                                <c:set var="g_login_userid" value="${db_activator.rows[0].userid}" scope="session" />
                                <c:set var="g_login_name" value="${db_activator.rows[0].name}" scope="session" />
                                <jsp:useBean id="g_myCart" class="myShop.CartBean" scope="session" />
                                <jsp:useBean id="g_LoginCustomer" class="myShop.CustomerBean" scope="session" />

                                <jsp:setProperty name="g_LoginCustomer" property="email" value="${db_activator.rows[0].email}"/>
                                <jsp:setProperty name="g_LoginCustomer" property="name" value="${db_activator.rows[0].name}"/>
                                <jsp:setProperty name="g_LoginCustomer" property="userid" value="${db_activator.rows[0].userid}"/>
                                <jsp:setProperty name="g_LoginCustomer" property="address" value="${db_activator.rows[0].address}"/>
                                <jsp:setProperty name="g_LoginCustomer" property="contactnumber" value="${db_activator.rows[0].contactnumber}"/>

                                  <%--jsp:getProperty name="g_LoginCustomer" property="email" /--%>
                                <c:set var="g_status_msg" value="Login successful." scope="session" />
                                
                                <c:set var="surl" value="${fn:replace(param.dest, '^', '?')}" />
                                <c:redirect url="${surl}" />
                            </c:if>
                        </c:catch>
                        <c:if test="${exception!=null}">
                            <tr>
                                <td style="color:red;">${exception}</td>
                            </tr>
                        </c:if>  
                  </c:when>
                  <c:otherwise>
                      Activated already.<br>
                      <a href="index.jsp">Go to home page</a>
                  </c:otherwise>    
            </c:choose>
        </c:if>
    </body>
</html>
