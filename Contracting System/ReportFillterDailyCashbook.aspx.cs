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
    public partial class ReportFillterDailyCashbook : System.Web.UI.Page
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
                                cbo_ExpensesCategories = Page.Request.Form["cbo_ExpensesCategories"],
                                cbo_ExpensesItems = Page.Request.Form["cbo_ExpensesItems"],
                                cbo_ExpensesWorkType = Page.Request.Form["cbo_ExpensesWorkType"],
                                txt_DateTo = Page.Request.Form["txt_DateTo"] == "" ? "" : DateTime.Parse(Page.Request.Form["txt_DateTo"]).ToSqlFormat(),
                                txt_DateFrom = Page.Request.Form["txt_DateFrom"] == "" ? "" : DateTime.Parse(Page.Request.Form["txt_DateFrom"]).ToSqlFormat();

                            string cbo_ProjectType = "1";
                            if (Page.Request.Form["cbo_ProjectType"] != null)
                                cbo_ProjectType = Page.Request.Form["cbo_ProjectType"];

                            string where = "";

                            where += (cbo_ProjectName == "" ? "" : " View_Guradianship.FK_ProjectID = " + cbo_ProjectName + " and ");
                            if (cbo_ExpensesCategories != "" && int.Parse(cbo_ExpensesCategories) < 0)
                            {
                                where += (cbo_ExpensesCategories == "" ? "" : " View_Guradianship.PersonTypeID = " + cbo_ExpensesCategories + " and ");

                                where += (cbo_ExpensesItems == "" ? "" : " View_Guradianship.PersonID = " + cbo_ExpensesItems + " and ");

                                where += (cbo_ExpensesWorkType == "" ? "" : " View_Guradianship.WorkTypeId = " + cbo_ExpensesWorkType + " and ");
                            }
                            else
                            {
                                where += (cbo_ExpensesCategories == "" ? "" : " View_Guradianship.FK_ExpenseCategory = " + cbo_ExpensesCategories + " and ");

                                where += (cbo_ExpensesItems == "" ? "" : " View_Guradianship.FK_ExpenseItemID = " + cbo_ExpensesItems + " and ");
                            }

                            where += (txt_DateTo == "" ? "" : " View_Guradianship.GuardianshipItemDate between '" + txt_DateTo + "' and '" + txt_DateFrom + "'" + " and ");

                            where += " View_Guradianship.IsActive = " + cbo_ProjectType + " and ";

                            where = where == "" ? "" : where.Remove(where.Length - 5, 4);
                            where = where == "" ? "" : " where " + where;

                            data = (DataSet)DB.ExecuteSqlStatmentQuery(@"select * from View_Guradianship " + where
                                , DB_OperationProcess.ResultReturnedDataType.DataSet);

                            xmlData = data.GetXml();
                            xmlData = xmlData.Replace("NewDataSet>", "main>");
                            xmlData = xmlData.Replace("Table>", "View_Guradianship>");
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