<!DOCTYPE html>
<%@page session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.http.Cookie;"%>


<html lang="en">
    <head>
		<title>NIIT University Exam Cell</title>
        <link rel="stylesheet" type="text/css" href="css/demo.css" />
        <link rel="stylesheet" type="text/css" href="css/style2.css" />
		
    </head>
    <body>
        <div class="container">
            <div class="header">
				<%
				if((session.getAttribute("name")==null)||(((session.getAttribute("usertype")).equals("admin"))==false))
				{
					//out.print("Error");
					response.sendRedirect("sessionexpired.jsp");
				}
				%>

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
                        <a href="#">
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
		Connection con = null;
		//Connection conn = null;
		PreparedStatement pst = null;
		PreparedStatement studb = null;
		Statement stmt=null;
		Statement stmt2=null;
		ResultSet rs = null;
		ResultSet rs2 = null;

		int subcount = 0;
		String String1 = new String();
		String String2 = new String();
		String url = "jdbc:mysql://localhost:3306/examcell";
		String user = "root";
		String password = "";

		ArrayList<String> singleList = new ArrayList<String>();
		ArrayList<ArrayList<String>> listOfLists = new ArrayList<ArrayList<String>>();

		ArrayList<String> conflictsubjects = new ArrayList<String>();
		ArrayList<ArrayList<String>> listOfnoconfsub = new ArrayList<ArrayList<String>>();
		
		ArrayList<String> noconflictsubjects = new ArrayList<String>();
		ArrayList<ArrayList<String>> listOfconfsub = new ArrayList<ArrayList<String>>();
		
		ArrayList<String> singleSlot = new ArrayList<String>();
		ArrayList<ArrayList<String>> listofSlots = new ArrayList<ArrayList<String>>();
		
		ArrayList<String> subjectsDone = new ArrayList<String>();
		
		/*
		int slotcapacity;
		Scanner in = new Scanner(System.in);
		out.println("Enter Total Capacity of each slot");
		slotcapacity = in.nextInt();
		out.println("");
		*/

		out.print("<pre>");
		try {
			con = DriverManager.getConnection(url, user, password);
			//con2 = DriverManager.getConnection(url, user, password);
			pst = con.prepareStatement("SELECT * FROM datesheet_course_detail");
			studb = con.prepareStatement("SELECT * FROM courses");
			rs = pst.executeQuery();
			rs2 = studb.executeQuery();

			while (rs.next())
			{
				String1 = rs.getString(1);
				if(String1!= null && !String1.isEmpty())
				{
					subcount = subcount + 1;
				}
			}
			out.println("number of subjects = " + subcount);


			rs = pst.executeQuery();

			int hc = 0;
			while (rs.next())
			{
				rs2 = studb.executeQuery();
				//out.println("inside rs.next");
				if(String1!= null && !String1.isEmpty())
				{
					String1 = rs.getString(1);
					//out.println("-----------------");
					//out.println(String1);
					//out.println("-----------------");
					singleList.add(String1);

				}
				int counter = 0;
				while(rs2.next())
				{
					//out.println("inside rs2.next");
					String2 = rs2.getString(3);
					//out.println(String2);

					if(String1.equals(String2))
					{
						String String3 = rs2.getString(2);
						if(String3!= null && !String3.isEmpty())
						{
							//out.println("printing enrollment no.");
							//out.println(rs2.getString(2));
							counter = counter + 1;
							singleList.add(String3);
						}
					}
				}
				//out.println("Total Students in "+rs.getString(1)+" = "+counter);
				if (counter > hc)
				{
					hc = counter;
				}
				ArrayList<String> saverList = new ArrayList<String>(singleList);
				singleList.clear();
				listOfLists.add(saverList);
			}
			for(int x = 0; x < listOfLists.size(); x++)
			{
				conflictsubjects.add(listOfLists.get(x).get(0));
				noconflictsubjects.add(listOfLists.get(x).get(0));
				//out.println("Exams that conflict with "+listOfLists.get(x).get(0)+" : ");
				for(int z = 0; z < listOfLists.size(); z++)
				{
					List <String> result = null;
					if(!listOfLists.get(x).get(0).equals(listOfLists.get(z).get(0)))
					{
						ArrayList<String> arrayList1 = new ArrayList<String>(listOfLists.get(x));
						ArrayList<String> arrayList2 = new ArrayList<String>(listOfLists.get(z));
						result = new ArrayList<String>(arrayList1);
						result.retainAll(arrayList2);
					}
					if(result!= null && !result.isEmpty())
					{
						//out.println(listOfLists.get(z).get(0));
						conflictsubjects.add(listOfLists.get(z).get(0));
					}
					else if(!listOfLists.get(z).get(0).equals(listOfLists.get(x).get(0)))
					{
						noconflictsubjects.add(listOfLists.get(z).get(0));
					}
				}
				ArrayList<String> subjectsaverList = new ArrayList<String>(conflictsubjects);
				ArrayList<String> subjectsaverList2 = new ArrayList<String>(noconflictsubjects);
				conflictsubjects.clear();
				noconflictsubjects.clear();
				listOfconfsub.add(subjectsaverList);
				listOfnoconfsub.add(subjectsaverList2);
				//out.println("Total Students in "+listOfLists.get(x).get(0)+" = "+(listOfLists.get(x).size()-1));
				//out.println("");
			}
			
			for(int x = 0; x < listOfconfsub.size(); x++)
			{
				out.println("Exams that conflict with "+listOfconfsub.get(x).get(0)+" : ");
				for(int z = 1; z < listOfconfsub.get(x).size(); z++)
				{
					out.println(listOfconfsub.get(x).get(z));
				}
				out.println("");
				out.println("Exams that don't conflict with "+listOfnoconfsub.get(x).get(0)+" : ");
				for(int c = 1; c <listOfnoconfsub.get(x).size(); c++)
				{
					out.println(listOfnoconfsub.get(x).get(c));
				}
				out.println("");
				out.println("");
			}
			
			
			int flag = 0;
			for(int s=0; s < listOfnoconfsub.size(); s++)
			{
				//System.out.print("Slot "+ (s+1) + " : ");
				for(int ac = 0; ac < listOfnoconfsub.get(s).size(); ac++)
				{
					if(!subjectsDone.contains(listOfnoconfsub.get(s).get(ac)))
					{
						
						for(int xc = 0; xc < listOfconfsub.size(); xc++)
						{
							if(listOfnoconfsub.get(s).get(ac).equals(listOfconfsub.get(xc).get(0)))
							{
								for(int zc = 1; zc < listOfconfsub.get(xc).size(); zc++)
								{
									if(!singleSlot.contains(listOfconfsub.get(xc).get(zc)))
									{
										flag = 1;
									}
									else
									{
										flag = 0;
									}
								}
								System.out.println("");
							}
						}
						if (flag == 1)
						{
							//System.out.print(listOfnoconfsub.get(s).get(ac) + " ");
							subjectsDone.add(listOfnoconfsub.get(s).get(ac));
							singleSlot.add(listOfnoconfsub.get(s).get(ac));
						}
					}
				}
				ArrayList<String> saverList3 = new ArrayList<String>(singleSlot);
				singleSlot.clear();
				listofSlots.add(saverList3);
				//System.out.println("");
			}
			
			int m,n=1;
			int day=1;
			//Array list
			String nos=" ";
			String q="";
			stmt=con.createStatement();
			stmt2=con.createStatement();
			for(int x = 0; x < listofSlots.size(); x++)
			{
				if((x==0)||(x%2==0))
				{
					m = 1;
					out.println("Day"+ (n) + " : ");
					out.println("");
					out.println("Slot "+ (m) + " : ");
					day=n;
					n++;
				}
				else
				{
					m=2;
					out.println("Slot "+ (m) + " : ");
				}
				for(int z = 0; z < listofSlots.get(x).size(); z++)
				{
					//out.print("index: "+day+" ");
					out.println(listofSlots.get(x).get(z));
					
 					q="select count(Enroll_no) from courses where Course_Code="+"'"+listofSlots.get(x).get(z)+"'";
					rs=stmt.executeQuery(q);
					while(rs.next())
					{
						nos=rs.getString(1);
						break;
					}
					//out.print("NOS"+nos);
					//out.print(q);
					
					q="update datesheet_course_detail set Exam_Day_No="+"'"+day+"'"+" , Slot_No="+"'"+m+"'"+" , No_Of_Students="+"'"+nos+"'"+
					" where Course_Code="+"'"+listofSlots.get(x).get(z)+"'";
					out.print(q);
					//stmt=con.createStatement();
					//studb=con.prepareStatement(q);
					studb.executeUpdate(q);
					
				}
				out.println("");
			}
			//studb.executeBatch();
			
			//Output the slots to database
			
				
		
		}catch (SQLException ex)
		{
		}
		
		finally {

			try {
				if (rs != null)
				{
					rs.close();
				}
				if (pst != null)
				{
					pst.close();
				}
				if (con != null)
				{
					con.close();
				}

			} catch (SQLException ex)
			{

			}
		}
		out.print("<pre>");
	%>
        </div>
		<script type="text/javascript" src="js/jquery.min.js"></script>
    </body>
</html>