
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void customerpage(object sender, EventArgs e)
        {
            Response.Redirect("customerregister.aspx", true);
        }
        protected void vendorpage(object sender, EventArgs e)
        {
            Response.Redirect("vendorregister.aspx", true);
        }
    }
}