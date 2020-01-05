<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="orders.aspx.cs" Inherits="WebApplication2.orders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
         .outerDiv {
		height: 100px;
		width: 100px;
		padding: 5px;
        float:right;
        display:block;
	    }
    	.leftDiv {
		height: 100px;
		width: 48%;
		float: left;
	    }
	    .rightDiv {
		height: 100px;
		width: 48%;
		float: right;
	    }
        .btn1 {
        border:2px solid;
        border-color:#A55129;
        border-radius:20px;
        background-color:#FFFFFF;
        color:#A55129;
        text-align:center;
        height:30px;
        width:120px;
        }
        .btn1:hover {
        border:hidden;
        border-radius:20px;
        color:#FFFFFF;
        background-color:#A55129;
        text-align:center;
        height:30px;
        width:120px;
        }
        .button {
        color:#000000;
        background-color:#ACA1B4;
        border:hidden;
        border-radius:2px;
        height:20px;
        cursor:pointer;
        }
    </style>
</head>
<body style="background-image:url('products.jpg');background-size:cover">
    <form id="form1" runat="server">
        <!--Upper Panel-->
         <div>
         <asp:Button id="Button3" runat="server" text="Homepage" onclick="homepage" class="btn1"/>

         <div class="outerDiv"> 
         <div class="leftDiv"><asp:ImageButton id="ImageButton1" runat="server" src="viewcart2.png" onclick="carts" title="Cart" style="max-height:100%;max-width:100%"/></div>
         <div class="rightDiv"><asp:ImageButton id="ImageButton2" runat="server" src="viewproducts.jpg" onclick="product" title="Products" style="max-height:100%;max-width:100%"/></div>
         </div>

         </div>
        <h1 id="header" runat="server" style="color:#A55129;font-weight:bold">Orders</h1>
            <div>
            <asp:GridView ID="GridView1" runat="server"  
            BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px"  
            CellPadding="3" CellSpacing="2" AutoGenerateColumns="False" style="margin-top: 0px">  
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />  
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />  
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />  
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />  
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />  
            <SortedAscendingCellStyle BackColor="#FFF1D4" />  
            <SortedAscendingHeaderStyle BackColor="#B95C30" />  
            <SortedDescendingCellStyle BackColor="#F1E5CE" />  
            <SortedDescendingHeaderStyle BackColor="#93451F" />  
            <Columns> 
                <asp:TemplateField HeaderText="Order Number">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("order_no") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField> 

                <asp:TemplateField HeaderText="Total Amount" >
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("total_amount") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                     <asp:TemplateField HeaderText="status" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("order_status")  %> ' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField> 

                <asp:TemplateField HeaderText="Options">
                    <ItemTemplate><asp:Panel ID="Panel1" runat="server">                
                        <asp:Button ID="Button1" runat="server" Text="Cancel order" Visible="false" OnClick="cancel" class="button"/>
                        <asp:Label ID="Label4" runat="server" Text="Order is not processed or in process" style="display:none"></asp:Label>
                        </asp:Panel>  
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>  
        </asp:GridView>  
        </div>
    </form>
    </body>
</html>

