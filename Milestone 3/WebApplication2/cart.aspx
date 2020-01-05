<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="WebApplication2.cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .outer {
         display: flex;
         align-items:center;
         justify-content: left;
         display:table-row;
        }
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
        body {
        background-image:url('products.jpg');
        background-size:cover
        }
        #header {
        color:#A55129;
        font-weight:bold
        }
        .text {
        color:#233a3c;
        font-weight:bold;
        display:table-cell;
        }
        .button {
        color:#000000;
        background-color:#ACA1B4;
        cursor:pointer;
        }
        .remove {
        color:#000000;
        background-color:#ACA1B4;
        cursor:pointer;
        border:hidden;
        border-radius:2px;
        }
        #Button1.button {
        height:30px;
        width:120px;
        border-color:#000000;
        border:1px solid;
        text-align:center;
        font-weight:bold;
        }
        #Button2.button {
        height:30px;
        width:80px;
        border-color:#000000;
        border:1px solid;
        text-align:center;
        font-weight:bold;
        }
        .outer1 {
        display:table;
        }
        .fields-cell {display:table-cell;}
    </style>
</head>
<body>
        <form id="form1" runat="server">
         <!--Upper Panel-->
         <div>
         <asp:Button id="Button3" runat="server" text="Homepage" onclick="homepage" class="btn1"/>

         <div class="outerDiv"> 
         <div class="leftDiv"><asp:ImageButton id="ImageButton1" runat="server" src="viewcart2.png" onclick="carts" title="Cart" style="max-height:100%;max-width:100%"/></div>
         <div class="rightDiv"><asp:ImageButton id="ImageButton2" runat="server" src="viewproducts.jpg" onclick="product" title="Products" style="max-height:100%;max-width:100%"/></div>
         </div>

         </div>
         <!--Header-->
         <h1 id="header" runat="server">Cart</h1>
         <!--Cart GridView-->
            <asp:Panel ID="Panel1" runat="server">
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
                        <asp:Button ID="removefromcart" Text="Remove from cart" runat="server" onclick="removefromcart" class="remove"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>  
        </asp:GridView><br /><br />
        <!--Make an order button-->
            <asp:Button ID="Button1" runat="server" Text="Make an order" onclick="makeanorder" class="button"/><br /><br />
        </asp:Panel>
        <!--Id and Price GridView -->
             <div>
            <asp:GridView ID="GridView2" runat="server"  
            BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px"  
            CellPadding="3" CellSpacing="2" AutoGenerateColumns="False" style="margin-top: 0px" Visible="false">  
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />  
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />  
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />  
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />  
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White"/>  
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

                <asp:TemplateField HeaderText="Total Amount">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("total_amount") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>  
        </asp:GridView>  
        </div><br /><br />
            <!--Payment method DropDownList-->  
            <div class="outer1">
            <div class="outer">
            <asp:Label ID="Label7" runat="server" Text="Choose payment method" Visible="false" class="text"></asp:Label> &nbsp;          
            <asp:DropDownList ID="DropDownList1" runat="server"  onselectedindexchanged ="namesselected" 
                    AutoPostBack="true" AppendDataBoundItems="true" Visible="false" class="fields-cell">
                    <asp:ListItem Text ="-" Value="0"/>
                    <asp:ListItem Text="cash" Value="cash"/>
                    <asp:ListItem Text="credit card" Value="credit card"/>
                </asp:DropDownList> <br /><br />
            </div>
           <!--Credit Card Info DropDownList-->
           <asp:Panel id = "Panel2" runat="server" style="display: flex;
         align-items:center;
         justify-content: left;
         display:table-row;">
           <asp:Label ID="Label9" runat="server" Text="Choose credit card" Visible="false" class="text"></asp:Label> &nbsp;
           <asp:DropDownList ID="DropDownList2" runat="server"  onselectedindexchanged ="choosecredit" 
        AutoPostBack="true" AppendDataBoundItems="true" DataTextField="cc_number" DataValueField="cc_number" Visible="false" lass="fields-cell">
                   <asp:ListItem Text ="-" Value="0"/>                   
                </asp:DropDownList> <br /><br />
             </asp:Panel>  
             <!--Payment Amount Textbox-->
             <div class="outer">
                <asp:Label ID="Label8" runat="server" Text="Payment amount:" Visible="false" class="text"></asp:Label> &nbsp;
                <asp:TextBox ID="TextBox1" runat="server" Visible="false" class="fields-cell"></asp:TextBox><br /><br />
             </div>
            </div>
            <!--Submit Button-->
            <div>
                <asp:Button ID="Button2" runat="server" Text="Submit" onclick="submitpayment" Visible="false" class="button"/>
            </div>

    </form>
</body>
</html>
