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
    public partial class AddEmployee : System.Web.UI.Page
    {
        DB_OperationProcess DB = new DB_OperationProcess();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            string xmlData = "<main>";
            if (Page.Request.HttpMethod == "POST")
            {
                DataBase database = new DataBase();
                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "AddEmployee")
                {

                    string Name = Page.Request.Form["Name"],
                           Mobile = Page.Request.Form["Mobile"],
                           ID = Page.Request.Form["EmployeeID"],
                           JobName = Page.Request.Form["JobName"],
                           Salary = Page.Request.Form["Salary"];

                    int id = (int)DB.NewID(TablesNames.Tbl_Employees);

                    DB.Insert(TablesNames.Tbl_Employees,
                              Tbl_Employees.Fields.PK_ID, id,
                              Tbl_Employees.Fields.Name, Name,
                              Tbl_Employees.Fields.Mobile, Mobile,
                              Tbl_Employees.Fields.ID, ID,
                              Tbl_Employees.Fields.JobName, JobName,
                              Tbl_Employees.Fields.Salary, decimal.Parse(Salary)
                        );
                    xmlData += "True</main>";
                    Response.Write(xmlData);
                }
            }
        }
    }
}
