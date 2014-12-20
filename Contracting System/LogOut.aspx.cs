using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UserId"] = -1;
            Session["UserName"] = "";
            Session["Tbl_Security"] = new DataTable();
            Response.Redirect("Default.aspx");
        }
    }
}