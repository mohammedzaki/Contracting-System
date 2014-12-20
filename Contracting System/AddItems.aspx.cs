using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Contracting_System
{
    public partial class AddItems : System.Web.UI.Page
    {
        DataBase database = new DataBase();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "AddItem")
                {
                    string
                        FK_CategoryID = Page.Request.Form["FK_CategoryID"],
                        ItemType = Page.Request.Form["ItemType"],
                        FK_MeasurementUnitID = Page.Request.Form["FK_MeasurementUnitID"];

                    database.InsertData( "INSERT INTO [Tbl_Items]([FK_CategoryID],[ItemType],[FK_MeasurementUnitID])VALUES(" +FK_CategoryID + ",'" + ItemType + "'," + FK_MeasurementUnitID + ")");

                    DataTable dtItems = database.ReturnTable("SELECT     Tbl_Category.Name, Tbl_Items.ItemType, Tbl_MeasurementUnit.Unit FROM         Tbl_Items INNER JOIN Tbl_MeasurementUnit ON Tbl_Items.FK_MeasurementUnitID = Tbl_MeasurementUnit.PK_ID INNER JOIN Tbl_Category ON Tbl_Items.FK_CategoryID = Tbl_Category.PK_ID");
                     
                    string xmlData = "";
                    xmlData = "<Tbl_Items>";

                    foreach (DataRow currentRow in dtItems.Rows)
                    {
                        xmlData += "<Item>";
                        xmlData += "<Category>" + currentRow[0] + "</Category>";
                        xmlData += "<ItemType>" + currentRow[1] + "</ItemType>";
                        xmlData += "<Unit>" + currentRow[2] + "</Unit>";
                        xmlData += "</Item>";
                    }


                    xmlData += "</Tbl_Items>";

                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadCbo_MeasurementUnit")
                {
                    string xmlData = "";

                    xmlData = "<Tbl_MeasurementUnit>";

                    DataTable dtUnits = database.ReturnTable("select * from Tbl_MeasurementUnit order by Unit");


                    foreach (DataRow currentRow in dtUnits.Rows)
                    {
                        xmlData += "<unit>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</unit>";
                    }


                    xmlData += "</Tbl_MeasurementUnit>";

                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadCbo_Category")
                {

                    string xmlData = "";
                    xmlData = "<Main>";
                    xmlData += "<Tbl_Category>";

                    DataTable dtWorks = database.ReturnTable("select * from Tbl_Category order by name");


                    foreach (DataRow currentRow in dtWorks.Rows)
                    {
                        xmlData += "<Category>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</Category>";
                    }


                    xmlData += "</Tbl_Category>";
                    DataTable dtItems = database.ReturnTable("SELECT     Tbl_Category.Name, Tbl_Items.ItemType, Tbl_MeasurementUnit.Unit FROM         Tbl_Items INNER JOIN Tbl_MeasurementUnit ON Tbl_Items.FK_MeasurementUnitID = Tbl_MeasurementUnit.PK_ID INNER JOIN Tbl_Category ON Tbl_Items.FK_CategoryID = Tbl_Category.PK_ID");

                    xmlData += "<Tbl_Items>";

                    foreach (DataRow currentRow in dtItems.Rows)
                    {
                        xmlData += "<Item>";
                        xmlData += "<Category>" + currentRow[0] + "</Category>";
                        xmlData += "<ItemType>" + currentRow[1] + "</ItemType>";
                        xmlData += "<Unit>" + currentRow[2] + "</Unit>";
                        xmlData += "</Item>";
                    }


                    xmlData += "</Tbl_Items>";
                    xmlData += "</Main>";
                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
            }
        }
    }
}