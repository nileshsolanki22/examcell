<html>
<head>
<script>
function validLogin() // java script function is created
{
if(document.frm1.userName.value == "")
{
alert ( "Please enter  Login Name." ); //java script message will be display
document.loginform.userName.focus();
return false;
}
if (document.frm1.pass.value == "")
{
alert ( "Please Enter your password….." );
document.userform.password.focus();
return false;
}
alert("Welcome mrbool readers" );
return true;
}
</script>
</head>
<body>
<form name="frm1" method="post" onsubmit="return validLogin();">
<table width="150px" border=0 style="background-color: H0080FF80;">
<tr><td colspan=2 align="center" style="font-weight:bold;font-size:20pt;" align="center"><b>B.C.E.I User Login Form.</b></td>
</tr>
<tr><td colspan=2> </td>
</tr>
<tr><td style="font-size:12pt;" align="center">Enter login Name:</td>
<td><input type="text" name="userName" value=""></td>
</tr>
<tr><td style="font-size:12pt;" align="center">Enter Password:</td>
<td><input type="password" name="password" value=""></td>
</tr>
<tr>
<td></td>
<td><input type="submit" name="Submit" value="Login as B.C.E.I User’s"></td>
</tr>
</table>
</form>
</body>
</html>