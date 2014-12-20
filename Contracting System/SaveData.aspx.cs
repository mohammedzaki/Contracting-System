using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using N_Tier_Classes.ObjectLayer.ContractingSystem;
using N_Tier_Classes.DataAccessLayer;
using System.Web.Services;
using System.Xml;

namespace Contracting_System
{
    public partial class SaveData : System.Web.UI.Page
    {
        private DB_OperationProcess DB = new DB_OperationProcess();
        int userId = 1;
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
                            if (Page.Request.Form["action"].ToString() == "SaveCompanySaver")
                            {
                                string txt_CompanySaver = Page.Request.Form["txt_CompanySaver"];

                                int id = (int)DB.NewID(TablesNames.Tbl_Savers);

                                DB.Insert(TablesNames.Tbl_Savers,
                                          Tbl_Savers.Fields.PK_ID, id,
                                          Tbl_Savers.Fields.Name, txt_CompanySaver
                                    );
                                StordedProcedures sp = new StordedProcedures();
                                
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditCompanySaver")
                            {
                                string
                                    txt_CompanySaver = Page.Request.Form["txt_CompanySaver"],
                                    cbo_CompanySaver = Page.Request.Form["cbo_CompanySaver"];

                                int id = int.Parse(cbo_CompanySaver);

                                DB.Update(TablesNames.Tbl_Savers,
                                    new object[]{
                                      Tbl_Savers.Fields.Name, txt_CompanySaver
                                },
                                    new object[]{
                                      Tbl_Savers.Fields.PK_ID, id
                                });
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "AddSaverItem")
                            {
                                string txt_SaverItem = Page.Request.Form["txt_SaverItem"];

                                int id = (int)DB.NewID(TablesNames.Tbl_SaverItems);

                                DB.Insert(TablesNames.Tbl_SaverItems,
                                          Tbl_SaverItems.Fields.PK_ID, id,
                                          Tbl_SaverItems.Fields.Name, txt_SaverItem
                                    );
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditSaverItem")
                            {
                                string
                                    txt_SaverItem = Page.Request.Form["txt_SaverItem"],
                                    cbo_SaverItem = Page.Request.Form["cbo_SaverItem"];

                                int id = int.Parse(cbo_SaverItem);

                                DB.Update(TablesNames.Tbl_SaverItems,
                                    new object[]{
                                      Tbl_SaverItems.Fields.Name, txt_SaverItem
                                },
                                    new object[]{
                                      Tbl_SaverItems.Fields.PK_ID, id
                                });
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "AddExpenseCategory")
                            {
                                string Name = Page.Request.Form["Name"];

                                int id = (int)DB.NewID(TablesNames.Tbl_ExpensesCategories);

                                DB.Insert(TablesNames.Tbl_ExpensesCategories,
                                          Tbl_ExpensesCategories.Fields.PK_ID, id,
                                          Tbl_ExpensesCategories.Fields.Name, Name
                                    );
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditExpenseCategory")
                            {
                                string
                                    Name = Page.Request.Form["Name"],
                                    id = Page.Request.Form["id"];

                                DB.Update(TablesNames.Tbl_ExpensesCategories,
                                    new object[]{
                                      Tbl_ExpensesCategories.Fields.Name, Name
                                },
                                    new object[]{
                                      Tbl_ExpensesCategories.Fields.PK_ID, int.Parse(id)
                                });
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "AddExpenseItem")
                            {
                                string
                                    Name = Page.Request.Form["Name"],
                                    p_id = Page.Request.Form["p_id"];

                                int id = (int)DB.NewID(TablesNames.Tbl_ExpensesItems);

                                DB.Insert(TablesNames.Tbl_ExpensesItems,
                                          Tbl_ExpensesItems.Fields.PK_ID, id,
                                          Tbl_ExpensesItems.Fields.Name, Name,
                                          Tbl_ExpensesItems.Fields.FK_ExpenseCategory, int.Parse(p_id)
                                    );
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "DailySuppliesbook")
                            {
                                string
                                    cbo_ProjectName = Page.Request.Form["cbo_ProjectName"],
                                    cbo_SupplieisCategory = Page.Request.Form["cbo_SupplieisCategory"],
                                    cbo_SupplierNames = Page.Request.Form["cbo_SupplierNames"],
                                    cbo_ItemType = Page.Request.Form["cbo_ItemType"],
                                    txt_SuppliesQTY = Page.Request.Form["txt_SuppliesQTY"],
                                    txt_UnitPrice = Page.Request.Form["txt_UnitPrice"],
                                    txt_TotalPrice = Page.Request.Form["txt_TotalPrice"],
                                    txt_RestSupplies = Page.Request.Form["txt_RestSupplies"],
                                    txt_ReciptNo = Page.Request.Form["txt_ReciptNo"],
                                    txt_Date = Page.Request.Form["txt_Date"],
                                    ProjectSupplyID = Page.Request.Form["ProjectSupplyID"];
                                int rest = int.Parse(txt_RestSupplies) - int.Parse(txt_SuppliesQTY);
                                if (rest <= 0)
                                {
                                    DB.Update(TablesNames.Tbl_ProjectSupplies,
                                        new object[] {
                                        Tbl_ProjectSupplies.Fields.Rest, 0,
                                        Tbl_ProjectSupplies.Fields.WasSupplied, 1
                                    },
                                        new object[] {
                                        Tbl_ProjectSupplies.Fields.PK_ID, int.Parse(ProjectSupplyID)
                                    });
                                }
                                else
                                {
                                    DB.Update(TablesNames.Tbl_ProjectSupplies,
                                        new object[] {
                                        Tbl_ProjectSupplies.Fields.Rest, rest,
                                        Tbl_ProjectSupplies.Fields.WasSupplied, 0
                                    },
                                        new object[] {
                                        Tbl_ProjectSupplies.Fields.PK_ID, int.Parse(ProjectSupplyID)
                                    });
                                }

                                int SuppliesEventID = (int)DB.NewID(TablesNames.Tbl_SuppliesEvent);

                                DB.Insert(TablesNames.Tbl_SuppliesEvent,
                                    Tbl_SuppliesEvent.Fields.PK_ID, SuppliesEventID,
                                    Tbl_SuppliesEvent.Fields.FK_SupplierID, int.Parse(cbo_SupplierNames),
                                    Tbl_SuppliesEvent.Fields.FK_ProjectSuppliesID, int.Parse(ProjectSupplyID),
                                    Tbl_SuppliesEvent.Fields.QTY, int.Parse(txt_SuppliesQTY),
                                    Tbl_SuppliesEvent.Fields.ReceiptNO, txt_ReciptNo,
                                    Tbl_SuppliesEvent.Fields.SuppliesDate, DateTime.Parse(txt_Date),
                                    Tbl_SuppliesEvent.Fields.TotalPrice, decimal.Parse(txt_TotalPrice),
                                    Tbl_SuppliesEvent.Fields.UnitPrice, decimal.Parse(txt_UnitPrice)
                                    );
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditDailySuppliesbook")
                            {
                                string
                                    txt_SuppliesQTY = Page.Request.Form["txt_SuppliesQTY"],
                                    txt_UnitPrice = Page.Request.Form["txt_UnitPrice"],
                                    txt_TotalPrice = Page.Request.Form["txt_TotalPrice"],
                                    txt_RestSupplies = Page.Request.Form["txt_RestSupplies"],
                                    txt_ReciptNo = Page.Request.Form["txt_ReciptNoEdit"],
                                    txt_WasSupplies = Page.Request.Form["txt_WasSupplies"],
                                    ProjectSupplies_PK_ID = Page.Request.Form["ProjectSupplies_PK_ID"],
                                    pk_id = Page.Request.Form["pk_id"];

                                int rest = int.Parse(txt_RestSupplies) - int.Parse(txt_SuppliesQTY);
                                if (rest <= 0)
                                {
                                    DB.Update(TablesNames.Tbl_ProjectSupplies,
                                        new object[] {
                                        Tbl_ProjectSupplies.Fields.Rest, 0,
                                        Tbl_ProjectSupplies.Fields.WasSupplied, 1
                                    },
                                        new object[] {
                                        Tbl_ProjectSupplies.Fields.PK_ID, int.Parse(ProjectSupplies_PK_ID)
                                    });
                                }
                                else
                                {
                                    DB.Update(TablesNames.Tbl_ProjectSupplies,
                                        new object[] {
                                        Tbl_ProjectSupplies.Fields.Rest, rest,
                                        Tbl_ProjectSupplies.Fields.WasSupplied, 0
                                    },
                                        new object[] {
                                        Tbl_ProjectSupplies.Fields.PK_ID, int.Parse(ProjectSupplies_PK_ID)
                                    });
                                }

                                int SuppliesEventID = int.Parse(pk_id);

                                DB.Update(TablesNames.Tbl_SuppliesEvent,
                                    new object[] {
                                        Tbl_SuppliesEvent.Fields.QTY, int.Parse(txt_SuppliesQTY),
                                        Tbl_SuppliesEvent.Fields.ReceiptNO, txt_ReciptNo,
                                        Tbl_SuppliesEvent.Fields.TotalPrice, decimal.Parse(txt_TotalPrice),
                                        Tbl_SuppliesEvent.Fields.UnitPrice, decimal.Parse(txt_UnitPrice)},
                                    new object[] { 
                                        Tbl_SuppliesEvent.Fields.PK_ID, SuppliesEventID
                                    });
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditExpenseItem")
                            {
                                string
                                    Name = Page.Request.Form["Name"],
                                    id = Page.Request.Form["id"];

                                DB.Update(TablesNames.Tbl_ExpensesItems,
                                    new object[]{
                                      Tbl_ExpensesItems.Fields.Name, Name
                                },
                                    new object[]{
                                      Tbl_ExpensesItems.Fields.PK_ID, int.Parse(id)
                                });
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditWorkType")
                            {
                                string
                                    Name = Page.Request.Form["Name"],
                                    id = Page.Request.Form["id"];

                                DB.Update(TablesNames.Tbl_WorkType,
                                    new object[]{
                                      Tbl_WorkType.Fields.Name, Name
                                },
                                    new object[]{
                                      Tbl_WorkType.Fields.PK_ID, int.Parse(id)
                                });
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "ProjectSaver")
                            {
                                string
                                    //cbo_CompanySaver = Page.Request.Form["cbo_CompanySaver"],
                                    cbo_ProjectName = Page.Request.Form["cbo_ProjectName"],
                                    cbo_SaverItem = Page.Request.Form["cbo_SaverItem"],
                                    //cbo_SaverItemType = Page.Request.Form["cbo_SaverItemType"],
                                    txt_value = Page.Request.Form["txt_value"],
                                    txt_Date = Page.Request.Form["txt_Date"],
                                    txt_Description = Page.Request.Form["txt_Description"];


                                int id = (int)DB.NewID(TablesNames.Tbl_ProjectSaverDeposits);
                                int ProjectId = 0;
                                ProjectId = int.Parse(cbo_ProjectName);
                                DB.Insert(TablesNames.Tbl_ProjectSaverDeposits,
                                          Tbl_ProjectSaverDeposits.Fields.PK_ID, id,
                                    //Tbl_SaverAmountActions.Fields.ActionType, int.Parse(cbo_SaverItemType),
                                          Tbl_ProjectSaverDeposits.Fields.FK_ProjectID, ProjectId,
                                    //Tbl_SaverAmountActions.Fields.FK_SaverID, int.Parse(cbo_CompanySaver),
                                          Tbl_ProjectSaverDeposits.Fields.FK_SaverItemID, int.Parse(cbo_SaverItem),
                                          Tbl_ProjectSaverDeposits.Fields.Amount, decimal.Parse(txt_value),
                                          Tbl_ProjectSaverDeposits.Fields.Date, DateTime.Parse(txt_Date),
                                          Tbl_ProjectSaverDeposits.Fields.Description, txt_Description
                                    );
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditProjectSaver")
                            {
                                string
                                    pk_id = Page.Request.Form["pk_id"],
                                    txt_value = Page.Request.Form["txt_value"],
                                    txt_Description = Page.Request.Form["txt_Description"];

                                DB.Update(TablesNames.Tbl_ProjectSaverDeposits,
                                    new object[] {
                                    Tbl_ProjectSaverDeposits.Fields.Amount, decimal.Parse(txt_value),
                                    Tbl_ProjectSaverDeposits.Fields.Description, txt_Description
                                },
                                    new object[] { 
                                    Tbl_ProjectSaverDeposits.Fields.PK_ID, int.Parse(pk_id)
                                });
                                xmlData += "True</main>";
                                Response.Write(xmlData);
                            }
                            else if (Page.Request.Form["action"].ToString() == "EditDailyCashbook")
                            {
                                string
                                    pk_id = Page.Request.Form["pk_id"],
                                    txt_value = Page.Request.Form["txt_value"];

                                DB.Update(TablesNames.Tbl_GuardianshipItems,
                                    new object[] {
                                    Tbl_GuardianshipItems.Fields.Amount, decimal.Parse(txt_value)
                                },
                                    new object[] { 
                                    Tbl_GuardianshipItems.Fields.PK_ID, int.Parse(pk_id)
                                });
                                xmlData += "True</main>";
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
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        [WebMethod]
        public static long SaveDailCashBook(string xmlGuardianship)
        {
            try
            {
                DB_OperationProcess DB = new DB_OperationProcess();
                XmlDocument xml = new XmlDocument();
                int GuardianshipId = (int)DB.NewID(TablesNames.Tbl_ProjectGuardianship);
                xml.LoadXml(xmlGuardianship);
                /*
                 * "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlBill += "<EmployeeId>" + $("#cbo_Employee").val() + "</EmployeeId>";
                xmlBill += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlBill += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlBill += "<Value>" + $("#txt_value").val() + "</Value>";
                xmlBill += "<Rest>" + $("#txt_RestValue").val() + "</Rest>";
                 * */
                string
                    ProjectId = xml.GetElementsByTagName("ProjectId").Item(0).InnerText,
                    EmployeeId = xml.GetElementsByTagName("EmployeeId").Item(0).InnerText,
                    DateFrom = xml.GetElementsByTagName("DateFrom").Item(0).InnerText,
                    DateTo = xml.GetElementsByTagName("DateTo").Item(0).InnerText,
                    Value = xml.GetElementsByTagName("Value").Item(0).InnerText,
                    Rest = xml.GetElementsByTagName("Rest").Item(0).InnerText;
                //SaverId = xml.GetElementsByTagName("SaverId").Item(0).InnerText;
                if (ProjectId != "")
                {
                    DB.Insert(TablesNames.Tbl_ProjectGuardianship,
                        Tbl_ProjectGuardianship.Fields.PK_ID, GuardianshipId,
                        Tbl_ProjectGuardianship.Fields.FK_ProjectID, int.Parse(ProjectId),
                        Tbl_ProjectGuardianship.Fields.FK_EmployeeID, int.Parse(EmployeeId),
                        Tbl_ProjectGuardianship.Fields.DateFrom, DateTime.Parse(DateFrom),
                        Tbl_ProjectGuardianship.Fields.DateTo, DateTime.Parse(DateTo),
                        Tbl_ProjectGuardianship.Fields.Amount, decimal.Parse(Value),
                        Tbl_ProjectGuardianship.Fields.Rest, decimal.Parse(Rest),
                        Tbl_ProjectGuardianship.Fields.Surplus, decimal.Parse(Rest)
                        //Tbl_ProjectGuardianship.Fields.FK_SaverID, int.Parse(SaverId)
                        );
                }
                else
                {
                    DB.Insert(TablesNames.Tbl_ProjectGuardianship,
                        Tbl_ProjectGuardianship.Fields.PK_ID, GuardianshipId,
                        Tbl_ProjectGuardianship.Fields.FK_EmployeeID, int.Parse(EmployeeId),
                        Tbl_ProjectGuardianship.Fields.DateFrom, DateTime.Parse(DateFrom),
                        Tbl_ProjectGuardianship.Fields.DateTo, DateTime.Parse(DateTo),
                        Tbl_ProjectGuardianship.Fields.Amount, decimal.Parse(Value),
                        Tbl_ProjectGuardianship.Fields.Rest, decimal.Parse(Rest),
                        Tbl_ProjectGuardianship.Fields.Surplus, decimal.Parse(Rest)
                        //Tbl_ProjectGuardianship.Fields.FK_SaverID, int.Parse(SaverId)
                        );
                }
                //Insert Order Line Items
                for (int i = 0; i < xml.GetElementsByTagName("Item").Count; i++)
                {
                    /*
                     * ItemCategoryId = $('#grid_GuardianshipDetails tr:eq(' + i + ') td:eq(1)').children(0).val(),
                ItemNameId = $('#grid_GuardianshipDetails tr:eq(' + i + ') td:eq(2)').children(0).val(),
                Value = $('#grid_GuardianshipDetails tr:eq(' + i + ') td:eq(3)').children(0).val(),
                Date = $('#grid_GuardianshipDetails tr:eq(' + i + ') td:eq(4)').children(0).val();
                     * */
                    string
                        ItemCategoryId = xml.GetElementsByTagName("Item").Item(i)["ItemCategoryId"].InnerText,
                        ItemNameId = xml.GetElementsByTagName("Item").Item(i)["ItemNameId"].InnerText,
                        Amount = xml.GetElementsByTagName("Item").Item(i)["Value"].InnerText,
                        Date = xml.GetElementsByTagName("Item").Item(i)["Date"].InnerText,
                        WorkTypeId = xml.GetElementsByTagName("Item").Item(i)["WorkTypeId"].InnerText;

                    int GuardianshipItemID = (int)DB.NewID(TablesNames.Tbl_GuardianshipItems);
                    if (int.Parse(ItemCategoryId) > 0)
                    {
                        DB.Insert(TablesNames.Tbl_GuardianshipItems,
                            Tbl_GuardianshipItems.Fields.PK_ID, GuardianshipItemID,
                            Tbl_GuardianshipItems.Fields.FK_ExpenseItemID, int.Parse(ItemNameId),
                            Tbl_GuardianshipItems.Fields.Amount, decimal.Parse(Amount),
                            Tbl_GuardianshipItems.Fields.FK_ProjectGuardianshipID, GuardianshipId,
                            Tbl_GuardianshipItems.Fields.Date, DateTime.Parse(Date)
                            );
                    }
                    else
                    {
                        if (WorkTypeId != "")
                        {
                            DB.Insert(TablesNames.Tbl_GuardianshipItems,
                                Tbl_GuardianshipItems.Fields.PK_ID, GuardianshipItemID,
                                Tbl_GuardianshipItems.Fields.PersonTypeID, int.Parse(ItemCategoryId),
                                Tbl_GuardianshipItems.Fields.PersonID, int.Parse(ItemNameId),
                                Tbl_GuardianshipItems.Fields.WorkTypeId, int.Parse(WorkTypeId),
                                Tbl_GuardianshipItems.Fields.Amount, decimal.Parse(Amount),
                                Tbl_GuardianshipItems.Fields.FK_ProjectGuardianshipID, GuardianshipId,
                                Tbl_GuardianshipItems.Fields.Date, DateTime.Parse(Date)
                                );
                        }
                        else
                        {
                            DB.Insert(TablesNames.Tbl_GuardianshipItems,
                                Tbl_GuardianshipItems.Fields.PK_ID, GuardianshipItemID,
                                Tbl_GuardianshipItems.Fields.PersonTypeID, int.Parse(ItemCategoryId),
                                Tbl_GuardianshipItems.Fields.PersonID, int.Parse(ItemNameId),
                                Tbl_GuardianshipItems.Fields.Amount, decimal.Parse(Amount),
                                Tbl_GuardianshipItems.Fields.FK_ProjectGuardianshipID, GuardianshipId,
                                Tbl_GuardianshipItems.Fields.Date, DateTime.Parse(Date)
                                );
                        }
                    }
                }
                return GuardianshipId;
            }
            catch
            {
                return -1;
            }
        }

        [WebMethod]
        public static long SaveCompanyExtract(string xmlCompanyExtract)
        {
            try
            {
                DB_OperationProcess DB = new DB_OperationProcess();
                XmlDocument xml = new XmlDocument();
                int CompanyExractId = (int)DB.NewID(TablesNames.Tbl_CompanyExract);
                xml.LoadXml(xmlCompanyExtract);
                /*
                 * 
                 * 
                 * xmlCompanyExtract += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlCompanyExtract += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlCompanyExtract += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlCompanyExtract += "<BusinessGuarantee>" + $("#txt_BusinessGuarantee").val() + "</BusinessGuarantee>";
                xmlCompanyExtract += "<Deductions>" + $("#txt_Deductions").val() + "</Deductions>";
                xmlCompanyExtract += "<LastPaid>" + $("#cbo_LastPaid").val() + "</LastPaid>";
                xmlCompanyExtract += "<TotalExtractPrice>" + $("#TotalExtractPrice").val() + "</TotalExtractPrice>";
                xmlCompanyExtract += "<NetDue>" + $("#txt_NetDue").val() + "</NetDue>";
                 * */
                string
                    ProjectId = xml.GetElementsByTagName("ProjectId").Item(0).InnerText,
                    DateFrom = xml.GetElementsByTagName("DateFrom").Item(0).InnerText,
                    DateTo = xml.GetElementsByTagName("DateTo").Item(0).InnerText,
                    BusinessGuarantee = xml.GetElementsByTagName("BusinessGuarantee").Item(0).InnerText,
                    Deductions = xml.GetElementsByTagName("Deductions").Item(0).InnerText,
                    LastPaid = xml.GetElementsByTagName("LastPaid").Item(0).InnerText,
                    TotalExtractPrice = xml.GetElementsByTagName("TotalExtractPrice").Item(0).InnerText,
                    NetDue = xml.GetElementsByTagName("NetDue").Item(0).InnerText,
                    ExractOrder = xml.GetElementsByTagName("ExractOrder").Item(0).InnerText,
                    Supervisor = xml.GetElementsByTagName("Supervisor").Item(0).InnerText;

                DB.Insert(TablesNames.Tbl_CompanyExract,
                    Tbl_CompanyExract.Fields.PK_ID, CompanyExractId,
                    Tbl_CompanyExract.Fields.FK_ProjectID, int.Parse(ProjectId),
                    Tbl_CompanyExract.Fields.DateFrom, DateTime.Parse(DateFrom),
                    Tbl_CompanyExract.Fields.DateTo, DateTime.Parse(DateTo),
                    Tbl_CompanyExract.Fields.BusinessGuarantee, decimal.Parse(BusinessGuarantee),
                    Tbl_CompanyExract.Fields.Deductions, decimal.Parse(Deductions),
                    Tbl_CompanyExract.Fields.LastPaid, decimal.Parse(LastPaid),
                    Tbl_CompanyExract.Fields.ExtractTotalPrice, decimal.Parse(TotalExtractPrice),
                    Tbl_CompanyExract.Fields.NetDue, decimal.Parse(NetDue),
                    Tbl_CompanyExract.Fields.Supervisor, Supervisor,
                    Tbl_CompanyExract.Fields.ExractOrder, int.Parse(ExractOrder)
                    );
                //Insert Order Line Items
                for (int i = 0; i < xml.GetElementsByTagName("Item").Count; i++)
                {
                    string
                        ProjectEstimationID = xml.GetElementsByTagName("Item").Item(i)["ProjectEstimationID"].InnerText,
                        EstimationName = xml.GetElementsByTagName("Item").Item(i)["EstimationName"].InnerText,
                        EstimationQTY = xml.GetElementsByTagName("Item").Item(i)["EstimationQTY"].InnerText,
                        Price = xml.GetElementsByTagName("Item").Item(i)["Price"].InnerText,
                        Unit22 = xml.GetElementsByTagName("Item").Item(i)["Unit"].InnerText,
                        LastExitExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExitExecutedQTY"].InnerText,
                        LastExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExecutedQTY"].InnerText,
                        CurrentExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["CurrentExecutedQTY"].InnerText,
                        TotalExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["TotalExecutedQTY"].InnerText,
                        TotalPrice = xml.GetElementsByTagName("Item").Item(i)["TotalPrice"].InnerText;

                    int CompanyExractItemID = (int)DB.NewID(TablesNames.Tbl_CompanyExractItems);

                    DB.Insert(TablesNames.Tbl_CompanyExractItems,
                        Tbl_CompanyExractItems.Fields.PK_ID, CompanyExractItemID,
                        Tbl_CompanyExractItems.Fields.ProjectEstimationID, int.Parse(ProjectEstimationID),
                        Tbl_CompanyExractItems.Fields.EstimationName, EstimationName,
                        Tbl_CompanyExractItems.Fields.EstimationQTY, int.Parse(EstimationQTY),
                        Tbl_CompanyExractItems.Fields.Price, decimal.Parse(Price),
                        Tbl_CompanyExractItems.Fields.Unit, int.Parse(Unit22),
                        Tbl_CompanyExractItems.Fields.LastExitExecutedQTY, int.Parse(LastExitExecutedQTY),
                        Tbl_CompanyExractItems.Fields.LastExecutedQTY, int.Parse(LastExecutedQTY),
                        Tbl_CompanyExractItems.Fields.CurrentExecutedQTY, int.Parse(CurrentExecutedQTY),
                        Tbl_CompanyExractItems.Fields.TotalExecutedQTY, int.Parse(TotalExecutedQTY),
                        Tbl_CompanyExractItems.Fields.TotalPrice, decimal.Parse(TotalPrice),
                        Tbl_CompanyExractItems.Fields.FK_CompanyExractID, CompanyExractId
                        );
                }
                return CompanyExractId;
            }
            catch
            {
                return -1;
            }
        }

        [WebMethod]
        public static int UpdateCompanyExtract(string xmlCompanyExtract)
        {
            DB_OperationProcess DB = new DB_OperationProcess();
            try
            {
                DB.StartTransaction();
                XmlDocument xml = new XmlDocument();
                xml.LoadXml(xmlCompanyExtract);
                int CompanyExractPK_ID = int.Parse(xml.GetElementsByTagName("CompanyExractPK_ID").Item(0).InnerText);
                string
                    BusinessGuarantee = xml.GetElementsByTagName("BusinessGuarantee").Item(0).InnerText,
                    Deductions = xml.GetElementsByTagName("Deductions").Item(0).InnerText,
                    LastPaid = xml.GetElementsByTagName("LastPaid").Item(0).InnerText,
                    TotalExtractPrice = xml.GetElementsByTagName("TotalExtractPrice").Item(0).InnerText,
                    NetDue = xml.GetElementsByTagName("NetDue").Item(0).InnerText;

                DB.Update(TablesNames.Tbl_CompanyExract,
                    new object [] 
                    {
                        Tbl_CompanyExract.Fields.BusinessGuarantee, decimal.Parse(BusinessGuarantee),
                        Tbl_CompanyExract.Fields.Deductions, decimal.Parse(Deductions),
                        Tbl_CompanyExract.Fields.LastPaid, decimal.Parse(LastPaid),
                        Tbl_CompanyExract.Fields.ExtractTotalPrice, decimal.Parse(TotalExtractPrice),
                        Tbl_CompanyExract.Fields.NetDue, decimal.Parse(NetDue)
                    },
                    new object []
                    {
                        Tbl_CompanyExract.Fields.PK_ID , CompanyExractPK_ID
                    });
                //Insert Order Line Items
                for (int i = 0; i < xml.GetElementsByTagName("Item").Count; i++)
                {
                    string
                        ExtractItemPK_ID = xml.GetElementsByTagName("Item").Item(i)["ExtractItemPK_ID"].InnerText,
                        Price = xml.GetElementsByTagName("Item").Item(i)["Price"].InnerText,
                        Unit22 = xml.GetElementsByTagName("Item").Item(i)["Unit"].InnerText,
                        LastExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExecutedQTY"].InnerText,
                        CurrentExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["CurrentExecutedQTY"].InnerText,
                        TotalExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["TotalExecutedQTY"].InnerText,
                        TotalPrice = xml.GetElementsByTagName("Item").Item(i)["TotalPrice"].InnerText;

                    DB.Update(TablesNames.Tbl_CompanyExractItems,
                        new object [] 
                        {
                            Tbl_CompanyExractItems.Fields.Price, decimal.Parse(Price),
                            Tbl_CompanyExractItems.Fields.Unit, int.Parse(Unit22),
                            Tbl_CompanyExractItems.Fields.LastExecutedQTY, int.Parse(LastExecutedQTY),
                            Tbl_CompanyExractItems.Fields.CurrentExecutedQTY, int.Parse(CurrentExecutedQTY),
                            Tbl_CompanyExractItems.Fields.TotalExecutedQTY, int.Parse(TotalExecutedQTY),
                            Tbl_CompanyExractItems.Fields.TotalPrice, decimal.Parse(TotalPrice)
                        },
                        new object [] 
                        { 
                            Tbl_CompanyExractItems.Fields.PK_ID, int.Parse(ExtractItemPK_ID)
                        });
                }
                DB.CommitTransaction();
                return CompanyExractPK_ID;
            }
            catch
            {
                DB.RollBackTransaction();
                return -1;
            }
        }

        [WebMethod]
        public static long SaveSupplierExtract(string xmlSupplierExtract)
        {
            try
            {
                DB_OperationProcess DB = new DB_OperationProcess();
                XmlDocument xml = new XmlDocument();
                int SupplierExtractId = (int)DB.NewID(TablesNames.Tbl_SupplierExtract);
                xml.LoadXml(xmlSupplierExtract);
                /*
                 * 
                 * 
                xmlSupplierExtract += "<SupplierExtractInfo>";
                xmlSupplierExtract += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlSupplierExtract += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlSupplierExtract += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlSupplierExtract += "<BusinessGuarantee>" + $("#txt_BusinessGuarantee").val() + "</BusinessGuarantee>";
                xmlSupplierExtract += "<Deductions>" + $("#txt_Deductions").val() + "</Deductions>";
                xmlSupplierExtract += "<LastPaid>" + $("#txt_LastPaid").val() + "</LastPaid>";
                xmlSupplierExtract += "<TotalExtractPrice>" + $("#TotalExtractPrice").val() + "</TotalExtractPrice>";
                xmlSupplierExtract += "<NetDue>" + $("#txt_NetDue").val() + "</NetDue>";
                xmlSupplierExtract += "<ExractOrder>" + $("#ExtractNumber").html() + "</ExractOrder>";
                xmlSupplierExtract += "<SupplierName>" + $("#cbo_Suppliers option:selected").val() + "</SupplierName>";
                xmlSupplierExtract += "<SupplierId>" + $("#cbo_Suppliers").val() + "</SupplierId>";
                xmlSupplierExtract += "</SupplierExtractInfo>";
                 * */
                string
                    ProjectId = xml.GetElementsByTagName("ProjectId").Item(0).InnerText,
                    DateFrom = xml.GetElementsByTagName("DateFrom").Item(0).InnerText,
                    DateTo = xml.GetElementsByTagName("DateTo").Item(0).InnerText,
                    BusinessGuarantee = xml.GetElementsByTagName("BusinessGuarantee").Item(0).InnerText,
                    Deductions = xml.GetElementsByTagName("Deductions").Item(0).InnerText,
                    LastPaid = xml.GetElementsByTagName("LastPaid").Item(0).InnerText,
                    TotalExtractPrice = xml.GetElementsByTagName("TotalExtractPrice").Item(0).InnerText,
                    NetDue = xml.GetElementsByTagName("NetDue").Item(0).InnerText,
                    ExractOrder = xml.GetElementsByTagName("ExractOrder").Item(0).InnerText,
                    SupplierName = xml.GetElementsByTagName("SupplierName").Item(0).InnerText,
                    SupplierId = xml.GetElementsByTagName("SupplierId").Item(0).InnerText;

                DB.Insert(TablesNames.Tbl_SupplierExtract,
                    Tbl_SupplierExtract.Fields.PK_ID, SupplierExtractId,
                    Tbl_SupplierExtract.Fields.FK_ProjectID, int.Parse(ProjectId),
                    Tbl_SupplierExtract.Fields.DateFrom, DateTime.Parse(DateFrom),
                    Tbl_SupplierExtract.Fields.DateTo, DateTime.Parse(DateTo),
                    Tbl_SupplierExtract.Fields.BusinessGuarantee, decimal.Parse(BusinessGuarantee),
                    Tbl_SupplierExtract.Fields.Deductions, decimal.Parse(Deductions),
                    Tbl_SupplierExtract.Fields.LastPaid, decimal.Parse(LastPaid),
                    Tbl_SupplierExtract.Fields.ExtractTotalPrice, decimal.Parse(TotalExtractPrice),
                    Tbl_SupplierExtract.Fields.NetDue, decimal.Parse(NetDue),
                    Tbl_SupplierExtract.Fields.SupplierName, SupplierName,
                    Tbl_SupplierExtract.Fields.SupplierId, int.Parse(SupplierId),
                    Tbl_SupplierExtract.Fields.ExractOrder, int.Parse(ExractOrder)
                    );
                //Insert Order Line Items
                for (int i = 0; i < xml.GetElementsByTagName("Item").Count; i++)
                {
                    /*
                     * 
                    xmlSupplierExtract += "<Item>";
                    xmlSupplierExtract += "<SupplyNameID>" + SupplyNameID + "</SupplyNameID>";
                    xmlSupplierExtract += "<SupplyName>" + SupplyName + "</SupplyName>";
                    xmlSupplierExtract += "<Price>" + Price + "</Price>";
                    xmlSupplierExtract += "<LastExecutedQTY>" + LastExecutedQTY + "</LastExecutedQTY>";
                    xmlSupplierExtract += "<CurrentExecutedQTY>" + CurrentExecutedQTY + "</CurrentExecutedQTY>";
                    xmlSupplierExtract += "<TotalExecutedQTY>" + TotalExecutedQTY + "</TotalExecutedQTY>";
                    xmlSupplierExtract += "<TotalPrice>" + TotalPrice + "</TotalPrice>";
                    xmlSupplierExtract += "</Item>";
                     * */
                    string
                        SupplyNameID = xml.GetElementsByTagName("Item").Item(i)["SupplyNameID"].InnerText,
                        SupplyName = xml.GetElementsByTagName("Item").Item(i)["SupplyName"].InnerText,
                        Price = xml.GetElementsByTagName("Item").Item(i)["Price"].InnerText,
                        LastExitExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExitExecutedQTY"].InnerText,
                        LastExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExecutedQTY"].InnerText,
                        CurrentExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["CurrentExecutedQTY"].InnerText,
                        TotalExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["TotalExecutedQTY"].InnerText,
                        TotalPrice = xml.GetElementsByTagName("Item").Item(i)["TotalPrice"].InnerText;

                    int SupplierExtractItemID = (int)DB.NewID(TablesNames.Tbl_SupplierExtractItems);

                    DB.Insert(TablesNames.Tbl_SupplierExtractItems,
                        Tbl_SupplierExtractItems.Fields.PK_ID, SupplierExtractItemID,
                        Tbl_SupplierExtractItems.Fields.SupplyNameID, int.Parse(SupplyNameID),
                        Tbl_SupplierExtractItems.Fields.SupplyName, SupplyName,
                        Tbl_SupplierExtractItems.Fields.Price, decimal.Parse(Price),
                        Tbl_SupplierExtractItems.Fields.LastExitExecutedQTY, int.Parse(LastExitExecutedQTY),
                        Tbl_SupplierExtractItems.Fields.LastExecutedQTY, int.Parse(LastExecutedQTY),
                        Tbl_SupplierExtractItems.Fields.CurrentExecutedQTY, int.Parse(CurrentExecutedQTY),
                        Tbl_SupplierExtractItems.Fields.TotalExecutedQTY, int.Parse(TotalExecutedQTY),
                        Tbl_SupplierExtractItems.Fields.TotalPrice, decimal.Parse(TotalPrice),
                        Tbl_SupplierExtractItems.Fields.FK_SupplierExractID, SupplierExtractId
                        );
                }
                return SupplierExtractId;
            }
            catch
            {
                return -1;
            }
        }

        [WebMethod]
        public static long UpdateSupplierExtract(string xmlSupplierExtract)
        {
            try
            {
                DB_OperationProcess DB = new DB_OperationProcess();
                XmlDocument xml = new XmlDocument();
                xml.LoadXml(xmlSupplierExtract);
                int SupplierExtractId = int.Parse(xml.GetElementsByTagName("SupplierExractPK_ID").Item(0).InnerText);
                string
                    ProjectId = xml.GetElementsByTagName("ProjectId").Item(0).InnerText,
                    DateFrom = xml.GetElementsByTagName("DateFrom").Item(0).InnerText,
                    DateTo = xml.GetElementsByTagName("DateTo").Item(0).InnerText,
                    BusinessGuarantee = xml.GetElementsByTagName("BusinessGuarantee").Item(0).InnerText,
                    Deductions = xml.GetElementsByTagName("Deductions").Item(0).InnerText,
                    LastPaid = xml.GetElementsByTagName("LastPaid").Item(0).InnerText,
                    TotalExtractPrice = xml.GetElementsByTagName("TotalExtractPrice").Item(0).InnerText,
                    NetDue = xml.GetElementsByTagName("NetDue").Item(0).InnerText,
                    ExractOrder = xml.GetElementsByTagName("ExractOrder").Item(0).InnerText,
                    SupplierName = xml.GetElementsByTagName("SupplierName").Item(0).InnerText,
                    SupplierId = xml.GetElementsByTagName("SupplierId").Item(0).InnerText;

                DB.Update(TablesNames.Tbl_SupplierExtract,
                    new object[]{
                    Tbl_SupplierExtract.Fields.BusinessGuarantee, decimal.Parse(BusinessGuarantee),
                    Tbl_SupplierExtract.Fields.Deductions, decimal.Parse(Deductions),
                    Tbl_SupplierExtract.Fields.LastPaid, decimal.Parse(LastPaid),
                    Tbl_SupplierExtract.Fields.ExtractTotalPrice, decimal.Parse(TotalExtractPrice),
                    Tbl_SupplierExtract.Fields.NetDue, decimal.Parse(NetDue)
                    },
                    new object[] { 
                    Tbl_SupplierExtract.Fields.PK_ID, SupplierExtractId
                    });
                //Insert Order Line Items
                for (int i = 0; i < xml.GetElementsByTagName("Item").Count; i++)
                {
                    string
                        SupplyNameID = xml.GetElementsByTagName("Item").Item(i)["SupplyNameID"].InnerText,
                        SupplyName = xml.GetElementsByTagName("Item").Item(i)["SupplyName"].InnerText,
                        Price = xml.GetElementsByTagName("Item").Item(i)["Price"].InnerText,
                        LastExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExecutedQTY"].InnerText,
                        CurrentExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["CurrentExecutedQTY"].InnerText,
                        TotalExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["TotalExecutedQTY"].InnerText,
                        TotalPrice = xml.GetElementsByTagName("Item").Item(i)["TotalPrice"].InnerText;
                    string xxx = xml.GetElementsByTagName("Item").Item(i)["ExtractItemPK_ID"].InnerText;
                    int SupplierExtractItemID = int.Parse(xxx);

                    DB.Update(TablesNames.Tbl_SupplierExtractItems,
                        new object[]{
                        Tbl_SupplierExtractItems.Fields.Price, decimal.Parse(Price),
                        Tbl_SupplierExtractItems.Fields.LastExecutedQTY, int.Parse(LastExecutedQTY),
                        Tbl_SupplierExtractItems.Fields.CurrentExecutedQTY, int.Parse(CurrentExecutedQTY),
                        Tbl_SupplierExtractItems.Fields.TotalExecutedQTY, int.Parse(TotalExecutedQTY),
                        Tbl_SupplierExtractItems.Fields.TotalPrice, decimal.Parse(TotalPrice)
                        },
                        new object[] { 
                        Tbl_SupplierExtractItems.Fields.PK_ID, SupplierExtractItemID
                        }
                        );
                }
                return SupplierExtractId;
            }
            catch
            {
                return -1;
            }
        }

        [WebMethod]
        public static long SaveSubContractorExtract(string xmlSubContractorExtract)
        {
            try
            {
                DB_OperationProcess DB = new DB_OperationProcess();
                XmlDocument xml = new XmlDocument();
                int SubContractorExractId = (int)DB.NewID(TablesNames.Tbl_SubContractorExtract);
                xml.LoadXml(xmlSubContractorExtract);
                /*
                 * 
                 * 
                xmlSubContractorExtract += "<SubContractorExtractInfo>";
                xmlSubContractorExtract += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlSubContractorExtract += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlSubContractorExtract += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlSubContractorExtract += "<BusinessGuarantee>" + $("#txt_BusinessGuarantee").val() + "</BusinessGuarantee>";
                xmlSubContractorExtract += "<Deductions>" + $("#txt_Deductions").val() + "</Deductions>";
                xmlSubContractorExtract += "<LastPaid>" + $("#txt_LastPaid").val() + "</LastPaid>";
                xmlSubContractorExtract += "<TotalExtractPrice>" + $("#TotalExtractPrice").val() + "</TotalExtractPrice>";
                xmlSubContractorExtract += "<NetDue>" + $("#txt_NetDue").val() + "</NetDue>";
                xmlSubContractorExtract += "<ExractOrder>" + $("#ExtractNumber").html() + "</ExractOrder>";
                xmlSubContractorExtract += "<SubContractorName>" + $("#cbo_SubContractor option:selected").val() + "</SubContractorName>";
                xmlSubContractorExtract += "<SubContractorId>" + $("#cbo_SubContractor").val() + "</SubContractorId>";
                xmlSubContractorExtract += "</SubContractorExtractInfo>";
                 * */
                string
                    ProjectId = xml.GetElementsByTagName("ProjectId").Item(0).InnerText,
                    DateFrom = xml.GetElementsByTagName("DateFrom").Item(0).InnerText,
                    DateTo = xml.GetElementsByTagName("DateTo").Item(0).InnerText,
                    BusinessGuarantee = xml.GetElementsByTagName("BusinessGuarantee").Item(0).InnerText,
                    Deductions = xml.GetElementsByTagName("Deductions").Item(0).InnerText,
                    LastPaid = xml.GetElementsByTagName("LastPaid").Item(0).InnerText,
                    TotalExtractPrice = xml.GetElementsByTagName("TotalExtractPrice").Item(0).InnerText,
                    NetDue = xml.GetElementsByTagName("NetDue").Item(0).InnerText,
                    ExractOrder = xml.GetElementsByTagName("ExractOrder").Item(0).InnerText,
                    SupplierName = xml.GetElementsByTagName("SubContractorName").Item(0).InnerText,
                    SupplierId = xml.GetElementsByTagName("SubContractorId").Item(0).InnerText;

                DB.Insert(TablesNames.Tbl_SubContractorExtract,
                    Tbl_SubContractorExtract.Fields.PK_ID, SubContractorExractId,
                    Tbl_SubContractorExtract.Fields.FK_ProjectID, int.Parse(ProjectId),
                    Tbl_SubContractorExtract.Fields.DateFrom, DateTime.Parse(DateFrom),
                    Tbl_SubContractorExtract.Fields.DateTo, DateTime.Parse(DateTo),
                    Tbl_SubContractorExtract.Fields.BusinessGuarantee, decimal.Parse(BusinessGuarantee),
                    Tbl_SubContractorExtract.Fields.Deductions, decimal.Parse(Deductions),
                    Tbl_SubContractorExtract.Fields.LastPaid, decimal.Parse(LastPaid),
                    Tbl_SubContractorExtract.Fields.ExtractTotalPrice, decimal.Parse(TotalExtractPrice),
                    Tbl_SubContractorExtract.Fields.NetDue, decimal.Parse(NetDue),
                    Tbl_SubContractorExtract.Fields.SubContractorName, SupplierName,
                    Tbl_SubContractorExtract.Fields.SubContractorId, int.Parse(SupplierId),
                    Tbl_SubContractorExtract.Fields.ExractOrder, int.Parse(ExractOrder)
                    );
                //Insert Order Line Items
                for (int i = 0; i < xml.GetElementsByTagName("Item").Count; i++)
                {
                    /*
                     * 
                    xmlSubContractorExtract += "<Item>";
                    xmlSubContractorExtract += "<WorkNameID>" + WorkNameID + "</WorkNameID>";
                    xmlSubContractorExtract += "<WorkName>" + WorkName + "</WorkName>";
                    xmlSubContractorExtract += "<Price>" + Price + "</Price>";
                    xmlSubContractorExtract += "<LastExecutedQTY>" + (parseInt(LastExecutedQTY) + parseInt(CurrentExecutedQTY)) + "</LastExecutedQTY>";
                    xmlSubContractorExtract += "<CurrentExecutedQTY>" + CurrentExecutedQTY + "</CurrentExecutedQTY>";
                    xmlSubContractorExtract += "<TotalExecutedQTY>" + TotalExecutedQTY + "</TotalExecutedQTY>";
                    xmlSubContractorExtract += "<ExchangeRatio>" + ExchangeRatio + "</ExchangeRatio>";
                    xmlSubContractorExtract += "<TotalPrice>" + TotalPrice + "</TotalPrice>";
                    xmlSubContractorExtract += "</Item>";
                     * */
                    string
                        WorkNameID = xml.GetElementsByTagName("Item").Item(i)["WorkNameID"].InnerText,
                        WorkName = xml.GetElementsByTagName("Item").Item(i)["WorkName"].InnerText,
                        Price = xml.GetElementsByTagName("Item").Item(i)["Price"].InnerText,
                        LastExitExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExitExecutedQTY"].InnerText,
                        LastExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExecutedQTY"].InnerText,
                        CurrentExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["CurrentExecutedQTY"].InnerText,
                        TotalExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["TotalExecutedQTY"].InnerText,
                        ExchangeRatio = xml.GetElementsByTagName("Item").Item(i)["ExchangeRatio"].InnerText,
                        TotalPrice = xml.GetElementsByTagName("Item").Item(i)["TotalPrice"].InnerText;

                    int SubContractorExractItemID = (int)DB.NewID(TablesNames.Tbl_SubContractorExtractItems);

                    DB.Insert(TablesNames.Tbl_SubContractorExtractItems,
                        Tbl_SubContractorExtractItems.Fields.PK_ID, SubContractorExractItemID,
                        Tbl_SubContractorExtractItems.Fields.WorkNameID, int.Parse(WorkNameID),
                        Tbl_SubContractorExtractItems.Fields.WorkName, WorkName,
                        Tbl_SubContractorExtractItems.Fields.Price, decimal.Parse(Price),
                        Tbl_SubContractorExtractItems.Fields.LastExitExecutedQTY, int.Parse(LastExitExecutedQTY),
                        Tbl_SubContractorExtractItems.Fields.LastExecutedQTY, int.Parse(LastExecutedQTY),
                        Tbl_SubContractorExtractItems.Fields.CurrentExecutedQTY, int.Parse(CurrentExecutedQTY),
                        Tbl_SubContractorExtractItems.Fields.TotalExecutedQTY, int.Parse(TotalExecutedQTY),
                        Tbl_SubContractorExtractItems.Fields.ExchangeRatio, float.Parse(ExchangeRatio),
                        Tbl_SubContractorExtractItems.Fields.TotalPrice, decimal.Parse(TotalPrice),
                        Tbl_SubContractorExtractItems.Fields.FK_SubContractorExractID, SubContractorExractId
                        );
                }
                return SubContractorExractId;
            }
            catch
            {
                return -1;
            }
        }

        [WebMethod]
        public static long UpdateSubContractorExtract(string xmlSubContractorExtract)
        {
            try
            {
                DB_OperationProcess DB = new DB_OperationProcess();
                XmlDocument xml = new XmlDocument();
                xml.LoadXml(xmlSubContractorExtract);
                int SubContractorExractId = int.Parse(xml.GetElementsByTagName("SubContractorExractPK_ID").Item(0).InnerText);
                /*
                 * 
                 * 
                xmlSubContractorExtract += "<SubContractorExtractInfo>";
                xmlSubContractorExtract += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlSubContractorExtract += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlSubContractorExtract += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlSubContractorExtract += "<BusinessGuarantee>" + $("#txt_BusinessGuarantee").val() + "</BusinessGuarantee>";
                xmlSubContractorExtract += "<Deductions>" + $("#txt_Deductions").val() + "</Deductions>";
                xmlSubContractorExtract += "<LastPaid>" + $("#txt_LastPaid").val() + "</LastPaid>";
                xmlSubContractorExtract += "<TotalExtractPrice>" + $("#TotalExtractPrice").val() + "</TotalExtractPrice>";
                xmlSubContractorExtract += "<NetDue>" + $("#txt_NetDue").val() + "</NetDue>";
                xmlSubContractorExtract += "<ExractOrder>" + $("#ExtractNumber").html() + "</ExractOrder>";
                xmlSubContractorExtract += "<SubContractorName>" + $("#cbo_SubContractor option:selected").val() + "</SubContractorName>";
                xmlSubContractorExtract += "<SubContractorId>" + $("#cbo_SubContractor").val() + "</SubContractorId>";
                xmlSubContractorExtract += "</SubContractorExtractInfo>";
                 * */
                string
                    ProjectId = xml.GetElementsByTagName("ProjectId").Item(0).InnerText,
                    DateFrom = xml.GetElementsByTagName("DateFrom").Item(0).InnerText,
                    DateTo = xml.GetElementsByTagName("DateTo").Item(0).InnerText,
                    BusinessGuarantee = xml.GetElementsByTagName("BusinessGuarantee").Item(0).InnerText,
                    Deductions = xml.GetElementsByTagName("Deductions").Item(0).InnerText,
                    LastPaid = xml.GetElementsByTagName("LastPaid").Item(0).InnerText,
                    TotalExtractPrice = xml.GetElementsByTagName("TotalExtractPrice").Item(0).InnerText,
                    NetDue = xml.GetElementsByTagName("NetDue").Item(0).InnerText,
                    ExractOrder = xml.GetElementsByTagName("ExractOrder").Item(0).InnerText,
                    SupplierName = xml.GetElementsByTagName("SubContractorName").Item(0).InnerText,
                    SupplierId = xml.GetElementsByTagName("SubContractorId").Item(0).InnerText;

                DB.Update(TablesNames.Tbl_SubContractorExtract,
                    new object[]{
                    Tbl_SubContractorExtract.Fields.BusinessGuarantee, decimal.Parse(BusinessGuarantee),
                    Tbl_SubContractorExtract.Fields.Deductions, decimal.Parse(Deductions),
                    Tbl_SubContractorExtract.Fields.LastPaid, decimal.Parse(LastPaid),
                    Tbl_SubContractorExtract.Fields.ExtractTotalPrice, decimal.Parse(TotalExtractPrice),
                    Tbl_SubContractorExtract.Fields.NetDue, decimal.Parse(NetDue),
                    },
                    new object[] { 
                    Tbl_SubContractorExtract.Fields.PK_ID, SubContractorExractId,
                    }
                    );
                //Insert Order Line Items
                for (int i = 0; i < xml.GetElementsByTagName("Item").Count; i++)
                {
                    string
                        WorkNameID = xml.GetElementsByTagName("Item").Item(i)["WorkNameID"].InnerText,
                        WorkName = xml.GetElementsByTagName("Item").Item(i)["WorkName"].InnerText,
                        Price = xml.GetElementsByTagName("Item").Item(i)["Price"].InnerText,
                        LastExitExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExitExecutedQTY"].InnerText,
                        LastExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["LastExecutedQTY"].InnerText,
                        CurrentExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["CurrentExecutedQTY"].InnerText,
                        TotalExecutedQTY = xml.GetElementsByTagName("Item").Item(i)["TotalExecutedQTY"].InnerText,
                        ExchangeRatio = xml.GetElementsByTagName("Item").Item(i)["ExchangeRatio"].InnerText,
                        TotalPrice = xml.GetElementsByTagName("Item").Item(i)["TotalPrice"].InnerText;

                    int SubContractorExractItemID = int.Parse(xml.GetElementsByTagName("Item").Item(i)["ExtractItemPK_ID"].InnerText);

                    DB.Update(TablesNames.Tbl_SubContractorExtractItems,
                        new object[]{
                        Tbl_SubContractorExtractItems.Fields.Price, decimal.Parse(Price),
                        Tbl_SubContractorExtractItems.Fields.LastExitExecutedQTY, int.Parse(LastExitExecutedQTY),
                        Tbl_SubContractorExtractItems.Fields.LastExecutedQTY, int.Parse(LastExecutedQTY),
                        Tbl_SubContractorExtractItems.Fields.CurrentExecutedQTY, int.Parse(CurrentExecutedQTY),
                        Tbl_SubContractorExtractItems.Fields.TotalExecutedQTY, int.Parse(TotalExecutedQTY),
                        Tbl_SubContractorExtractItems.Fields.ExchangeRatio, float.Parse(ExchangeRatio),
                        Tbl_SubContractorExtractItems.Fields.TotalPrice, decimal.Parse(TotalPrice)
                        },
                        new object[] { 
                        Tbl_SubContractorExtractItems.Fields.PK_ID, SubContractorExractItemID
                        });
                }
                return SubContractorExractId;
            }
            catch
            {
                return -1;
            }
        }

        [WebMethod]
        public static long SaveDailyWorkerExtract(string xmlDailyWorkerExtract)
        {
            DB_OperationProcess DB = new DB_OperationProcess();
            try
            {
                DB.StartTransaction();
                XmlDocument xml = new XmlDocument();
                int DailyWorkerExractId = (int)DB.NewID(TablesNames.Tbl_DailyWorkerExtract);
                xml.LoadXml(xmlDailyWorkerExtract);
                string
                    ProjectId = xml.GetElementsByTagName("ProjectId").Item(0).InnerText,
                    DateFrom = xml.GetElementsByTagName("DateFrom").Item(0).InnerText,
                    DateTo = xml.GetElementsByTagName("DateTo").Item(0).InnerText,
                    Deductions = xml.GetElementsByTagName("Deductions").Item(0).InnerText,
                    LastPaid = xml.GetElementsByTagName("LastPaid").Item(0).InnerText,
                    TotalExtractPrice = xml.GetElementsByTagName("TotalExtractPrice").Item(0).InnerText,
                    NetDue = xml.GetElementsByTagName("NetDue").Item(0).InnerText,
                    ExractOrder = xml.GetElementsByTagName("ExractOrder").Item(0).InnerText,
                    WorkerName = xml.GetElementsByTagName("WorkerName").Item(0).InnerText,
                    WorkerId = xml.GetElementsByTagName("WorkerId").Item(0).InnerText;

                DB.Insert(TablesNames.Tbl_DailyWorkerExtract,
                    Tbl_DailyWorkerExtract.Fields.PK_ID, DailyWorkerExractId,
                    Tbl_DailyWorkerExtract.Fields.FK_ProjectID, int.Parse(ProjectId),
                    Tbl_DailyWorkerExtract.Fields.DateFrom, DateTime.Parse(DateFrom),
                    Tbl_DailyWorkerExtract.Fields.DateTo, DateTime.Parse(DateTo),
                    Tbl_DailyWorkerExtract.Fields.Deductions, decimal.Parse(Deductions),
                    Tbl_DailyWorkerExtract.Fields.LastPaid, decimal.Parse(LastPaid),
                    Tbl_DailyWorkerExtract.Fields.ExtractTotalPrice, decimal.Parse(TotalExtractPrice),
                    Tbl_DailyWorkerExtract.Fields.NetDue, decimal.Parse(NetDue),
                    Tbl_DailyWorkerExtract.Fields.WorkerName, WorkerName,
                    Tbl_DailyWorkerExtract.Fields.WorkerId, int.Parse(WorkerId),
                    Tbl_DailyWorkerExtract.Fields.ExractOrder, int.Parse(ExractOrder)
                    );
                //Insert Order Line Items
                for (int i = 0; i < xml.GetElementsByTagName("Item").Count; i++)
                {
                    string
                        WorkDurationName = xml.GetElementsByTagName("Item").Item(i)["WorkDurationName"].InnerText,
                        Price = xml.GetElementsByTagName("Item").Item(i)["Price"].InnerText,
                        TotalDays = xml.GetElementsByTagName("Item").Item(i)["TotalDays"].InnerText,
                        DeductionsDays = xml.GetElementsByTagName("Item").Item(i)["DeductionsDays"].InnerText,
                        NetDays = xml.GetElementsByTagName("Item").Item(i)["NetDays"].InnerText,
                        ExchangeRatio = xml.GetElementsByTagName("Item").Item(i)["ExchangeRatio"].InnerText,
                        TotalPrice = xml.GetElementsByTagName("Item").Item(i)["TotalPrice"].InnerText;

                    int DailyWorkerExractItemID = (int)DB.NewID(TablesNames.Tbl_DailyWorkerExtractItems);

                    DB.Insert(TablesNames.Tbl_DailyWorkerExtractItems,
                        Tbl_DailyWorkerExtractItems.Fields.PK_ID, DailyWorkerExractItemID,
                        Tbl_DailyWorkerExtractItems.Fields.WorkDurationName, WorkDurationName,
                        Tbl_DailyWorkerExtractItems.Fields.Price, decimal.Parse(Price),
                        Tbl_DailyWorkerExtractItems.Fields.TotalDays, int.Parse(TotalDays),
                        Tbl_DailyWorkerExtractItems.Fields.DeductionsDays, int.Parse(DeductionsDays),
                        Tbl_DailyWorkerExtractItems.Fields.NetDays, int.Parse(NetDays),
                        Tbl_DailyWorkerExtractItems.Fields.ExchangeRatio, float.Parse(ExchangeRatio),
                        Tbl_DailyWorkerExtractItems.Fields.TotalPrice, decimal.Parse(TotalPrice),
                        Tbl_DailyWorkerExtractItems.Fields.FK_DailyWorkerExractID, DailyWorkerExractId
                        );

                }
                DB.CommitTransaction();
                return DailyWorkerExractId;
            }
            catch
            {
                DB.RollBackTransaction();
                return -1;
            }
        }

    }
}