using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace stellar.uploadfile
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string txt = "";
                if (Request.Files.Count > 0)
                {
                    txt = Request.Files[0].FileName;
                    //here save the file Request.Files[0]
                    Request.Files[0].SaveAs(Server.MapPath("~/uploadfile/" + Request.Files[0].FileName));
                    Response.Write("Done");
                }
            }
            catch (Exception exp)
            {
                Response.Write(exp.ToString());
            }
        }
    }
}