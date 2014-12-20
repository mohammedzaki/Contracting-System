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
    public partial class SetRoles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            DataBase database = new DataBase();
            DB_OperationProcess DB = new DB_OperationProcess();
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null &&
                    Page.Request.Form["action"].ToString() == "LoadPages")
                {
                    string xmlData = "";

                    xmlData = "<Tbl_Pages>";

                    DataTable dtUnits = database.ReturnTable("select * from tbl_Pages order by ArabicName");


                    foreach (DataRow currentRow in dtUnits.Rows)
                    {
                        xmlData += "<Page>";
                        xmlData += "<Id>" + currentRow[0] + "</Id>";
                        xmlData += "<Name>" + currentRow[2] + "</Name>";
                        xmlData += "</Page>";
                    }


                    xmlData += "</Tbl_Pages>";

                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                         Page.Request.Form["action"].ToString() == "AddRole")
                {
                    string roleName = Page.Request.Form["RoleName"].ToString();
                    string xmlData = "";
                    long RoleId = DB.NewID(TablesNames.Tbl_Roles);
                    DB.Insert(TablesNames.Tbl_Roles,
                              Tbl_Roles.Fields.PK_ID, RoleId,
                              Tbl_Roles.Fields.Name, roleName);
                    xmlData = "<Role>";
                    xmlData += "<RoleID>";
                    xmlData += "<ID>" + RoleId + "</ID>";
                    xmlData += "</RoleID>";
                    xmlData += "</Role>";
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                         Page.Request.Form["action"].ToString() == "AddRoleByID")
                {
                    string xmlData = "";
                    try
                    {
                    Int16 RoleID = Convert.ToInt16(Page.Request.Form["RoleID"]);
                    Int16 PageID = Convert.ToInt16(Page.Request.Form["PageID"]);
                    int Access = Convert.ToInt16(Page.Request.Form["Access"]);
                    
                    
                    long RolePerId = DB.NewID(TablesNames.Tbl_RolePermissions);
                    DB.Insert(TablesNames.Tbl_RolePermissions,
                              Tbl_RolePermissions.Fields.PK_ID, RolePerId,
                              Tbl_RolePermissions.Fields.FK_PageID, PageID,
                              Tbl_RolePermissions.Fields.Access, Access,
                              Tbl_RolePermissions.Fields.FK_RoleID,RoleID);

                    xmlData = "<Role>";
                    xmlData += "<RoleID>";
                    xmlData += "<ID>تمت الاضافة بنجاح</ID>";
                    xmlData += "</RoleID>";
                    xmlData += "</Role>";
                    }
                    catch (Exception ex)
                    {
                        xmlData = "<Role>";
                        xmlData += "<RoleID>";
                        xmlData += "<ID>"+ex.Message+"</ID>";
                        xmlData += "</RoleID>";
                        xmlData += "</Role>";
                    }
                    Response.Write(xmlData);
                }
            }
        }
    }
}