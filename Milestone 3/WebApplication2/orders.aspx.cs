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
    public partial class orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string s = "'" + (string)Session["username"] + "'";
            string query = "SELECT O.order_no, O.total_amount,O.order_status FROM Orders O WHERE O.customer_name = " + s;
            SqlCommand cmd = new SqlCommand(query, conn);

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

            for(int i = 0; i < GridView1.Rows.Count; i++)
            {
                Label l3=(Label)GridView1.Rows[i].FindControl("Label3");
                String mystatus = l3.Text;
                if(mystatus=="not processed" || mystatus == "in process")
                {
                    GridView1.Rows[i].FindControl("Button1").Visible = true;
                }
                else
                {
                    Panel p1 = (Panel)GridView1.Rows[i].FindControl("Panel1");
                    Button b1 = (Button)GridView1.Rows[i].FindControl("Button1");
                    Label l1 = (Label)GridView1.Rows[i].FindControl("Label4");
                    p1.Controls.Remove(b1);
                    l1.Attributes.Add("style", "display:block");
                }


            }
            conn.Close();
        }


        protected void cancel(object sender, EventArgs e)
        {
            Button button1 = (Button)sender;
            GridViewRow myrow =(GridViewRow)button1.NamingContainer;

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("cancelOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            Label l1 = (Label)myrow.FindControl("Label1");
            String myorderid = l1.Text;
            int myorder = Int32.Parse(myorderid);
            
            cmd.Parameters.Add(new SqlParameter("@orderid", myorder));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Write("Order deleted successfully!");

            string s = "'" + (string)Session["username"] + "'";
            string query = "SELECT O.order_no, O.total_amount, O.order_status FROM Orders O WHERE O.customer_name = " + s;
            cmd = new SqlCommand(query, conn);

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

            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                Label l3 = (Label)GridView1.Rows[i].FindControl("Label3");
                String mystatus = l3.Text;
                if (mystatus == "not processed" || mystatus == "in process")
                {
                    GridView1.Rows[i].FindControl("Button1").Visible = true;
                }
                else
                {
                    Panel p1 = (Panel)GridView1.Rows[i].FindControl("Panel1");
                    Button b1 = (Button)GridView1.Rows[i].FindControl("Button1");
                    Label l2 = (Label)GridView1.Rows[i].FindControl("Label4");
                    p1.Controls.Remove(b1);
                    l2.Attributes.Add("style", "display:block");
                }


            }
            conn.Close();
        }

        protected void homepage(object sender, EventArgs e)
        {
            Response.Redirect("customerhome.aspx", true);
        }

        protected void carts(object sender, EventArgs e)
        {
            Response.Redirect("cart.aspx", true);
        }

        protected void product(object sender, EventArgs e)
        {
            Response.Redirect("products.aspx", true);
        }

    }
}