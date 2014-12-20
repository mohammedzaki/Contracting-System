using N_Tier_Classes.DataAccessLayer;
using N_Tier_Classes.ObjectLayer.ContractingSystem;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class EditSupplier : System.Web.UI.Page
    {
        DB_OperationProcess DB = new DB_OperationProcess();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            if (Page.Request.HttpMethod == "POST")
            {
                DataBase database = new DataBase();
                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "UpdateSupplier")
                {

                    string
                        Id = Page.Request.Form["Id"],
                        Name = Page.Request.Form["Name"],
                        Mobile = Page.Request.Form["Mobile"],
                        LandLine = Page.Request.Form["LandLine"],
                        Address = Page.Request.Form["Address"];

                    DB.Update(TablesNames.Tbl_Supplier,
                        new object[] {
                            Tbl_Supplier.Fields.Name, Name,
                            Tbl_Supplier.Fields.Mobile, Mobile,
                            Tbl_Supplier.Fields.LandLine, LandLine,
                            Tbl_Supplier.Fields.Address, Address
                        },
                        new object[] { 
                            Tbl_Supplier.Fields.PK_ID, int.Parse(Id)
                        });

                    string xmlData = "";
                    Response.Write(xmlData);
                }
            }
        }
    }
}