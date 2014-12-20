using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using N_Tier_Classes.DataAccessLayer;
using N_Tier_Classes.ObjectLayer.ContractingSystem;

namespace Contracting_System
{
    public partial class EditUserAndPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            if (Page.Request.HttpMethod == "POST")
            {
                DataBase database = new DataBase();
                DB_OperationProcess DB = new DB_OperationProcess();
                if (Page.Request.Form["action"] != null &&
                    Page.Request.Form["action"].ToString() == "LoadEmps")
                {
                    string xmlData = "";

                    xmlData = "<main>";

                    DataTable dtUnits =
                        database.ReturnTable(
                            "select PK_ID,Name from Tbl_Employees");


                    foreach (DataRow currentRow in dtUnits.Rows)
                    {
                        xmlData += "<Tbl_Employees>";
                        xmlData += "<ID>" + currentRow[0] + "</ID>";
                        xmlData += "<Name>" + currentRow[1] + "</Name>";
                        xmlData += "</Tbl_Employees>";
                    }
                    xmlData += "</main>";

                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                   Page.Request.Form["action"].ToString() == "SaveUserAndPassword")
                {
                    string user = Page.Request.Form["UserName"].ToString(),
                           password = Page.Request.Form["Password"].ToString();
                    int EmpID = Convert.ToInt16(Page.Request.Form["EmpID"]);
                    DB.Update(TablesNames.Tbl_Employees, new object[]
                                                             {
                                                                 Tbl_Employees.Fields.UserName,user,
                                                                 Tbl_Employees.Fields.Password,password
                                                             }, new object[]
                                                                    {
                                                                        Tbl_Employees.Fields.PK_ID, EmpID
                                                                    });
                }
            }
        }
    }
}