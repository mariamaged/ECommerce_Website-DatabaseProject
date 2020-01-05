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
    public partial class vendorregister: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void vendortodatabase(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("vendorRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string username = TextBox1.Text;
            string password = TextBox2.Text;
            string firstname = TextBox3.Text;
            string lastname = TextBox4.Text;
            string email = TextBox5.Text;
            string bankaccnum= TextBox6.Text;
            string companyname = TextBox7.Text;

           
            if(username=="" || password=="" || firstname=="" || lastname=="" || email == "" || bankaccnum=="" || companyname=="") {
                Response.Write("Data is Missing!");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@username", username));
                cmd.Parameters.Add(new SqlParameter("@password", password));
                cmd.Parameters.Add(new SqlParameter("@first_name", firstname));
                cmd.Parameters.Add(new SqlParameter("@last_name", lastname));
                cmd.Parameters.Add(new SqlParameter("@email", email));
                cmd.Parameters.Add(new SqlParameter("@company_name",companyname));
                cmd.Parameters.Add(new SqlParameter("@bank_acc_no", bankaccnum));

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