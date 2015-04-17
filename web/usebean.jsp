<%-- 
    Document   : usebean
    Created on : Jan 14, 2013, 6:00:49 PM
    Author     : nanda.minnaing
--%>
<%-- 
    Name            : Nanda Min Naing
    Course          : ST8016
    Class           : SECT\VC\1A\02
    Admission No    : P1257506
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>

<head>

<TITLE>JavaBeans in JSP</TITLE>

<meta http-equiv="Content-Language" content="en-us">

<style type="text/css">

.style1 {

border: 2px solid #0000FF;

background-color: #CCFFFF;

}

</style>

</head>

<BODY>

<table class="style1" style="float: CENTER" align="center">

<tr>

<td style="width: 430px; height: 38px">

<h3><strong>EXAMPLE OF JSP:USEBEAN STANDARD ACTION</strong></h3>

</td>

</tr>

</table>

<P>

<jsp:useBean id="test" class="foo.usebeanexample" />

<jsp:setProperty name="test" property="message" value="Hello ANKIT" />

<center><H1>Message:

<jsp:getProperty name="test" property="message" />

</H1></center>

</BODY>

</HTML>
