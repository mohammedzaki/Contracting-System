using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using N_Tier_Classes.ObjectLayer.ContractingSystem;
using N_Tier_Classes.DataAccessLayer;
using System.Data;

namespace Contracting_System
{
    public partial class LoadData : System.Web.UI.Page
    {
        private DB_OperationProcess DB = new DB_OperationProcess();
        DataSet data = null;
        int userId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            userId = int.Parse(Session["UserId"].ToString());
            userId = 1;
            if (userId > 0)
            {
                if (Page.Request.HttpMethod == "POST")
                {
                    string xmlData = "<main>";
                    try
                    {
                        if (Page.Request.Form["action"] != null)
                        {
                            if (Page.Request.Form["action"].ToString() == "LoadCompanySaver")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_Savers,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Savers>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditSaverItem")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_SaverItems,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_SaverItems>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditEmployee")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_Employees,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditSubcontractors")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_Subcontractor,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditSupplier")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Supplier +
                                    " select Tbl_SupplierSupplies.PK_ID as suppliesID, Tbl_Supplier.PK_ID, Tbl_Supplier.Name,Tbl_Category.PK_ID AS CategoryID, Tbl_Category.Name AS CategoryName from Tbl_Supplier INNER JOIN dbo.Tbl_SupplierSupplies ON dbo.Tbl_SupplierSupplies.FK_SupplierID = dbo.Tbl_Supplier.PK_ID INNER JOIN dbo.Tbl_Category ON dbo.Tbl_SupplierSupplies.FK_CategoryID = dbo.Tbl_Category.PK_ID" +
                                    " select * from " + TablesNames.Tbl_Category,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_SupplierSupplies>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_Category>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditDailyWorker")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_DailyWorker,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditExpenseCategory")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_ExpensesCategories,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditExpenseItem")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_ExpensesCategories + " select * from " + TablesNames.Tbl_ExpensesItems,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Sub>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditWorkType")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_WorkCategories + " select * from " + TablesNames.Tbl_WorkType,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Sub>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditItems")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Category + 
                                    " select * from " + TablesNames.Tbl_Items + 
                                    " select * from " + TablesNames.Tbl_MeasurementUnit,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);
                                
                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Sub>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_MeasurementUnit>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "AddExpenseItem")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_ExpensesCategories + " select * from " + TablesNames.Tbl_ExpensesItems,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Data>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Sub>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "ProjectSaver")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_Savers + " select * from " + TablesNames.Tbl_Project + " select * from " + TablesNames.Tbl_SaverItems,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Savers>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_SaverItems>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditProjectSaver")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(@" select * from " + TablesNames.Tbl_Savers + " select * from " + TablesNames.Tbl_Project + " select * from " + TablesNames.Tbl_SaverItems,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Savers>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_SaverItems>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "DailyCashbook")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_Employees +
                                    " select * from " + TablesNames.Tbl_ExpensesCategories +
                                    " select * from " + TablesNames.Tbl_ExpensesItems +
                                    " select * from " + TablesNames.View_ProjectContractor +
                                    " select * from " + TablesNames.View_ProjectSuppliers +
                                    " select distinct ProjectName, SupplierName,  ProjectID, SupplierID from View_ProjectSuppliers " +
                                    " select * from " + TablesNames.View_ProjectWorker +
                                    //" select * from " + TablesNames.View_SubContractorWorkNames +
                                    " select * from " + TablesNames.Tbl_Savers +
                                    " select distinct View_ProjectContractor.ProjectId, View_ProjectContractor.SubContractorId, View_ProjectContractor.SubContractorName from View_ProjectContractor",
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Employees>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_ExpensesCategories>");
                                xmlData = xmlData.Replace("Table3>", "Tbl_ExpensesItems>");
                                xmlData = xmlData.Replace("Table4>", "View_ProjectContractor>");
                                xmlData = xmlData.Replace("Table5>", "View_ProjectSuppliers>");
                                xmlData = xmlData.Replace("Table6>", "Tbl_Supplier>");
                                xmlData = xmlData.Replace("Table7>", "View_ProjectWorker>");
                                //xmlData = xmlData.Replace("Table8>", "View_SubContractorWorkNames>");
                                xmlData = xmlData.Replace("Table8>", "Tbl_Savers>");
                                xmlData = xmlData.Replace("Table9>", "View_ProjectContractors>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditDailyCashbook")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.View_Guradianship +
                                    " select * from " + TablesNames.View_ProjectGurdianship,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "View_Guradianship>");
                                xmlData = xmlData.Replace("Table2>", "View_ProjectGurdianship>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "CompanyExtract")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_CompanyExract +
                                    " select * from " + TablesNames.Tbl_CompanyExractItems +
                                    " select * from " + TablesNames.View_ProjectEstimation +
                                    " select * from " + TablesNames.View_CompanyExtract +
                                    " select * from " + TablesNames.View_CompanyExtractNewOrder,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_CompanyExract>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_CompanyExractItems>");
                                xmlData = xmlData.Replace("Table3>", "View_ProjectEstimation>");
                                xmlData = xmlData.Replace("Table4>", "View_CompanyExtract>");
                                xmlData = xmlData.Replace("Table5>", "View_CompanyExtractNewOrder>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditCompanyExtract")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_CompanyExract +
                                    " select * from " + TablesNames.Tbl_CompanyExractItems,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_CompanyExract>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_CompanyExractItems>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "SupplierExtract")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_SupplierExtract +
                                    " select * from " + TablesNames.Tbl_SupplierExtractItems +
                                    " select * from " + TablesNames.View_ProjectSuppliers +
                                    " select distinct ProjectName, SupplierName,  ProjectID, SupplierID from View_ProjectSuppliers " +
                                    " select * from " + TablesNames.View_SupplierExtract +
                                    " select * from " + TablesNames.View_SupplierExtractNewOrder +
                                    " select * from " + TablesNames.View_EmpolyeePaid,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_SupplierExtract>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_SupplierExtractItems>");
                                xmlData = xmlData.Replace("Table3>", "View_ProjectSuppliers>");
                                xmlData = xmlData.Replace("Table4>", "ProjectSuppliers>");
                                xmlData = xmlData.Replace("Table5>", "View_SupplierExtract>");
                                xmlData = xmlData.Replace("Table6>", "View_SupplierExtractNewOrder>");
                                xmlData = xmlData.Replace("Table7>", "View_EmpolyeePaid>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditSupplierExtract")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_SupplierExtract +
                                    " select * from " + TablesNames.Tbl_SupplierExtractItems +
                                    " select * from " + TablesNames.View_ProjectSuppliers +
                                    " select distinct ProjectName, SupplierName,  ProjectID, SupplierID from View_ProjectSuppliers " +
                                    " select * from " + TablesNames.View_SupplierExtract +
                                    " select * from " + TablesNames.View_SupplierExtractNewOrder +
                                    " select * from " + TablesNames.View_EmpolyeePaid,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_SupplierExtract>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_SupplierExtractItems>");
                                xmlData = xmlData.Replace("Table3>", "View_ProjectSuppliers>");
                                xmlData = xmlData.Replace("Table4>", "ProjectSuppliers>");
                                xmlData = xmlData.Replace("Table5>", "View_SupplierExtract>");
                                xmlData = xmlData.Replace("Table6>", "View_SupplierExtractNewOrder>");
                                xmlData = xmlData.Replace("Table7>", "View_EmpolyeePaid>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "SubContractorExtract")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_SubContractorExtract +
                                    " select * from " + TablesNames.Tbl_SubContractorExtractItems +
                                    " select * from " + TablesNames.View_ProjectContractor +
                                    " select distinct ProjectName, SubContractorName,  ProjectID, SubContractorID from View_ProjectContractor " +
                                    " select * from " + TablesNames.View_SubContractorExtract +
                                    " select * from " + TablesNames.View_SubContractorExtractNewOrder +
                                    " select * from " + TablesNames.View_EmpolyeePaid,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_SubContractorExtract>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_SubContractorExtractItems>");
                                xmlData = xmlData.Replace("Table3>", "View_ProjectSubContractors>");
                                xmlData = xmlData.Replace("Table4>", "ProjectSubContractors>");
                                xmlData = xmlData.Replace("Table5>", "View_SubContractorExtract>");
                                xmlData = xmlData.Replace("Table6>", "View_SubContractorExtractNewOrder>");
                                xmlData = xmlData.Replace("Table7>", "View_EmpolyeePaid>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditDailyWorkerExtract")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_SubContractorExtract +
                                    " select * from " + TablesNames.Tbl_SubContractorExtractItems +
                                    " select * from " + TablesNames.View_ProjectContractor +
                                    " select distinct ProjectName, SubContractorName,  ProjectID, SubContractorID from View_ProjectContractor " +
                                    " select * from " + TablesNames.View_SubContractorExtract +
                                    " select * from " + TablesNames.View_SubContractorExtractNewOrder +
                                    " select * from " + TablesNames.View_EmpolyeePaid,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_SubContractorExtract>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_SubContractorExtractItems>");
                                xmlData = xmlData.Replace("Table3>", "View_ProjectSubContractors>");
                                xmlData = xmlData.Replace("Table4>", "ProjectSubContractors>");
                                xmlData = xmlData.Replace("Table5>", "View_SubContractorExtract>");
                                xmlData = xmlData.Replace("Table6>", "View_SubContractorExtractNewOrder>");
                                xmlData = xmlData.Replace("Table7>", "View_EmpolyeePaid>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditSubContractorExtract")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_SubContractorExtract +
                                    " select * from " + TablesNames.Tbl_SubContractorExtractItems +
                                    " select * from " + TablesNames.View_ProjectContractor +
                                    " select distinct ProjectName, SubContractorName,  ProjectID, SubContractorID from View_ProjectContractor " +
                                    " select * from " + TablesNames.View_SubContractorExtract +
                                    " select * from " + TablesNames.View_SubContractorExtractNewOrder +
                                    " select * from " + TablesNames.View_EmpolyeePaid,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_SubContractorExtract>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_SubContractorExtractItems>");
                                xmlData = xmlData.Replace("Table3>", "View_ProjectSubContractors>");
                                xmlData = xmlData.Replace("Table4>", "ProjectSubContractors>");
                                xmlData = xmlData.Replace("Table5>", "View_SubContractorExtract>");
                                xmlData = xmlData.Replace("Table6>", "View_SubContractorExtractNewOrder>");
                                xmlData = xmlData.Replace("Table7>", "View_EmpolyeePaid>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "DailyWorkerExtract")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.View_ProjectWorker +
                                    " select distinct ProjectName, WorkerName,  ProjectID, WorkerId from View_ProjectWorker " +
                                    " select * from " + TablesNames.View_DailyWorkerExract +
                                    " select * from " + TablesNames.View_DailyWorkerExtractNewOrder +
                                    " select * from " + TablesNames.View_EmpolyeePaid,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "View_ProjectSubContractors>");
                                xmlData = xmlData.Replace("Table2>", "ProjectWorkers>");
                                xmlData = xmlData.Replace("Table3>", "View_DailyWorkerExract>");
                                xmlData = xmlData.Replace("Table4>", "View_DailyWorkerExtractNewOrder>");
                                xmlData = xmlData.Replace("Table5>", "View_EmpolyeePaid>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "DailySuppliesbook")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.View_ProjectSupplies +
                                    " select Tbl_Supplier.PK_ID, Tbl_Supplier.Name,Tbl_Category.PK_ID AS CategoryID, Tbl_Category.Name AS CategoryName from Tbl_Supplier INNER JOIN dbo.Tbl_SupplierSupplies ON dbo.Tbl_SupplierSupplies.FK_SupplierID = dbo.Tbl_Supplier.PK_ID INNER JOIN dbo.Tbl_Category ON dbo.Tbl_SupplierSupplies.FK_CategoryID = dbo.Tbl_Category.PK_ID " +
                                    " select distinct ProjectName, ProjectId from View_ProjectSupplies " +
                                    " select distinct CategoryName, CategoryID, ProjectId from View_ProjectSupplies ",
                                            DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "View_ProjectSupplies>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Suppliers>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_Projects>");
                                xmlData = xmlData.Replace("Table3>", "Tbl_Categories>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditDailySuppliesbook")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_Subcontractor +
                                    " select * from " + TablesNames.Tbl_Items +
                                    " select * from " + TablesNames.Tbl_Category,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Subcontractor>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_Items>");
                                xmlData = xmlData.Replace("Table3>", "Tbl_Category>");
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"] != null && Page.Request.Form["action"].ToString() == "LoadExtract")
                            {
                                data = (DataSet)DB.ExecuteSqlStatmentQuery(
                                    " select * from " + TablesNames.Tbl_Supplier +
                                    " select * from " + TablesNames.Tbl_Project +
                                    " select * from " + TablesNames.Tbl_Subcontractor +
                                    " select * from " + TablesNames.Tbl_DailyWorker,
                                    DB_OperationProcess.ResultReturnedDataType.DataSet);

                                xmlData = data.GetXml();
                                xmlData = xmlData.Replace("NewDataSet>", "main>");
                                xmlData = xmlData.Replace("Table>", "Tbl_Supplier>");
                                xmlData = xmlData.Replace("Table1>", "Tbl_Project>");
                                xmlData = xmlData.Replace("Table2>", "Tbl_Subcontractor>");
                                xmlData = xmlData.Replace("Table3>", "Tbl_DailyWorker>");
                                Response.Write(xmlData);
                            }//
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
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
    }
}