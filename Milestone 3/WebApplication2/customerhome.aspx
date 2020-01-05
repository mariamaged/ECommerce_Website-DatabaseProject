<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customerhome.aspx.cs" Inherits="WebApplication2.customerhome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            background-image:url('blue.png');
        }
        #wish {
            margin-top: 0px;
        }
        #theuser {
             float:right;
        }
        .dashedborder {
            border-style:dashed;
            padding:15px;
        }
        .fields{display:table;}
        .fields-row{display: table-row;}
        .fields-cell{display: table-cell;}
        .outerDiv {
		height: 200px;
		width: 600px;
		padding: 5px;
	    }
    	.leftDiv {
		height: 200px;
		width: 48%;
		float: left;
	    }
	    .rightDiv {
		height: 200px;
		width: 48%;
		float: right;
	    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!--The Home Page Part-->
            <div><asp:Label ID="theuser" runat="server"></asp:Label></div>
            <div><h1 id="header" runat="server">Home Page</h1></div>
        <!--View Wishlist and Add wishlist part-->
        <div class="outerDiv">
        <div class="leftDiv">
            <asp:ImageButton id = "ImageButton1" runat="server" onclick="viewwishlist" src ="viewwishlist.png" Height="98px" Width="150px"/> &nbsp;
            <asp:Label id="Label1" runat="server" text="<b>View Wishlist</b>"></asp:Label><br /><br />
            <div id="wishview" runat="server" visible="false">
                <asp:DropDownList ID="DropDownList1" runat="server" onselectedindexchanged ="namesselected" 
                    AutoPostBack="true" AppendDataBoundItems="true" DataTextField="name" DataValueField="name">
                    <asp:ListItem Text="Select wishlist:" Value="0" />
                </asp:DropDownList>
            </div>     
        </div>
        <div class="rightDiv">
            <asp:ImageButton id="ImageButton2" runat="server" onclick ="createwishlist" src ="createwishlist.jpg" Height="98px" Width="150px"/> &nbsp
            <asp:Label id="Label2" runat="server" text="<b>Create Wishlist</b>"></asp:Label> <br /><br />
            <div id="wish" runat="server" visible="false">
                <asp:Label id="Label8" runat="server" text="Name"></asp:Label> &nbsp;
                <asp:TextBox id="TextBox4" runat="server"></asp:TextBox><br /><br />
                <asp:Button id="Button2" runat="server" text="Submit" onclick ="wishsubmit"/>
            </div>
        </div>
        </div>
        <!--View products and View cart part-->
        <div class="outerDiv">
        <div class="leftDiv">
          <asp:ImageButton id="ImageButton3" runat="server" onclick="viewproducts" src ="viewproducts.jpg" Height="98px" Width="150px"/> &nbsp;
          <asp:Label id="Label3" runat="server" text="<b>View Products</b>"></asp:Label> <br /><br />
        </div>  

        <div class="rightDiv">
        <asp:ImageButton id="ImageButton5" runat="server" onclick="viewcart" src ="viewcart.jpg" Height="98px" Width="150px"/> &nbsp;
        <asp:Label id="Label10" runat="server" text="<b>View Cart</b>"></asp:Label> <br /><br />
        </div>
        </div>


        <!--View orders part-->
        <div>
          <asp:ImageButton id="ImageButton4" runat="server" onclick="vieworders" src ="orders.png" Height="98px" Width="150px"/> &nbsp;
          <asp:Label id="Label4" runat="server" text="<b>View Orders</b>"></asp:Label> <br /><br />
        </div>


        <!--Credit Card part-->
        <div class="dashedborder" >
        <div>
            <h2 id="creditheader" runat="server">Add Credit Card</h2>
        </div>
        <div class="fields">
        <div class="fields-row">
            <asp:Label id="Label5" runat="server" text="Card Number" class="fields-cell"></asp:Label> &nbsp; 
            <asp:TextBox id="TextBox1" runat="server" class="fields-cell"></asp:TextBox><br /><br />
        </div>

        <div class="fields-row">
            <asp:Label id="Label6" runat="server" text="CVV Code" class="fields-cell"></asp:Label> &nbsp; 
            <asp:TextBox id="TextBox2" runat="server" class="fields-cell"></asp:TextBox><br /><br />
        </div>

        <div class="fields-row">
            <asp:Label id="Label7" runat="server" text="Expiry date" class="fields-cell"></asp:Label> &nbsp; 
            <asp:TextBox id="TextBox3" runat="server" class="fields-cell"></asp:TextBox><br /><br />
        </div>
        </div>
         <div>
             <asp:Button id="Button1" runat="server" text="submit" onclick="addcreditcard"/>
         </div>
         </div><br /><br />


        <!--Mobile Number part-->
         <div class="dashedborder">
            <div>
            <h2 id="mobileheader" runat="server">Add Mobile Number</h2>
            </div>

            <div class="fields">
            <div class="fields-row">
                <asp:Label id="Label9" runat="server" text="Mobile Number" class="fields-cell"></asp:Label> &nbsp; 
                <asp:TextBox id="TextBox5" runat="server" class="fields-cell"></asp:TextBox><br /><br />
            </div>
            </div>

            <div>
                <asp:Button id="Button3" runat="server" text="submit" onclick="addmobilenumber"/>
            </div>
        </div>
    </form>
</body>
</html>
