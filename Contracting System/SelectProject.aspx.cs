using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class SelectProject : System.Web.UI.Page
    {
        DataBase database = new DataBase();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadCbo_SelectProject")
                {
                    string xmlData = "";

                    xmlData = "<Tbl_CurrentProjects>";

                    DataTable dtUnits = database.ReturnTable("select Tbl_Project.PK_ID,Tbl_Project.Name from Tbl_Project where IsActive = 1");


                    foreach (DataRow currentRow in dtUnits.Rows)
                    {
                        xmlData += "<Project>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</Project>";
                    }


                    xmlData += "</Tbl_CurrentProjects>";

                    Response.Write(xmlData);

                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "SetPK_ID")
                {

                    Session["ProjectId"] = Page.Request.Form["PK_ID"];
                    
                }

            }
        }
    }
}