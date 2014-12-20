using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class AddSubcontractor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
             DataBase database = new DataBase();
            
            if (Page.Request.HttpMethod == "POST")
             {

                 if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "AddSubContractor")
                 {

                     string Name = Page.Request.Form["Name"],
                            Mobile = Page.Request.Form["Mobile"],
                            LandLine = Page.Request.Form["LandLine"],
                            Address = Page.Request.Form["Address"];

                     int pk_id = Convert.ToInt16(database.ReturnRow(@"if ((select COUNT(pk_id) from Tbl_Subcontractor) > 0)
select max(pk_id)+1 from Tbl_Subcontractor
else select COUNT(pk_id)+1 from Tbl_Subcontractor")[0]);

                     database.InsertData("INSERT INTO [Tbl_Subcontractor]([PK_ID],[Name],[Mobile],[LandLine],[Address])VALUES(" + pk_id + ",'" + Name + "','" + Mobile + "','" + LandLine + "','" + Address + "')");

                     //database.InsertData("INSERT INTO [Tbl_SubContractorWorks]([FK_WorkID],[FK_SubContractorID])VALUES(" + FK_WorkTypeID + "," + pk_id + ")");

                     string xmlData = "";
                     xmlData = "<Main> <PK>" + pk_id + "</PK></Main>";
                     Response.Write(xmlData);
                 }
                
             }
        }
    }
}