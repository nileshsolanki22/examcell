<!DOCTYPE html>
<%@page session="true"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.Cookie;"%>

<% ResultSet rs =null;
Statement stmt=null;
Connection conn=null;
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
        <div class="container">
            <div class="header">
				<%
				if((session.getAttribute("name")==null)||(((session.getAttribute("usertype")).equals("teacher"))==false))
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
                        <a href="TeacherHome.jsp">
                            <span class="ca-icon">F</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Home</h2>	
                                <!--<h3 class="ca-sub">Personalized to your needs</h3>-->
                            </div>
                        </a>
                    </li>
					<li>
                        <a href="Debarlistt.jsp">
                            <span class="ca-icon">&#85;</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Debarred List</h2>
                                <!--<h3 class="ca-sub">24/7 for you needs</h3>-->
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="DateSheett.jsp">
                            <span class="ca-icon">&#97</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Date Sheet</h2>
                               <!--<h3 class="ca-sub">Advanced use of technology</h3>-->
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="ca-icon">P</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Time Table</h2>
                                <!--<h3 class="ca-sub">Understanding visually</h3>-->
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
            </div><!-- content -->
			<div class="main-content">		
			<br/>
	<%
		/*--------------This code updates datesheet detail into the database---------------------*/
		String batch=(String)session.getAttribute("batch");
		String course[]=request.getParameterValues("course");
		String exam_type[];
		//=request.getParameterValues("radio");
		String duration[]=request.getParameterValues("duration");
		int i,b;
		String query;
		for(i=0;i<course.length;i++)
		{
			query="update datesheet_course_detail set Exam_Type="+"'"+request.getParameter(course[i])+"'"+" , Exam_Duration="+
			"'"+duration[i]+"'"+" where Course_Code="+"'"+course[i]+"'"+"and Batch="+"'"+batch+"'";
			//out.print(query);
			//out.println(course[i]);
			//out.println(request.getParameter(course[i]));
			//out.println(duration[i]);
			//out.println(course[i]);
			stmt.executeUpdate(query);
			//a=stmt.executeUpdate(q);
		}
	%>		
	
		<div class="main-content">
		<iframe src="DateSheetSuccess.jsp" width="1000px" height="500px" frameBorder="0" scrolling="yes" ></iframe>
		</div>
        </div><!--End of main Div-->
        <script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>