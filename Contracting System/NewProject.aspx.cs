using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Microsoft.Office.Interop.Excel;
using N_Tier_Classes.DataAccessLayer;
using N_Tier_Classes.ObjectLayer.ContractingSystem;
using DataTable = System.Data.DataTable;


namespace Contracting_System
{
    public partial class NewProject : System.Web.UI.Page
    {
        //public int StateId;
        //DataSet ds = new DataSet();
        //Thread th2;
        //DataSet myDs = new DataSet();
        //string fu = "";
        //int result;


        //Microsoft.Office.Interop.Excel.Application oXL = new Microsoft.Office.Interop.Excel.Application();

        //Microsoft.Office.Interop.Excel.Workbook oWB;
        //Microsoft.Office.Interop.Excel.Worksheet oSheet;

        private DB_OperationProcess DB = new DB_OperationProcess();


        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
            if (Page.Request.HttpMethod == "POST")
            {

                if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadPage")
                {
                    string xmlData = "";

                    //xmlData = "<Tbl_Subcontractor>";

                    //DataSet dtsubContractors = database.ReturnTable("select * from view_subcontractorWork order by SubContractorName");
                    DataSet dtsubContractors = null;
                    if (Convert.ToInt64(Session["ProjectId"]) > 0)
                    {
                        
                        dtsubContractors =
                        (DataSet)
                        DB.ExecuteSqlStatmentQuery(
                            @" select * from Tbl_Category  select * from Tbl_Items  select * from Tbl_DailyWorker select * from Tbl_Employees  select * from Tbl_Subcontractor order by name  select * from Tbl_WorkType   select * from Tbl_WorkCategories    SELECT [PK_ID],[Name],[Quantity],[EquationItemPK_ID]FROM [dbo].[View_AddedStimation] where [FK_ProjectID] = " + Session["ProjectId"].ToString() + " And [HasEquationItems] = 0   SELECT Tbl_EstimationItemEquations.EquationName FROM Tbl_ProjectEstimation INNER JOIN Tbl_EstimationItems ON Tbl_ProjectEstimation.FK_EstimationItemsID = Tbl_EstimationItems.PK_ID INNER JOIN Tbl_EstimationItemEquations ON Tbl_EstimationItems.PK_ID = Tbl_EstimationItemEquations.FK_EstimationItemID where Tbl_ProjectEstimation.FK_ProjectID = " + Session["ProjectId"].ToString(),
                            DB_OperationProcess.ResultReturnedDataType.DataSet);
                    }
                    else
                    {
                        dtsubContractors =
                         (DataSet)
                         DB.ExecuteSqlStatmentQuery(
                             @" select * from Tbl_Category  select * from Tbl_Items  select * from Tbl_DailyWorker select * from Tbl_Employees  select * from Tbl_Subcontractor order by name  select * from Tbl_WorkType   select * from Tbl_WorkCategories    SELECT [PK_ID],[Name],[Quantity],[EquationItemPK_ID]FROM [dbo].[View_AddedStimation] where [FK_ProjectID] = 0",
                             DB_OperationProcess.ResultReturnedDataType.DataSet);
                    }


                    //foreach (DataRow currentRow in dtsubContractors.Rows)
                    //{
                    //    xmlData += "<Subcontractor>";
                    //    xmlData += "<Id id22="currentRow[0]" >" + currentRow[0] + "</Id>";
                    //    xmlData += "<Name>" + currentRow[1] + "</Name>";
                    //    xmlData += "<FK_WorkTypeID>" + currentRow[5] + "</FK_WorkTypeID>";
                    //    xmlData += "</Subcontractor>";
                    //}


                    //xmlData += "</Tbl_Subcontractor>";

                    xmlData = dtsubContractors.GetXml();
                    xmlData = xmlData.Replace("NewDataSet>", "main>");
                    xmlData = xmlData.Replace("Table>", "Tbl_Category>");
                    xmlData = xmlData.Replace("Table1>", "Tbl_Items>");
                    xmlData = xmlData.Replace("Table2>", "Tbl_DailyWorker>");
                    xmlData = xmlData.Replace("Table3>", "Tbl_Employees>");
                    xmlData = xmlData.Replace("Table4>", "Tbl_Subcontractor>");
                    xmlData = xmlData.Replace("Table5>", "Tbl_WorkType>");
                    xmlData = xmlData.Replace("Table6>", "Tbl_WorkCategories>");
                    xmlData = xmlData.Replace("Table7>", "View_AddedStimation>");
                    xmlData = xmlData.Replace("Table8>", "Tbl_EquationName>");
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                         Page.Request.Form["action"].ToString() == "SaveProjectData")
                {
                    string xmlData = "<main>";
                    try
                    {
                        string txt_ProjectName = Page.Request.Form["txt_ProjectName"],
                               txt_SupervisingAuthority = Page.Request.Form["txt_SupervisingAuthority"],
                               txt_ProjectPeriod = Page.Request.Form["txt_ProjectPeriod"],
                               txt_ProjectStartDate = Page.Request.Form["txt_ProjectStartDate"],
                               txt_ReceptionLocationDate = Page.Request.Form["txt_ReceptionLocationDate"],
                               txt_ProjectEndDate = Page.Request.Form["txt_ProjectEndDate"],
                               txt_ProjectCost = Page.Request.Form["txt_ProjectCost"],
                               txt_ProjectStartTechnicalDate = Page.Request.Form["txt_ProjectStartTechnicalDate"];

                        int id = (int)DB.NewID(TablesNames.Tbl_Project);

                        DB.Insert(TablesNames.Tbl_Project,
                                  Tbl_Project.Fields.PK_ID, id,
                                  Tbl_Project.Fields.Name, txt_ProjectName,
                                  Tbl_Project.Fields.Supervisor, txt_SupervisingAuthority,
                                  Tbl_Project.Fields.ProjectPeriodPerMonth, int.Parse(txt_ProjectPeriod),
                                  Tbl_Project.Fields.StartDate, DateTime.Parse(txt_ProjectStartDate),
                                  Tbl_Project.Fields.DateOfReceiptOfTheSite,
                                  DateTime.Parse(txt_ReceptionLocationDate),
                                  Tbl_Project.Fields.EndDate, DateTime.Parse(txt_ProjectEndDate),
                                  Tbl_Project.Fields.TechnicalOpenDate, DateTime.Parse(txt_ProjectStartTechnicalDate),
                                  Tbl_Project.Fields.ProjectCost, decimal.Parse(txt_ProjectCost)
                            );
                        Session.Add("ProjectId", id);
                        Session.Timeout = 40;
                        xmlData += "True</main>";
                        Response.Write(xmlData);
                    }
                    catch (Exception exp)
                    {
                        xmlData = "<main>";
                        xmlData += "<Exception>Internal Server Error : \r\n";
                        xmlData += exp.Message.ToString();
                        xmlData += "</Exception>";
                    }
                    xmlData += "</main>";

                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                         Page.Request.Form["action"].ToString() == "SaveNewSubContractor")
                {
                    string xmlData = "<main>";
                    try
                    {
                        int id = int.Parse(Session["ProjectId"].ToString());
                        int WorkID = int.Parse(Page.Request.Form["WorkID"]);
                        int SubContractorID = int.Parse(Page.Request.Form["txt_SubContractorCode"]);

                        DB.Insert(TablesNames.Tbl_SubContractorWorks,
                                  Tbl_SubContractorWorks.Fields.FK_SubContractorID, SubContractorID,
                                  Tbl_SubContractorWorks.Fields.FK_WorkID, WorkID
                            );
                        int FK_SubContractorWorkID = (int)DB.GetMaxID(TablesNames.Tbl_SubContractorWorks);
                        DB.Insert(TablesNames.Tbl_ProjectSubContractor,
                                  Tbl_ProjectSubContractor.Fields.PK_ID, (int)DB.NewID(TablesNames.Tbl_ProjectSubContractor),
                                  Tbl_ProjectSubContractor.Fields.FK_ProjectID, id,
                                  Tbl_ProjectSubContractor.Fields.FK_SubContractorWorkID, FK_SubContractorWorkID
                            );
                        xmlData += "True</main>";
                        Response.Write(xmlData);
                    }
                    catch (Exception exp)
                    {
                        xmlData = "<main>";
                        xmlData += "<Exception>Internal Server Error : \r\n";
                        xmlData += exp.Message.ToString();
                        xmlData += "</Exception>";
                    }
                    xmlData += "</main>";

                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                         Page.Request.Form["action"].ToString() == "SaveProjectSupply")
                {
                    string xmlData = "<main>";
                    try
                    {
                        string txt_ProjectSuppliesQTY = Page.Request.Form["txt_ProjectSuppliesQTY"],
                               cbo_ProjectSuppliesItems = Page.Request.Form["cbo_ProjectSuppliesItems"],
                               cbo_ProjectSupplies = Page.Request.Form["cbo_ProjectSupplies"];

                        int id = int.Parse(Session["ProjectId"].ToString());

                        DB.Insert(TablesNames.Tbl_ProjectSupplies,
                                  Tbl_ProjectSupplies.Fields.PK_ID, (int)DB.NewID(TablesNames.Tbl_ProjectSupplies),
                            //Tbl_ProjectSupplies.Fields.ProjectID, id,
                                  Tbl_ProjectSupplies.Fields.FK_ItemsID, int.Parse(cbo_ProjectSuppliesItems),
                                  Tbl_ProjectSupplies.Fields.QTY, int.Parse(txt_ProjectSuppliesQTY)
                            //Tbl_ProjectSupplies.Fields.Rest, int.Parse(txt_ProjectSuppliesQTY),
                            //Tbl_ProjectSupplies.Fields.WasSupplied, 0
                            );
                        xmlData += "True</main>";
                        Response.Write(xmlData);
                    }
                    catch (Exception exp)
                    {
                        xmlData = "<main>";
                        xmlData += "<Exception>Internal Server Error : \r\n";
                        xmlData += exp.Message.ToString();
                        xmlData += "</Exception>";
                    }
                    xmlData += "</main>";

                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                         Page.Request.Form["action"].ToString() == "SaveDailyWorker")
                {
                    string xmlData = "<main>";
                    try
                    {
                        string DailyWorkerID = Page.Request.Form["DailyWorkerID"],
                               DailyWorkStartDate = Page.Request.Form["DailyWorkStartDate"],
                               txt_DailyWorkerWageDay = Page.Request.Form["txt_DailyWorkerWageDay"];

                        int id = int.Parse(Session["ProjectId"].ToString());

                        DB.Insert(TablesNames.Tbl_ProjectDailyWorker,
                                  Tbl_ProjectDailyWorker.Fields.PK_ID,
                                  (int)DB.NewID(TablesNames.Tbl_ProjectDailyWorker),
                                  Tbl_ProjectDailyWorker.Fields.FK_Project_ID, id,
                                  Tbl_ProjectDailyWorker.Fields.FK_DailyWorker_ID, int.Parse(DailyWorkerID)
                            );
                        xmlData += "True</main>";
                        Response.Write(xmlData);
                    }
                    catch (Exception exp)
                    {
                        xmlData = "<main>";
                        xmlData += "<Exception>Internal Server Error : \r\n";
                        xmlData += exp.Message.ToString();
                        xmlData += "</Exception>";
                    }
                    xmlData += "</main>";

                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                         Page.Request.Form["action"].ToString() == "SaveEmployee")
                {
                    string xmlData = "<main>";
                    try
                    {
                        string txt_EmployeeCode = Page.Request.Form["txt_EmployeeCode"];

                        int id = int.Parse(Session["ProjectId"].ToString());

                        DB.Insert(TablesNames.Tbl_ProjectEmployees,
                                  Tbl_ProjectEmployees.Fields.PK_ID, (int)DB.NewID(TablesNames.Tbl_ProjectEmployees),
                                  Tbl_ProjectEmployees.Fields.FK_ProjectID, id,
                                  Tbl_ProjectEmployees.Fields.FK_EmployeeID, int.Parse(txt_EmployeeCode)
                            );
                        xmlData += "True</main>";
                        Response.Write(xmlData);
                    }
                    catch (Exception exp)
                    {
                        xmlData = "<main>";
                        xmlData += "<Exception>Internal Server Error : \r\n";
                        xmlData += exp.Message.ToString();
                        xmlData += "</Exception>";
                    }
                    xmlData += "</main>";

                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                        Page.Request.Form["action"].ToString() == "AddEquation")
                {
                    string xmlData = "<main>";
                    string FK_EstimationItemEquationID = Page.Request.Form["FK_EstimationItemEquationID"],
                           FK_ItemID = Page.Request.Form["FK_ItemID"],
                           ItemBY = Page.Request.Form["ItemBY"],
                           ItemDevid = Page.Request.Form["ItemDevid"];
                    try
                    {
                        DB.Insert(TablesNames.Tbl_EquationItems,
                            Tbl_EquationItems.Fields.FK_EstimationItemEquationID, Convert.ToInt32(FK_EstimationItemEquationID),
                            Tbl_EquationItems.Fields.FK_ItemID, Convert.ToInt32(FK_ItemID),
                            Tbl_EquationItems.Fields.ItemBY, Convert.ToDouble(ItemBY),
                            Tbl_EquationItems.Fields.ItemDevid, Convert.ToDouble(ItemDevid)
                            );
                       
                       DataTable ddt = (DataTable)DB.ExecuteSqlStatmentQuery("SELECT Tbl_EstimationItemEquations.EquationName FROM Tbl_ProjectEstimation INNER JOIN Tbl_EstimationItems ON Tbl_ProjectEstimation.FK_EstimationItemsID = Tbl_EstimationItems.PK_ID INNER JOIN Tbl_EstimationItemEquations ON Tbl_EstimationItems.PK_ID = Tbl_EstimationItemEquations.FK_EstimationItemID where Tbl_ProjectEstimation.FK_ProjectID = " + Session["ProjectId"].ToString(), DB_OperationProcess.ResultReturnedDataType.Table);
                        xmlData = "<main>";
                        xmlData += "<row>";
                        foreach (DataRow item in ddt.Rows)
                        {
                            
                            xmlData += "<rowItem>";
                            xmlData += item[0].ToString();
                            xmlData += "</rowItem>";
                            
                        }
                        xmlData += "</row>";
                        xmlData += "<Messeage>";
                        xmlData += "تمت اضافة المعادلة بنجاح";
                        xmlData += "</Messeage>";
                        
                    }
                    catch (Exception exp)
                    {
                        xmlData = "<main>";
                        xmlData += "<Messeage>Internal Server Error : \r\n";
                        xmlData += exp.Message.ToString();
                        xmlData += "</Messeage>";
                    }
                    xmlData += "</main>";
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                       Page.Request.Form["action"].ToString() == "FinishEstimation")
                {
                    DataSet dtsubContractors = null;
                    string xmlData = "";
                    string PK_ID_EstimationItemEquation = Page.Request.Form["PK_ID_EstimationItemEquation"];
                    //غلق المعادلة
                    DB.ExecuteSqlStatmentQuery(@"UPDATE [dbo].[Tbl_EstimationItemEquations]
   SET [HasEquationItems] = 1 WHERE PK_ID = " + PK_ID_EstimationItemEquation, DB_OperationProcess.ResultReturnedDataType.NumberOfRowsAffected);

                    //تطبيق المعادلة
                    #region تطبيق المعادلات

                    DataTable HasEstimation = (DataTable)DB.ExecuteSqlStatmentQuery(@"SELECT        Tbl_EstimationItemEquations.PK_ID, Tbl_EstimationItemEquations.FK_EstimationItemID,  Tbl_ProjectEstimation.PK_ID as ProjectEstimationID
FROM            Tbl_ProjectEstimation INNER JOIN
                         Tbl_EstimationItems ON Tbl_ProjectEstimation.FK_EstimationItemsID = Tbl_EstimationItems.PK_ID INNER JOIN
                         Tbl_EstimationItemEquations ON Tbl_EstimationItems.PK_ID = Tbl_EstimationItemEquations.FK_EstimationItemID
where Tbl_ProjectEstimation.FK_ProjectID = " + Convert.ToInt32(Session["ProjectId"]) + " and Tbl_EstimationItemEquations.HasEquationItems = 1 and Tbl_EstimationItemEquations.PK_ID = " + PK_ID_EstimationItemEquation, DB_OperationProcess.ResultReturnedDataType.Table);
                    if (HasEstimation.Rows.Count > 0)
                    {
                        foreach (DataRow EstimationItemRow in HasEstimation.Rows)
                        {
                            DataTable EstimationItems = (DataTable)DB.ExecuteSqlStatmentQuery("select * from Tbl_EquationItems where FK_EstimationItemEquationID = " + EstimationItemRow[0].ToString(), DB_OperationProcess.ResultReturnedDataType.Table);
                            foreach (DataRow EquationRow in EstimationItems.Rows)
                            {
                                double ItemQTY = (Convert.ToDouble(EquationRow[3]) *
                                                  Convert.ToDouble(
                                                      (object)
                                                      DB.ExecuteSqlStatmentQuery(
                                                          "select Quantity from Tbl_ProjectEstimation where FK_EstimationItemsID =" + EstimationItemRow[1].ToString() + " And FK_ProjectID = " + Convert.ToInt32(Session["ProjectId"]).ToString(),
                                                          DB_OperationProcess.ResultReturnedDataType.Scalar))) /
                                                 Convert.ToDouble(EquationRow[4]);
                                DB.Insert(TablesNames.Tbl_ProjectSupplies,
                                          Tbl_ProjectSupplies.Fields.PK_ID, DB.NewID(TablesNames.Tbl_ProjectSupplies),
                                          Tbl_ProjectSupplies.Fields.FK_ItemsID, Convert.ToInt32(EquationRow[2]),
                                          Tbl_ProjectSupplies.Fields.FK_ProjectID, Convert.ToInt32(Session["ProjectId"]),
                                          Tbl_ProjectSupplies.Fields.FK_ProjectEstimationItemID, EstimationItemRow["ProjectEstimationID"],
                                          Tbl_ProjectSupplies.Fields.QTY, ItemQTY,
                                          Tbl_ProjectSupplies.Fields.Rest, ItemQTY
                                    );

                            }
                        }
                    }

                    #endregion

                    //اعادة تحميل الصفحة
                    dtsubContractors =
                    (DataSet)
                    DB.ExecuteSqlStatmentQuery(
                        @" select * from Tbl_Category  select * from Tbl_Items  select * from Tbl_DailyWorker select * from Tbl_Employees  select * from Tbl_Subcontractor order by name  select * from Tbl_WorkType   select * from Tbl_WorkCategories    SELECT [PK_ID],[Name],[Quantity],[EquationItemPK_ID]FROM [dbo].[View_AddedStimation] where [FK_ProjectID] = " + Session["ProjectId"].ToString() + " And [HasEquationItems] = 0",
                        DB_OperationProcess.ResultReturnedDataType.DataSet);


                    xmlData = dtsubContractors.GetXml();
                    xmlData = xmlData.Replace("NewDataSet>", "main>");
                    xmlData = xmlData.Replace("Table>", "Tbl_Category>");
                    xmlData = xmlData.Replace("Table1>", "Tbl_Items>");
                    xmlData = xmlData.Replace("Table2>", "Tbl_DailyWorker>");
                    xmlData = xmlData.Replace("Table3>", "Tbl_Employees>");
                    xmlData = xmlData.Replace("Table4>", "Tbl_Subcontractor>");
                    xmlData = xmlData.Replace("Table5>", "Tbl_WorkType>");
                    xmlData = xmlData.Replace("Table6>", "Tbl_WorkCategories>");
                    xmlData = xmlData.Replace("Table7>", "View_AddedStimation>");
                    Response.Write(xmlData);
                }
                else if (Page.Request.Form["action"] != null &&
                        Page.Request.Form["action"].ToString() == "RefreshAppliedEstemation")
                {
                    DataSet dtsubContractors = null;
                    string xmlData = "";
                    dtsubContractors =
                       (DataSet)
                       DB.ExecuteSqlStatmentQuery(
                           @"SELECT Tbl_Category.Name, Tbl_Items.ItemType, sum(Tbl_ProjectSupplies.QTY) as 'QTY'
FROM            Tbl_ProjectSupplies INNER JOIN
                         Tbl_Items ON Tbl_ProjectSupplies.FK_ItemsID = Tbl_Items.PK_ID INNER JOIN
                         Tbl_Category ON Tbl_Items.FK_CategoryID = Tbl_Category.PK_ID
						 where Tbl_ProjectSupplies.FK_ProjectID = " + Session["ProjectId"].ToString() + " group by Tbl_Items.ItemType ,Tbl_Category.Name",
                           DB_OperationProcess.ResultReturnedDataType.DataSet);


                    xmlData = dtsubContractors.GetXml();
                    xmlData = xmlData.Replace("NewDataSet>", "main>");
                    xmlData = xmlData.Replace("Table>", "Tbl_ProjectSupplies>");
                    Response.Write(xmlData);
                }
            }
        }

    }
}
