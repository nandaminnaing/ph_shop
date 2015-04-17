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
<%-- construct our current URI, complete with query string --%>
<%
    String querystring="";
    if (request.getQueryString() != null)
        querystring="?" + request.getQueryString();
    
        pageContext.setAttribute("redirect", request.getRequestURL() + querystring);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>P1257506</title>
        <script language="javascript">
            function Validate() {
                var alphalist = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                
                var name = document.frmPayment.txtCardHolderName.value.toUpperCase();
                var card = document.frmPayment.txtCardNumber.value;
                var securitycode = document.frmPayment.txtSecurityCode.value;
                var selectedmonth=document.frmPayment.month.value;
                var selectedyear=document.frmPayment.year.value;
                /*var cmt = document.frmPayment.txtComment.value;
                var em = document.frmPayment.txtEmail.value;
		var em2 = document.frmPayment.txtEmail2.value;*/
		var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
			
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
                
                if (card.length <= 0) {
                    alert('There was a problem of submission.\nCard Number should not be empty.');
                    return false;
                }
                
                if (isNaN(card)) {
                    alert('There was a problem of submission.\nCard Number should be numeric value.');
                    return false;
                }
                
                if (card.length!=16) {
                    alert('There was a problem of submission.\nCard Number should be 16 digits value.');
                    return false;
                }
                
                if (securitycode.length <= 0) {
                    alert('There was a problem of submission.\nSecurity Code should not be empty.');
                    return false;
                }                
                
                if (isNaN(securitycode)) {
                    alert('There was a problem of submission.\nSecurity Code should be numeric value.');
                    return false;
                }
                
                if (securitycode.length!=3) {
                    alert('There was a problem of submission.\nSecurity Code should be 3 digits value.');
                    return false;
                }
                
                if (selectedmonth==''){
                    alert('There was a problem of submission.\nSelected Month is empty for expirary.');
                    return false;
                }
                
                if (selectedyear==''){
                    alert('There was a problem of submission.\nSelected Year is empty for expirary.');
                    return false;
                }
                
                return true;

                if (cmt.length <= 0) {
                    alert('There was a problem of submission.\n Comment should not be empty.');
                    return false;
                }
                			
                if(nric.length<9){
                    alert('There was a problem of submission.\nSingapore NRIC found invalid.');
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
                if (nriclist.indexOf(prefixnric) <= -1) {
                    alert('There was a problem of submission.\nSingapore NRIC should starts with S or T.');
                    return false;
                }
				
                var suffixnric = nric.substring(9, 1);
                if (! isNaN(suffixnric)) {
                    alert('There was a problem of submission.\nSingapore NRIC should end with alphabet.');
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
        <c:if test="${empty g_login_userid}">
            <c:redirect url="${param.dest}" />
        </c:if>
        <table align="center"  style="border-color:whitesmoke;border-style: solid; border-width: 1px;" width="960px">
            <tr>
                <td class="banner">
                    <table class="navigator">
                        <tr>
                            <td><a href="index.jsp">Home</a></td>
                            <td>|</td>
                            <td><a href="index.jsp">Store</a></td>
                            <td>|</td>
                            <td><a href="feedback.jsp">Feedback</a></td>
                            <c:if test="${not empty g_login_userid}">
                            <td>|</td>    
                            <td>
                                <a href="purchasehistory.jsp"><nobr>Purchase history</nobr></a>
                            </td>
                            </c:if>
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
                    <table width="100%" border="0" style="border-color:whitesmoke;border-style: solid; border-width: 1px;">
                        <tr>
                            <td id="checkout" width="90%">
                                <c:if test="${not empty g_myCart}">
                                    <%-- is there anything in the shopping cart? --%>
                                    <c:choose>
                                        <%-- empty cart? --%>
                                        <c:when test="${g_myCart.noItems == 0}">
                                            <p>Shopping cart is empty.</p>                        
                                        </c:when>
                                        <%-- cart has something --%>
                                        <c:otherwise>
                                            <form name="frmPayment" action="confirm.jsp">
                                            <table class="paymenttable">
                                                <tr>
                                                    <td class="paymentheader">Payment</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table class="paymenttable">
                                                            <tr>
                                                                <td>Card Holder Name <font color=red>*</font></td>
                                                                <td>:</td>
                                                                <td><input type="text" id="txtCardHolderName" name="cardholdername" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Credit/Debit Card Number <font color=red>*</font></td>
                                                                <td>:</td>
                                                                <td><input type="text" id="txtCardNumber" name="cardnumber" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Security Code <font color=red>*</font></td>
                                                                <td>:</td>
                                                                <td><input type="text" id="txtSecurityCode" size="5" name="securitycode" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Expiry <font color=red>*</font></td>
                                                                <td>:</td>
                                                                <td>
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <select name="month" name="month">
                                                                                    <option>-Month-</option>
                                                                                    <%--
                                                                                    <option value="January">Jan</option>
                                                                                    <option value="February">Feb</option>
                                                                                    <option value="March">Mar</option>
                                                                                    <option value="April">Apr</option>
                                                                                    <option value="May">May</option>
                                                                                    <option value="June">Jun</option>
                                                                                    <option value="July">Jul</option>
                                                                                    <option value="August">Aug</option>
                                                                                    <option value="September">Sep</option>
                                                                                    <option value="October">Oct</option>
                                                                                    <option value="November">Nov</option>
                                                                                    <option value="December">Dec</option>
                                                                                    --%>
                                                                                    <option value="01">Jan</option>
                                                                                    <option value="02">Feb</option>
                                                                                    <option value="03">Mar</option>
                                                                                    <option value="04">Apr</option>
                                                                                    <option value="05">May</option>
                                                                                    <option value="06">Jun</option>
                                                                                    <option value="07">Jul</option>
                                                                                    <option value="08">Aug</option>
                                                                                    <option value="09">Sep</option>
                                                                                    <option value="10">Oct</option>
                                                                                    <option value="11">Nov</option>
                                                                                    <option value="12">Dec</option>
                                                                                </select>
                                                                            </td>
                                                                            <td>
                                                                                <select name="year" name="year">
                                                                                    <option>-Year-</option>
                                                                                    <option value="2012">2012</option>
                                                                                    <option value="2013">2013</option>
                                                                                    <option value="2014">2014</option>
                                                                                    <option value="2015">2015</option>
                                                                                    <option value="2016">2016</option>
                                                                                    <option value="2018">2018</option>
                                                                                    <option value="2019">2019</option>
                                                                                    <option value="2020">2020</option>
                                                                                </select>
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
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <input style="width:80px;" type="submit" value="Ok" name="Ok" onclick="return Validate();" />
                                                                    <input style="display: none;" id="btnOk" type="button" value="Ok" onclick="if(Validate()){location.href('h_clearcart.jsp?dest=paymentack.jsp');}else{return false;}" style="width:80px;" >
                                                                </td>
                                                                <td><input id="btnCancel" type="button" value="Cancel" style="width:80px;" onclick="javascript:location.href('checkout.jsp');"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            </form>    
                                        </c:otherwise>
                                    </c:choose> 
                                </c:if>                            
                            </td>
                            <c:choose>                                
                            <c:when test="${empty g_login_userid}">
                            <td valign="top" width="10%">
                                <table border="1">
                                    <tr>
                                        <td id="td_login">
                                            <c:choose>
                                                <%-- show the login form, if user has not logged in --%>
                                                <c:when test="${empty g_login_userid}">
                                                    <form name="frm_login" action="h_login.jsp?dest=${redirect}" method="post">
                                                        <table>
                                                            <tr>
                                                                <td>User ID</td>
                                                                <td>:</td>
                                                                <td><input type="text" style="width:100px" name="userid" value="${param.userid}" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Password</td>
                                                                <td>:</td>
                                                                <td><input type="password"  style="width:100px" name="password" value="${param.password}" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">&nbsp;</td>
                                                                <td><input type="submit" value="Login" name="login" /></td>
                                                            </tr>
                                                            <%--display system messages (if any) --%>
                                                            <c:if test="${not empty g_status_msg}">
                                                                <tr>
                                                                    <td colspan="2">&nbsp;</td>
                                                                    <td>
                                                                        <p><font color="red">${g_status_msg}</font></p>
                                                                        <c:remove var="g_status_msg" scope="session" />
                                                                    </td>
                                                                </tr>
                                                            </c:if>                                                            
                                                        </table>
                                                    </form>
                                                </c:when>

                                                <%-- show logout link, if user has logged in --%>
                                                <c:otherwise>
                                                    <%--table>
                                                        <tr>
                                                            <td>Welcome ${g_login_name}, <a href="h_logout.jsp?dest=${redirect}">Logout</a></td>
                                                        </tr>
                                                    </table--%>      
                                                </c:otherwise>
                                            </c:choose>                                            
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            </c:when>
                            </c:choose>
                        </tr>
                    </table>
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
