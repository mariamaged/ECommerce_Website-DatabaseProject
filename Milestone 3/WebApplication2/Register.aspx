<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication2.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .button {
        color:#000000;
        background-color:#ACA1B4;
        cursor:pointer;
        height:30px;
        width:120px;
        border-color:#000000;
        border:1px solid;
        text-align:center;
        font-weight:bold;
        }
    </style>
</head>
<body style="background-image:url('blue.png');background-size:cover">
    <form id="form1" runat="server">
    <!--Header Part-->
    <div>
        <h1 id="Label1" runat="server">Sign up options</h1>
    </div>
    <!--Choices part-->        
    <div>
        <asp:Button id="Button1" runat="server" text="Customer" onclick= "customerpage" class="button"/>&nbsp;
        <asp:Button id="Button2" runat="server" text="Vendor" onclick= "vendorpage" class="button"/>
    </div>
    </form>
</body>
</html>
