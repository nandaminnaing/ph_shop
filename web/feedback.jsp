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
		var name = document.frmFeedback.txtName.value.toUpperCase();
                var nric = document.frmFeedback.txtNRIC.value.toUpperCase();
                var cmt = document.frmFeedback.txtComment.value;
                var em = document.frmFeedback.txtEmail.value;
                
                var em2 = document.frmFeedback.txtEmail2.value;

                var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
                /*This style used for all browser*/
                /*
                var name=document.getElementById('txtName').value;
                var nric=document.getElementById('txtNRIC').value;
                var cmt=document.getElementById('txtComment').value;
                var em=document.getElementById('txtEmail').value;
                */
				
                var nriclist = "ST";
                var finlist = "GT";
                var msg = "";

                if (cmt.length <= 0) {
                    alert('There was a problem of submission.\n Comment should not be empty.');
                    return false;
                }

                if (name.length <= 0) {
                    alert('There was a problem of submission.\n Name should not be empty.');
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
				
                if(nric.length<9){
                    alert('There was a problem of submission.\nSingapore NRIC found invalid. \n Please follow this format S5554447T.');
                    return false;
                }
					
                var midnric = nric.substring(1, 8);
                for (var i = 0; i < midnric.length; i++) {
                    if (isNaN(midnric.charAt(i))) {
                        alert('There was a problem of submission.\nSingapore NRIC should followed by 7 numbers.');
                        return false;
                    }
                }

                var prefixnric = nric.substring(0, 1);
                if (nriclist.indexOf(prefixnric) <= -1 && finlist.indexOf(prefixnric) <= -1) {
                    alert('There was a problem of submission.\n NRIC\\FIN should starts with S or G.');
                    return false;
                }
				
                var suffixnric = nric.substring(9, 1);
                if (! isNaN(suffixnric)) {
                        alert('There was a problem of submission.\n NRIC\\FIN should end with alphabet.');
                        return false;
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
				
                return true;
            }
        </script>        
    </head>
<body>
     <table align="center" width="960px" class="maintable">
            <tr>
                <td class="banner">
                    
                    <table>
                        <tr>
                            <td class="navigator"><a href="index.jsp">Home</a></td>
                            <td class="navigator">|</td>
                            <td class="navigator"><a href="index.jsp">Store</a></td>
                            <td class="navigator">|</td>
                            <td class="navigator"><a href="feedback.jsp">Feedback</a></td>
                            <td width="100%" align="right">
                                <table class="welcomeuser">
                                    <tr>
                                        <c:if test="${not empty g_login_userid}">
                                            <td>Welcome ${g_login_name}</td>
                                            <td>|</td>
                                            <td class="navigator">
                                                <a href="h_logout.jsp?dest=${redirect}">Logout</a>
                                            </td>
                                        </c:if>
                                        <c:if test="${empty g_login_userid}">
                                            <td>New to MyPhoneShop?</td>
                                            <td>|</td>
                                            <td class="navigator"><a href="registeruser.jsp">Click here to register.</a></td>
                                        </c:if>                                                                                        
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
                        <form name="frmFeedback" method="post">                                                        
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
                                <c:if test="${ pageContext.request.method == 'POST'}">
                                    <c:catch var="exception">
                                        <c:set var="now" value="<%=new java.util.Date()%>" />
                                        <c:set var="loginuser" value="" />
                                        <c:if test="${!empty g_LoginCustomer}">
                                            <c:set var="loginuser" value="${g_LoginCustomer.userid}" />
                                        </c:if>
                                        <sql:update dataSource="jdbc/phones" var="updatedTable">
                                            INSERT INTO APP.FEEDBACK (FEEDBACK_TIMESTAMP,FEEDBACK_DATE,FEEDBACK_TIME,NAME, NRIC, CONTACTNUMBER, EMAIL, ENQUIRYTYPE, COMMENT, LOGINUSERID) 
                                            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                                            <sql:dateParam value="${now}" type="TIMESTAMP" />
                                            <sql:dateParam value="${now}" type="DATE" />
                                            <sql:dateParam value="${now}" type="TIME" />
                                            <sql:param value="${param.Name}" />
                                            <sql:param value="${param.NRIC}" />
                                            <sql:param value="${param.ContactNumber}" />
                                            <sql:param value="${param.email}" />
                                            <sql:param value="${param.EnquiryType}" />
                                            <sql:param value="${param.Comment}" />
                                            <sql:param value="${loginuser}" />
                                        </sql:update>
                                        <c:if test="${updatedTable>=1}">
                                            <%--font size="5" color='green'> Congratulations ! Data inserted
                                            successfully.</font--%>
                                            <c:redirect url="feedbackack.jsp?name=${param.Name}" />
                                        </c:if>
                                    </c:catch>
                                    <c:if test="${exception!=null}">
                                        <tr>
                                            <td style="color:red;">${exception}</td>
                                        </tr>
                                        <%-- c:out value="Unable to insert data in database.${exception}" / --%>
                                    </c:if>        
                                </c:if>                                
                                <tr>
                                    <td>
                                        <table style="font-size:10pt; border: 1px solid rgb(239, 239, 239);" border="0" align=center cellpadding="0" cellspacing="0">
                                            <tbody>
                                            <tr>
                                                <td style="padding: 3px; vertical-align: top; background-color: rgb(239, 239, 239);">
                                                <strong>Name <font color=red>*</font> :</strong>
                                                </td>
                                                <td
                                                style="padding: 3px; width: 293px; background-color: rgb(239, 239, 239);"
                                                valign="middle">
                                                <input type=text id=txtName name="Name" value="${!empty param.Name ? param.Name : !empty g_LoginCustomer ? g_LoginCustomer.name : param.Name}" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px; width: 236px;" valign="top">
                                                    <strong>NRIC\FIN <font color=red>*</font> :</strong>
                                                </td>
                                                <td style="padding: 3px; width: 293px;" valign="middle">
                                                <input type=text id=txtNRIC name="NRIC" value="${param.NRIC}" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px; width: 236px; background-color: rgb(239, 239, 239);"
                                                valign="top">
                                                    <strong>Contact Number :</strong>
                                                </td>
                                                <td style="padding: 3px; width: 293px; background-color: rgb(239, 239, 239);"
                                                valign="middle">
                                                <input type=text id=txtContactNumber name="ContactNumber" value="${!empty param.ContactNumber ? param.ContactNumber : !empty g_LoginCustomer ? g_LoginCustomer.contactnumber : param.ContactNumber}" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px; width: 236px;" valign="top">
                                                <strong>Email Address <font color=red>*</font> :</strong>
                                                </td>
                                                <td style="padding: 3px; width: 293px;" valign="middle">
                                                <input type=text id=txtEmail name="email" value="${!empty param.email ? param.email : !empty g_LoginCustomer ? g_LoginCustomer.email : param.email}" /><br />
                                                <input type=text id=txtEmail2 value="${!empty param.email ? param.email : !empty g_LoginCustomer ? g_LoginCustomer.email : param.email}" />&nbsp;<font style="font-size:7pt;color:red;font-weight:bold;">Retype email address.								
                                                </font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px; width: 236px; background-color: rgb(239, 239, 239);"
                                                valign="top">
                                                    <strong>Type of Enquiry <font color=red>*</font> :</strong>
                                                </td>
                                                <td
                                                style="padding: 3px; width: 293px; background-color: rgb(239, 239, 239);"
                                                valign="middle">
                                                <select id=cboEnquiryType name="EnquiryType">
                                                    <option selected=selected>General</option>
                                                    <option ${param.EnquiryType == 'Feedback' ? 'selected' : ''}>Feedback</option>
                                                    <option ${param.EnquiryType == 'Delivery' ? 'selected' : ''}>Delivery</option>
                                                </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 3px; width: 236px;" valign="top">
                                                    <strong>Comment <font color=red>*</font> :</strong>
                                                </td>
                                                <td style="padding: 3px; width: 293px;" valign="top">
                                                <textarea id="txtComment" cols="40" name="Comment" rows="10" maxlength="1000">${param.Comment}</textarea></td>
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
