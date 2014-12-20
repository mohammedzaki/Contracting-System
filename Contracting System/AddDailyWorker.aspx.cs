using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class AddDailyWorker : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            if (Page.Request.HttpMethod == "POST")
            {
                DataBase database = new DataBase();
                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "AddDailyWorker")
                {

                    string Name = Page.Request.Form["Name"],
                           Mobile = Page.Request.Form["Mobile"],
                           WorkerID = Page.Request.Form["WorkerID"];

                    int pk_id =
                        Convert.ToInt16(database.ReturnRow(@"if ((select COUNT(pk_id) from Tbl_DailyWorker) > 0)
select max(pk_id)+1 from Tbl_DailyWorker
else select COUNT(pk_id)+1 from Tbl_DailyWorker")[0]);

                    database.InsertData(
                        "INSERT INTO [Tbl_DailyWorker]([PK_ID],[Name],[Mobile],[WorkerID])VALUES(" + pk_id + ",'" + Name +
                        "','" + Mobile + "', '" + WorkerID + "')");

                    string xmlData = "";
                    xmlData = "<Main> <PK>" + pk_id + "</PK></Main>";
                    Response.Write(xmlData);
                }
            }
        }
    }
}