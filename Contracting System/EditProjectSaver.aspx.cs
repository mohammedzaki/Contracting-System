using N_Tier_Classes.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class EditProjectSaver : System.Web.UI.Page
    {
        private DB_OperationProcess DB = new DB_OperationProcess();
        DataSet data = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            if (Page.Request.HttpMethod == "POST")
            {
                string xmlData = "<main>";
                try
                {
                    if (Page.Request.Form["action"] != null)
                    {
                        if (Page.Request.Form["action"].ToString() == "LoadSearch")
                        {
                            string
                                cbo_ProjectName = Page.Request.Form["cbo_ProjectName"],
                                cbo_SaverItem = Page.Request.Form["cbo_SaverItem"],
                                txt_DateTo = Page.Request.Form["txt_DateTo"] == "" ? "" : DateTime.Parse(Page.Request.Form["txt_DateTo"]).ToSqlFormat(),
                                txt_DateFrom = Page.Request.Form["txt_DateFrom"] == "" ? "" : DateTime.Parse(Page.Request.Form["txt_DateFrom"]).ToSqlFormat();

                            data = (DataSet)DB.ExecuteSqlStatmentQuery(@"select * from View_ProjectDeposits where View_ProjectDeposits.FK_ProjectID = '" + cbo_ProjectName + "' or (View_ProjectDeposits.Date between '" + txt_DateTo + "' and '" + txt_DateFrom + "' and View_ProjectDeposits.FK_SaverItemID = '" + cbo_SaverItem + "' and View_ProjectDeposits.FK_ProjectID = '" + cbo_ProjectName + "') or (View_ProjectDeposits.Date between '" + txt_DateTo + "' and '" + txt_DateFrom + "' and View_ProjectDeposits.FK_ProjectID = '" + cbo_ProjectName + "') or (View_ProjectDeposits.FK_SaverItemID = '" + cbo_SaverItem + "' and View_ProjectDeposits.FK_ProjectID = '" + cbo_ProjectName + "')", DB_OperationProcess.ResultReturnedDataType.DataSet);

                            xmlData = data.GetXml();
                            xmlData = xmlData.Replace("NewDataSet>", "main>");
                            xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                            Response.Write(xmlData);
                        }
                    }
                }
                catch (Exception exp)
                {
                    xmlData = "<main>";
                    xmlData += "<Exception>Internal Server Error : \r\n";
                    xmlData += exp.Message.ToString();
                    xmlData += "</Exception>";
                    xmlData += "</main>";
                    Response.Write(xmlData);
                }
            }
        }
    }
}