<!DOCTYPE html>
<%@page session="true"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.Cookie;"%>

<% 
	ResultSet rs =null;
	Statement stmt=null;
	Connection conn=null;
	String b="";
%>

<%
    try{
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/examcell","root","");
        stmt = conn.createStatement() ;
        rs =stmt.executeQuery("SELECT * FROM datesheet_course_detail") ;
		
		String batch;
		while(rs.next())
		{
			if(session.getAttribute("name").equals(rs.getString("Student_Name")))
			{
				batch=rs.getString("Batch");
				//batch="B.Tech";
				out.print(batch);
				session.setAttribute("batch",batch);
			}
		}
	}
	catch(Exception e)
	{
	}	
%>
<html lang="en">
    <head>
        <title>NIIT University Exam Cell</title>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta name="description" content="Creative CSS3 Animation Menus" />
        <meta name="keywords" content="menu, navigation, animation, transition, transform, rotate, css3, web design, component, icon, slide" />
        <meta name="author" content="Codrops" />
        <link rel="shortcut icon" href="../favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="css/demo.css" />
        <link rel="stylesheet" type="text/css" href="css/style2.css" />	
    </head>
    <body>
        <div class="container">
            <div class="header">
				<%
				if((session.getAttribute("name")==null)||(((session.getAttribute("usertype")).equals("student"))==false))
				{
					//out.print("Error");
					response.sendRedirect("sessionexpired.jsp");
				}
				%>

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
                                <h2 class="ca-main">Debarred List</h2>
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
			<div class="main-content">
			<!--
			Export <a href="temp/datesheet.xls">Excel</a> &nbsp&nbsp <a href="temp/datesheet.pdf" download>PDF</a>
			<iframe src="temp/datesheet.pdf" width="1000px" height="450px" frameBorder="0" scrolling="no" ></iframe>
			-->
			
			Export <a href="temp/<%="datesheet"+"_"+(String)session.getAttribute("batch")+".xls"%>"  >Excel</a> &nbsp&nbsp <a href="temp/<%="datesheet"+"_"+(String)session.getAttribute("batch")+".pdf"%>" download>PDF</a>
			<iframe src="temp/<%="datesheet"+"_"+(String)session.getAttribute("batch")+".pdf"%>" width="1000px" height="450px" frameBorder="0" scrolling="no" ></iframe>
			</div><!--End of main Div-->
			
        <script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>