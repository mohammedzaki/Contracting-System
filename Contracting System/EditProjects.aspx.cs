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
    public partial class EditProjects : System.Web.UI.Page
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
                            @"select * from Tbl_Category  select * from Tbl_Items  select * from Tbl_DailyWorker select * from Tbl_Employees  select * from Tbl_Subcontractor order by name  select * from Tbl_WorkType   select * from Tbl_WorkCategories    SELECT [PK_ID],[Name],[Quantity],[EquationItemPK_ID]FROM [dbo].[View_AddedStimation] where [FK_ProjectID] = " + Session["ProjectId"].ToString() + " And [HasEquationItems] = 0  select * from Tbl_Project where pk_id = " + Session["ProjectId"].ToString() + " SELECT Tbl_Employees.PK_ID, Tbl_Employees.Name FROM Tbl_ProjectEmployees INNER JOIN Tbl_Employees ON Tbl_ProjectEmployees.FK_EmployeeID = Tbl_Employees.PK_ID where Tbl_ProjectEmployees.FK_ProjectID = " + Session["ProjectId"].ToString() + " SELECT  Tbl_Subcontractor.PK_ID , Tbl_Subcontractor.Name AS ContractorName, Tbl_WorkType.Name AS WorkType, Tbl_WorkCategories.Name AS WorkCategory FROM Tbl_Subcontractor INNER JOIN Tbl_SubContractorWorks ON Tbl_Subcontractor.PK_ID = Tbl_SubContractorWorks.FK_SubContractorID INNER JOIN Tbl_ProjectSubContractor ON Tbl_SubContractorWorks.PK_ID = Tbl_ProjectSubContractor.FK_SubContractorWorkID INNER JOIN Tbl_WorkType ON Tbl_SubContractorWorks.FK_WorkID = Tbl_WorkType.PK_ID INNER JOIN Tbl_WorkCategories ON Tbl_WorkType.FK_WorkCategory = Tbl_WorkCategories.PK_ID where Tbl_ProjectSubContractor.FK_ProjectID = " + Session["ProjectId"].ToString() + " SELECT Tbl_EstimationItemEquations.EquationName FROM Tbl_ProjectEstimation INNER JOIN Tbl_EstimationItems ON Tbl_ProjectEstimation.FK_EstimationItemsID = Tbl_EstimationItems.PK_ID INNER JOIN Tbl_EstimationItemEquations ON Tbl_EstimationItems.PK_ID = Tbl_EstimationItemEquations.FK_EstimationItemID where Tbl_ProjectEstimation.FK_ProjectID = " + Session["ProjectId"].ToString() + "  select Tbl_DailyWorker.*, Tbl_ProjectDailyWorker.FK_Project_ID from Tbl_DailyWorker Inner join Tbl_ProjectDailyWorker on Tbl_ProjectDailyWorker.FK_DailyWorker_ID = Tbl_DailyWorker.PK_ID where Tbl_ProjectDailyWorker.FK_Project_ID = " + Session["ProjectId"].ToString(),
                            DB_OperationProcess.ResultReturnedDataType.DataSet);
                    }

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
                    xmlData = xmlData.Replace("Table8>", "Tbl_Project>");
                    xmlData = xmlData.Replace("Table9>", "Tbl_ProjectEmployees>");
                    xmlData = xmlData.Replace("Table10>", "Tbl_ProjectSubContractor>");
                    xmlData = xmlData.Replace("Table11>", "Tbl_EquationName>");
                    xmlData = xmlData.Replace("Table12>", "Tbl_ProjectDailyWorker>");
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


                        DB.Update(TablesNames.Tbl_Project, new object[]
                                                               {
                                                                   Tbl_Project.Fields.Name, txt_ProjectName,
                                                                   Tbl_Project.Fields.Supervisor,
                                                                   txt_SupervisingAuthority,
                                                                   Tbl_Project.Fields.ProjectPeriodPerMonth,
                                                                   int.Parse(txt_ProjectPeriod),
                                                                   Tbl_Project.Fields.StartDate,
                                                                   DateTime.Parse(txt_ProjectStartDate),
                                                                   Tbl_Project.Fields.DateOfReceiptOfTheSite,
                                                                   DateTime.Parse(txt_ReceptionLocationDate),
                                                                   Tbl_Project.Fields.EndDate,
                                                                   DateTime.Parse(txt_ProjectEndDate),
                                                                   Tbl_Project.Fields.TechnicalOpenDate,
                                                                   DateTime.Parse(txt_ProjectStartTechnicalDate),
                                                                   Tbl_Project.Fields.ProjectCost,
                                                                   decimal.Parse(txt_ProjectCost)
                                                               }, new object[]
                                                                      {
                                                                          Tbl_Project.Fields.PK_ID,
                                                                          Convert.ToInt64(Session["ProjectId"])
                                                                      }
                            );
                        //Session.Add("ProjectId", id);
                        //Session.Timeout = 40;
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
                        Page.Request.Form["action"].ToString() == "CloseProject")
                {
                    string xmlData = "<main>";
                    try
                    {

                        DB.Update(TablesNames.Tbl_Project, new object[]
                                                               {
                                                                   Tbl_Project.Fields.IsActive,0
                                                               }, new object[]
                                                                      {
                                                                          Tbl_Project.Fields.PK_ID,
                                                                          Convert.ToInt64(Session["ProjectId"])
                                                                      }
                            );
                        //Session.Add("ProjectId", id);
                        //Session.Timeout = 40;
                        xmlData += "True</main>";
                        Session["ProjectId"] = 0;
                        Response.Write(xmlData);
                    }
                    catch (Exception exp)
                    {
                        xmlData = "<main>";
                        xmlData += "<Exception>Internal Server Error : \r\n";
                        xmlData += exp.Message.ToString();
                        xmlData += "</Exception>";
                        Session["ProjectId"] = 0;
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
                else if (Page.Request.Form["action"] != null &&
                       Page.Request.Form["action"].ToString() == "AddNewEstimation")
                {
                    string estimation = Page.Request.Form["TheEstimation"].ToString(),
                           unit = Page.Request.Form["TheUnit"].ToString(),
                           Quantity = Page.Request.Form["Quantity"].ToString(),
                           QuantityPrice = Page.Request.Form["QuantityPrice"].ToString();

                    if (Convert.ToInt64(Session["ProjectId"]) > 0)
                    {
                        try
                        {
                            DB.StartTransaction();
                            #region test6
                            //3. insert Data To DB
                            Int64 _ID = 0;
                            if (
                                (object)
                                (DB.ExecuteSqlStatmentQuery(
                                    "select BusinessStatement from Tbl_EstimationItems where BusinessStatement = '" +
                                    estimation + "'", DB_OperationProcess.ResultReturnedDataType.Scalar)) == null)
                            {
                                _ID = DB.NewID(TablesNames.Tbl_EstimationItems);
                                DB.Insert(TablesNames.Tbl_EstimationItems,
                                          Tbl_EstimationItems.Fields.PK_ID, _ID,
                                          Tbl_EstimationItems.Fields.BusinessStatement, estimation,
                                          Tbl_EstimationItems.Fields.Unit, unit);
                                DB.Insert(TablesNames.Tbl_EstimationItemEquations,
                                    Tbl_EstimationItemEquations.Fields.EquationName, estimation + " معادلة",
                                    Tbl_EstimationItemEquations.Fields.FK_EstimationItemID, _ID,
                                    Tbl_EstimationItemEquations.Fields.HasEquationItems, false
                                    );
                            }




                            decimal PRICE = 0;
                            try
                            {
                                PRICE = Convert.ToDecimal(QuantityPrice);
                            }
                            catch (Exception)
                            {
                                PRICE = 0;
                            }
                            try
                            {
                                DB.Insert(TablesNames.Tbl_ProjectEstimation,
                                          Tbl_ProjectEstimation.Fields.PK_ID,
                                          DB.NewID(TablesNames.Tbl_ProjectEstimation),
                                          Tbl_ProjectEstimation.Fields.Price, PRICE,
                                          Tbl_ProjectEstimation.Fields.Quantity,
                                          Convert.ToInt16(Quantity),
                                          Tbl_ProjectEstimation.Fields.Notes,
                                          "تمت إضافة هذا البند اثناء تعديل المشروع",
                                          Tbl_ProjectEstimation.Fields.FK_ProjectID,
                                          Convert.ToInt32(Session["ProjectId"]),
                                          Tbl_ProjectEstimation.Fields.FK_EstimationItemsID, _ID
                                    );
                            }
                            catch (Exception ex)
                            { }


//                            #region تطبيق المعادلات

//                            DataTable HasEstimation = (DataTable)DB.ExecuteSqlStatmentQuery(@"SELECT        Tbl_EstimationItemEquations.PK_ID, Tbl_EstimationItemEquations.FK_EstimationItemID
//FROM            Tbl_ProjectEstimation INNER JOIN
//                         Tbl_EstimationItems ON Tbl_ProjectEstimation.FK_EstimationItemsID = Tbl_EstimationItems.PK_ID INNER JOIN
//                         Tbl_EstimationItemEquations ON Tbl_EstimationItems.PK_ID = Tbl_EstimationItemEquations.FK_EstimationItemID
//where Tbl_ProjectEstimation.FK_ProjectID = " + Convert.ToInt32(Session["ProjectId"]) + " and Tbl_EstimationItemEquations.HasEquationItems = 1", DB_OperationProcess.ResultReturnedDataType.Table);
//                            if (HasEstimation.Rows.Count > 0)
//                            {
//                                foreach (DataRow EstimationItemRow in HasEstimation.Rows)
//                                {
//                                    DataTable EstimationItems = (DataTable)DB.ExecuteSqlStatmentQuery("select * from Tbl_EquationItems where FK_EstimationItemEquationID = " + EstimationItemRow[0].ToString(), DB_OperationProcess.ResultReturnedDataType.Table);
//                                    foreach (DataRow EquationRow in EstimationItems.Rows)
//                                    {
//                                        double ItemQTY = (Convert.ToDouble(EquationRow[3]) *
//                                                          Convert.ToDouble(
//                                                              (object)
//                                                              DB.ExecuteSqlStatmentQuery(
//                                                                  "select Quantity from Tbl_ProjectEstimation where FK_EstimationItemsID =" + EstimationItemRow[1].ToString() + " And FK_ProjectID = " + Convert.ToInt32(Session["ProjectId"]).ToString(),
//                                                                  DB_OperationProcess.ResultReturnedDataType.Scalar))) /
//                                                         Convert.ToDouble(EquationRow[4]);
//                                        DB.Insert(TablesNames.Tbl_ProjectSupplies,
//                                                  Tbl_ProjectSupplies.Fields.PK_ID, DB.NewID(TablesNames.Tbl_ProjectSupplies),
//                                                  Tbl_ProjectSupplies.Fields.FK_ItemsID, Convert.ToInt32(EquationRow[2]),
//                                                  Tbl_ProjectSupplies.Fields.FK_ProjectID, Convert.ToInt32(Session["ProjectId"]),
//                                                  Tbl_ProjectSupplies.Fields.QTY, ItemQTY
//                                            );

//                                    }
//                                }
//                            }

//                            #endregion

                            DB.CommitTransaction();
                            Response.Write("<script LANGUAGE='JavaScript' >alert('تم الحفظ بنجاح ... من فضلك اضغط على زر العودة للصفحة السابقة');document.location='" + ResolveClientUrl("AddEstimationItems.aspx") + "';</script>");

                            #endregion
                        }
                        catch (Exception ex)
                        {
                            DB.RollBackTransaction();

                        }

                        #region LoadCbo_Estimation

                        string xmlData = "";

                        //xmlData = "<Tbl_Subcontractor>";

                        //DataSet dtsubContractors = database.ReturnTable("select * from view_subcontractorWork order by SubContractorName");
                        DataSet dtsubContractors = null;
                        if (Convert.ToInt64(Session["ProjectId"]) > 0)
                        {

                            dtsubContractors =
                            (DataSet)
                            DB.ExecuteSqlStatmentQuery(
                                @"SELECT [PK_ID],[Name],[Quantity],[EquationItemPK_ID]FROM [dbo].[View_AddedStimation] where [FK_ProjectID] = " + Session["ProjectId"].ToString() + " And [HasEquationItems] = 0 ",
                                DB_OperationProcess.ResultReturnedDataType.DataSet);
                        }

                        xmlData = dtsubContractors.GetXml();
                        xmlData = xmlData.Replace("NewDataSet>", "main>");
                        xmlData = xmlData.Replace("Table>", "View_AddedStimation>");
                        Response.Write(xmlData);
                        #endregion

                    }
                    else
                    {
                        Response.Write("<script LANGUAGE='JavaScript' >alert(' لم يتم حفظ المشروع حتى الان ... برجاء الظغط على زر العودة للصفحة السابقة');document.location='" + ResolveClientUrl("AddEstimationItems.aspx") + "';</script>");

                    }

                }
                //else if (Page.Request.Form["action"] != null &&
                //      Page.Request.Form["action"].ToString() == "DeleteSubContractor")
                //{
                //    //Int64 ContractorID = Convert.ToInt64(Page.Request.Form["ContractorID"]);
                //    //DataTable dtsubContractors = (DataTable)DB.ExecuteSqlStatmentQuery("select * from Tbl_GuardianshipItems inner join Tbl_ProjectGuardianship on Tbl_ProjectGuardianship.PK_ID = Tbl_GuardianshipItems.FK_ProjectGuardianshipID where Tbl_ProjectGuardianship.FK_ProjectID = " + Session["ProjectId"].ToString() + " and Tbl_GuardianshipItems.PersonTypeID = -4 and Tbl_GuardianshipItems.PersonID =" + ContractorID, DB_OperationProcess.ResultReturnedDataType.Table);
                //    //string xmlData = "";
                //    //if (dtsubContractors.Rows.Count > 0)
                //    //{
                //    //    xmlData = "<main>";
                //    //    xmlData += "<Messeage>";
                //    //    xmlData += "لا يمكن حذف هذا الشخص لان لديه قائمة اعمال بالفعل على هذا المشروع";
                //    //    xmlData += "</Messeage>";
                //    //}
                //    //else
                //    //{
                //    //    DB.Delete(tables)
                //    //    xmlData = "<main>";
                //    //    xmlData += "<Messeage>";
                //    //    xmlData += "تم الحذف";
                //    //    xmlData += "</Messeage>";       
                //    //}
                //    //xmlData += "</main>";
                //}
            }
        }

    }
}
