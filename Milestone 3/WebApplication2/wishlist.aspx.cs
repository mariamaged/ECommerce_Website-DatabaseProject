using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class wishlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            wishlistheader.InnerHtml = (string)Session["name"];

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("showWishlistProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string user = (string)Session["username"];
            string name = (string)Session["name"];

            //Add the parameters.
            cmd.Parameters.Add(new SqlParameter("@customername", user));
            cmd.Parameters.Add(new SqlParameter("@name", name));

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
        }

        protected void removefromwishlist(object sender, EventArgs e)
        {
            Button btn = (Button)sender as Button;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer as GridViewRow;

            Label serial = (Label)gvr.FindControl("Label1");
            string serialnum = serial.Text;

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("removefromWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string customername = (string)Session["username"];
            string wishlistname = (string)Session["name"];

            //Add the parameters.
            cmd.Parameters.Add(new SqlParameter("@customername", customername));
            cmd.Parameters.Add(new SqlParameter("@serial", serialnum));
            cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlistname));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Write("Product removed from wishlist successfully!");

            cmd = new SqlCommand("showWishlistProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string user = (string)Session["username"];
            string name = (string)Session["name"];

            //Add the parameters.
            cmd.Parameters.Add(new SqlParameter("@customername", user));
            cmd.Parameters.Add(new SqlParameter("@name", name));

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

        }
        protected void cart(object sender, EventArgs e)
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