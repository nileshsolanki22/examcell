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
			
			<%	
				/*--------------This code creates datesheet excel and pdf files---------------------*/
				String ccode;
				String ct;
				String cin;
				String no_of_students;
				String exam_duration;
				String exam_day_no;
				String slot_no;
				String exam_type;
				

				String batch=(String)session.getAttribute("batch");
				//(String)request.getParameter("batch");
				out.println(batch);
				
				String query="select * from datesheet_course_detail where Batch=";
				String q=query+"'"+batch+"'";
				out.print(q);

					//out.print("1");
				try
				{


					stmt=conn.createStatement();
					rs=stmt.executeQuery(q);
					
 					//out.print("2");
					HSSFWorkbook wb = new HSSFWorkbook();
					HSSFSheet sheet = wb.createSheet("Excel Sheet");
					HSSFRow rowhead = sheet.createRow((short) 0);
					rowhead.createCell((short) 0).setCellValue("Code");
					rowhead.createCell((short) 1).setCellValue("Title");
					rowhead.createCell((short) 2).setCellValue("Course In-Charge");
					rowhead.createCell((short) 3).setCellValue("No Of Students");
					rowhead.createCell((short) 4).setCellValue("Exam Day No");
					rowhead.createCell((short) 5).setCellValue("Slot No");
					rowhead.createCell((short) 6).setCellValue("Exam Type"); 
					
					int index=1;
					while(rs.next())
					{			
						exam_type=rs.getString(4);
						if(exam_type.equals("No_Exam"))
						{
							break;
						}
						ccode=rs.getString(1);
						ct=rs.getString(2);
						cin=rs.getString(3);
						no_of_students=rs.getString(9);
						exam_day_no=rs.getString(7);
						slot_no=rs.getString(8);
						if(exam_type.equals("Pen_Paper"))
						{
							exam_type="Pen Paper";
						}
						
						/*---Conversion Of Database data to Excel Sheet-----*/
						
						HSSFRow row1 = sheet.createRow((short) index);
						row1.createCell((short) 0).setCellValue(ccode);
						row1.createCell((short) 1).setCellValue(ct);
						row1.createCell((short) 2).setCellValue(cin);
						//row.createCell((short) 3).setCellValue(Integer.parseInt(no_of_students));
						//row.createCell((short) 4).setCellValue(Integer.parseInt(exam_day_no));
						//row.createCell((short) 5).setCellValue(Integer.parseInt(slot_no));
						row1.createCell((short) 3).setCellValue(no_of_students);
						row1.createCell((short) 4).setCellValue(exam_day_no);
						row1.createCell((short) 5).setCellValue(slot_no);
						row1.createCell((short) 6).setCellValue(exam_type);
						index++;
						
						/*--------------------------------------------------*/
						String fname="./webapps/exam/temp/datesheet"+"_"+batch+".xls";
						FileOutputStream fileOut = new FileOutputStream(fname);
						wb.write(fileOut);
						fileOut.close();		
					
						/*---Conversion Of Excel Sheet to PDF-----*/
					
						FileInputStream input_document = new FileInputStream(new File(fname));
						// Read workbook into HSSFWorkbook
						HSSFWorkbook my_xls_workbook = new HSSFWorkbook(input_document); 
						// Read worksheet into HSSFSheet
						HSSFSheet my_worksheet = my_xls_workbook.getSheetAt(0); 
						// To iterate over the rows
						Iterator<Row> rowIterator = my_worksheet.iterator();
						//We will create output PDF document objects at this point
						Document iText_xls_2_pdf = new Document();
						fname="./webapps/exam/temp/datesheet"+"_"+batch+".pdf";
						PdfWriter.getInstance(iText_xls_2_pdf, new FileOutputStream(fname));
						iText_xls_2_pdf.open();
						//we have seven columns in the Excel sheet, so we create a PDF table with seven columns
						//Note: There are ways to make this dynamic in nature, if you want to.
						PdfPTable my_table = new PdfPTable(7);
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
						float[] columnWidths = new float[] {15f, 24f, 23f, 15f,15f,8f,14f};
						my_table.setWidths(columnWidths);
						iText_xls_2_pdf.add(my_table);                       
						iText_xls_2_pdf.close();                
						//we created our pdf file..
						input_document.close(); //close xls
						
					/*--------------------------------------------------------------*/
					}
					
					

					{
						rs.close();
						stmt.close();
					}
						//out.print("3");
						response.sendRedirect("DateSheetShowa.jsp");
					}
				catch(Exception e)
				{
				}
				%>		 
			</div

		
        <script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>