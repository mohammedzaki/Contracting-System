using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class AddSupplier : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            DataBase database = new DataBase();
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadCbo_Items")
                {

                    DataTable dtItems = database.ReturnTable("SELECT * from Tbl_Category order by name");

                    string xmlData = "";
                    xmlData = "<Tbl_Items>";

                    foreach (DataRow currentRow in dtItems.Rows)
                    {
                        xmlData += "<Item>";
                        xmlData += "<ID>" + currentRow[0] + "</ID>";
                        xmlData += "<ItemName>" + currentRow[1] + "</ItemName>";
                        xmlData += "</Item>";
                    }


                    xmlData += "</Tbl_Items>";

                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "SaveNewSupplier")
                {
                   
                    string SupplierName = Page.Request.Form["SupplierName"]
                       , SupplierMobile = Page.Request.Form["SupplierMobile"]
                       , SupplierTel = Page.Request.Form["SupplierTel"]
                       , SuuplierAddress = Page.Request.Form["SuuplierAddress"];
                    int pk_id =  Convert.ToInt16(database.ReturnRow(@"if ((select COUNT(pk_id) from Tbl_Supplier) > 0)
select max(pk_id)+1 from Tbl_Supplier
else select COUNT(pk_id)+1 from Tbl_Supplier")[0]);
                    
                    database.InsertData("INSERT INTO [Tbl_Supplier]([PK_ID],[Name],[Mobile],[LandLine],[Address])VALUES("+pk_id+",'" + SupplierName + "','" + SupplierMobile + "','" + SupplierTel + "','" + SuuplierAddress + "')");
                    
                    string xmlData = "";
                   xmlData = "<Main> <PK>"+pk_id+"</PK></Main>";


                    //Response.Write("<main><result>" + Page.Request.Form["unit"] + "</result></main>");
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "SelectFromCbo_Items")
                {
                    string FK_CategoryID = Page.Request.Form["FK_CategoryID"];
                    string FK_SupplierID = Page.Request.Form["FK_SupplierID"];

                    database.InsertData("INSERT INTO [Tbl_SupplierSupplies]([FK_CategoryID],[FK_SupplierID])VALUES(" + FK_CategoryID + "," + FK_SupplierID + ")");
                    DataTable DT = database.ReturnTable("SELECT     Tbl_Category.Name FROM         Tbl_Category INNER JOIN Tbl_SupplierSupplies ON Tbl_Category.PK_ID = Tbl_SupplierSupplies.FK_CategoryID where Tbl_SupplierSupplies.FK_SupplierID = " + FK_SupplierID);

                    string xmlData = "";
                    xmlData = "<Tbl_Category>";

                    foreach (DataRow currentRow in DT.Rows)
                    {
                        xmlData += "<Category>";
                        xmlData += "<Name>" + currentRow[0] + "</Name>";
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