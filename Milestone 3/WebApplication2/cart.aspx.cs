using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("viewMyCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string user = (string)Session["username"];

            //Add the parameters.
            cmd.Parameters.Add(new SqlParameter("@customer", user));

            conn.Open();
            cmd.ExecuteNonQuery();

            //1- Create SqlDataAdapter.
            SqlDataAdapter sqladapter = new SqlDataAdapter();
            //2- Assign to it the command.
            sqladapter.SelectCommand = cmd;
            //3- Create new dataset.
            DataSet ds = new DataSet();
            //4- fill the adapter with the data set.
            sqladapter.Fill(ds);
            //5- Give the GridView the data set as data source.
            GridView1.DataSource = ds;
            //6- bind the data
            GridView1.DataBind();

            conn.Close();
            if (GridView1.Rows.Count == 0) Button1.Visible = false;
        }
        protected void removefromcart(object sender, EventArgs e)
        {
            Button btn = (Button)sender as Button;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer as GridViewRow;

            Label serial = (Label)gvr.FindControl("Label1");
            string serialstring = serial.Text;
            int serialnum = Int32.Parse(serialstring);

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("removefromCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string customername = (string)Session["username"];

            cmd.Parameters.Add(new SqlParameter("@customername", customername));
            cmd.Parameters.Add(new SqlParameter("@serial", serialnum));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Write("Product removed from cart successfully!");

            cmd = new SqlCommand("viewMyCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@customer", customername));

            conn.Open();
            cmd.ExecuteNonQuery();

            //1- Create SqlDataAdapter.
            SqlDataAdapter sqladapter = new SqlDataAdapter();
            //2- Assign to it the command.
            sqladapter.SelectCommand = cmd;
            //3- Create new dataset.
            DataSet ds = new DataSet();
            //4- fill the adapter with the data set.
            sqladapter.Fill(ds);
            //5- Give the GridView the data set as data source.
            GridView1.DataSource = ds;
            //6- bind the data
            GridView1.DataBind();

            conn.Close();
            if (GridView1.Rows.Count == 0) Button1.Visible = false;
        }


        protected void makeanorder(object sender, EventArgs e)
        {
            // Call procedure makeOrder.
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("makeOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;
           
            string customername = (string)Session["username"];

            cmd.Parameters.Add(new SqlParameter("@customername", customername));

          
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Panel1.Attributes.Add("style", "display:none");

            // Fill the grid
            // 1 - Create SqlDataAdapter.
            string s = "'" + (string)Session["username"] + "'";
            string query = "SELECT O.order_no, O.total_amount FROM Orders O WHERE O.order_no in (select max(order_no) from Orders where O.customer_name = " 
                + s +") and O.customer_name = " + s;
            cmd = new SqlCommand(query, conn);

            SqlDataAdapter sqladapter = new SqlDataAdapter();
            //2- Assign to it the command.
            sqladapter.SelectCommand = cmd;
            //3- Create new dataset.
            DataSet ds = new DataSet();
            //4- fill the adapter with the data set.
            sqladapter.Fill(ds);
            //5- Give the GridView the data set as data source.
            GridView2.DataSource = ds;
            //6- bind the data
            GridView2.DataBind();

            // Show the Grid.
            GridView2.Visible = true;
            Label7.Visible = true;
            DropDownList1.Visible = true;

        }

        protected void namesselected(object sender, EventArgs e)
        {
          
            if (DropDownList1.SelectedItem.Text == "cash")
            {
                Session["paymentmethod"] = "cash";
                Panel2.Attributes.Add("style", "display:none");
                Label8.Visible = true;
                TextBox1.Visible = true;
                Button2.Visible = true;
            }

            if (DropDownList1.SelectedItem.Text == "credit card")
            {
                Session["paymentmethod"] = "credit card";
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                conn.Open();

                string user = "'" + (string)Session["username"] + "'";
                string query = "SELECT C.cc_number FROM Customer_CreditCard C WHERE C.customer_name = " + user;
                SqlCommand cmd = new SqlCommand(query, conn);

                SqlDataReader reader = cmd.ExecuteReader();

                DropDownList2.DataSource = reader;
                DropDownList2.DataBind();

                cmd.Dispose();
                conn.Close();
                conn.Dispose();
                Label9.Visible = true;
                DropDownList2.Visible = true;
            }
            DropDownList1.SelectedValue = "0";
        }
            protected void submitpayment(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
            cmd.CommandType = CommandType.StoredProcedure;

           

            Label l1 = (Label)GridView2.Rows[0].FindControl("Label1");
            int myorder = Int32.Parse(l1.Text);
            var price = Convert.ToDecimal(TextBox1.Text);
            var zero = 0;
            string customername = (string)Session["username"];
            if ((String)Session["paymentmethod"] == "cash")
            {
              
                cmd.Parameters.Add(new SqlParameter("@customername", customername));
                cmd.Parameters.Add(new SqlParameter("@orderID", myorder));
                cmd.Parameters.Add(new SqlParameter("@cash", price));
                cmd.Parameters.Add(new SqlParameter("@credit", zero));
            }

            if ((String)Session["paymentmethod"] == "credit card")
            {
                
                cmd.Parameters.Add(new SqlParameter("@customername", customername));
                cmd.Parameters.Add(new SqlParameter("@orderID", myorder));
                cmd.Parameters.Add(new SqlParameter("@cash", zero));
                cmd.Parameters.Add(new SqlParameter("@credit", price));
            }


            string s = "'" + (string)Session["username"] + "'";
            string query = "SELECT C.points FROM Customer C WHERE C.username ="
                + s;
            SqlCommand cmd2 = new SqlCommand(query, conn);

            conn.Open();
            SqlDataReader reader = cmd2.ExecuteReader();

            int mypoints = 0;
     
                if (reader.HasRows)
                {
                    reader.Read();
                    mypoints = reader.GetInt32(0);
                }
            conn.Close();
            cmd2.Dispose();
            conn.Close();

            Label l2= (Label)GridView2.Rows[0].FindControl("Label2");
            var total = Convert.ToDecimal(l2.Text);

            if ((total-price)>mypoints)
            {
                Response.Write("You don't have enough points!");
            }

            
            else {
                conn.Open();
                cmd.ExecuteNonQuery();

                cmd.Dispose();
                conn.Close();
                conn.Dispose();
                Response.Write("Order Successful!");
            }

        }
        protected void choosecredit(object sender, EventArgs e)
        {
            Label8.Visible = true;
            TextBox1.Visible = true;
            Button2.Visible = true;
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("ChooseCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            String cc_number = DropDownList2.SelectedItem.Text;
            Label l1 = (Label)GridView2.Rows[0].FindControl("Label1");
            int myorder = Int32.Parse(l1.Text);

            cmd.Parameters.Add(new SqlParameter("@creditcard",cc_number));
            cmd.Parameters.Add(new SqlParameter("@orderid",myorder));

            conn.Open();
            cmd.ExecuteNonQuery();

            cmd.Dispose();
            conn.Close();
            conn.Dispose();

            DropDownList2.SelectedValue = "0";

        }
        protected void carts(object sender, EventArgs e)
        {
            Response.Redirect("cart.aspx", true);
        }
        protected void product(object sender, EventArgs e)
        {
            Response.Redirect("products.aspx", true);
        }
        protected void homepage(object sender, EventArgs e)
        {
            Response.Redirect("customerhome.aspx", true);
        }

    }
}