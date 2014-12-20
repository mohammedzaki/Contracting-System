using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using N_Tier_Classes.ObjectLayer.ContractingSystem;
using N_Tier_Classes.DataAccessLayer;

namespace Contracting_System
{
    public partial class EditEmployee : System.Web.UI.Page
    {
        DB_OperationProcess DB = new DB_OperationProcess();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            string xmlData = "<main>";
            if (Page.Request.HttpMethod == "POST")
            {
                DataBase database = new DataBase();
                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "UpdateEmployee")
                {

                    string Name = Page.Request.Form["Name"],
                           Mobile = Page.Request.Form["Mobile"],
                           ID = Page.Request.Form["EmployeeID"],
                           JobName = Page.Request.Form["JobName"],
                           Salary = Page.Request.Form["Salary"],
                           id = Page.Request.Form["id"];

                    DB.Update(TablesNames.Tbl_Employees,
                        new object[] {
                              Tbl_Employees.Fields.Name, Name,
                              Tbl_Employees.Fields.Mobile, Mobile,
                              Tbl_Employees.Fields.ID, ID,
                              Tbl_Employees.Fields.JobName, JobName,
                              Tbl_Employees.Fields.Salary, decimal.Parse(Salary)
                        }, 
                        new object[] {
                              Tbl_Employees.Fields.PK_ID, int.Parse(id)
                        });
                    xmlData += "True</main>";
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "UpdateWorker")
                {

                    string Name = Page.Request.Form["Name"],
                           Mobile = Page.Request.Form["Mobile"],
                           ID = Page.Request.Form["WorkerID"],
                           id = Page.Request.Form["id"];

                    DB.Update(TablesNames.Tbl_DailyWorker,
                        new object[] {
                              Tbl_DailyWorker.Fields.Name, Name,
                              Tbl_DailyWorker.Fields.Mobile, Mobile,
                              Tbl_DailyWorker.Fields.WorkerID, ID
                        },
                        new object[] {
                              Tbl_DailyWorker.Fields.PK_ID, int.Parse(id)
                        });
                    xmlData += "True</main>";
                    Response.Write(xmlData);
                }
            }
        }
    }
}
