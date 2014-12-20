using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using N_Tier_Classes.ObjectLayer.ContractingSystem;
using N_Tier_Classes.DataAccessLayer;

namespace Contracting_System
{
    public partial class DailySuppliesbook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
        }
    }
}