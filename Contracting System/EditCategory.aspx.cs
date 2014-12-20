﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using N_Tier_Classes.ObjectLayer.ContractingSystem;

namespace Contracting_System
{
    public partial class EditCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            DataBase database = new DataBase();
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadCbo_EditCategory")
                {
                    string xmlData = "";

                    xmlData = "<Tbl_Category>";

                    DataTable dtUnits = database.ReturnTable("select * from Tbl_Category order by name");


                    foreach (DataRow currentRow in dtUnits.Rows)
                    {
                        xmlData += "<Category>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</Category>";
                    }


                    xmlData += "</Tbl_Category>";

                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "UpdateCategory")
                {
                    string PK_ID = Page.Request.Form["PK_ID"],
                           Name = Page.Request.Form["Name"];
                    database.InsertData("UPDATE [dbo].[Tbl_Category] SET [Name] = '"+Name+"' WHERE PK_ID = "+PK_ID+"");

                }
            }
        }
    }
}