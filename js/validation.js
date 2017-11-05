function validLogin() // java script function is created
{
if(document.frm1.username.value == "")
{
alert ( "Please enter  Login Name." ); //java script message will be display
document.loginform.user.focus();
return false;
}
if (document.frm1.password.value == "")
{
alert ( "Please Enter your secret password….." );
document.userform.password.focus();
return false;
}
//else if((document.frm1.user.value =="admin") && (document.frm1.password.value == "12345"))
//location.href="Home.jsp"
//alert("Welcome admin" );
//else
//alert("Invalid credentials");
//return true;
}