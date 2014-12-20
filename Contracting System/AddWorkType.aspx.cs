using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class AddWorkType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();

            DataBase database = new DataBase();
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "AddWorkType")
                {
                    string
                        FK_WorkCategory = Page.Request.Form["FK_WorkCategory"],
                        Name = Page.Request.Form["Name"];

                    database.InsertData("INSERT INTO [Tbl_WorkType]([Name],[FK_WorkCategory])VALUES('" + Name + "'," + FK_WorkCategory + ")");

                    DataTable dtItems = database.ReturnTable("SELECT     dbo.Tbl_WorkCategories.Name AS WorkCategory, dbo.Tbl_WorkType.Name AS WorkType FROM      dbo.Tbl_WorkCategories INNER JOIN dbo.Tbl_WorkType ON dbo.Tbl_WorkCategories.PK_ID = dbo.Tbl_WorkType.FK_WorkCategory");

                    string xmlData = "";
                    xmlData = "<Tbl_WorkType>";

                    foreach (DataRow currentRow in dtItems.Rows)
                    {
                        xmlData += "<WorkType>";
                        xmlData += "<WorkCategory>" + currentRow[0] + "</WorkCategory>";
                        xmlData += "<WorkTypeName>" + currentRow[1] + "</WorkTypeName>";
                        xmlData += "</WorkType>";
                    }


                    xmlData += "</Tbl_WorkType>";

                    
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadCbo_WorkCategory")
                {

                    string xmlData = "";

                    xmlData = "<Main>";
                    xmlData += "<Tbl_WorkCategories>";

                    DataTable dtWorks = database.ReturnTable("select * from Tbl_WorkCategories order by name");


                    foreach (DataRow currentRow in dtWorks.Rows)
                    {
                        xmlData += "<Category>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</Category>";
                    }


                    xmlData += "</Tbl_Category>";

                    DataTable dtItems = database.ReturnTable("SELECT     dbo.Tbl_WorkCategories.Name AS WorkCategory, dbo.Tbl_WorkType.Name AS WorkType FROM      dbo.Tbl_WorkCategories INNER JOIN dbo.Tbl_WorkType ON dbo.Tbl_WorkCategories.PK_ID = dbo.Tbl_WorkType.FK_WorkCategory");

                    xmlData += "<Tbl_WorkType>";

                    foreach (DataRow currentRow in dtItems.Rows)
                    {
                        xmlData += "<WorkType>";
                        xmlData += "<WorkCategory>" + currentRow[0] + "</WorkCategory>";
                        xmlData += "<WorkTypeName>" + currentRow[1] + "</WorkTypeName>";
                        xmlData += "</WorkType>";
                    }


                    xmlData += "</Tbl_WorkType>";
                    xmlData += "</Main>";
                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
            }
        }
    }
}