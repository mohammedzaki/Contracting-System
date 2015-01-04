using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using N_Tier_Classes.DataAccessLayer;
using N_Tier_Classes.ObjectLayer.ContractingSystem;

namespace Contracting_System
{
    public partial class AddEstimationItems : System.Web.UI.Page
    {
        private DB_OperationProcess DB = new DB_OperationProcess();
        double ItemQTY = 0, ItemBY = 0, Quantity = 0, ItemDevid = 0;

        protected void btn_ImportEstemetion_Click(object sender, EventArgs e)
        {
            this.Security();
            try
            {

                if (Convert.ToInt64(Session["ProjectId"]) > 0)
                {
                    string fileExtension = file1.PostedFile.FileName.Substring(file1.PostedFile.FileName.Length - 4);
                    if (fileExtension == ".xls" || fileExtension == "xlsx")
                    {

                        #region test6

                        //1. Upload File To Server
                        var fileName = Path.GetFileName(file1.PostedFile.FileName);
                        var path = Path.Combine(Server.MapPath("~/temp"), fileName);
                        file1.PostedFile.SaveAs(path);


                        //2. select Data From Excel File
                        string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;";
                        connectionString += "Data Source=" + path.ToString() + ";";
                        connectionString += @"Extended Properties=""Excel 12.0;HDR=YES;""";

                        OleDbConnection objConn = null;
                        objConn = new OleDbConnection(connectionString);

                        objConn.Open();
                        DataTable dt = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                        String[] excelSheets = new String[dt.Rows.Count];

                        int i = 0;

                        foreach (DataRow row in dt.Rows)
                        {

                            excelSheets[i] = row["TABLE_NAME"].ToString();

                            i++;

                        }
                        objConn.Close();

                        string strSQL = "SELECT * FROM [" + excelSheets[0] + "]";
                        OleDbConnection excelConnection = new OleDbConnection(connectionString);
                        excelConnection.Open(); // This code will open excel file.
                        DB.StartTransaction();
                        OleDbCommand dbCommand = new OleDbCommand(strSQL, excelConnection);
                        OleDbDataAdapter dataAdapter = new OleDbDataAdapter(dbCommand);

                        // create data table
                        DataTable dTable = new DataTable();
                        dataAdapter.Fill(dTable);

                        //3. insert Data To DB
                        foreach (DataRow row in dTable.Rows)
                        {
                            if (
                                (object)
                                (DB.ExecuteSqlStatmentQuery(
                                    "select BusinessStatement from Tbl_EstimationItems where BusinessStatement = '" +
                                    row[1].ToString() + "'", DB_OperationProcess.ResultReturnedDataType.Scalar)) == null)
                            {
                                Int64 _ID = DB.NewID(TablesNames.Tbl_EstimationItems);
                                DB.Insert(TablesNames.Tbl_EstimationItems,
                                          Tbl_EstimationItems.Fields.PK_ID, _ID,
                                          Tbl_EstimationItems.Fields.BusinessStatement, row[1].ToString(),
                                          Tbl_EstimationItems.Fields.Unit, row[2].ToString());
                                DB.Insert(TablesNames.Tbl_EstimationItemEquations,
                                    Tbl_EstimationItemEquations.Fields.EquationName, row[1].ToString() + " معادلة",
                                    Tbl_EstimationItemEquations.Fields.FK_EstimationItemID, _ID,
                                    Tbl_EstimationItemEquations.Fields.HasEquationItems, false
                                    );
                            }


                        }

                        DataTable _Tbl_EstimationItems = (DataTable)DB.Select(Tbl_EstimationItems.Fields.ALL);

                        foreach (DataRow row in dTable.Rows)
                        {
                            foreach (DataRow subrow in _Tbl_EstimationItems.Rows)
                            {
                                if (row[1].ToString() == subrow[1].ToString())
                                {
                                    decimal PRICE = 0;
                                    try
                                    {
                                        PRICE = Convert.ToDecimal(row[4]);
                                    }
                                    catch (Exception)
                                    {
                                        PRICE = 0;
                                    }
                                    try
                                    {
                                        DB.Insert(TablesNames.Tbl_ProjectEstimation,
                                                  Tbl_ProjectEstimation.Fields.PK_ID, DB.NewID(TablesNames.Tbl_ProjectEstimation),
                                                  Tbl_ProjectEstimation.Fields.Price, PRICE,
                                                  Tbl_ProjectEstimation.Fields.Quantity, Convert.ToInt16(row[3]),
                                                  Tbl_ProjectEstimation.Fields.Notes, row[5].ToString(),
                                                  Tbl_ProjectEstimation.Fields.FK_ProjectID, Convert.ToInt32(Session["ProjectId"]),
                                                  Tbl_ProjectEstimation.Fields.FK_EstimationItemsID, Convert.ToInt32(subrow[0])
                                            );
                                    }
                                    catch (Exception ex)
                                    { }

                                    break;
                                }
                            }
                        }

                        #region تطبيق المعادلات

                        DataTable HasEstimation = (DataTable)DB.ExecuteSqlStatmentQuery(@"SELECT        Tbl_EstimationItemEquations.PK_ID, Tbl_EstimationItemEquations.FK_EstimationItemID
FROM            Tbl_ProjectEstimation INNER JOIN
                         Tbl_EstimationItems ON Tbl_ProjectEstimation.FK_EstimationItemsID = Tbl_EstimationItems.PK_ID INNER JOIN
                         Tbl_EstimationItemEquations ON Tbl_EstimationItems.PK_ID = Tbl_EstimationItemEquations.FK_EstimationItemID
where Tbl_ProjectEstimation.FK_ProjectID = " + Convert.ToInt32(Session["ProjectId"]) + " and Tbl_EstimationItemEquations.HasEquationItems = 1", DB_OperationProcess.ResultReturnedDataType.Table);
                        if (HasEstimation.Rows.Count > 0)
                        {
                            foreach (DataRow EstimationItemRow in HasEstimation.Rows)
                            {
                                DataTable EstimationItems = (DataTable)DB.ExecuteSqlStatmentQuery("select * from Tbl_EquationItems where FK_EstimationItemEquationID = " + EstimationItemRow[0].ToString(), DB_OperationProcess.ResultReturnedDataType.Table);
                                foreach (DataRow EquationRow in EstimationItems.Rows)
                                {

                                    ItemBY = Convert.ToDouble(EquationRow[3]);
                                    Quantity = Convert.ToDouble(DB.ExecuteSqlStatmentQuery("select Quantity from Tbl_ProjectEstimation where FK_EstimationItemsID =" + EstimationItemRow[1].ToString() + " And FK_ProjectID = " + Convert.ToInt32(Session["ProjectId"]).ToString(), DB_OperationProcess.ResultReturnedDataType.Scalar));
                                    ItemDevid = Convert.ToDouble(EquationRow[4]);

                                    ItemQTY = (ItemBY * Quantity) / ItemDevid;

                                    DB.Insert(TablesNames.Tbl_ProjectSupplies,
                                              Tbl_ProjectSupplies.Fields.PK_ID, DB.NewID(TablesNames.Tbl_ProjectSupplies),
                                              Tbl_ProjectSupplies.Fields.FK_ItemsID, Convert.ToInt32(EquationRow[2]),
                                              Tbl_ProjectSupplies.Fields.FK_ProjectID, Convert.ToInt32(Session["ProjectId"]),
                                              Tbl_ProjectSupplies.Fields.QTY, ItemQTY
                                        );
                                    /*
                                    DB.Insert(TablesNames.Tbl_ProjectSupplies,
                                              Tbl_ProjectSupplies.Fields.PK_ID, DB.NewID(TablesNames.Tbl_ProjectSupplies),
                                              Tbl_ProjectSupplies.Fields.FK_ItemsID, Convert.ToInt32(EquationRow[2]),
                                              Tbl_ProjectSupplies.Fields.FK_ProjectID, Convert.ToInt32(Session["ProjectId"]),
                                              Tbl_ProjectSupplies.Fields.FK_ProjectEstimationItemID, EstimationItemRow["ProjectEstimationID"],
                                              Tbl_ProjectSupplies.Fields.QTY, ItemQTY,
                                              Tbl_ProjectSupplies.Fields.Rest, ItemQTY);*/
                                }
                            }
                        }

                        #endregion

                        DB.CommitTransaction();
                        excelConnection.Close();
                        File.Delete(path);
                        Response.Write("تم الحفظ بنجاح ... من فضلك اضغط على زر العودة للصفحة السابقة");

                        #endregion
                    }
                }
                else
                {
                    Response.Write(" لم يتم حفظ المشروع حتى الان ... برجاء الظغط على زر العودة للصفحة السابقة");

                }
            }
            catch (Exception ex)
            {
                DB.RollBackTransaction();
                Response.Write(ex.Message);
            }
        }
    }
}