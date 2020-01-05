<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication2.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .fields{display:table;}
        .fields-row{display: table-row;}
        .fields-cell{display: table-cell;}
        body {
            background-image: url('ecommerce-plugins.jpg');
        }
        #Label1 {
            font-weight:bold;
            color:#DB5548;
        }
        .data {
            font-weight:bold;
            color:#FBCC62;
            display:table-cell;
        }
        #Button1 {
            line-height: 50px;
            font-weight:bold;
            text-align: center;
            height: 50px;
            width: 250px;
            cursor: pointer;
            background-color:#63CBE4;
            border:hidden;
        }
        #Button1:hover {
            line-height: 50px;
            font-weight:bold;
            text-align: center;
            height: 50px;
            width: 250px;
            cursor: pointer;
            background-color:#FFFFFF;
            border:hidden;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!--The Login part-->
        <div>
           <h1 id="Label1" runat="server">Login</h1>
        </div>
        <!--The username and password part-->
        <div class="fields">
        <div class="fields-row">
            <asp:Label id="Label2" runat="server" text ="Username" class="data"/> &nbsp; 
            <asp:TextBox id="TextBox1" runat="server" class="fields-cell"/> <br /><br />
        </div>

        <div class="fields-row">
            <asp:Label id="Label3" runat="server" text="Password" class ="data"/> &nbsp;
            <asp:TextBox id="TextBox2" runat="server" textmode="Password" class="fields-cell"></asp:TextBox> <br /><br />
        </div>
        </div>
        <!--The submit button part-->
        <div>
            <asp:Button id="Button1" runat="server" text="Submit" onclick = "gotologin"/><br /><br />
        </div>

        <asp:HyperLink id="HyperLink1" runat="server" text="Don't have an account? Sign up" navigateurl="~/Register.aspx">
        </asp:HyperLink>

    </form>
</body>
</html>
