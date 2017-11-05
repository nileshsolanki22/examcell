<!DOCTYPE html>
<%@ page session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.http.Cookie"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%>
<%@ page import="org.apache.poi.ss.usermodel.*"%>
<%@ page import="com.itextpdf.text.*"%>
<%@ page import="com.itextpdf.text.pdf.*"%>
<%@ page import="java.util.*"%>

<html lang="en">
    <head>
        <title>NIIT University Exam Cell</title>
		<link rel="stylesheet" type="text/css" href="css/demo.css" />
        <link rel="stylesheet" type="text/css" href="css/style2.css" />
	</head>
	
	<script language="javascript">
	document.onmousedown=disableclick;
	status="Right Click Disabled";
	function disableclick(event)
	{
		if(event.button==2)
		{
			//alert(status);
			return false;    
		}
}
</script>

	<body>
	        <div class="container">
            <div class="header">

                <a href="#"><strong>&laquo; Welcome,<%=session.getAttribute("name")%> </strong>(<%=session.getAttribute("usertype")%>)</a>
                <span class="right">
                    <a href="" target="_blank"></a>
                    <a href="logout.jsp">Logout</a>
                </span>
                <div class="clr"></div>
            </div>
            <div class="content">
                <ul class="ca-menu">
                    <li>
                        <a href="StudentHome.jsp">
                            <span class="ca-icon">F</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Home</h2>	
                                <!--<h3 class="ca-sub">Personalized to your needs</h3>-->
                            </div>
                        </a>
                    </li>
					<li>
                        <a href="Debarlist.jsp">
                            <span class="ca-icon">&#85;</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Debar Status</h2>
                                <!--<h3 class="ca-sub">24/7 for you needs</h3>-->
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="DateSheet.jsp">
                            <span class="ca-icon">&#97</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Date Sheet</h2>
                               <!--<h3 class="ca-sub">Advanced use of technology</h3>-->
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="SeatingShow.jsp">
                            <span class="ca-icon">&#63</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Seating Plan</h2>
                                <!--<h3 class="ca-sub">Professionals in action</h3>-->
                            </div>
                        </a>
                    </li>
					
                </ul>
            </div><!-- content -->
	<div class ="main-content">	
	<iframe src="temp/student.pdf" width="800px" height="350px" frameBorder="0" scrolling="No" seamless ></iframe>
	</div>	
	</body>
	</html>