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
                        <a href="InvigilationShowt.jsp">
                            <span class="ca-icon">L</span>
                            <div class="ca-content">
                                <h2 class="ca-main">Invigilation</h2>
                                <!--<h3 class="ca-sub">Professionals in action</h3>-->
                            </div>
                        </a>
                    </li>
                </ul>
            </div><!-- content -->
			<div class="main-content">		
			<br/>
			
			<script type="text/javascript">
			
			function getCourse(value){
			if(value == "B.Tech")
			{
				document.getElementById("courses").style.display = "block";
				<%session.setAttribute("batch","B.Tech");%>
			}
			else 
			{
				document.getElementById("courses").style.display = "none";
			}
    }
			<%
				//<!--This code lets you select batch and course detail of debarlist for admin-->
			%>
			</script>						
			<form action="DateSheetUpdate.jsp" name="myform" method="post" >
			<pre>
			Select Batch:
			<select name="Batch" size="1" onchange="getCourse(this.value)"  >
			<option value="select" autofocus>---select---   &nbsp &nbsp </option>
			<% 
			rs =stmt.executeQuery("select b_name from batch");
			while(rs.next()){ %>
            <option value="<%= rs.getString(1)%>"><%= rs.getString(1)%></option>
			<%}%></select>
			<% 
			%><div id="courses" style="display:none;">
			<pre><b><%="\t\t\t"%>Select Courses <%="\t\t\t   "%>Select Paper Type <%="\t\t\t   "%> Exam Duration(in hours)</b></pre>
			<%
			String batch=(String)session.getAttribute("batch");
			String query="select distinct Course_Code from courses where Batch=";
			String q=query + "'"+batch+"'";
			//out.print(q);
			rs =stmt.executeQuery(q) ;
			out.print("<pre>");
			while(rs.next()){ %>
			<%= rs.getString(1)%><%="\t"%><input type="checkbox" name="course" value="<%= rs.getString(1)%>" required> <%="\t\t\t    "%>Pen Paper  <input type="radio" name="<%= rs.getString(1)%>" value="Pen_Paper" checked>
			<%="\t\t\t\t    "%>Online     <input type="radio" name="<%= rs.getString(1)%>" value="Online"><%="\t\t\t    "%><input type="text" name="duration" value="0" required>	
			<%="\t\t\t\t    "%>No Exam    <input type="radio" name="<%= rs.getString(1)%>" value="No_Exam">
			<%}
			%>	
			<input type="submit" name="go" value="Submit">
			</div>
			</form>
			</pre>
			</div>
        </div><!--End of main Div-->
        <script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>