using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using N_Tier_Classes.DataAccessLayer;
using System.Data;

namespace Contracting_System
{
    public partial class LogIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.Request.HttpMethod == "POST")
            {
                DataBase database = new DataBase();
                DB_OperationProcess DB = new DB_OperationProcess();
                if (Page.Request.Form["action"] != null &&
                    Page.Request.Form["action"].ToString() == "LogIn")
                {
                    string UserID = Page.Request.Form["userID"].ToString(),
                           Password = Page.Request.Form["pasword"].ToString();

                    string xmlData = "";

                    xmlData = "<main>";
                    object empID = DB.ExecuteSqlStatmentQuery(
                        "select [PK_ID] from Tbl_Employees where [UserName] = '" + UserID + "' and [Password]= '" +
                        Password + "'", DB_OperationProcess.ResultReturnedDataType.Scalar);
                    object Name = DB.ExecuteSqlStatmentQuery(
                        "select [Name] from Tbl_Employees where [UserName] = '" + UserID + "' and [Password]= '" +
                        Password + "'", DB_OperationProcess.ResultReturnedDataType.Scalar);
                    if (empID != null)
                    {
                        Session["UserId"] = empID;
                        Session["UserName"] = Name;
                        Session["Tbl_Security"] = (DataTable)DB.ExecuteSqlStatmentQuery("select * from view_security where EmployeePK_ID = " + empID, DB_OperationProcess.ResultReturnedDataType.Table);
                        DataTable DT = (DataTable)Session["Tbl_Security"];
                        xmlData += "<Tbl_Employees>";
                        xmlData += "<ID>true</ID>";
                        xmlData += "</Tbl_Employees>";

                    }
                    else
                    {
                        xmlData += "<Tbl_Employees>";
                        xmlData += "<ID>false</ID>";
                        xmlData += "</Tbl_Employees>";
                    }
                    xmlData += "</main>";
                    Response.Write(xmlData);
                }
            }


        }
    }
}