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
<link href="main.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>P1257506</title>
        <script language="javascript">
            function Validate() {
                var alphalist = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                /*This style doesn't work in firefox browser.*/
		var name = document.frmUser.txtName.value.toUpperCase();
                var userid = document.frmUser.txtUserID.value.toUpperCase();
                var address=document.frmUser.txtAddress.value;
                var em = document.frmUser.txtEmail.value;
                var pw = document.frmUser.txtPassword.value;
                
                var em2 = document.frmUser.txtEmail2.value;
                var pw2 = document.frmUser.txtPassword2.value;

                var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
                /*This style used for all browser*/
                /*
                var name=document.getElementById('txtName').value;
                var nric=document.getElementById('txtNRIC').value;
                var cmt=document.getElementById('txtComment').value;
                var em=document.getElementById('txtEmail').value;
                */
		
                if (name.length <= 0) {
                    alert('There was a problem of submission.\n Name should not be empty.');
                    return false;
                }

                if (userid.length <= 0) {
                    alert('There was a problem of submission.\n User ID should not be empty.');
                    return false;
                }
                
                //length for a string returns the length
                for (var i = 0; i < name.length; i++) {

                    //charAt returns the char at that index position
                    //first char is index 0
                    //alert("char at index position " + i + " is " + name.charAt(i));
                    if (alphalist.indexOf(name.charAt(i)) <= -1) {
                        alert('There was a problem of submission.\n Name should only contain alphabets and whitespace.');
                        return false;
                    }
                }
                                            
                if (em.length <= 0) {
                    alert('There was a problem of submission.\n Email should not be empty.');
                    return false;
                }
                		
                if (em.search(emailRegEx) == -1) {
                  alert("Please enter a valid email address.");
                  return false;
                }

                if (em != em2) {
                  alert("Email addresses do not match.  Please retype them to make sure they are the same.");
                  return false;
                }
		
		if (pw.length <= 0) {
                    alert('There was a problem of submission.\n Password should not be empty.');
                    return false;
                }
                
                if (pw != pw2) {
                  alert("Password do not match.  Please retype them to make sure they are the same.");
                  return false;
                }	
                
                if (address.length <= 0) {
                    alert('There was a problem of submission.\n Address should not be empty.');
                    return false;
                }
                return true;
            }
        </script>        
    </head>
<body>
     <table align="center" width="960px" class="maintable">
            <tr>
                <td class="banner">
                    <table class="navigator">
                        <tr>
                            <td><a href="index.jsp">Home</a></td>
                            <td>|</td>
                            <td><a href="index.jsp">Store</a></td>
                            <td>|</td>
                            <td><a href="feedback.jsp">Feedback</a></td>
                            <td width="100%" align="right">
                                <table class="welcomeuser">
                                    <tr>
                                        <td>
                                            <c:if test="${not empty g_login_userid}">
                                                Welcome ${g_login_name} | <a href="h_logout.jsp?dest=${redirect}">Logout</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </table>    
                            </td>
                        </tr>
                    </table>                    
                </td>
            </tr>
            <tr>
                <td>
                    <div id="main">                           
                        <form name="frmUser" method="post">                                                        
                            <table>
                                <tr>
                                    <td style="color:grey;"><h3>Feedback</h3></td>
                                </tr> 
                                <c:if test="${!empty g_LoginCustomer}">
                                    <tr>
                                        <td style="font-size: 8pt;">
                                            <p>
                                                Dear Member, your member information are filled up automactically and can be changed later.
                                            </p>
                                        </td>
                                    </tr>
                                </c:if>
                                <fmt:formatDate value="<%=new java.util.Date()%>" var="formatPDate" pattern="yyyyMMddhhmmss" />
                                <c:set var="duplicatedfound" value="0" />
                                <c:set var="duplicatedemail" value="0" />
                                <c:set var="duplicateduserid" value="0" />
                                <c:set var="activationid" value="" />
                                <c:if test="${ pageContext.request.method == 'POST'}">
                                    <sql:query dataSource="jdbc/phones" var="checkUserID">
                                        SELECT * FROM APP.CUSTOMERS WHERE userid=?                                        
                                        <sql:param value="${param.UserID}" />                                    
                                    </sql:query>
                                    <c:if test="${!empty checkUserID && checkUserID.rowCount>0}">
                                        <c:set var="duplicateduserid" value="1" />
                                    </c:if>
                                        
                                    <sql:query dataSource="jdbc/phones" var="checkEmail">
                                        SELECT * FROM APP.CUSTOMERS WHERE email=?
                                        <sql:param value="${param.email}" />                                
                                    </sql:query>
                                    <c:if test="${!empty checkEmail && checkEmail.rowCount>0}">
                                        <c:set var="duplicatedemail" value="1" />
                                    </c:if>
                                        
                                    <sql:query dataSource="jdbc/phones" var="selectCustomer">
                                        SELECT * FROM APP.CUSTOMERS WHERE email=? OR userid=?
                                        <sql:param value="${param.email}" />
                                        <sql:param value="${param.UserID}" />                                    
                                    </sql:query>
                                    <c:choose>
                                        <c:when test="${!empty selectCustomer && selectCustomer.rowCount>0}">
                                            <c:set var="duplicatedfound" value="1" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="activationid" value="ACTIVATE-${formatPDate}${param.email}" />
                                                <%----%>
                                                <c:catch var="exception">
                                                    <sql:update dataSource="jdbc/phones" var="updatedTable">
                                                        INSERT INTO APP.CUSTOMERS (EMAIL, "NAME", USERID, PASSWORD, CONTACTNUMBER, ADDRESS, ACTIVATIONID, ACTIVATED)
                                                        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                                                        <sql:param value="${param.email}" />
                                                        <sql:param value="${param.Name}" />
                                                        <sql:param value="${param.UserID}" />
                                                        <sql:param value="${param.Password}" />
                                                        <sql:param value="${param.ContactNumber}" />
                                                        <sql:param value="${param.Address}" />
                                                        <sql:param value="${activationid}" />
                                                        <sql:param value="${0}" />
                                                    </sql:update>
                                                    <c:if test="${updatedTable>=1}">
                                                        <c:redirect url="registeruserack.jsp?name=${param.Name}&actid=${activationid}" />
                                                    </c:if>
                                                </c:catch>
                                                <c:if test="${exception!=null}">
                                                    <tr>
                                                        <td style="color:red;">${exception}</td>
                                                    </tr>
                                                </c:if>     
                                                <%----%>  
                                        </c:otherwise>
                                    </c:choose>                                                                          
                                </c:if> 
                                <tr>
                                    <td>
                                        <table style="font-size:10pt; border: 1px solid rgb(239, 239, 239);" border="0" align=center cellpadding="0" cellspacing="0">
                                            <tbody>
                                            <tr>
                                                <td style="padding: 3px; vertical-align: top; background-color: rgb(239, 239, 239);">
                                                <strong>Name <font color=red>*</font></strong>
                                                </td>
                                                <td style="background-color: rgb(239, 239, 239);" valign="top">:</td>
                                                <td style="padding: 3px; width: 293px; background-color: rgb(239, 239, 239);" valign="middle">
                                                <input type=text id=txtName name="Name" value="${!empty param.Name ? param.Name : !empty g_LoginCustomer ? g_LoginCustomer.name : param.Name}" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px;">
                                                <strong>User ID <font color=red>*</font></strong>
                                                </td>
                                                <td valign="top">:</td>
                                                <td style="padding: 3px; width: 236px;" valign="middle">
                                                <input type=text id=txtUserID name="UserID" value="${!empty param.UserID ? param.UserID : !empty g_LoginCustomer ? g_LoginCustomer.name : param.Name}" />
                                                <c:if test="${duplicateduserid==1}">
                                                    <font style="font-size:7pt;color:red;font-weight:bold;"><nobr>UserID already in used.</nobr></font>
                                                </c:if>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px;background-color: rgb(239, 239, 239);" valign="top">
                                                    <strong>Contact Number</strong>
                                                </td>
                                                <td style="background-color: rgb(239, 239, 239);" valign="top">:</td>
                                                <td style="padding: 3px; width: 293px; background-color: rgb(239, 239, 239);" valign="middle">
                                                <input type=text id=txtContactNumber name="ContactNumber" value="${!empty param.ContactNumber ? param.ContactNumber : !empty g_LoginCustomer ? g_LoginCustomer.contactnumber : param.ContactNumber}" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px;" valign="top">
                                                <strong>Email Address <font color=red>*</font></strong>
                                                </td>
                                                <td valign="top">:</td>
                                                <td style="padding: 3px; width: 293px;" valign="middle">
                                                <input type=text id=txtEmail name="email" value="${!empty param.email ? param.email : !empty g_LoginCustomer ? g_LoginCustomer.email : param.email}" />
                                                <c:if test="${duplicatedemail==1}">
                                                    <font style="font-size:7pt;color:red;font-weight:bold;"><nobr>Email already in used.</nobr></font>
                                                </c:if>
                                                <br />
                                                <input type=text id=txtEmail2 value="${!empty param.email ? param.email : !empty g_LoginCustomer ? g_LoginCustomer.email : param.email}" />&nbsp;<font style="font-size:7pt;color:red;font-weight:bold;">Retype email address.								
                                                </font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px; vertical-align: top; background-color: rgb(239, 239, 239);" valign="top">
                                                <strong>Password <font color=red>*</font></strong>
                                                </td>
                                                <td style="background-color: rgb(239, 239, 239);" valign="top">:</td>
                                                <td style="padding: 3px; vertical-align: top; background-color: rgb(239, 239, 239);" valign="middle">
                                                <input type=password id=txtPassword name="Password" value="${!empty param.Password ? param.Password : ''}" /><br />
                                                <input type=password id=txtPassword2 value="" />&nbsp;<font style="font-size:7pt;color:red;font-weight:bold;">Retype password.								
                                                </font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px;" valign="top">
                                                    <strong>Address <font color=red>*</font></strong>
                                                </td>
                                                <td valign="top">:</td>
                                                <td style="padding: 3px; width: 293px;" valign="top">
                                                <textarea id="txtAddress" cols="40" name="Address" rows="5" maxlength="1000">${param.Address}</textarea></td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan=2 style="font-size:8pt;"><font color=red>*</font> Mandatory field</td>
                                </tr>
                                <tr>
                                    <td colspan=2>
                                        <table>
                                            <tr>
                                                <td class="style1">
                                                    <%-- onclick="return Validate();" --%>
                                                    <input id="Submit1" type="submit" value="Submit" onclick="return Validate();" />
                                                </td>
                                                <td class="style1">
                                                    <input id="Button1" type="button" onclick="javascript:location.href('index.jsp');" value="Cancel" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>  
                        </form>
                        <br class="clear" />	  
                        <br class="clear" />
                        <br class="clear" />				
                    </div>                    
                </td>
            </tr>
            <tr>
                <td>
                    <p class="img_privacy_info">
                        All images and other copyrighted materials used in this project are for educational
                        purposes, and the copyright of the materials remain the property of the respective owners.<br>
                        Refer <a class="imgfooterlink" href="http://www.gsmarena.com/">here</a> for the list of materials used. Email <a class="imgfooterlink" href="mailto:ndminnaing@gmail.com">me</a> if you are the owner and you would like
                        to have them removed on this site.
                    </p>                    
                </td>
            </tr>            
        </table>
</body>    
</html>
