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
	<script src="js/jquery-1.11.1.js" type="text/javascript"></script>
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
                        <a href="Invigilation.jsp">
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
			
			<script type="text/javascript">
			<%
				//--------------This code lets you select batch and course detail of debarlist for admin---------------------*/
			%>
			function setOptions(chosen) 
			{
				var selbox = document.myform.course;
				selbox.options.length = 0;
				//if (chosen == " ") {
				//  selbox.options[selbox.options.length] = new Option('Please select one of the options above first',' '); 
				//}
				
				if (chosen == "---select---   ") {
					selbox.options[selbox.options.length] = new Option('---select---','c');
				}
				if (chosen == "B.Tech") {
				 // selbox.options[selbox.options.length] = new Option('CS201','oneone');
				  //selbox.options[selbox.options.length] = new Option('first choice - option two','onetwo');
				  selbox.options[selbox.options.length] = new Option('---select---','c');
				<%
				String q1="select distinct Course_Code from courses where Batch="+"'"+"B.Tech"+"'";
				rs =stmt.executeQuery(q1) ;
				while(rs.next()){ %>
				selbox.options[selbox.options.length] = new Option('<%= rs.getString(1)%>','<%= rs.getString(1)%>');
				  <% } 
				  %>
				}
				
				if (chosen == "MBA") {
				  selbox.options[selbox.options.length] = new Option('---select---','c');
				  selbox.options[selbox.options.length] = new Option('second choice - option one','twoone');
				  selbox.options[selbox.options.length] = new Option('second choice - option two','twotwo');
				}
				
				if (chosen == "M.Tech") {
				  selbox.options[selbox.options.length] = new Option('---select---','c');
				  selbox.options[selbox.options.length] = new Option('third choice - option one','threeone');
				  selbox.options[selbox.options.length] = new Option('third choice - option two','threetwo');
			}
			
			}
			
			function validate(chosen)
			{
				valid = true;
				//valid=false;
				//var selbox = document.myform.course;
				//selbox.options.length = 0;
				
				if ( chosen=="select")
				{
					alert ( "Select Batch" );
					valid = false;
				}
				if(chosen=="---select---")
				{
					alert ( "Select Course" );
					valid = false;
				}
				return valid;
			}
			</script>						
			<form action="DebarStatusRedirect_a.jsp" name="myform" method="post" onsubmit="return validate(document.myform.batch.options[document.myform.batch.selectedIndex].value);" >
			<pre>
			Select Batch:
			<select name="batch" size="1" onchange="setOptions(document.myform.batch.options[document.myform.batch.selectedIndex].value);" required>
			<option value="select" autofocus>---select---   &nbsp &nbsp </option>
			<!--<option value=" " selected="selected"> </option>-->
			<% 
			rs =stmt.executeQuery("select b_name from batch") ;
			while(rs.next()){ %>
            <option value="<%= rs.getString(1)%>"><%= rs.getString(1)%></option>
			<%}
			//session.setAttribute("batch","rs.getString(1)");
			//session.setAttribute("usertype",dbUsertype);
			%>
			</select>
			</select>
			Select Course:
			<select name="course" size="1" required>
			<!--<option value=" " selected="selected">Please select one of the options above first</option>-->
			<option value="---select---" autofocus required>---select---   &nbsp &nbsp </option>
			</select>
			<br/>
			<input type="submit" name="go" value="Generate" >
			</form>
			</pre>
		</div

		
        <script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>