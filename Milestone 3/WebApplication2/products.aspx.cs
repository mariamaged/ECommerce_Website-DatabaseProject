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
    public partial class products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("showProducts", conn);
            cmd.CommandType = CommandType.StoredProcedure;

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

        protected void addtocart(object sender, EventArgs e)
        {
            Button btn = (Button)sender as Button;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer as GridViewRow;

            Label serial = (Label)gvr.FindControl("Label1");
            Label avai = (Label)gvr.FindControl("available");
            String avstr = avai.Text;
            string serialnum = serial.Text;

            if (avstr.Equals("True")){
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand cmd = new SqlCommand("addToCart", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                string customername = (string)Session["username"];

                cmd.Parameters.Add(new SqlParameter("@customername", customername));
                cmd.Parameters.Add(new SqlParameter("@serial", serialnum));

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Write("Product added to cart succesfully!"); }
            else
            {
                Response.Write("Product is not available!");
            }

        }

        protected void namesselected(object sender, EventArgs e)
        { 
            DropDownList list = (DropDownList)sender as DropDownList;
            GridViewRow gvr = (GridViewRow)list.NamingContainer as GridViewRow;

            if (list.SelectedValue != "0")
            {

                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand cmd = new SqlCommand("AddtoWishlist", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                Label l1 = (Label)gvr.FindControl("Label1");
                string customername = (string)Session["username"];
                string wishlistname = list.SelectedItem.Text;
                string serialnum = l1.Text;

                string s = "'" + (string)Session["username"] + "'";
                string wish = "'" + wishlistname + "'";
                string query = "SELECT * FROM Wishlist_Product w WHERE  w.username ="
                    + s + " and wish_name=" + wish + " and serial_no=" + serialnum;

                SqlCommand cmd2 = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd2.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Close();
                    Response.Write("Item is already in your WishList");
                }
                else
                {
                    reader.Close();
                    cmd.Parameters.Add(new SqlParameter("@customername", customername));
                    cmd.Parameters.Add(new SqlParameter("@serial", serialnum));
                    cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlistname));


                    cmd.ExecuteNonQuery();
                    list.Visible = false;
                    Response.Write("Product added to wishlist " + wishlistname + " succesfully!");
                }
                conn.Close();
            }
         
            }
                
            
        

        protected void addtowishlist(object sender, EventArgs e)
        {


            Button btn = (Button)sender as Button;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer as GridViewRow;
            int index = gvr.RowIndex;
            DropDownList list = (DropDownList)GridView1.Rows[index].FindControl("DropDownList1") as DropDownList;

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            string user = "'" + (string)Session["username"] + "'";
            string query = "SELECT W.name FROM Wishlist W WHERE W.username = " + user;
            SqlCommand cmd = new SqlCommand(query, conn);

            SqlDataReader reader = cmd.ExecuteReader();

            list.DataSource = reader;
            list.DataBind();

            cmd.Dispose();
            conn.Close();
            conn.Dispose();

            list.Visible = true;


        }

        protected void sort(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("ShowProductsByPrice", conn);
            cmd.CommandType = CommandType.StoredProcedure;

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