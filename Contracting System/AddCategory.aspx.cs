using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class AddCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            DataBase database = new DataBase();
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "AddCategory")
                {
                    database.InsertData("INSERT INTO [Tbl_Category]([Name])VALUES('" + Page.Request.Form["name"] + "')");
                    string xmlData = "";

                    xmlData = "<Tbl_Category>";

                    DataTable dtWorks = database.ReturnTable("select * from Tbl_Category order by name");


                    foreach (DataRow currentRow in dtWorks.Rows)
                    {
                        xmlData += "<Category>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</Category>";
                    }


                    xmlData += "</Tbl_Category>";

                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadCategory")
                {

                    string xmlData = "";

                    xmlData = "<Tbl_Category>";

                    DataTable dtWorks = database.ReturnTable("select * from Tbl_Category order by name");


                    foreach (DataRow currentRow in dtWorks.Rows)
                    {
                        xmlData += "<Category>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</Category>";
                    }


                    xmlData += "</Tbl_Category>";

                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
            }
        }
    }
}