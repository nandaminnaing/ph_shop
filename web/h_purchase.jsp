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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:set var="g_status_msg" value="Remove Product failed." scope="session" />
        
        <%-- authenticate user and ensure we have valid data --%>
        <c:if test="${not empty g_myCart}">
            <%-- is there anything in the shopping cart? --%>
            <c:choose>
                <%-- empty cart? --%>
                <c:when test="${g_myCart.noItems == 0}">
                    <p>Shopping cart is empty.</p>                        
                </c:when>
                <%-- cart has something --%>
                <c:otherwise>
                        <fmt:formatDate value="<%=new java.util.Date()%>" var="formatPDate" pattern="yyyyMMddhhmmss" />
                        <%--p>Parsed Date: <c:out value="${formatPDate}" /></p--%>
                        <c:set var="icount" value="0"/>
                        <%-- list out all the items in the shopping cart --%>
                        <%----%>
                        ${param.securitycode}
                        <c:catch var="exception">
                        <c:set var="purchase_id" value="P-${formatPDate}" />                         
                        <sql:transaction  dataSource="jdbc/phones">
                            <%-- Insert into purcase header --%>
                            <c:if test="${!empty g_LoginCustomer}">
                                <fmt:formatDate value="${g_LoginCustomer.expiry}" var="formatExpiry" pattern="dd/MM/yyyy" />
                                <sql:update>
                                    INSERT INTO APP.PURCHASE (PURCHASE_REFNO,CUSTOMER_EMAIL,CARDHOLDERNAME,CARDNUMBER,SCODE,CARD_EXPIRY,SHIPPING_ADDRESS,P_TIMESTAMP) 
                                    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                                    <sql:param value="${purchase_id}" />
                                    <sql:param value="${g_LoginCustomer.email}" />
                                    <sql:param value="${g_LoginCustomer.cardholdername}" />
                                    <sql:param value="${g_LoginCustomer.cardno}" />
                                    <sql:param value="${g_LoginCustomer.securitycode}" />
                                    <sql:param value="${formatExpiry}" />
                                    <sql:param value="${g_LoginCustomer.address}" />
                                    <sql:dateParam value="<%=new java.util.Date()%>" type="TIMESTAMP" />
                                </sql:update>  
                            </c:if>
                            
                            <%-- Insert into purcase items --%>
                            <c:forEach items="${g_myCart.products}" var="curProd">                                                                                             
                                <jsp:useBean id="curProd" class="myShop.ProductBean" />
                                <c:set var="icount" value="${icount+1}"/>  
                                <sql:update>
                                INSERT INTO APP.PURCHASE_ITEMS (PURCHASE_REFNO,PRODUCT_ID,QUANTITY,PRICE,SRNO) 
                                VALUES (?, ?, ?, ?, ?)
                                <sql:param value="${purchase_id}" />
                                <sql:param value="${curProd.prodID}" />
                                <sql:param value="${curProd.prodQty}" />
                                <sql:param value="${curProd.prodPrice}" />
                                <sql:param value="${icount}" />
                                </sql:update>                                    
                            </c:forEach>
                        </sql:transaction>
                        </c:catch>
                        <c:if test="${exception!=null}">
                            <c:out value="Unable to insert data in database.${exception}" />
                        </c:if>
                        <c:if test="${exception==null}">                            
                            <c:redirect url="h_clearcart.jsp?dest=paymentack.jsp" />                            
                        </c:if> 
                        <%----%>
                </c:otherwise>
            </c:choose> 
        </c:if>               
    </body>
</html>
