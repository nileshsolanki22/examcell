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
				//<!----------------This code generates seating Plan----------------------->
				out.print("<pre>");
				String batch=(String)request.getParameter("batch");
				if(batch.equals("select") || batch.equals("M.Tech") || batch.equals("MBA"))
				{
					response.sendRedirect("SeatingPlan.jsp");
				}
				String course;	
				out.println("<h1>Seating Plan for "+batch+"</h1>");
				out.println("\t\t"+"Click on Course Code to download seating plan:-\n\n\n");
				
				String query="select * from datesheet_course_detail where Batch=";
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
						/*---Conversion Of Excel Sheet to PDF-----*/
						file=fname+"temp/Seating_of_"+rs.getString("Course_Code")+"_of_Batch_"+batch+".xls";
						file2=fname+"seating/Seating_of_"+rs.getString("Course_Code")+"_of_Batch_"+batch+".pdf";
						
						//out.println(file2);
						if(rs.getString("Course_Code").length()==5)
						{
							out.print("\t\t"+rs.getString("Course_Code")+"     ");
						}
						else
						{
							out.print("\t\t"+rs.getString("Course_Code")+"    ");
						}
						
						//out.println("");
						
						FileInputStream input_document = new FileInputStream(new File(file));
						//out.println(file);
						// Read workbook into HSSFWorkbook
						HSSFWorkbook my_xls_workbook = new HSSFWorkbook(input_document); 
						// Read worksheet into HSSFSheet
						HSSFSheet my_worksheet = my_xls_workbook.getSheetAt(0); 
						// To iterate over the rows
						Iterator<Row> rowIterator = my_worksheet.iterator();
						//We will create output PDF document objects at this point
						Document iText_xls_2_pdf = new Document();
						
						//out.println(file2);
						
						PdfWriter.getInstance(iText_xls_2_pdf, new FileOutputStream(file2));
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