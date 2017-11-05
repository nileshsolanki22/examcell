<html>
<%@ include file="Home2.jsp"
%>
</head>
	</title><h1><center>Welcome</center></h1></title>
</head>
<body>
		<div class="header">
                <a href="#"><strong>&laquo; Welcome,<%=session.getAttribute("name")%> </strong>(<%=session.getAttribute("usertype")%>)</a>
                <span class="right">
                    <a href="" target="_blank"></a>
                    <a href="logout.jsp">Logout</a>
                </span>
                <div class="clr"></div>
            </div>
			<div class="main-content">
				Hello <br/>
				Testing <br/>
			</div>
</body>
</html>