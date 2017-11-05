<!DOCTYPE html>
<%@page session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.Cookie;"%>

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
	<body oncontextmenu="return false">
<div class="main-content">

<%
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;

String enrollno;
String tname;
String dob;
String sex;
String mstatus;
String add;
String bg;
String pno;
String email;
String name=(String)session.getAttribute("name");
//out.println(name);
String query="select * from admin_detail where Admin_Name=";
String q=query+"'"+name+"'";
//out.print(q);

	//out.print("1");
try
{

	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/examcell","root","");
	stmt=conn.createStatement();
	rs=stmt.executeQuery(q);
	
	//out.print("2");
	while(rs.next())
	{			
		enrollno=rs.getString("Enroll_no");
		tname=rs.getString("Admin_Name");
		//fname=rs.getString("Father's Name");
		dob=rs.getString("Date_Of_Birth");
		mstatus=rs.getString("Marital_Status");
		sex=rs.getString("Gender");
		add=rs.getString("Address");
		bg=rs.getString("Blood_Group");
		pno=rs.getString("Phone_No");
		email=rs.getString("Email_ID");
		
		if((name.equalsIgnoreCase(tname)))
		{
			//out.print("");
			out.print("<pre>");
			
			out.print("<b>\n\t\t\tName\t\t\t\t:</b>");
			out.println("\t\t"+tname);
			out.print("<b>\n\t\t\tEnrollment Number\t\t:</b>");
			out.println("\t\t"+enrollno);
			//out.println("<b>\n\t\t\tFather's Name\t\t\t:\t\t</b>"+fname);
			out.println("<b>\n\t\t\tAddress\t\t\t\t:\t\t</b>"+add);
			out.println("<b>\n\t\t\tDate Of Birth\t\t\t:\t\t</b>"+dob.toString());
			out.println("<b>\n\t\t\tMarital Status\t\t\t:\t\t</b>"+mstatus);
			out.println("<b>\n\t\t\tGender\t\t\t\t:\t\t</b>"+sex);
			out.println("<b>\n\t\t\tBlood Group\t\t\t:\t\t</b>"+bg);
			out.println("<b>\n\t\t\tPhone No.\t\t\t:\t\t</b>"+pno);
			out.println("<b>\n\t\t\tEmail ID\t\t\t:\t\t</b>"+email);
			out.print("</pre>");
		}	
	}
	{
		rs.close();
		stmt.close();
	}
		//out.print("3");
}
catch(Exception e)
{
}
%>	
</div>		
	</body>
	</html>
	