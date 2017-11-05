<!DOCTYPE html>
<%@page session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.Cookie;"%>
<%@ page isELIgnored ="false" %>

<%
	if((session.getAttribute("name")==null)||(((session.getAttribute("usertype")).equals("admin"))==false))
	{
		//out.print("Error");
		response.sendRedirect("sessionexpired.jsp");
	}
%>


<%
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
%>
<%
    try{
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/examcell","root","");
        stmt = conn.createStatement() ;
        //rs =stmt.executeQuery("select distinct Course_Code from courses") ;
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
	
	<script language="javascript">

	</script>
        <div class="container">
            <div class="header">
				<%
				if((session.getAttribute("name")==null)||(((session.getAttribute("usertype")).equals("admin"))==false))
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
                        <a href="Home.jsp">
                            <span class="ca-icon">F</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Home</h2>	
                                <!--<h3 class="ca-sub">Personalized to your needs</h3>-->
                            </div>
                        </a>
                    </li>
					<li>
                        <a href="Debarlista.jsp">
                            <span class="ca-icon">&#85;</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Debarred List</h2>
                                <!--<h3 class="ca-sub">24/7 for you needs</h3>-->
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="DateSheeta.jsp">
                            <span class="ca-icon">&#97</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Date Sheet</h2>
                               <!--<h3 class="ca-sub">Advanced use of technology</h3>-->
                            </div>
                        </a>
                    </li>
					<li>
                        <a href="SeatingPlan.jsp">
                            <span class="ca-icon">&#63</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Seating Plan</h2>
                                <!--<h3 class="ca-sub">Professionals in action</h3>-->
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="ca-icon">L</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Invigilation</h2>
                                <!--<h3 class="ca-sub">24/7 for you needs</h3>-->
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
			<!-- content -->		
			
			
			
			<div class="main-content">
			
			<%//request.getParameter("batch")%>
			<%//request.getParameter("course")%>
			
			<%
			String batch=(String)request.getParameter("batch");
			String course1=(String)request.getParameter("course");
				
			//out.print(course1);
			if(course1.equals("c") || course1.equals("M.Tech") || course1.equals("MBA") )
			{
				response.sendRedirect("Debarlista.jsp");
			}
			//out.print(batch);
			/*
			if(batch.equals("") || batch.equals("M.Tech") || batch.equals("MBA") )
			{
				response.sendRedirect("Deabarlista.jsp");
			}
			*/	
			session.setAttribute("batch",batch);
			//out.println(name);
			String course=(String)request.getParameter("course");
			session.setAttribute("course",course);
			%>	
			<iframe src="DebarStatusa.jsp" width="1000px" height="500px" frameBorder="0" scrolling="yes" ></iframe>
			</div>
			
			<div class="footer">
			<a href="Debarlista.jsp"><input type="button" value="back" class="button"></a>
			</div>						
			
        <script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>
	