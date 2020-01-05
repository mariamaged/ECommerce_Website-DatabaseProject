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
    public partial class customerhome : System.Web.UI.Page
    {
        void Page_PreRender(object obj, EventArgs e)
        {
            ViewState["update"] = Session["update"];
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
            }
            theuser.Text = "Username: " + "<b>" + (string)Session["username"] + "</b>";
        }

        protected void addmobilenumber(object sender, EventArgs e)
        {

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string user = (string)Session["username"];
            string mobile = TextBox5.Text;

            cmd.Parameters.Add(new SqlParameter("@username", user));
            cmd.Parameters.Add(new SqlParameter("@mobile_number", mobile));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        protected void addcreditcard(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string cardnumber = TextBox1.Text;
            string cvv = TextBox2.Text;
            string expirydate = TextBox3.Text;
            string customername = (string)Session["username"];

            cmd.Parameters.Add(new SqlParameter("@creditcardnumber", cardnumber));
            cmd.Parameters.Add(new SqlParameter("@expirydate", expirydate));
            cmd.Parameters.Add(new SqlParameter("@cvv", cvv));
            cmd.Parameters.Add(new SqlParameter("@customername",customername));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
    
        protected void vieworders(object sender, EventArgs e)
        {
            Response.Redirect("orders.aspx", true);
        }
        protected void viewproducts(object sender, EventArgs e)
        {           
            Response.Redirect("products.aspx", true);
        }
        protected void viewcart(object sender, EventArgs e)
        {
            Response.Redirect("cart.aspx", true);
        }

        protected void createwishlist(object sender, EventArgs e)
        {
            wish.Visible = true;        
        }

        protected void wishsubmit(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string name = TextBox4.Text;
            string customername = (string)Session["username"];

            cmd.Parameters.Add(new SqlParameter("@name", name));
            cmd.Parameters.Add(new SqlParameter("@customername", customername));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            wish.Visible = false;
        }

        protected void viewwishlist(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            string user = "'" + (string)Session["username"] + "'";
            string query = "SELECT W.name FROM Wishlist W WHERE W.username = " + user;
            SqlCommand cmd = new SqlCommand(query, conn);

            SqlDataReader reader = cmd.ExecuteReader();      

            DropDownList1.DataSource = reader;
            DropDownList1.DataBind();

            cmd.Dispose();
            conn.Close();
            conn.Dispose();

            wishview.Visible = true;
        }

        protected void namesselected(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue != "0" && Session["update"].ToString() == ViewState["update"].ToString())
            {
                string name = DropDownList1.SelectedItem.Text;
                Session["name"] = name;
                Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
                Response.Redirect("wishlist.aspx", true);        
            }

        }
    }
}