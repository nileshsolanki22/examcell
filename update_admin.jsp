<%@page session="true"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.Cookie;"%>

<html>
	<head><title>First Page</title></head>
		<%
		if((session.getAttribute("name")==null) || (((session.getAttribute("usertype")).equals("admin"))==false) )
		{
			//out.print("Error");
			response.sendRedirect("sessionexpired.jsp");
		}
		%>

	<body>
	<%
		//<!--This code updates the debarlist to database by admin-->
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String debar_status=null;
	Enumeration update=request.getParameterNames();
	String p_debar_status;
	//out.print("<h1>Update Length "+update.length+"</h1>");
	int i=0;
	
    try
	{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/examcell","root","");
        stmt = conn.createStatement() ;
        //rs =stmt.executeQuery("select distinct Course_Code from courses") ;
		String batch=(String)session.getAttribute("batch");
		String course=(String)session.getAttribute("course");
		//update courses set Debar_Status='No' where Enroll_no='U101112FCS100' and Course_Code='CS211'
		String query="update courses set Debar_Status='No' where Enroll_no=";
		//'U101112FCS100' and Course_Code='CS211'";
		String q;
		//out.print(q);
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/examcell","root","");
		stmt=conn.createStatement();
		//rs=stmt.executeQuery(q);
		int a;
		
		while(update.hasMoreElements()) {
		String paramName = (String)update.nextElement();
		q=query+"'"+paramName+"'"+" and Course_Code="+"'"+course+"'";
		//out.print(q);
		//out.print(paramName + "\n");
		String paramValue = request.getParameter(paramName);
		//out.println(paramValue + "\n"+"<br/>");
		if(paramValue.equals(paramName))
		{
			a=stmt.executeUpdate(q);
		}
   }
		
		//out.println("from db\n\n\n");		
	/* 	while(rs.next())
		{
			//debar_status=rs.getString("Debar_Status");
			//out.println(debar_status);
			//out.println("parmam\t"+update[i]);
			//i++;
		} */
		out.println("Records Updated Successfully...!");
		rs.close();
		stmt.close();
	}
	catch(Exception e){}
	%>
	
	
	
	
	
	
	
	
	
	
	
	</body>
</html>