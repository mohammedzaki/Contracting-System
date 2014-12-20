using N_Tier_Classes.ObjectLayer.ContractingSystem;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            string txt = "";
            if (Request.Files.Count > 0)
                txt = Request.Files[0].FileName;
            */
            StordedProcedures sp = new StordedProcedures();
            DataSet dataset = new DataSet();
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("ID");
            var dr = dataTable.NewRow();
            dr["ID"] = 1;
            dataTable.Rows.Add(dr);
            string str = new DataTable().GetType().ToString();
            DataSet ds = sp.SelectTestTableVariable(dataTable);
            Response.Write(ds.GetXml());
        }
    }
}