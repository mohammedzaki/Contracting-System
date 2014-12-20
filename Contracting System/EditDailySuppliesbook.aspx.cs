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
    public partial class EditDailySuppliesbook : System.Web.UI.Page
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
                                cbo_SupplierNames = Page.Request.Form["cbo_SupplierNames"],
                                cbo_SupplieisCategory = Page.Request.Form["cbo_SupplieisCategory"],
                                cbo_ItemType = Page.Request.Form["cbo_ItemType"],
                                txt_ReciptNo = Page.Request.Form["txt_ReciptNo"],
                                txt_DateTo = Page.Request.Form["txt_DateTo"] == "" ? "" : DateTime.Parse(Page.Request.Form["txt_DateTo"]).ToSqlFormat(),
                                txt_DateFrom = Page.Request.Form["txt_DateFrom"] == "" ? "" : DateTime.Parse(Page.Request.Form["txt_DateFrom"]).ToSqlFormat();
                                
                            string cbo_ProjectType = "1";
                            if (Page.Request.Form["cbo_ProjectType"] != null)
                                cbo_ProjectType = Page.Request.Form["cbo_ProjectType"];

                            string where = "";

                            where += (cbo_ProjectName == "" ? "" : " View_DailySuppliesbook.FK_ProjectID = " + cbo_ProjectName + " and ");

                            where += (cbo_SupplierNames == "" ? "" : " View_DailySuppliesbook.FK_SupplierID = " + cbo_SupplierNames + " and ");

                            where += (cbo_SupplieisCategory == "" ? "" : " View_DailySuppliesbook.CategoryID = " + cbo_SupplieisCategory + " and ");

                            where += (cbo_ItemType == "" ? "" : " View_DailySuppliesbook.ItemID = " + cbo_ItemType + " and ");

                            where += (txt_ReciptNo == "" ? "" : " View_DailySuppliesbook.ReceiptNO = " + txt_ReciptNo + " and ");

                            where += (txt_DateTo == "" ? "" : " View_DailySuppliesbook.SuppliesDate between '" + txt_DateTo + "' and '" + txt_DateFrom + "'" + " and ");

                            where += " View_DailySuppliesbook.IsActive = " + cbo_ProjectType + " and ";

                            where = where == "" ? "" : where.Remove(where.Length - 5, 4);
                            where = where == "" ? "" : " where " + where;

                            data = (DataSet)DB.ExecuteSqlStatmentQuery(@"select * from View_DailySuppliesbook " + where
                                , DB_OperationProcess.ResultReturnedDataType.DataSet);

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