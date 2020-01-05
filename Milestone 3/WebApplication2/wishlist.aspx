<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="wishlist.aspx.cs" Inherits="WebApplication2.wishlist" %>

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
        width:100px;
        }
        .btn1:hover {
        border:hidden;
        border-radius:20px;
        color:#FFFFFF;
        background-color:#A55129;
        text-align:center;
        height:30px;
        width:100px;
        }
        body {
        background-image:url('products.jpg');
        background-size:cover
        }
        #wishlistheader {
        color:#A55129;
        font-weight:bold
        }
        .remove {
        color:#000000;
        background-color:#ACA1B4;
        cursor:pointer;
        border:hidden;
        border-radius:2px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
         <asp:Button ID="Button1" runat="server" Text="Homepage" onclick="homepage" class="btn1"/>
         <div class="outerDiv"> 
         <div class="leftDiv"><asp:ImageButton id="ImageButton1" runat="server" src="viewcart2.png" onclick="cart" title="Cart" style="max-height:100%;max-width:100%"/></div>
         <div class="rightDiv"><asp:ImageButton id="ImageButton2" runat="server" src="viewproducts.jpg" onclick="product" title="Products" style="max-height:100%;max-width:100%"/></div>
         </div>
        </div>
        <h1 id="wishlistheader" runat="server"></h1>
         <div>
            <asp:GridView ID="GridView1" runat="server"  
            BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px"  
            CellPadding="3" CellSpacing="2" AutoGenerateColumns="False">  
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
               <asp:TemplateField HeaderText="Serial Number" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("serial_no") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField> 

                <asp:TemplateField HeaderText="Product Name">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("product_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Product Description">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("product_description") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Price">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("price") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Final Price">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("final_price") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Color">
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("color") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>    
                  
                <asp:TemplateField HeaderText="Options">
                    <ItemTemplate>
                        <asp:Button ID="removefromwishlist" Text="Remove from wishlist" runat="server" onclick="removefromwishlist" class="remove"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>  
        </asp:GridView>  
        </div>
    </form>
</body>
</html>
