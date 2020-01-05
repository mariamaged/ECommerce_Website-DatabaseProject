<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customerregister.aspx.cs" Inherits="WebApplication2.customerregister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
   .fields{
       display:table;
   }
  .row {
  display: table-row;
  }
  .cell {
  display: table-cell;
  }
  body {
  background-image:url('blue.png');
  background-size:cover
  }
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
<body>
    <form id="form1" runat="server">
    <!--Header part-->
    <div>
        <h1 id ="header" runat ="server">Please enter the following information:</h1>
    </div>
    <!--Data entry part-->
    <div class="fields">
    <div class="row">
        <asp:Label id="Label1" runat="server" text="Username" class="cell"></asp:Label> &nbsp;
        <asp:TextBox id="TextBox1" runat="server" class="cell"></asp:TextBox> <br /><br />
    </div>

    <div class="row">
        <asp:Label id="Label2" runat="server" text="Password" class="cell"></asp:Label> &nbsp;
        <asp:TextBox id="TextBox2" runat="server" textmode ="Password" class="cell"></asp:TextBox> <br /><br />
    </div>

    <div class="row">
        <asp:Label id="Label3" runat="server" text="First Name" class="cell"></asp:Label> &nbsp;
        <asp:TextBox id="TextBox3" runat="server" class="cell"></asp:TextBox> &nbsp;

        <asp:Label id="Label4" runat="server" text="Last Name" class="cell"></asp:Label> &nbsp;
        <asp:TextBox id="TextBox4" runat="server" class="cell"></asp:TextBox> <br /><br />
    </div>

    <div class="row">
        <asp:Label id="Label5" runat="server" text="Email" class="cell"></asp:Label> &nbsp;
        <asp:TextBox id="TextBox5" runat="server" class="cell"></asp:TextBox><br /><br />          
    </div>
    </div>

    <!--Submit Button part-->
    <div>
        <asp:Button id="Button1" runat="server" text="Submit" onclick ="customertodatabase" class="button"/>
    </div>

    </form>
</body>
</html>
