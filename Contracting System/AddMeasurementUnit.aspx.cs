using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class AddMeasurementUnit : System.Web.UI.Page
    {
        DataBase database = new DataBase();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "SaveMeasurementUnit")
                {
                    database.InsertData("INSERT INTO [Tbl_MeasurementUnit](Unit)VALUES('"+Page.Request.Form["unit"]+"')");
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
                    
                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadLst_Units")
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
                
            }
        }
    }
}