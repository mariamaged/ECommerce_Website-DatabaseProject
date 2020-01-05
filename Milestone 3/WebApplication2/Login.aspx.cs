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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gotologin(object sender, EventArgs e)
        {
 
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string username = TextBox1.Text;
            string password = TextBox2.Text;

            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;
            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString().Equals("False"))
            {
                if (type.Value.ToString().Equals("-1"))
                {
                    Response.Write("Wrong Password!");
                }

                else
                {
                    Response.Write("Wrong username or password!");

                }
            }
            else
            {
                Session["username"] = TextBox1.Text;
                if (type.Value.ToString().Equals("0")) //customer
                {
                    Response.Redirect("customerhome.aspx", true);

                }
                if (type.Value.ToString().Equals("1")) //vendor
                {
                    Response.Redirect("vendorhome.aspx", true);

                }
                if (type.Value.ToString().Equals("2")) //admin
                {

                }
                if (type.Value.ToString().Equals("3")) //delivery
                {

                }
            }
        }
    }
}