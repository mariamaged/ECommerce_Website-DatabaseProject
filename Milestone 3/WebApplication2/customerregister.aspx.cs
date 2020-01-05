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
    public partial class customerregister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void customertodatabase(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("customerRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string username = TextBox1.Text;
            string password = TextBox2.Text;
            string firstname = TextBox3.Text;
            string lastname = TextBox4.Text;
            string email = TextBox5.Text;
             
            if(username=="" || password=="" || firstname=="" || lastname=="" || email == "")
            {
                Response.Write("Data is Missing!");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@username", username));
                cmd.Parameters.Add(new SqlParameter("@password", password));
                cmd.Parameters.Add(new SqlParameter("@first_name", firstname));
                cmd.Parameters.Add(new SqlParameter("@last_name", lastname));
                cmd.Parameters.Add(new SqlParameter("@email", email));

                SqlParameter success = cmd.Parameters.Add("@return", SqlDbType.Bit);
                success.Direction = ParameterDirection.Output;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                 if (success.Value.ToString().Equals("True")) {
                     Response.Write("Username Already Taken!");
                 }

                else {
                    Response.Redirect("Login.aspx", true);
                }
            }
        }
    }
}