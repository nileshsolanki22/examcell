<!DOCTYPE html>
<%@ page session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.http.Cookie"%>
<%@ page import="java.util.*"%>

<%
	if((session.getAttribute("name")==null)||(((session.getAttribute("usertype")).equals("student"))==false))
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
			<div class="main-content">
			<%
				out.print("<pre>");
				String query,batch="";
				String user=(String)session.getAttribute("name");
				query="select Batch from student_detail where Student_Name="+"'"+user+"'";
				rs=stmt.executeQuery(query);
				try
				{
					while(rs.next())
					{
						batch=rs.getString("Batch");
					}
				}
				catch(Exception e)
				{
					
				}
				
				//out.print(query);
				out.println("<h1>Seating Plan for "+batch+"</h1>");
				out.println("\t\t"+"Click on Excel or PDF to download seating plan:-\n\n\n");
				
				query="select * from datesheet_course_detail where Batch=";
				String q=query+"'"+batch+"'";
				String fname="./webapps/exam/";
				//out.println(q);
				String file,file2;
					//out.print("1");
				try
				{
					rs=stmt.executeQuery(q);
					while(rs.next())
					{	
						file=fname+"temp/Seating_of_"+rs.getString("Course_Code")+"_of_Batch_"+batch+".xls";
						file2=fname+"seating/Seating_of_"+rs.getString("Course_Code")+"_of_Batch_"+batch+".pdf";
						
						//out.println(file);
						if(rs.getString("Course_Code").length()==5)
						{
							out.print("\t\t"+rs.getString("Course_Code")+"     ");
						}
						else
						{
							out.print("\t\t"+rs.getString("Course_Code")+"    ");
						}
						out.print("<a href="+"temp/Seating_of_"+rs.getString("Course_Code")+"_of_Batch_"+batch+".xls"+">"+"Excel"+"</a>"+"\t\t");
						out.print("<a href="+"seating/Seating_of_"+rs.getString("Course_Code")+"_of_Batch_"+batch+".pdf"+" download >"+"PDF"+"</a>"+"\n");
						
						/*--------------------------------------------------------------*/	
					}
					
				}
				catch(Exception e)
				{
				}
				%>		 
			</div

		
        <script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>