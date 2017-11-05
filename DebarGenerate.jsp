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

	<body>
	<div="main-content">
	<%
		/*--------------This code generates debarlist---------------------*/
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;

		String enrollno;
		String sname;
		String ccode;
		String ct;
		String cin;
		String attendance;
		String debar_status;

		String name=(String)session.getAttribute("Enroll_no");
		//out.println(name);
		String query="select * from courses where Enroll_no=";
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
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("Excel Sheet");
			HSSFRow rowhead = sheet.createRow((short) 0);
			rowhead.createCell((short) 0).setCellValue("Course Code\t\t\t");
			rowhead.createCell((short) 1).setCellValue("Course Title");
			rowhead.createCell((short) 2).setCellValue("Attendance");
			rowhead.createCell((short) 3).setCellValue("Debar Status");
			
			int index=1;
			while(rs.next())
			{			
				enrollno=rs.getString("Enroll_no");
				//sname=rs.getString("Student_Name");
				ccode=rs.getString("Course_Code");
				ct=rs.getString("Course_Title");
				cin=rs.getString("Course_In_Charge");
				attendance=rs.getString("Attendance");
				debar_status=rs.getString("Debar_Status");
				
				/*---Conversion Of Database data to Excel Sheet-----*/
				
				HSSFRow row = sheet.createRow((short) index);
				row.createCell((short) 0).setCellValue(ccode);
				row.createCell((short) 1).setCellValue(ct);
				row.createCell((short) 2).setCellValue(attendance);
				row.createCell((short) 3).setCellValue(debar_status);
				//row.createCell((short) 4).setCellValue(rs.getString(5));
				index++;
				
				/*--------------------------------------------------*/
				FileOutputStream fileOut = new FileOutputStream("./webapps/exam/temp/student.xls");
				wb.write(fileOut);
				fileOut.close();		
			}
			
			
			/*---Conversion Of Excel Sheet to PDF-----*/
			
			FileInputStream input_document = new FileInputStream(new File("./webapps/exam/temp/student.xls"));
			// Read workbook into HSSFWorkbook
			HSSFWorkbook my_xls_workbook = new HSSFWorkbook(input_document); 
			// Read worksheet into HSSFSheet
			HSSFSheet my_worksheet = my_xls_workbook.getSheetAt(0); 
			// To iterate over the rows
			Iterator<Row> rowIterator = my_worksheet.iterator();
			//We will create output PDF document objects at this point
			Document iText_xls_2_pdf = new Document();
			PdfWriter.getInstance(iText_xls_2_pdf, new FileOutputStream("./webapps/exam/temp/student.pdf"));
			iText_xls_2_pdf.open();
			//we have four columns in the Excel sheet, so we create a PDF table with four columns
			//Note: There are ways to make this dynamic in nature, if you want to.
			PdfPTable my_table = new PdfPTable(4);
			//We will use the object below to dynamically add new data to the table
			PdfPCell table_cell;
			//Loop through rows.
			while(rowIterator.hasNext()) 
			{
				Row row = rowIterator.next(); 
				Iterator<Cell> cellIterator = row.cellIterator();
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
				iText_xls_2_pdf.add(my_table);                       
				iText_xls_2_pdf.close();                
				//we created our pdf file..
				input_document.close(); //close xls
				
			/*--------------------------------------------------------------*/
			{
				rs.close();
				stmt.close();
			}
				//out.print("3");
				response.sendRedirect("DebarStatus.jsp");
			}
		catch(Exception e)
		{
		}
	%>	
	</div>	
	
	</body>
	</html>
	