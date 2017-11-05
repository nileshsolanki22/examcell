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
			<%	
				//<!--This code generates invigilation duty list-->
				
				String bname=(String)request.getParameter("batch");
				if(bname.equals("select") || bname.equals("M.Tech") || bname.equals("MBA"))
				{
					response.sendRedirect("Invigilation.jsp");
				}
				ArrayList venue = new ArrayList();
				ArrayList count = new ArrayList();
				ArrayList invigilator = new ArrayList();
				
				String q="select * from seating_rooms where Used=";
				String query=q+"'"+"Yes"+"'";
				rs =stmt.executeQuery(query) ;
				while(rs.next())
				{
					venue.add(rs.getString("Venue"));
					venue.add(rs.getString("Venue"));				
				}
				out.print(venue+"<br/>");
				//out.println(venue.size());
				q="select * from invigilators where Available="+"'"+"Yes"+"'";
				//q="select * from invigilators where Available="+"'"+"Yes"+"'"+" and Assigned="+"'"+"Yes"+"'";
				out.print(q);
				rs =stmt.executeQuery(q);
				while(rs.next())
				{
					if((venue.size())==rs.getInt("ID"))
					{
						invigilator.add(rs.getString("Name"));
						break;
					}
					invigilator.add(rs.getString("Name"));
				}
				
				
				Collections.shuffle(invigilator);
				out.print(invigilator);
				//Updating Invigilator to database
				for(int i=0;i<venue.size();i++)
				{	
					q="update seating_rooms set Invigilator_1="+"'"+invigilator.get(i)+"'"+" ,"+"Invigilator_2="+"'"+invigilator.get(++i)+"'"+" where Venue="+"'"+venue.get(i)+"'";	
					//out.println(q);
					stmt.executeUpdate(q);
				}
				
				//Assigning venues to invigilator table
				for(int i=0;i<venue.size();i++)
				{	
					q="update invigilators set Venue="+"'"+venue.get(i)+"'"+" ,"+"Assigned='Yes' "+" where Name="+"'"+invigilator.get(i)+"'";	
					//out.println(q);
					stmt.executeUpdate(q);
				}
				
				/*------------------Converting database to excel---------------------*/

				HSSFWorkbook wb = new HSSFWorkbook();
				HSSFSheet sheet = wb.createSheet("Excel Sheet");
				HSSFRow rowhead = sheet.createRow((short) 0);
				rowhead.createCell((short) 0).setCellValue("Venue\t\t\t");
				rowhead.createCell((short) 1).setCellValue("Invigilator 1\t\t\t");
				rowhead.createCell((short) 2).setCellValue("Invigilator 2\t\t\t");
				
				/*-------------------------------------------------------------------*/
				
				q="select * from seating_rooms where Used='Yes' ";
				rs=stmt.executeQuery(q);
				//out.println(q);
				
				String ven;
				String inv_1;
				String inv_2;		
				int index=1;
				while(rs.next())
				{
					/*---Conversion Of Database data to Excel Sheet-----*/

					ven=rs.getString("Venue");
					inv_1=rs.getString("Invigilator_1");
					inv_2=rs.getString("Invigilator_2"); 	
					//out.print(ven);
					//out.print(inv_1);
					//out.print(inv_2);
					
					HSSFRow row = sheet.createRow((short) index);
					row.createCell((short) 0).setCellValue(ven);
					row.createCell((short) 1).setCellValue(inv_1);
					row.createCell((short) 2).setCellValue(inv_2);	
					index++;
						
		
					/*--------------------------------------------------*/	
				}
					
					FileOutputStream fileOut = new FileOutputStream("./webapps/exam/temp/Invigilation.xls");
					wb.write(fileOut);
					fileOut.close();
					
					rs.close();
					stmt.close();
					/*--------------------Conversion Of Excel Sheet to PDF--------------------------*/
	
					FileInputStream input_document = new FileInputStream(new File("./webapps/exam/temp/Invigilation.xls"));
					// Read workbook into HSSFWorkbook
					HSSFWorkbook my_xls_workbook = new HSSFWorkbook(input_document); 
					// Read worksheet into HSSFSheet
					HSSFSheet my_worksheet = my_xls_workbook.getSheetAt(0); 
					// To iterate over the rows
					Iterator<Row> rowIterator = my_worksheet.iterator();
					//We will create output PDF document objects at this point
					Document iText_xls_2_pdf = new Document();
					PdfWriter.getInstance(iText_xls_2_pdf, new FileOutputStream("./webapps/exam/temp/Invigilation.pdf"));
					iText_xls_2_pdf.open();
					//we have three columns in the Excel sheet, so we create a PDF table with three columns
					//Note: There are ways to make this dynamic in nature, if you want to.
					PdfPTable my_table = new PdfPTable(3);
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
						float[] columnWidths = new float[] {15f,20f,25f};
						my_table.setWidths(columnWidths);
						iText_xls_2_pdf.add(my_table);                       
						iText_xls_2_pdf.close();                
						//we created our pdf file..
						input_document.close(); //close xls
						
					/*------------------------------------------------------------------------------------*/	
				response.sendRedirect("InvigilationShow.jsp");			
		
			%>
			
			</div	
        <script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>