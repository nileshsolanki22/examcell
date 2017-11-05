<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.Cookie;"%>

<html> 
<head> 
<title>LoginCheck</title> 
</head> 
<body> 

	<%
		//<!--This code validates login -->
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;

		String userdbName;
		String userdbpass;
		String dbUsertype;
		String dbenrollno;

		String name=request.getParameter("username"); 
		String password=request.getParameter("password");
		String usertype;


		try
		{

			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/examcell","root","");
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from user");

			while(rs.next())
			{
				userdbName=rs.getString("name");
				userdbpass=rs.getString("password");
				dbUsertype=rs.getString("usertype");
				dbenrollno=rs.getString("Enroll_no");
				if((name.equalsIgnoreCase(userdbName)) && (password.equals(userdbpass)))
				{
					session.setAttribute("name",userdbName);
					session.setAttribute("usertype",dbUsertype);
					session.setAttribute("Enroll_no",dbenrollno);
					session.setMaxInactiveInterval(3*60*60);
					
					if((dbUsertype).equalsIgnoreCase("admin"))
					response.sendRedirect("Home.jsp");
					else if((dbUsertype).equalsIgnoreCase("student"))
					response.sendRedirect("StudentHome.jsp");
					else if((dbUsertype).equalsIgnoreCase("teacher"))
					response.sendRedirect("TeacherHome.jsp");
					//out.print(userdbName);
				}	
			}
			{
				//RequestDispatcher rd = application.getRequestDispatcher("/index.jsp");
					//out.println("<font color=red>Either user name or password is wrong.</font>");
					//rd.include(request, response);
				response.sendRedirect("default.jsp");
				rs.close();
				stmt.close();
			}
				//out.print("3");
		}
		catch(Exception e)
		{
		}
	%> 
</body> 
</html>