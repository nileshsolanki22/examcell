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

<%
	if((session.getAttribute("name")==null)||(((session.getAttribute("usertype")).equals("teacher"))==false))
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
	<script src="js/jquery-1.11.1.js" type="text/javascript"></script>
	<script language="javascript">
/* 	document.onmousedown=disableclick;
	status="Right Click Disabled";
	function disableclick(event)
	{
		if(event.button==2)
		{
			alert(status);
			return false;    
		}
	} */
	<% 
	//session.removeAttribute("export"); 
	%> 
</script>			
			<%String export="Deabarlist_of_"+(String)session.getAttribute("course")+"_of_Batch_"+(String)session.getAttribute("batch");
			String fname="";%>
			<body>	
			<div class"export">
			Export <a href="temp/<%=export+".xls"%>">Excel</a> &nbsp&nbsp <a href="temp/<%=export+".pdf"%>" download>PDF</a>
			<div>
			<div class="main-content">
			
			<%//session.getAttribute("batch")%>
			<%//session.getAttribute("course")%>
			
			<%
			
				//<!--This code shows debarred list to teacher-->
				
				String enrollno;
				String sname;
				String cc;
				String ct;
				String atten;
				String debar_status;
				String batch=(String)session.getAttribute("batch");
				//session.setAttribute(batch,"batch");
				//out.println(name);
				String course=(String)session.getAttribute("course");
				//session.setAttribute(course,"course");
				String query="select student_detail.Enroll_no,Student_Name,Course_Code,Course_Title,Attendance,Debar_Status FROM student_detail,courses where student_detail.Enroll_no=courses.Enroll_no and Course_Code=";
				String q=query+"'"+course+"'"+"and student_detail.Batch="+"'"+batch+"'";
				//out.print(q);

					//out.print("1");
				try
				{

					Class.forName("com.mysql.jdbc.Driver");
					conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/examcell","root","");
					stmt=conn.createStatement();
					rs=stmt.executeQuery(q);
					
					//out.print("2");
					out.print("<pre>");
					out.print("<b>    Student Name</b>\t");
					out.print("<b>\tEnrollment Number     </b>");
					out.print("<b>Course Code\t   </b>");
					out.print("<b>Course Title\t    </b>");
					out.print("<b>Attendance\t    </b>");
					out.print("<b>Allowed\n\n</b>");
					
					/*------------------Converting database to excel---------------------*/
					HSSFWorkbook wb = new HSSFWorkbook();
					HSSFSheet sheet = wb.createSheet("Excel Sheet");
					HSSFRow rowhead = sheet.createRow((short) 0);
					rowhead.createCell((short) 0).setCellValue("Student Name\t\t\t");
					rowhead.createCell((short) 1).setCellValue("Enrollment Number");
					rowhead.createCell((short) 2).setCellValue("Course Code");
					rowhead.createCell((short) 3).setCellValue("Course Title");
					rowhead.createCell((short) 4).setCellValue("Attendance");
					rowhead.createCell((short) 5).setCellValue("Debar Status");
					
					%><form action="update.jsp" method="post" style="display:inline"><%
					out.print("</pre>");
					int index=1;
					String temp="./webapps/exam/temp/";
					fname=temp+"Deabarlist_of_"+course+"_of_Batch_"+batch;
					//export="Deabarlist_of_"+course+"_of_Batch_"+batch+".xls";
					//session.setAttribute("export",export);
					while(rs.next())
					{			
						enrollno=rs.getString("Enroll_no");
						sname=rs.getString("Student_Name");
						cc=rs.getString("Course_Code");
						ct=rs.getString("Course_Title");
						atten=rs.getString("Attendance");
						debar_status=rs.getString("Debar_Status");
						
						/*---Conversion Of Database data to Excel Sheet-----*/
			
						HSSFRow row = sheet.createRow((short) index);
						row.createCell((short) 0).setCellValue(sname);
						row.createCell((short) 1).setCellValue(enrollno);
						row.createCell((short) 2).setCellValue(cc);
						row.createCell((short) 3).setCellValue(ct);
						row.createCell((short) 4).setCellValue(atten);
						row.createCell((short) 5).setCellValue(debar_status);
						index++;
						
						FileOutputStream fileOut = new FileOutputStream(fname+".xls");
						wb.write(fileOut);
						fileOut.close();	
			
						/*--------------------------------------------------*/
						
						
						/*--------------------Conversion Of Excel Sheet to PDF--------------------------*/
		
						FileInputStream input_document = new FileInputStream(new File(fname+".xls"));
						// Read workbook into HSSFWorkbook
						HSSFWorkbook my_xls_workbook = new HSSFWorkbook(input_document); 
						// Read worksheet into HSSFSheet
						HSSFSheet my_worksheet = my_xls_workbook.getSheetAt(0); 
						// To iterate over the rows
						Iterator<Row> rowIterator = my_worksheet.iterator();
						//We will create output PDF document objects at this point
						Document iText_xls_2_pdf = new Document();
						PdfWriter.getInstance(iText_xls_2_pdf, new FileOutputStream(fname+".pdf"));
						iText_xls_2_pdf.open();
						//we have six columns in the Excel sheet, so we create a PDF table with six columns
						//Note: There are ways to make this dynamic in nature, if you want to.
						PdfPTable my_table = new PdfPTable(6);
						//We will use the object below to dynamically add new data to the table
						PdfPCell table_cell;
						//Loop through rows.
						while(rowIterator.hasNext()) 
						{
							Row row1 = rowIterator.next(); 
							Iterator<Cell> cellIterator = row1.cellIterator();
							while(cellIterator.hasNext()) 
							{
								Cell cell = cellIterator.next(); //Fetch CELL
								switch(cell.getCellType())  //Identify CELL type
								{
									//you need to add more code here based on
									//your requirement transformations
									case Cell.CELL_TYPE_STRING:
									//Push the data from Excel to PDF Cell
									table_cell=new PdfPCell(new Phrase(cell.getStringCellValue()));
									//feel free to move the code below to suit to your needs
									my_table.addCell(table_cell);
									break;
								}
							//next line
						} 
							}
							//Finally add the table to PDF document
							float[] columnWidths = new float[] {18f, 25f, 14f, 20f,18f,10f};
							my_table.setWidths(columnWidths);
							iText_xls_2_pdf.add(my_table);                       
							iText_xls_2_pdf.close();                
							//we created our pdf file..
							input_document.close(); //close xls
							
							
						/*------------------------------------------------------------------------------------*/
						
						{
							//out.print("");
							out.print("<pre>");
							if(sname.length()>15)
							{
								out.print("    "+sname.substring(0,15));
							}
							else if(sname.length()<12)
							{
								out.print("    "+sname+"\t");
							}
							else
							{
								out.print("    "+sname);
							}
							//out.print("    "+sname);
							out.print("\t\t"+enrollno);
							out.print("\t\t"+cc);
							out.print("\t   "+ct);
							out.print("\t\t"+atten);
							out.print("\t      ");
							//out.print("\t\t\t\t"+debar_status);
							//out.print("</pre>");
							%><%=""%><input type="checkbox" name="<%=rs.getString("Enroll_no")%>" value="<%=rs.getString("Enroll_no")%>"
							<%=("No".equals(rs.getString("debar_status"))?"checked":"")%>><%
						}
						out.println("<br>");					
						out.print("</pre>");
				}
					%><input type="submit" value="update" class="button"></form></pre><%
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
        <script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>
	