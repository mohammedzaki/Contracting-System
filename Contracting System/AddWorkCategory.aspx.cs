using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class AddWorkCategory : System.Web.UI.Page
    {
        DataBase database = new DataBase();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "AddWorkTypee")
                {
                    database.InsertData("INSERT INTO [Tbl_WorkCategories]([Name])VALUES('" + Page.Request.Form["name"] + "')");
                    string xmlData = "";

                    xmlData = "<Tbl_WorkType>";

                    DataTable dtWorks = database.ReturnTable("select * from Tbl_WorkCategories order by name");


                    foreach (DataRow currentRow in dtWorks.Rows)
                    {
                        xmlData += "<WorkType>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</WorkType>";
                    }


                    xmlData += "</Tbl_WorkType>";

                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadWorkType")
                {
                    
                    string xmlData = "";

                    xmlData = "<Tbl_WorkType>";

                    DataTable dtWorks = database.ReturnTable("select * from Tbl_WorkCategories order by name");


                    foreach (DataRow currentRow in dtWorks.Rows)
                    {
                        xmlData += "<WorkType>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</WorkType>";
                    }


                    xmlData += "</Tbl_WorkType>";

                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
            }
        }
    }
}