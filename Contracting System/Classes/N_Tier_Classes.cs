using N_Tier_Classes.ObjectLayer.ContractingSystem;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Data.SqlClient;

namespace N_Tier_Classes.DataAccessLayer
{
    public class DB_OperationProcess
    {
        #region Fields
        private string _QueryFields = "";
        private string _QueryFieldsAndValues = "";
        private string _QueryFieldsToWhere = "";
        private string _QueryValues = "";
        private List<SqlParameter> _SqlParameters = new List<SqlParameter>();
        private int _IndexOfValues = 0;
        private Enum _CurrentField;
        private static string _ConnectionString = "";
        private string _QueryTables = "";
        private string _FirstTable = "";
        private Type _Type;
        private SqlTransaction _Transaction = null;
        private SqlConnection _Connection = new SqlConnection();
        private SqlConnection _TestConnection = new SqlConnection();
        private bool _TransPeriod = false;
        private List<SqlCommand> _TransactionsCommands = new List<SqlCommand>();
        public static string ServerName = "";
        public static string DatabaseName = "";
        public static string UserID = "";
        public static string UserPassword = "";
        public static bool IntegratedSecurity = true;
        #endregion

        public DB_OperationProcess()
        {
        }

        public static string ConnectionString
        {
            set { _ConnectionString = value; }
            get { return _ConnectionString; }
        }

        #region Transactions
        public void StartTransaction()
        {
            _TransPeriod = true;
            _Connection.ConnectionString = _ConnectionString;
            _Connection.Open();
            _Transaction = _Connection.BeginTransaction(IsolationLevel.Serializable);
        }
        public void CommitTransaction()
        {
            _Transaction.Commit();
            _Connection.Close();
            _Connection.ConnectionString = "";
            _TransactionsCommands.Clear();
            _TransPeriod = false;
        }
        public void RollBackTransaction()
        {
            if (_TransPeriod == true)
                _Transaction.Rollback();
            _Connection.Close();
            _Connection.ConnectionString = "";
            _TransactionsCommands.Clear();
            _TransPeriod = false;
        }
        #endregion

        public bool TestConnection()
        {
            //try
            //{
            _TestConnection.ConnectionString = ConnectionString;
            _TestConnection.Open();
            _TestConnection.Close();
            return true;
            //}
            //catch (Exception)
            //{
            //    //MessageBox.Show("ãä ÝÖáß ÊÃßÏ ÇáÇÊÕÇá ÈÇáÔÈßÉ Çæ ÞÇÚÏÉ ÇáÈíÇäÇÊ", "Connection Failer", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);

            //    return false;
            //}
        }

        public bool CheckExist(string DatabaseName)
        {
            if (ExecuteSqlStatmentQuery(@"select name from sys.databases where name = '" + DatabaseName + "'", ResultReturnedDataType.Scalar) == null)
                return false;
            else
                return true;
        }

        //public bool CreateDatabase(string ServerName, string DatabaseScript)
        //{
        //    SqlConnection masterConnection = new SqlConnection(@"Data Source=" + ServerName + ";Initial Catalog=master;Integrated Security=True");
        //    SqlCommand command;
        //    try
        //    {
        //        masterConnection.Open();
        //        string[] commands = DatabaseScript.Split(
        //            new string[] { "GO\r\n", "GO ", "GO\t" }, StringSplitOptions.RemoveEmptyEntries);
        //        foreach (string c in commands)
        //        {
        //            command = new SqlCommand(c, masterConnection);
        //            command.ExecuteNonQuery();
        //        }
        //        masterConnection.Close();
        //        return true;
        //    }
        //    catch (Exception exp)
        //    {
        //        masterConnection.Close();
        //        MessageBox.Show(exp.Message);
        //        return false;
        //    }
        //}

        //public bool CreateDatabase(string ServerName, string UserName, string Password, string DatabaseScript)
        //{
        //    SqlConnection masterConnection = new SqlConnection(@"Data Source=" + ServerName + ";Initial Catalog=master;User Id=" + UserName + ";Password=" + Password + ";");
        //    SqlCommand command;
        //    try
        //    {
        //        masterConnection.Open();
        //        string[] commands = DatabaseScript.Split(
        //            new string[] { "GO\r\n", "GO ", "GO\t" }, StringSplitOptions.RemoveEmptyEntries);
        //        foreach (string c in commands)
        //        {
        //            command = new SqlCommand(c, masterConnection);
        //            command.ExecuteNonQuery();
        //        }
        //        masterConnection.Close();
        //        return true;
        //    }
        //    catch (Exception exp)
        //    {
        //        masterConnection.Close();
        //        MessageBox.Show(exp.Message);
        //        return false;
        //    }
        //}

        public enum ResultReturnedDataType
        {
            Table,
            Column,
            Row,
            Scalar,
            NumberOfRowsAffected,
            DataSet
        }

        public virtual object ExecuteSqlStatmentQuery(string SqlQureyStatment, ResultReturnedDataType ReturnType)
        {
            object Result = null;
            try
            {
                if (_TransPeriod == false)
                {
                    _Connection.ConnectionString = _ConnectionString;
                    _Connection.Open();
                }
                _TransactionsCommands.Add(new SqlCommand(SqlQureyStatment, _Connection));
                if (_SqlParameters.Count > 0)
                {
                    foreach (SqlParameter CurrentPar in _SqlParameters)
                    {
                        _TransactionsCommands[_TransactionsCommands.Count - 1].Parameters.Add(CurrentPar);
                    }
                }
                DataSet Dataset = new DataSet();
                SqlDataAdapter DataReader = new SqlDataAdapter();
                SqlCommandBuilder sqlbuilder = new SqlCommandBuilder();
                if (_TransPeriod)
                {
                    _TransactionsCommands[_TransactionsCommands.Count - 1].Transaction = _Transaction;
                    //command.Transaction = transaction;
                }
                switch (ReturnType)
                {
                    case ResultReturnedDataType.Table:
                        DataReader = new SqlDataAdapter(_TransactionsCommands[_TransactionsCommands.Count - 1]);
                        sqlbuilder = new SqlCommandBuilder(DataReader);
                        DataReader.Fill(Dataset);
                        Result = Dataset.Tables[0];
                        break;
                    case ResultReturnedDataType.Column:
                        DataReader = new SqlDataAdapter(_TransactionsCommands[_TransactionsCommands.Count - 1]);
                        sqlbuilder = new SqlCommandBuilder(DataReader);
                        DataReader.Fill(Dataset);
                        Result = Dataset.Tables[0].Columns[0];
                        break;
                    case ResultReturnedDataType.Row:
                        DataReader = new SqlDataAdapter(_TransactionsCommands[_TransactionsCommands.Count - 1]);
                        sqlbuilder = new SqlCommandBuilder(DataReader);
                        DataReader.Fill(Dataset);
                        if (Dataset.Tables[0].Rows.Count > 0)
                            Result = Dataset.Tables[0].Rows[0];
                        else
                            Result = null;
                        break;
                    case ResultReturnedDataType.Scalar:
                        Result = _TransactionsCommands[_TransactionsCommands.Count - 1].ExecuteScalar();
                        break;
                    case ResultReturnedDataType.NumberOfRowsAffected:
                        Result = _TransactionsCommands[_TransactionsCommands.Count - 1].ExecuteNonQuery();
                        break;
                    case ResultReturnedDataType.DataSet:
                        DataReader = new SqlDataAdapter(_TransactionsCommands[_TransactionsCommands.Count - 1]);
                        sqlbuilder = new SqlCommandBuilder(DataReader);
                        DataReader.Fill(Dataset);
                        Result = Dataset;
                        break;
                }
                if (_TransPeriod == false)
                {
                    _Connection.Close();
                    _Connection.ConnectionString = "";
                    _TransactionsCommands.Clear();
                }

            }
            catch (Exception Exp)
            {
                //_Connection.Close();
                //_Connection.ConnectionString = "";
                //RollBackTransaction();
                //Result = null;
                throw Exp;
            }
            _QueryValues = "";
            if (_SqlParameters.Count > 0)
                _SqlParameters.Clear();
            _QueryFieldsAndValues = "";
            _QueryFieldsToWhere = "";
            _QueryFields = "";
            _QueryTables = "";
            _FirstTable = "";
            _IndexOfValues = 0;
            return Result;
        }

        public virtual object ExecuteSqlStored(string SqlQureyStatment, ResultReturnedDataType ReturnType)
        {
            object Result = null;
            try
            {
                if (_TransPeriod == false)
                {
                    _Connection.ConnectionString = _ConnectionString;
                    _Connection.Open();
                }
                _TransactionsCommands.Add(new SqlCommand(SqlQureyStatment, _Connection));
                _TransactionsCommands[_TransactionsCommands.Count - 1].CommandType = CommandType.StoredProcedure;
                if (_SqlParameters.Count > 0)
                {
                    /*foreach (SqlParameter CurrentPar in _SqlParameters)
                    {
                        _TransactionsCommands[_TransactionsCommands.Count - 1].Parameters.Add(CurrentPar);
                    }*/
                    _TransactionsCommands[_TransactionsCommands.Count - 1].Parameters.AddRange(_SqlParameters.ToArray());
                }
                DataSet Dataset = new DataSet();
                SqlDataAdapter DataReader = new SqlDataAdapter();
                SqlCommandBuilder sqlbuilder = new SqlCommandBuilder();
                if (_TransPeriod)
                {
                    _TransactionsCommands[_TransactionsCommands.Count - 1].Transaction = _Transaction;
                    //command.Transaction = transaction;
                }
                switch (ReturnType)
                {
                    case ResultReturnedDataType.Table:
                        DataReader = new SqlDataAdapter(_TransactionsCommands[_TransactionsCommands.Count - 1]);
                        sqlbuilder = new SqlCommandBuilder(DataReader);
                        DataReader.Fill(Dataset);
                        Result = Dataset.Tables[0];
                        break;
                    case ResultReturnedDataType.Column:
                        DataReader = new SqlDataAdapter(_TransactionsCommands[_TransactionsCommands.Count - 1]);
                        sqlbuilder = new SqlCommandBuilder(DataReader);
                        DataReader.Fill(Dataset);
                        Result = Dataset.Tables[0].Columns[0];
                        break;
                    case ResultReturnedDataType.Row:
                        DataReader = new SqlDataAdapter(_TransactionsCommands[_TransactionsCommands.Count - 1]);
                        sqlbuilder = new SqlCommandBuilder(DataReader);
                        DataReader.Fill(Dataset);
                        if (Dataset.Tables[0].Rows.Count > 0)
                            Result = Dataset.Tables[0].Rows[0];
                        else
                            Result = null;
                        break;
                    case ResultReturnedDataType.Scalar:
                        Result = _TransactionsCommands[_TransactionsCommands.Count - 1].ExecuteScalar();
                        break;
                    case ResultReturnedDataType.NumberOfRowsAffected:
                        Result = _TransactionsCommands[_TransactionsCommands.Count - 1].ExecuteNonQuery();
                        break;
                    case ResultReturnedDataType.DataSet:
                        DataReader = new SqlDataAdapter(_TransactionsCommands[_TransactionsCommands.Count - 1]);
                        sqlbuilder = new SqlCommandBuilder(DataReader);
                        DataReader.Fill(Dataset);
                        Result = Dataset;
                        break;
                }
                if (_TransPeriod == false)
                {
                    _Connection.Close();
                    _Connection.ConnectionString = "";
                    _TransactionsCommands.Clear();
                }

            }
            catch (Exception Exp)
            {
                //_Connection.Close();
                //_Connection.ConnectionString = "";
                //RollBackTransaction();
                //Result = null;
                throw Exp;
            }
            _QueryValues = "";
            if (_SqlParameters.Count > 0)
                _SqlParameters.Clear();
            _QueryFieldsAndValues = "";
            _QueryFieldsToWhere = "";
            _QueryFields = "";
            _QueryTables = "";
            _FirstTable = "";
            _IndexOfValues = 0;
            return Result;
        }

        public virtual long NewID()
        {
            DataTable myTable = (DataTable)ExecuteSqlStatmentQuery("SELECT PK_ID from " + this.GetType().Name, ResultReturnedDataType.Table);
            if (myTable.Rows.Count == 0)
                return 1;
            else
                return Convert.ToInt64(ExecuteSqlStatmentQuery("SELECT MAX(PK_ID) from " + this.GetType().Name, ResultReturnedDataType.Scalar)) + 1;
        }

        public virtual long NewID(TablesNames TableName)
        {
            DataTable myTable = (DataTable)ExecuteSqlStatmentQuery("SELECT * from " + TableName.ToString(), ResultReturnedDataType.Table);
            if (myTable.Rows.Count == 0)
                return 1;
            else
                return Convert.ToInt64(ExecuteSqlStatmentQuery("SELECT MAX(PK_ID) from " + TableName.ToString(), ResultReturnedDataType.Scalar)) + 1;
        }

        public virtual long GetMaxID(TablesNames TableName)
        {
            DataTable myTable = (DataTable)ExecuteSqlStatmentQuery("SELECT * from " + TableName.ToString(), ResultReturnedDataType.Table);
            if (myTable.Rows.Count == 0)
                return 0;
            else
                return Convert.ToInt64(ExecuteSqlStatmentQuery("SELECT MAX(PK_ID) from " + TableName.ToString(), ResultReturnedDataType.Scalar));
        }

        public int MaxID
        {
            get
            {
                DataTable myTable = (DataTable)ExecuteSqlStatmentQuery("SELECT PK_ID from " + this.GetType().Name, ResultReturnedDataType.Table);
                if (myTable.Rows.Count == 0)
                    return 0;
                else
                    return Convert.ToInt32(ExecuteSqlStatmentQuery("SELECT MAX(PK_ID) from " + this.GetType().Name, ResultReturnedDataType.Scalar));
                //return -1;
            }
        }

        public virtual object Delete(TablesNames TableName, params object[] Fields)
        {
            foreach (var field in Fields)
            {
                try
                {
                    _CurrentField = (Enum)field;
                }
                catch (Exception)
                {
                    if (_QueryFieldsToWhere == "")
                    {
                        if (field.GetType() == typeof(String))
                            _QueryFieldsToWhere += " " + Fields[_IndexOfValues - 1].ToString() + " = " + "'" + field + "'" + " ";
                        else
                            _QueryFieldsToWhere += " " + Fields[_IndexOfValues - 1].ToString() + " = " + field + " ";
                    }
                    else
                    {
                        if (field.GetType() == typeof(String))
                            _QueryFieldsToWhere += " and " + Fields[_IndexOfValues - 1].ToString() + " = " + "'" + field + "'" + " ";
                        else
                            _QueryFieldsToWhere += " and " + Fields[_IndexOfValues - 1].ToString() + " = " + field + " ";
                    }
                }
                _IndexOfValues++;
            }
            return ExecuteSqlStatmentQuery("DELETE FROM " + TableName.ToString() + " WHERE " + _QueryFieldsToWhere, ResultReturnedDataType.NumberOfRowsAffected);
        }

        public virtual object DeleteALL(TablesNames TableName)
        {
            return ExecuteSqlStatmentQuery("DELETE FROM " + TableName.ToString(), ResultReturnedDataType.NumberOfRowsAffected);
        }

        public virtual object Select(params object[] Fields)
        {
            _FirstTable = Fields[0].GetType().DeclaringType.Name;
            _QueryTables += " , " + _FirstTable;
            foreach (var field in Fields)
            {
                if (field.GetType().BaseType == typeof(Enum))
                {
                    _CurrentField = (Enum)field;
                    _Type = field.GetType().DeclaringType;
                    if (field.ToString() == "ALL")
                    {
                        _QueryFields += " , * ";
                    }
                    else
                    {
                        _QueryFields += " , " + field.ToString() + " ";
                    }

                    if (_Type.Name != _FirstTable)
                    {
                        _QueryTables += " , " + _Type.Name;
                    }
                }
                else
                {
                    _QueryValues += " and " + _CurrentField + " = " + " @Where" + _CurrentField;
                    AddSqlParameter("@Where" + _CurrentField, field);
                }
                _IndexOfValues++;
            }
            if (_QueryTables.StartsWith(" ,"))
                _QueryTables = _QueryTables.Remove(1, 1);
            if (_QueryFields.StartsWith(" ,"))
                _QueryFields = _QueryFields.Remove(1, 1);
            if (_QueryValues.StartsWith(" and "))
                _QueryValues = _QueryValues.Remove(1, 3);

            if (_QueryValues == "")
                return ExecuteSqlStatmentQuery(@"select " + _QueryFields + " from " + _QueryTables, ResultReturnedDataType.Table);
            else
                return ExecuteSqlStatmentQuery(@"select " + _QueryFields + " from " + _QueryTables + " Where " + _QueryValues, ResultReturnedDataType.Table);
        }

        public virtual object SelectScalar(params object[] Fields)
        {
            _FirstTable = Fields[0].GetType().DeclaringType.Name;
            foreach (var field in Fields)
            {
                if (field.GetType().BaseType == typeof(Enum))
                {
                    _CurrentField = (Enum)field;
                    _Type = field.GetType().DeclaringType;
                    if (field.ToString() == "ALL")
                    {
                        _QueryFields += " , * ";
                    }
                    else
                    {
                        _QueryFields += " , " + field.ToString() + " ";
                    }

                    if (_Type.Name != _FirstTable)
                        _QueryTables += " , " + _Type.Name;
                }
                else
                {
                    _QueryValues += " and " + _CurrentField + " = " + " @Where" + _CurrentField;
                    AddSqlParameter("@Where" + _CurrentField, field);
                }
                _IndexOfValues++;
            }

            _QueryTables = _QueryTables.Remove(1, 1);
            _QueryFields = _QueryFields.Remove(1, 1);
            _QueryValues = _QueryValues.Remove(1, 3);

            if (_QueryValues == "")
                return ExecuteSqlStatmentQuery(@"select " + _QueryFields + " from " + _QueryTables, ResultReturnedDataType.Scalar);
            else
                return ExecuteSqlStatmentQuery(@"select " + _QueryFields + " from " + _QueryTables + " Where " + _QueryValues, ResultReturnedDataType.Scalar);
        }

        public virtual object Update(TablesNames TableName, object[] UserFieldsAndValues, object[] FieldsToWhere)
        {
            #region FieldsAndValues
            foreach (var field in UserFieldsAndValues)
            {
                if (field.GetType().BaseType == typeof(Enum))
                {
                    _CurrentField = (Enum)field;
                }
                else
                {
                    _QueryFieldsAndValues += " , " + _CurrentField + " = @" + _CurrentField;
                    AddSqlParameter("@" + _CurrentField, field);
                }
                _IndexOfValues++;
            }
            #endregion

            #region FieldsToWhere
            _IndexOfValues = 0;
            foreach (var field in FieldsToWhere)
            {
                if (field.GetType().BaseType == typeof(Enum))
                {
                    _CurrentField = (Enum)field;
                }
                else
                {
                    _QueryFieldsToWhere += " and " + _CurrentField + " = " + " @Where" + _CurrentField;
                    AddSqlParameter("@Where" + _CurrentField, field);
                }
                _IndexOfValues++;
            }
            #endregion

            _QueryFieldsAndValues = _QueryFieldsAndValues.Remove(1, 1);
            _QueryFieldsToWhere = _QueryFieldsToWhere.Remove(1, 3);

            return ExecuteSqlStatmentQuery(@"UPDATE " + TableName.ToString() + " SET " + _QueryFieldsAndValues + " WHERE " + _QueryFieldsToWhere, ResultReturnedDataType.NumberOfRowsAffected);
        }

        public void AddSqlParameter(string Name, object value)
        {
            _SqlParameters.Add(new SqlParameter(Name, value));
        }

        public virtual object Insert(TablesNames TableName, params object[] FieldsAndValues)
        {
            foreach (var field in FieldsAndValues)
            {
                if (field.GetType().BaseType == typeof(Enum))
                {
                    _CurrentField = (Enum)field;
                    _QueryFields += " , " + field.ToString() + " ";
                }
                else
                {
                    _QueryValues += " , @" + _CurrentField;
                    AddSqlParameter("@" + _CurrentField, field);
                }
                _IndexOfValues++;
            }
            _QueryFields = _QueryFields.Remove(1, 1);
            _QueryValues = _QueryValues.Remove(1, 1);
            return ExecuteSqlStatmentQuery(@"INSERT INTO " + TableName.ToString() + " ( " + _QueryFields + " )VALUES ( " + _QueryValues + " )", ResultReturnedDataType.NumberOfRowsAffected); ;
        }

    }
}
namespace N_Tier_Classes.ObjectLayer
{
    namespace ContractingSystem
    {
        using N_Tier_Classes.DataAccessLayer;

        public enum TablesNames
        {
            Tbl_Category,
            Tbl_CompanyExract,
            Tbl_CompanyExractItems,
            Tbl_DailyWorker,
            Tbl_DailyWorkerExtract,
            Tbl_DailyWorkerExtractItems,
            Tbl_DailyWorkerTime,
            Tbl_Employees,
            Tbl_EquationItems,
            Tbl_EstimationItemEquations,
            Tbl_EstimationItems,
            TestTableVariable,
            Tbl_ExpensesCategories,
            Tbl_ExpensesItems,
            Tbl_GuardianshipItems,
            Tbl_Items,
            Tbl_MeasurementUnit,
            Tbl_Pages,
            Tbl_Project,
            Tbl_ProjectDailyWorker,
            Tbl_ProjectEmployees,
            Tbl_ProjectEstimation,
            Tbl_ProjectGuardianship,
            Tbl_ProjectSaverDeposits,
            Tbl_ProjectSubContractor,
            Tbl_ProjectSupplies,
            Tbl_RolePermissions,
            Tbl_Roles,
            Tbl_SaverAmountActions,
            Tbl_SaverCategory,
            Tbl_SaverItems,
            Tbl_Savers,
            Tbl_Subcontractor,
            Tbl_SubContractorExtract,
            Tbl_SubContractorExtractItems,
            Tbl_SubContractorWorks,
            Tbl_Supplier,
            Tbl_SupplierExtract,
            Tbl_SupplierExtractItems,
            Tbl_SupplierSupplies,
            Tbl_SuppliesEvent,
            Tbl_WorkCategories,
            Tbl_WorkType,
            View_AddedStimation,
            View_CompanyExtract,
            View_CompanyExtractNewOrder,
            View_DailySuppliesbook,
            View_DailyWorkerExract,
            View_DailyWorkerExtractNewOrder,
            View_EmpolyeePaid,
            View_Guradianship,
            View_ProjectContractor,
            View_ProjectDeposits,
            View_ProjectEstimation,
            View_ProjectGurdianship,
            View_ProjectSuppliers,
            View_ProjectSupplies,
            View_ProjectWorker,
            View_Security,
            View_SubContractorExtract,
            View_SubContractorExtractNewOrder,
            view_subcontractorWork,
            View_SubContractorWorkNames,
            View_SupplierExtract,
            View_SupplierExtractNewOrder,
        }
        public class Tbl_Category
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_CompanyExract
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                ExractOrder,
                FK_ProjectID,
                ExtractTotalPrice,
                LastPaid,
                Deductions,
                BusinessGuarantee,
                NetDue,
                Supervisor,
                DateFrom,
                DateTo,
            }

            #region Fields
            private int _PK_ID;
            private int _ExractOrder;
            private int _FK_ProjectID;
            private decimal _ExtractTotalPrice;
            private decimal _LastPaid;
            private decimal _Deductions;
            private decimal _BusinessGuarantee;
            private decimal _NetDue;
            private string _Supervisor;
            private string _DateFrom;
            private string _DateTo;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int ExractOrder
            {
                get { return this._ExractOrder; }
                set { this._ExractOrder = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public decimal ExtractTotalPrice
            {
                get { return this._ExtractTotalPrice; }
                set { this._ExtractTotalPrice = value; }
            }
            public decimal LastPaid
            {
                get { return this._LastPaid; }
                set { this._LastPaid = value; }
            }
            public decimal Deductions
            {
                get { return this._Deductions; }
                set { this._Deductions = value; }
            }
            public decimal BusinessGuarantee
            {
                get { return this._BusinessGuarantee; }
                set { this._BusinessGuarantee = value; }
            }
            public decimal NetDue
            {
                get { return this._NetDue; }
                set { this._NetDue = value; }
            }
            public string Supervisor
            {
                get { return this._Supervisor; }
                set { this._Supervisor = value; }
            }
            public string DateFrom
            {
                get { return this._DateFrom; }
                set { this._DateFrom = value; }
            }
            public string DateTo
            {
                get { return this._DateTo; }
                set { this._DateTo = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_CompanyExractItems
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                EstimationName,
                EstimationQTY,
                ProjectEstimationID,
                Price,
                Unit,
                LastExitExecutedQTY,
                LastExecutedQTY,
                CurrentExecutedQTY,
                TotalExecutedQTY,
                TotalPrice,
                FK_CompanyExractID,
            }

            #region Fields
            private int _PK_ID;
            private string _EstimationName;
            private string _EstimationQTY;
            private int _ProjectEstimationID;
            private decimal _Price;
            private int _Unit;
            private int _LastExitExecutedQTY;
            private int _LastExecutedQTY;
            private int _CurrentExecutedQTY;
            private int _TotalExecutedQTY;
            private decimal _TotalPrice;
            private int _FK_CompanyExractID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string EstimationName
            {
                get { return this._EstimationName; }
                set { this._EstimationName = value; }
            }
            public string EstimationQTY
            {
                get { return this._EstimationQTY; }
                set { this._EstimationQTY = value; }
            }
            public int ProjectEstimationID
            {
                get { return this._ProjectEstimationID; }
                set { this._ProjectEstimationID = value; }
            }
            public decimal Price
            {
                get { return this._Price; }
                set { this._Price = value; }
            }
            public int Unit
            {
                get { return this._Unit; }
                set { this._Unit = value; }
            }
            public int LastExitExecutedQTY
            {
                get { return this._LastExitExecutedQTY; }
                set { this._LastExitExecutedQTY = value; }
            }
            public int LastExecutedQTY
            {
                get { return this._LastExecutedQTY; }
                set { this._LastExecutedQTY = value; }
            }
            public int CurrentExecutedQTY
            {
                get { return this._CurrentExecutedQTY; }
                set { this._CurrentExecutedQTY = value; }
            }
            public int TotalExecutedQTY
            {
                get { return this._TotalExecutedQTY; }
                set { this._TotalExecutedQTY = value; }
            }
            public decimal TotalPrice
            {
                get { return this._TotalPrice; }
                set { this._TotalPrice = value; }
            }
            public int FK_CompanyExractID
            {
                get { return this._FK_CompanyExractID; }
                set { this._FK_CompanyExractID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_DailyWorker
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                Mobile,
                WorkerID,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private string _Mobile;
            private string _WorkerID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public string Mobile
            {
                get { return this._Mobile; }
                set { this._Mobile = value; }
            }
            public string WorkerID
            {
                get { return this._WorkerID; }
                set { this._WorkerID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_DailyWorkerExtract
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ProjectID,
                ExractOrder,
                ExtractTotalPrice,
                LastPaid,
                Deductions,
                NetDue,
                WorkerId,
                WorkerName,
                DateFrom,
                DateTo,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ProjectID;
            private int _ExractOrder;
            private decimal _ExtractTotalPrice;
            private decimal _LastPaid;
            private decimal _Deductions;
            private decimal _NetDue;
            private int _WorkerId;
            private string _WorkerName;
            private string _DateFrom;
            private string _DateTo;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int ExractOrder
            {
                get { return this._ExractOrder; }
                set { this._ExractOrder = value; }
            }
            public decimal ExtractTotalPrice
            {
                get { return this._ExtractTotalPrice; }
                set { this._ExtractTotalPrice = value; }
            }
            public decimal LastPaid
            {
                get { return this._LastPaid; }
                set { this._LastPaid = value; }
            }
            public decimal Deductions
            {
                get { return this._Deductions; }
                set { this._Deductions = value; }
            }
            public decimal NetDue
            {
                get { return this._NetDue; }
                set { this._NetDue = value; }
            }
            public int WorkerId
            {
                get { return this._WorkerId; }
                set { this._WorkerId = value; }
            }
            public string WorkerName
            {
                get { return this._WorkerName; }
                set { this._WorkerName = value; }
            }
            public string DateFrom
            {
                get { return this._DateFrom; }
                set { this._DateFrom = value; }
            }
            public string DateTo
            {
                get { return this._DateTo; }
                set { this._DateTo = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_DailyWorkerExtractItems
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                WorkDurationName,
                Price,
                ExchangeRatio,
                TotalDays,
                DeductionsDays,
                NetDays,
                TotalPrice,
                FK_DailyWorkerExractID,
            }

            #region Fields
            private int _PK_ID;
            private string _WorkDurationName;
            private decimal _Price;
            private int _ExchangeRatio;
            private int _TotalDays;
            private int _DeductionsDays;
            private int _NetDays;
            private decimal _TotalPrice;
            private int _FK_DailyWorkerExractID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string WorkDurationName
            {
                get { return this._WorkDurationName; }
                set { this._WorkDurationName = value; }
            }
            public decimal Price
            {
                get { return this._Price; }
                set { this._Price = value; }
            }
            public int ExchangeRatio
            {
                get { return this._ExchangeRatio; }
                set { this._ExchangeRatio = value; }
            }
            public int TotalDays
            {
                get { return this._TotalDays; }
                set { this._TotalDays = value; }
            }
            public int DeductionsDays
            {
                get { return this._DeductionsDays; }
                set { this._DeductionsDays = value; }
            }
            public int NetDays
            {
                get { return this._NetDays; }
                set { this._NetDays = value; }
            }
            public decimal TotalPrice
            {
                get { return this._TotalPrice; }
                set { this._TotalPrice = value; }
            }
            public int FK_DailyWorkerExractID
            {
                get { return this._FK_DailyWorkerExractID; }
                set { this._FK_DailyWorkerExractID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_DailyWorkerTime
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ProjectDailyWorker,
                WorkStartDate,
                WorkEndDate,
                WorkWageDay,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ProjectDailyWorker;
            private string _WorkStartDate;
            private string _WorkEndDate;
            private decimal _WorkWageDay;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectDailyWorker
            {
                get { return this._FK_ProjectDailyWorker; }
                set { this._FK_ProjectDailyWorker = value; }
            }
            public string WorkStartDate
            {
                get { return this._WorkStartDate; }
                set { this._WorkStartDate = value; }
            }
            public string WorkEndDate
            {
                get { return this._WorkEndDate; }
                set { this._WorkEndDate = value; }
            }
            public decimal WorkWageDay
            {
                get { return this._WorkWageDay; }
                set { this._WorkWageDay = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_Employees
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                Mobile,
                ID,
                Salary,
                JobName,
                UserName,
                Password,
                FK_RoleID,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private string _Mobile;
            private string _ID;
            private decimal _Salary;
            private string _JobName;
            private string _UserName;
            private string _Password;
            private int _FK_RoleID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public string Mobile
            {
                get { return this._Mobile; }
                set { this._Mobile = value; }
            }
            public string ID
            {
                get { return this._ID; }
                set { this._ID = value; }
            }
            public decimal Salary
            {
                get { return this._Salary; }
                set { this._Salary = value; }
            }
            public string JobName
            {
                get { return this._JobName; }
                set { this._JobName = value; }
            }
            public string UserName
            {
                get { return this._UserName; }
                set { this._UserName = value; }
            }
            public string Password
            {
                get { return this._Password; }
                set { this._Password = value; }
            }
            public int FK_RoleID
            {
                get { return this._FK_RoleID; }
                set { this._FK_RoleID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_EquationItems
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_EstimationItemEquationID,
                FK_ItemID,
                ItemBY,
                ItemDevid,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_EstimationItemEquationID;
            private int _FK_ItemID;
            private decimal _ItemBY;
            private decimal _ItemDevid;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_EstimationItemEquationID
            {
                get { return this._FK_EstimationItemEquationID; }
                set { this._FK_EstimationItemEquationID = value; }
            }
            public int FK_ItemID
            {
                get { return this._FK_ItemID; }
                set { this._FK_ItemID = value; }
            }
            public decimal ItemBY
            {
                get { return this._ItemBY; }
                set { this._ItemBY = value; }
            }
            public decimal ItemDevid
            {
                get { return this._ItemDevid; }
                set { this._ItemDevid = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_EstimationItemEquations
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                EquationName,
                FK_EstimationItemID,
                HasEquationItems,
            }

            #region Fields
            private int _PK_ID;
            private string _EquationName;
            private int _FK_EstimationItemID;
            private string _HasEquationItems;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string EquationName
            {
                get { return this._EquationName; }
                set { this._EquationName = value; }
            }
            public int FK_EstimationItemID
            {
                get { return this._FK_EstimationItemID; }
                set { this._FK_EstimationItemID = value; }
            }
            public string HasEquationItems
            {
                get { return this._HasEquationItems; }
                set { this._HasEquationItems = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_EstimationItems
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                BusinessStatement,
                Unit,
            }

            #region Fields
            private int _PK_ID;
            private string _BusinessStatement;
            private string _Unit;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string BusinessStatement
            {
                get { return this._BusinessStatement; }
                set { this._BusinessStatement = value; }
            }
            public string Unit
            {
                get { return this._Unit; }
                set { this._Unit = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class TestTableVariable
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                ID,
                Name,
                Addr,
            }

            #region Fields
            private int _ID;
            private string _Name;
            private string _Addr;
            #endregion

            #region Properties
            public int ID
            {
                get { return this._ID; }
                set { this._ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public string Addr
            {
                get { return this._Addr; }
                set { this._Addr = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_ExpensesCategories
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_ExpensesItems
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                FK_ExpenseCategory,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private int _FK_ExpenseCategory;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public int FK_ExpenseCategory
            {
                get { return this._FK_ExpenseCategory; }
                set { this._FK_ExpenseCategory = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_GuardianshipItems
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ProjectGuardianshipID,
                Amount,
                FK_ExpenseItemID,
                PersonID,
                PersonTypeID,
                Date,
                WorkTypeId,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ProjectGuardianshipID;
            private decimal _Amount;
            private int _FK_ExpenseItemID;
            private int _PersonID;
            private int _PersonTypeID;
            private string _Date;
            private int _WorkTypeId;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectGuardianshipID
            {
                get { return this._FK_ProjectGuardianshipID; }
                set { this._FK_ProjectGuardianshipID = value; }
            }
            public decimal Amount
            {
                get { return this._Amount; }
                set { this._Amount = value; }
            }
            public int FK_ExpenseItemID
            {
                get { return this._FK_ExpenseItemID; }
                set { this._FK_ExpenseItemID = value; }
            }
            public int PersonID
            {
                get { return this._PersonID; }
                set { this._PersonID = value; }
            }
            public int PersonTypeID
            {
                get { return this._PersonTypeID; }
                set { this._PersonTypeID = value; }
            }
            public string Date
            {
                get { return this._Date; }
                set { this._Date = value; }
            }
            public int WorkTypeId
            {
                get { return this._WorkTypeId; }
                set { this._WorkTypeId = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_Items
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_CategoryID,
                ItemType,
                FK_MeasurementUnitID,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_CategoryID;
            private string _ItemType;
            private int _FK_MeasurementUnitID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_CategoryID
            {
                get { return this._FK_CategoryID; }
                set { this._FK_CategoryID = value; }
            }
            public string ItemType
            {
                get { return this._ItemType; }
                set { this._ItemType = value; }
            }
            public int FK_MeasurementUnitID
            {
                get { return this._FK_MeasurementUnitID; }
                set { this._FK_MeasurementUnitID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_MeasurementUnit
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Unit,
            }

            #region Fields
            private int _PK_ID;
            private string _Unit;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Unit
            {
                get { return this._Unit; }
                set { this._Unit = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_Pages
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                PageName,
                ArabicName,
            }

            #region Fields
            private int _PK_ID;
            private string _PageName;
            private string _ArabicName;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string PageName
            {
                get { return this._PageName; }
                set { this._PageName = value; }
            }
            public string ArabicName
            {
                get { return this._ArabicName; }
                set { this._ArabicName = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_Project
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                Supervisor,
                ProjectPeriodPerMonth,
                StartDate,
                EndDate,
                DateOfReceiptOfTheSite,
                TechnicalOpenDate,
                ProjectCost,
                IsActive,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private string _Supervisor;
            private int _ProjectPeriodPerMonth;
            private string _StartDate;
            private string _EndDate;
            private string _DateOfReceiptOfTheSite;
            private string _TechnicalOpenDate;
            private decimal _ProjectCost;
            private string _IsActive;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public string Supervisor
            {
                get { return this._Supervisor; }
                set { this._Supervisor = value; }
            }
            public int ProjectPeriodPerMonth
            {
                get { return this._ProjectPeriodPerMonth; }
                set { this._ProjectPeriodPerMonth = value; }
            }
            public string StartDate
            {
                get { return this._StartDate; }
                set { this._StartDate = value; }
            }
            public string EndDate
            {
                get { return this._EndDate; }
                set { this._EndDate = value; }
            }
            public string DateOfReceiptOfTheSite
            {
                get { return this._DateOfReceiptOfTheSite; }
                set { this._DateOfReceiptOfTheSite = value; }
            }
            public string TechnicalOpenDate
            {
                get { return this._TechnicalOpenDate; }
                set { this._TechnicalOpenDate = value; }
            }
            public decimal ProjectCost
            {
                get { return this._ProjectCost; }
                set { this._ProjectCost = value; }
            }
            public string IsActive
            {
                get { return this._IsActive; }
                set { this._IsActive = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_ProjectDailyWorker
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_DailyWorker_ID,
                FK_Project_ID,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_DailyWorker_ID;
            private int _FK_Project_ID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_DailyWorker_ID
            {
                get { return this._FK_DailyWorker_ID; }
                set { this._FK_DailyWorker_ID = value; }
            }
            public int FK_Project_ID
            {
                get { return this._FK_Project_ID; }
                set { this._FK_Project_ID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_ProjectEmployees
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ProjectID,
                FK_EmployeeID,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ProjectID;
            private int _FK_EmployeeID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int FK_EmployeeID
            {
                get { return this._FK_EmployeeID; }
                set { this._FK_EmployeeID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_ProjectEstimation
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Price,
                Quantity,
                Notes,
                FK_ProjectID,
                FK_EstimationItemsID,
            }

            #region Fields
            private int _PK_ID;
            private decimal _Price;
            private int _Quantity;
            private string _Notes;
            private int _FK_ProjectID;
            private int _FK_EstimationItemsID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public decimal Price
            {
                get { return this._Price; }
                set { this._Price = value; }
            }
            public int Quantity
            {
                get { return this._Quantity; }
                set { this._Quantity = value; }
            }
            public string Notes
            {
                get { return this._Notes; }
                set { this._Notes = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int FK_EstimationItemsID
            {
                get { return this._FK_EstimationItemsID; }
                set { this._FK_EstimationItemsID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_ProjectGuardianship
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ProjectID,
                FK_EmployeeID,
                Date,
                DateFrom,
                DateTo,
                Amount,
                FK_SaverID,
                Rest,
                Surplus,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ProjectID;
            private int _FK_EmployeeID;
            private string _Date;
            private string _DateFrom;
            private string _DateTo;
            private decimal _Amount;
            private int _FK_SaverID;
            private decimal _Rest;
            private decimal _Surplus;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int FK_EmployeeID
            {
                get { return this._FK_EmployeeID; }
                set { this._FK_EmployeeID = value; }
            }
            public string Date
            {
                get { return this._Date; }
                set { this._Date = value; }
            }
            public string DateFrom
            {
                get { return this._DateFrom; }
                set { this._DateFrom = value; }
            }
            public string DateTo
            {
                get { return this._DateTo; }
                set { this._DateTo = value; }
            }
            public decimal Amount
            {
                get { return this._Amount; }
                set { this._Amount = value; }
            }
            public int FK_SaverID
            {
                get { return this._FK_SaverID; }
                set { this._FK_SaverID = value; }
            }
            public decimal Rest
            {
                get { return this._Rest; }
                set { this._Rest = value; }
            }
            public decimal Surplus
            {
                get { return this._Surplus; }
                set { this._Surplus = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_ProjectSaverDeposits
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_SaverItemID,
                Date,
                FK_ProjectID,
                Amount,
                Description,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_SaverItemID;
            private string _Date;
            private int _FK_ProjectID;
            private decimal _Amount;
            private string _Description;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_SaverItemID
            {
                get { return this._FK_SaverItemID; }
                set { this._FK_SaverItemID = value; }
            }
            public string Date
            {
                get { return this._Date; }
                set { this._Date = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public decimal Amount
            {
                get { return this._Amount; }
                set { this._Amount = value; }
            }
            public string Description
            {
                get { return this._Description; }
                set { this._Description = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_ProjectSubContractor
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ProjectID,
                FK_SubContractorWorkID,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ProjectID;
            private int _FK_SubContractorWorkID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int FK_SubContractorWorkID
            {
                get { return this._FK_SubContractorWorkID; }
                set { this._FK_SubContractorWorkID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_ProjectSupplies
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ItemsID,
                QTY,
                FK_ProjectEstimationItemID,
                FK_ProjectID,
                WasSupplied,
                Rest,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ItemsID;
            private decimal _QTY;
            private int _FK_ProjectEstimationItemID;
            private int _FK_ProjectID;
            private string _WasSupplied;
            private int _Rest;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ItemsID
            {
                get { return this._FK_ItemsID; }
                set { this._FK_ItemsID = value; }
            }
            public decimal QTY
            {
                get { return this._QTY; }
                set { this._QTY = value; }
            }
            public int FK_ProjectEstimationItemID
            {
                get { return this._FK_ProjectEstimationItemID; }
                set { this._FK_ProjectEstimationItemID = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public string WasSupplied
            {
                get { return this._WasSupplied; }
                set { this._WasSupplied = value; }
            }
            public int Rest
            {
                get { return this._Rest; }
                set { this._Rest = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_RolePermissions
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_RoleID,
                FK_PageID,
                Access,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_RoleID;
            private int _FK_PageID;
            private string _Access;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_RoleID
            {
                get { return this._FK_RoleID; }
                set { this._FK_RoleID = value; }
            }
            public int FK_PageID
            {
                get { return this._FK_PageID; }
                set { this._FK_PageID = value; }
            }
            public string Access
            {
                get { return this._Access; }
                set { this._Access = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_Roles
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SaverAmountActions
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_SaverItemID,
                FK_SaverID,
                Date,
                ActionType,
                Amount,
                Description,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_SaverItemID;
            private int _FK_SaverID;
            private string _Date;
            private string _ActionType;
            private decimal _Amount;
            private string _Description;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_SaverItemID
            {
                get { return this._FK_SaverItemID; }
                set { this._FK_SaverItemID = value; }
            }
            public int FK_SaverID
            {
                get { return this._FK_SaverID; }
                set { this._FK_SaverID = value; }
            }
            public string Date
            {
                get { return this._Date; }
                set { this._Date = value; }
            }
            public string ActionType
            {
                get { return this._ActionType; }
                set { this._ActionType = value; }
            }
            public decimal Amount
            {
                get { return this._Amount; }
                set { this._Amount = value; }
            }
            public string Description
            {
                get { return this._Description; }
                set { this._Description = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SaverCategory
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SaverItems
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                FK_SaverCategory,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private int _FK_SaverCategory;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public int FK_SaverCategory
            {
                get { return this._FK_SaverCategory; }
                set { this._FK_SaverCategory = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_Savers
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                Amount,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private decimal _Amount;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public decimal Amount
            {
                get { return this._Amount; }
                set { this._Amount = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_Subcontractor
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                Mobile,
                LandLine,
                Address,
                FK_WorkTypeID,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private string _Mobile;
            private string _LandLine;
            private string _Address;
            private int _FK_WorkTypeID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public string Mobile
            {
                get { return this._Mobile; }
                set { this._Mobile = value; }
            }
            public string LandLine
            {
                get { return this._LandLine; }
                set { this._LandLine = value; }
            }
            public string Address
            {
                get { return this._Address; }
                set { this._Address = value; }
            }
            public int FK_WorkTypeID
            {
                get { return this._FK_WorkTypeID; }
                set { this._FK_WorkTypeID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SubContractorExtract
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ProjectID,
                ExractOrder,
                ExtractTotalPrice,
                LastPaid,
                Deductions,
                BusinessGuarantee,
                SubContractorId,
                SubContractorName,
                NetDue,
                DateFrom,
                DateTo,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ProjectID;
            private int _ExractOrder;
            private decimal _ExtractTotalPrice;
            private decimal _LastPaid;
            private decimal _Deductions;
            private decimal _BusinessGuarantee;
            private int _SubContractorId;
            private string _SubContractorName;
            private decimal _NetDue;
            private string _DateFrom;
            private string _DateTo;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int ExractOrder
            {
                get { return this._ExractOrder; }
                set { this._ExractOrder = value; }
            }
            public decimal ExtractTotalPrice
            {
                get { return this._ExtractTotalPrice; }
                set { this._ExtractTotalPrice = value; }
            }
            public decimal LastPaid
            {
                get { return this._LastPaid; }
                set { this._LastPaid = value; }
            }
            public decimal Deductions
            {
                get { return this._Deductions; }
                set { this._Deductions = value; }
            }
            public decimal BusinessGuarantee
            {
                get { return this._BusinessGuarantee; }
                set { this._BusinessGuarantee = value; }
            }
            public int SubContractorId
            {
                get { return this._SubContractorId; }
                set { this._SubContractorId = value; }
            }
            public string SubContractorName
            {
                get { return this._SubContractorName; }
                set { this._SubContractorName = value; }
            }
            public decimal NetDue
            {
                get { return this._NetDue; }
                set { this._NetDue = value; }
            }
            public string DateFrom
            {
                get { return this._DateFrom; }
                set { this._DateFrom = value; }
            }
            public string DateTo
            {
                get { return this._DateTo; }
                set { this._DateTo = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SubContractorExtractItems
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                WorkName,
                WorkNameID,
                Price,
                ExchangeRatio,
                LastExitExecutedQTY,
                LastExecutedQTY,
                CurrentExecutedQTY,
                TotalExecutedQTY,
                TotalPrice,
                FK_SubContractorExractID,
            }

            #region Fields
            private int _PK_ID;
            private string _WorkName;
            private int _WorkNameID;
            private decimal _Price;
            private decimal _ExchangeRatio;
            private int _LastExitExecutedQTY;
            private int _LastExecutedQTY;
            private int _CurrentExecutedQTY;
            private int _TotalExecutedQTY;
            private decimal _TotalPrice;
            private int _FK_SubContractorExractID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string WorkName
            {
                get { return this._WorkName; }
                set { this._WorkName = value; }
            }
            public int WorkNameID
            {
                get { return this._WorkNameID; }
                set { this._WorkNameID = value; }
            }
            public decimal Price
            {
                get { return this._Price; }
                set { this._Price = value; }
            }
            public decimal ExchangeRatio
            {
                get { return this._ExchangeRatio; }
                set { this._ExchangeRatio = value; }
            }
            public int LastExitExecutedQTY
            {
                get { return this._LastExitExecutedQTY; }
                set { this._LastExitExecutedQTY = value; }
            }
            public int LastExecutedQTY
            {
                get { return this._LastExecutedQTY; }
                set { this._LastExecutedQTY = value; }
            }
            public int CurrentExecutedQTY
            {
                get { return this._CurrentExecutedQTY; }
                set { this._CurrentExecutedQTY = value; }
            }
            public int TotalExecutedQTY
            {
                get { return this._TotalExecutedQTY; }
                set { this._TotalExecutedQTY = value; }
            }
            public decimal TotalPrice
            {
                get { return this._TotalPrice; }
                set { this._TotalPrice = value; }
            }
            public int FK_SubContractorExractID
            {
                get { return this._FK_SubContractorExractID; }
                set { this._FK_SubContractorExractID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SubContractorWorks
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_WorkID,
                FK_SubContractorID,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_WorkID;
            private int _FK_SubContractorID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_WorkID
            {
                get { return this._FK_WorkID; }
                set { this._FK_WorkID = value; }
            }
            public int FK_SubContractorID
            {
                get { return this._FK_SubContractorID; }
                set { this._FK_SubContractorID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_Supplier
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                Mobile,
                LandLine,
                Address,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private string _Mobile;
            private string _LandLine;
            private string _Address;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public string Mobile
            {
                get { return this._Mobile; }
                set { this._Mobile = value; }
            }
            public string LandLine
            {
                get { return this._LandLine; }
                set { this._LandLine = value; }
            }
            public string Address
            {
                get { return this._Address; }
                set { this._Address = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SupplierExtract
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ProjectID,
                ExractOrder,
                ExtractTotalPrice,
                LastPaid,
                Deductions,
                BusinessGuarantee,
                SupplierId,
                SupplierName,
                NetDue,
                DateFrom,
                DateTo,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ProjectID;
            private int _ExractOrder;
            private decimal _ExtractTotalPrice;
            private decimal _LastPaid;
            private decimal _Deductions;
            private decimal _BusinessGuarantee;
            private int _SupplierId;
            private string _SupplierName;
            private decimal _NetDue;
            private string _DateFrom;
            private string _DateTo;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int ExractOrder
            {
                get { return this._ExractOrder; }
                set { this._ExractOrder = value; }
            }
            public decimal ExtractTotalPrice
            {
                get { return this._ExtractTotalPrice; }
                set { this._ExtractTotalPrice = value; }
            }
            public decimal LastPaid
            {
                get { return this._LastPaid; }
                set { this._LastPaid = value; }
            }
            public decimal Deductions
            {
                get { return this._Deductions; }
                set { this._Deductions = value; }
            }
            public decimal BusinessGuarantee
            {
                get { return this._BusinessGuarantee; }
                set { this._BusinessGuarantee = value; }
            }
            public int SupplierId
            {
                get { return this._SupplierId; }
                set { this._SupplierId = value; }
            }
            public string SupplierName
            {
                get { return this._SupplierName; }
                set { this._SupplierName = value; }
            }
            public decimal NetDue
            {
                get { return this._NetDue; }
                set { this._NetDue = value; }
            }
            public string DateFrom
            {
                get { return this._DateFrom; }
                set { this._DateFrom = value; }
            }
            public string DateTo
            {
                get { return this._DateTo; }
                set { this._DateTo = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SupplierExtractItems
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                SupplyName,
                SupplyNameID,
                Price,
                ExchangeRatio,
                LastExitExecutedQTY,
                LastExecutedQTY,
                CurrentExecutedQTY,
                TotalExecutedQTY,
                TotalPrice,
                FK_SupplierExractID,
            }

            #region Fields
            private int _PK_ID;
            private string _SupplyName;
            private int _SupplyNameID;
            private decimal _Price;
            private int _ExchangeRatio;
            private int _LastExitExecutedQTY;
            private int _LastExecutedQTY;
            private int _CurrentExecutedQTY;
            private int _TotalExecutedQTY;
            private decimal _TotalPrice;
            private int _FK_SupplierExractID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string SupplyName
            {
                get { return this._SupplyName; }
                set { this._SupplyName = value; }
            }
            public int SupplyNameID
            {
                get { return this._SupplyNameID; }
                set { this._SupplyNameID = value; }
            }
            public decimal Price
            {
                get { return this._Price; }
                set { this._Price = value; }
            }
            public int ExchangeRatio
            {
                get { return this._ExchangeRatio; }
                set { this._ExchangeRatio = value; }
            }
            public int LastExitExecutedQTY
            {
                get { return this._LastExitExecutedQTY; }
                set { this._LastExitExecutedQTY = value; }
            }
            public int LastExecutedQTY
            {
                get { return this._LastExecutedQTY; }
                set { this._LastExecutedQTY = value; }
            }
            public int CurrentExecutedQTY
            {
                get { return this._CurrentExecutedQTY; }
                set { this._CurrentExecutedQTY = value; }
            }
            public int TotalExecutedQTY
            {
                get { return this._TotalExecutedQTY; }
                set { this._TotalExecutedQTY = value; }
            }
            public decimal TotalPrice
            {
                get { return this._TotalPrice; }
                set { this._TotalPrice = value; }
            }
            public int FK_SupplierExractID
            {
                get { return this._FK_SupplierExractID; }
                set { this._FK_SupplierExractID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SupplierSupplies
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_CategoryID,
                FK_SupplierID,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_CategoryID;
            private int _FK_SupplierID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_CategoryID
            {
                get { return this._FK_CategoryID; }
                set { this._FK_CategoryID = value; }
            }
            public int FK_SupplierID
            {
                get { return this._FK_SupplierID; }
                set { this._FK_SupplierID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_SuppliesEvent
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                FK_ProjectSuppliesID,
                UnitPrice,
                QTY,
                TotalPrice,
                FK_SupplierID,
                SuppliesDate,
                ReceiptNO,
            }

            #region Fields
            private int _PK_ID;
            private int _FK_ProjectSuppliesID;
            private decimal _UnitPrice;
            private decimal _QTY;
            private decimal _TotalPrice;
            private int _FK_SupplierID;
            private string _SuppliesDate;
            private string _ReceiptNO;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectSuppliesID
            {
                get { return this._FK_ProjectSuppliesID; }
                set { this._FK_ProjectSuppliesID = value; }
            }
            public decimal UnitPrice
            {
                get { return this._UnitPrice; }
                set { this._UnitPrice = value; }
            }
            public decimal QTY
            {
                get { return this._QTY; }
                set { this._QTY = value; }
            }
            public decimal TotalPrice
            {
                get { return this._TotalPrice; }
                set { this._TotalPrice = value; }
            }
            public int FK_SupplierID
            {
                get { return this._FK_SupplierID; }
                set { this._FK_SupplierID = value; }
            }
            public string SuppliesDate
            {
                get { return this._SuppliesDate; }
                set { this._SuppliesDate = value; }
            }
            public string ReceiptNO
            {
                get { return this._ReceiptNO; }
                set { this._ReceiptNO = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_WorkCategories
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class Tbl_WorkType
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                FK_WorkCategory,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private int _FK_WorkCategory;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public int FK_WorkCategory
            {
                get { return this._FK_WorkCategory; }
                set { this._FK_WorkCategory = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_AddedStimation
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                PK_ID,
                Name,
                FK_ProjectID,
                Quantity,
                HasEquationItems,
                EquationItemPK_ID,
                FK_EstimationItemID,
            }

            #region Fields
            private int _PK_ID;
            private string _Name;
            private int _FK_ProjectID;
            private int _Quantity;
            private string _HasEquationItems;
            private int _EquationItemPK_ID;
            private int _FK_EstimationItemID;
            #endregion

            #region Properties
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int Quantity
            {
                get { return this._Quantity; }
                set { this._Quantity = value; }
            }
            public string HasEquationItems
            {
                get { return this._HasEquationItems; }
                set { this._HasEquationItems = value; }
            }
            public int EquationItemPK_ID
            {
                get { return this._EquationItemPK_ID; }
                set { this._EquationItemPK_ID = value; }
            }
            public int FK_EstimationItemID
            {
                get { return this._FK_EstimationItemID; }
                set { this._FK_EstimationItemID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_CompanyExtract
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                ProjectEstimationID,
                ExecutedQTY,
                FK_ProjectID,
            }

            #region Fields
            private int _ProjectEstimationID;
            private int _ExecutedQTY;
            private int _FK_ProjectID;
            #endregion

            #region Properties
            public int ProjectEstimationID
            {
                get { return this._ProjectEstimationID; }
                set { this._ProjectEstimationID = value; }
            }
            public int ExecutedQTY
            {
                get { return this._ExecutedQTY; }
                set { this._ExecutedQTY = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_CompanyExtractNewOrder
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                NewExtractOrder,
                FK_ProjectID,
                LastPaid,
            }

            #region Fields
            private int _NewExtractOrder;
            private int _FK_ProjectID;
            private decimal _LastPaid;
            #endregion

            #region Properties
            public int NewExtractOrder
            {
                get { return this._NewExtractOrder; }
                set { this._NewExtractOrder = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public decimal LastPaid
            {
                get { return this._LastPaid; }
                set { this._LastPaid = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_DailySuppliesbook
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                ItemID,
                ItemName,
                CategoryName,
                FullItemName,
                WasSupplied,
                Rest,
                QTY,
                TotalSupplied,
                PK_ID,
                FK_ProjectEstimationItemID,
                FK_ProjectID,
                SuppliesEventID,
                FK_ProjectSuppliesID,
                UnitPrice,
                SuppliesEventQTY,
                TotalPrice,
                FK_SupplierID,
                SuppliesDate,
                ReceiptNO,
                CategoryID,
                ProjectName,
                SupplierName,
                IsActive,
            }

            #region Fields
            private int _ItemID;
            private string _ItemName;
            private string _CategoryName;
            private string _FullItemName;
            private string _WasSupplied;
            private int _Rest;
            private decimal _QTY;
            private decimal _TotalSupplied;
            private int _PK_ID;
            private int _FK_ProjectEstimationItemID;
            private int _FK_ProjectID;
            private int _SuppliesEventID;
            private int _FK_ProjectSuppliesID;
            private decimal _UnitPrice;
            private decimal _SuppliesEventQTY;
            private decimal _TotalPrice;
            private int _FK_SupplierID;
            private string _SuppliesDate;
            private string _ReceiptNO;
            private int _CategoryID;
            private string _ProjectName;
            private string _SupplierName;
            private string _IsActive;
            #endregion

            #region Properties
            public int ItemID
            {
                get { return this._ItemID; }
                set { this._ItemID = value; }
            }
            public string ItemName
            {
                get { return this._ItemName; }
                set { this._ItemName = value; }
            }
            public string CategoryName
            {
                get { return this._CategoryName; }
                set { this._CategoryName = value; }
            }
            public string FullItemName
            {
                get { return this._FullItemName; }
                set { this._FullItemName = value; }
            }
            public string WasSupplied
            {
                get { return this._WasSupplied; }
                set { this._WasSupplied = value; }
            }
            public int Rest
            {
                get { return this._Rest; }
                set { this._Rest = value; }
            }
            public decimal QTY
            {
                get { return this._QTY; }
                set { this._QTY = value; }
            }
            public decimal TotalSupplied
            {
                get { return this._TotalSupplied; }
                set { this._TotalSupplied = value; }
            }
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public int FK_ProjectEstimationItemID
            {
                get { return this._FK_ProjectEstimationItemID; }
                set { this._FK_ProjectEstimationItemID = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int SuppliesEventID
            {
                get { return this._SuppliesEventID; }
                set { this._SuppliesEventID = value; }
            }
            public int FK_ProjectSuppliesID
            {
                get { return this._FK_ProjectSuppliesID; }
                set { this._FK_ProjectSuppliesID = value; }
            }
            public decimal UnitPrice
            {
                get { return this._UnitPrice; }
                set { this._UnitPrice = value; }
            }
            public decimal SuppliesEventQTY
            {
                get { return this._SuppliesEventQTY; }
                set { this._SuppliesEventQTY = value; }
            }
            public decimal TotalPrice
            {
                get { return this._TotalPrice; }
                set { this._TotalPrice = value; }
            }
            public int FK_SupplierID
            {
                get { return this._FK_SupplierID; }
                set { this._FK_SupplierID = value; }
            }
            public string SuppliesDate
            {
                get { return this._SuppliesDate; }
                set { this._SuppliesDate = value; }
            }
            public string ReceiptNO
            {
                get { return this._ReceiptNO; }
                set { this._ReceiptNO = value; }
            }
            public int CategoryID
            {
                get { return this._CategoryID; }
                set { this._CategoryID = value; }
            }
            public string ProjectName
            {
                get { return this._ProjectName; }
                set { this._ProjectName = value; }
            }
            public string SupplierName
            {
                get { return this._SupplierName; }
                set { this._SupplierName = value; }
            }
            public string IsActive
            {
                get { return this._IsActive; }
                set { this._IsActive = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_DailyWorkerExract
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                Name,
                FK_ProjectID,
                ExractOrder,
                ExtractTotalPrice,
                LastPaid,
                Deductions,
                WorkerId,
                WorkerName,
                Price,
                ExchangeRatio,
                TotalDays,
                DeductionsDays,
                NetDays,
                TotalPrice,
                FK_DailyWorkerExractID,
            }

            #region Fields
            private string _Name;
            private int _FK_ProjectID;
            private int _ExractOrder;
            private decimal _ExtractTotalPrice;
            private decimal _LastPaid;
            private decimal _Deductions;
            private int _WorkerId;
            private string _WorkerName;
            private decimal _Price;
            private int _ExchangeRatio;
            private int _TotalDays;
            private int _DeductionsDays;
            private int _NetDays;
            private decimal _TotalPrice;
            private int _FK_DailyWorkerExractID;
            #endregion

            #region Properties
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int ExractOrder
            {
                get { return this._ExractOrder; }
                set { this._ExractOrder = value; }
            }
            public decimal ExtractTotalPrice
            {
                get { return this._ExtractTotalPrice; }
                set { this._ExtractTotalPrice = value; }
            }
            public decimal LastPaid
            {
                get { return this._LastPaid; }
                set { this._LastPaid = value; }
            }
            public decimal Deductions
            {
                get { return this._Deductions; }
                set { this._Deductions = value; }
            }
            public int WorkerId
            {
                get { return this._WorkerId; }
                set { this._WorkerId = value; }
            }
            public string WorkerName
            {
                get { return this._WorkerName; }
                set { this._WorkerName = value; }
            }
            public decimal Price
            {
                get { return this._Price; }
                set { this._Price = value; }
            }
            public int ExchangeRatio
            {
                get { return this._ExchangeRatio; }
                set { this._ExchangeRatio = value; }
            }
            public int TotalDays
            {
                get { return this._TotalDays; }
                set { this._TotalDays = value; }
            }
            public int DeductionsDays
            {
                get { return this._DeductionsDays; }
                set { this._DeductionsDays = value; }
            }
            public int NetDays
            {
                get { return this._NetDays; }
                set { this._NetDays = value; }
            }
            public decimal TotalPrice
            {
                get { return this._TotalPrice; }
                set { this._TotalPrice = value; }
            }
            public int FK_DailyWorkerExractID
            {
                get { return this._FK_DailyWorkerExractID; }
                set { this._FK_DailyWorkerExractID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_DailyWorkerExtractNewOrder
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                NewExtractOrder,
                FK_ProjectID,
                LastPaid,
            }

            #region Fields
            private int _NewExtractOrder;
            private int _FK_ProjectID;
            private decimal _LastPaid;
            #endregion

            #region Properties
            public int NewExtractOrder
            {
                get { return this._NewExtractOrder; }
                set { this._NewExtractOrder = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public decimal LastPaid
            {
                get { return this._LastPaid; }
                set { this._LastPaid = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_EmpolyeePaid
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                Last_Paid,
                PersonID,
                PersonTypeID,
            }

            #region Fields
            private decimal _Last_Paid;
            private int _PersonID;
            private int _PersonTypeID;
            #endregion

            #region Properties
            public decimal Last_Paid
            {
                get { return this._Last_Paid; }
                set { this._Last_Paid = value; }
            }
            public int PersonID
            {
                get { return this._PersonID; }
                set { this._PersonID = value; }
            }
            public int PersonTypeID
            {
                get { return this._PersonTypeID; }
                set { this._PersonTypeID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_Guradianship
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                Name,
                Supervisor,
                ProjectPeriodPerMonth,
                StartDate,
                EndDate,
                DateOfReceiptOfTheSite,
                TechnicalOpenDate,
                ProjectCost,
                IsActive,
                FK_ProjectID,
                FK_EmployeeID,
                DateFrom,
                Date,
                DateTo,
                Amount,
                FK_SaverID,
                Rest,
                Surplus,
                FK_ProjectGuardianshipID,
                GuardianshipItemAmount,
                FK_ExpenseItemID,
                PersonID,
                PersonTypeID,
                PersonName,
                GuardianshipItemDate,
                WorkTypeId,
                WorkFullName,
                ExpensesItemName,
                FK_ExpenseCategory,
                ExpensesCategoryName,
                GuardianshipItemsId,
                Expr1,
                Mobile,
                JobName,
                FK_RoleID,
                UserName,
            }

            #region Fields
            private string _Name;
            private string _Supervisor;
            private int _ProjectPeriodPerMonth;
            private string _StartDate;
            private string _EndDate;
            private string _DateOfReceiptOfTheSite;
            private string _TechnicalOpenDate;
            private decimal _ProjectCost;
            private string _IsActive;
            private int _FK_ProjectID;
            private int _FK_EmployeeID;
            private string _DateFrom;
            private string _Date;
            private string _DateTo;
            private decimal _Amount;
            private int _FK_SaverID;
            private decimal _Rest;
            private decimal _Surplus;
            private int _FK_ProjectGuardianshipID;
            private decimal _GuardianshipItemAmount;
            private int _FK_ExpenseItemID;
            private int _PersonID;
            private int _PersonTypeID;
            private string _PersonName;
            private string _GuardianshipItemDate;
            private int _WorkTypeId;
            private string _WorkFullName;
            private string _ExpensesItemName;
            private int _FK_ExpenseCategory;
            private string _ExpensesCategoryName;
            private int _GuardianshipItemsId;
            private string _Expr1;
            private string _Mobile;
            private string _JobName;
            private int _FK_RoleID;
            private string _UserName;
            #endregion

            #region Properties
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public string Supervisor
            {
                get { return this._Supervisor; }
                set { this._Supervisor = value; }
            }
            public int ProjectPeriodPerMonth
            {
                get { return this._ProjectPeriodPerMonth; }
                set { this._ProjectPeriodPerMonth = value; }
            }
            public string StartDate
            {
                get { return this._StartDate; }
                set { this._StartDate = value; }
            }
            public string EndDate
            {
                get { return this._EndDate; }
                set { this._EndDate = value; }
            }
            public string DateOfReceiptOfTheSite
            {
                get { return this._DateOfReceiptOfTheSite; }
                set { this._DateOfReceiptOfTheSite = value; }
            }
            public string TechnicalOpenDate
            {
                get { return this._TechnicalOpenDate; }
                set { this._TechnicalOpenDate = value; }
            }
            public decimal ProjectCost
            {
                get { return this._ProjectCost; }
                set { this._ProjectCost = value; }
            }
            public string IsActive
            {
                get { return this._IsActive; }
                set { this._IsActive = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int FK_EmployeeID
            {
                get { return this._FK_EmployeeID; }
                set { this._FK_EmployeeID = value; }
            }
            public string DateFrom
            {
                get { return this._DateFrom; }
                set { this._DateFrom = value; }
            }
            public string Date
            {
                get { return this._Date; }
                set { this._Date = value; }
            }
            public string DateTo
            {
                get { return this._DateTo; }
                set { this._DateTo = value; }
            }
            public decimal Amount
            {
                get { return this._Amount; }
                set { this._Amount = value; }
            }
            public int FK_SaverID
            {
                get { return this._FK_SaverID; }
                set { this._FK_SaverID = value; }
            }
            public decimal Rest
            {
                get { return this._Rest; }
                set { this._Rest = value; }
            }
            public decimal Surplus
            {
                get { return this._Surplus; }
                set { this._Surplus = value; }
            }
            public int FK_ProjectGuardianshipID
            {
                get { return this._FK_ProjectGuardianshipID; }
                set { this._FK_ProjectGuardianshipID = value; }
            }
            public decimal GuardianshipItemAmount
            {
                get { return this._GuardianshipItemAmount; }
                set { this._GuardianshipItemAmount = value; }
            }
            public int FK_ExpenseItemID
            {
                get { return this._FK_ExpenseItemID; }
                set { this._FK_ExpenseItemID = value; }
            }
            public int PersonID
            {
                get { return this._PersonID; }
                set { this._PersonID = value; }
            }
            public int PersonTypeID
            {
                get { return this._PersonTypeID; }
                set { this._PersonTypeID = value; }
            }
            public string PersonName
            {
                get { return this._PersonName; }
                set { this._PersonName = value; }
            }
            public string GuardianshipItemDate
            {
                get { return this._GuardianshipItemDate; }
                set { this._GuardianshipItemDate = value; }
            }
            public int WorkTypeId
            {
                get { return this._WorkTypeId; }
                set { this._WorkTypeId = value; }
            }
            public string WorkFullName
            {
                get { return this._WorkFullName; }
                set { this._WorkFullName = value; }
            }
            public string ExpensesItemName
            {
                get { return this._ExpensesItemName; }
                set { this._ExpensesItemName = value; }
            }
            public int FK_ExpenseCategory
            {
                get { return this._FK_ExpenseCategory; }
                set { this._FK_ExpenseCategory = value; }
            }
            public string ExpensesCategoryName
            {
                get { return this._ExpensesCategoryName; }
                set { this._ExpensesCategoryName = value; }
            }
            public int GuardianshipItemsId
            {
                get { return this._GuardianshipItemsId; }
                set { this._GuardianshipItemsId = value; }
            }
            public string Expr1
            {
                get { return this._Expr1; }
                set { this._Expr1 = value; }
            }
            public string Mobile
            {
                get { return this._Mobile; }
                set { this._Mobile = value; }
            }
            public string JobName
            {
                get { return this._JobName; }
                set { this._JobName = value; }
            }
            public int FK_RoleID
            {
                get { return this._FK_RoleID; }
                set { this._FK_RoleID = value; }
            }
            public string UserName
            {
                get { return this._UserName; }
                set { this._UserName = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_ProjectContractor
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                ProjectId,
                ProjectName,
                SubContractorName,
                SubContractorId,
                FK_WorkTypeID,
                WorkTypeName,
                FK_WorkCategory,
                WorkCategoriesName,
                FullWorkName,
                FK_WorkID,
            }

            #region Fields
            private int _ProjectId;
            private string _ProjectName;
            private string _SubContractorName;
            private int _SubContractorId;
            private int _FK_WorkTypeID;
            private string _WorkTypeName;
            private int _FK_WorkCategory;
            private string _WorkCategoriesName;
            private string _FullWorkName;
            private int _FK_WorkID;
            #endregion

            #region Properties
            public int ProjectId
            {
                get { return this._ProjectId; }
                set { this._ProjectId = value; }
            }
            public string ProjectName
            {
                get { return this._ProjectName; }
                set { this._ProjectName = value; }
            }
            public string SubContractorName
            {
                get { return this._SubContractorName; }
                set { this._SubContractorName = value; }
            }
            public int SubContractorId
            {
                get { return this._SubContractorId; }
                set { this._SubContractorId = value; }
            }
            public int FK_WorkTypeID
            {
                get { return this._FK_WorkTypeID; }
                set { this._FK_WorkTypeID = value; }
            }
            public string WorkTypeName
            {
                get { return this._WorkTypeName; }
                set { this._WorkTypeName = value; }
            }
            public int FK_WorkCategory
            {
                get { return this._FK_WorkCategory; }
                set { this._FK_WorkCategory = value; }
            }
            public string WorkCategoriesName
            {
                get { return this._WorkCategoriesName; }
                set { this._WorkCategoriesName = value; }
            }
            public string FullWorkName
            {
                get { return this._FullWorkName; }
                set { this._FullWorkName = value; }
            }
            public int FK_WorkID
            {
                get { return this._FK_WorkID; }
                set { this._FK_WorkID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_ProjectDeposits
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                ProjectName,
                Supervisor,
                ProjectPeriodPerMonth,
                StartDate,
                EndDate,
                DateOfReceiptOfTheSite,
                TechnicalOpenDate,
                ProjectCost,
                IsActive,
                FK_SaverItemID,
                Date,
                FK_ProjectID,
                Amount,
                Description,
                ItemName,
                FK_SaverCategory,
                PK_ID,
            }

            #region Fields
            private string _ProjectName;
            private string _Supervisor;
            private int _ProjectPeriodPerMonth;
            private string _StartDate;
            private string _EndDate;
            private string _DateOfReceiptOfTheSite;
            private string _TechnicalOpenDate;
            private decimal _ProjectCost;
            private string _IsActive;
            private int _FK_SaverItemID;
            private string _Date;
            private int _FK_ProjectID;
            private decimal _Amount;
            private string _Description;
            private string _ItemName;
            private int _FK_SaverCategory;
            private int _PK_ID;
            #endregion

            #region Properties
            public string ProjectName
            {
                get { return this._ProjectName; }
                set { this._ProjectName = value; }
            }
            public string Supervisor
            {
                get { return this._Supervisor; }
                set { this._Supervisor = value; }
            }
            public int ProjectPeriodPerMonth
            {
                get { return this._ProjectPeriodPerMonth; }
                set { this._ProjectPeriodPerMonth = value; }
            }
            public string StartDate
            {
                get { return this._StartDate; }
                set { this._StartDate = value; }
            }
            public string EndDate
            {
                get { return this._EndDate; }
                set { this._EndDate = value; }
            }
            public string DateOfReceiptOfTheSite
            {
                get { return this._DateOfReceiptOfTheSite; }
                set { this._DateOfReceiptOfTheSite = value; }
            }
            public string TechnicalOpenDate
            {
                get { return this._TechnicalOpenDate; }
                set { this._TechnicalOpenDate = value; }
            }
            public decimal ProjectCost
            {
                get { return this._ProjectCost; }
                set { this._ProjectCost = value; }
            }
            public string IsActive
            {
                get { return this._IsActive; }
                set { this._IsActive = value; }
            }
            public int FK_SaverItemID
            {
                get { return this._FK_SaverItemID; }
                set { this._FK_SaverItemID = value; }
            }
            public string Date
            {
                get { return this._Date; }
                set { this._Date = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public decimal Amount
            {
                get { return this._Amount; }
                set { this._Amount = value; }
            }
            public string Description
            {
                get { return this._Description; }
                set { this._Description = value; }
            }
            public string ItemName
            {
                get { return this._ItemName; }
                set { this._ItemName = value; }
            }
            public int FK_SaverCategory
            {
                get { return this._FK_SaverCategory; }
                set { this._FK_SaverCategory = value; }
            }
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_ProjectEstimation
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                Price,
                Quantity,
                Notes,
                FK_ProjectID,
                FK_EstimationItemsID,
                BusinessStatement,
                Unit,
                ProjectName,
            }

            #region Fields
            private decimal _Price;
            private int _Quantity;
            private string _Notes;
            private int _FK_ProjectID;
            private int _FK_EstimationItemsID;
            private string _BusinessStatement;
            private string _Unit;
            private string _ProjectName;
            #endregion

            #region Properties
            public decimal Price
            {
                get { return this._Price; }
                set { this._Price = value; }
            }
            public int Quantity
            {
                get { return this._Quantity; }
                set { this._Quantity = value; }
            }
            public string Notes
            {
                get { return this._Notes; }
                set { this._Notes = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int FK_EstimationItemsID
            {
                get { return this._FK_EstimationItemsID; }
                set { this._FK_EstimationItemsID = value; }
            }
            public string BusinessStatement
            {
                get { return this._BusinessStatement; }
                set { this._BusinessStatement = value; }
            }
            public string Unit
            {
                get { return this._Unit; }
                set { this._Unit = value; }
            }
            public string ProjectName
            {
                get { return this._ProjectName; }
                set { this._ProjectName = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_ProjectGurdianship
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                FK_ProjectID,
                FK_EmployeeID,
                Date,
                DateFrom,
                DateTo,
                Amount,
                FK_SaverID,
                Rest,
                Surplus,
                Name,
                Mobile,
                ID,
                Salary,
                JobName,
                PK_ID,
                GurdianshipName,
            }

            #region Fields
            private int _FK_ProjectID;
            private int _FK_EmployeeID;
            private string _Date;
            private string _DateFrom;
            private string _DateTo;
            private decimal _Amount;
            private int _FK_SaverID;
            private decimal _Rest;
            private decimal _Surplus;
            private string _Name;
            private string _Mobile;
            private string _ID;
            private decimal _Salary;
            private string _JobName;
            private int _PK_ID;
            private string _GurdianshipName;
            #endregion

            #region Properties
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public int FK_EmployeeID
            {
                get { return this._FK_EmployeeID; }
                set { this._FK_EmployeeID = value; }
            }
            public string Date
            {
                get { return this._Date; }
                set { this._Date = value; }
            }
            public string DateFrom
            {
                get { return this._DateFrom; }
                set { this._DateFrom = value; }
            }
            public string DateTo
            {
                get { return this._DateTo; }
                set { this._DateTo = value; }
            }
            public decimal Amount
            {
                get { return this._Amount; }
                set { this._Amount = value; }
            }
            public int FK_SaverID
            {
                get { return this._FK_SaverID; }
                set { this._FK_SaverID = value; }
            }
            public decimal Rest
            {
                get { return this._Rest; }
                set { this._Rest = value; }
            }
            public decimal Surplus
            {
                get { return this._Surplus; }
                set { this._Surplus = value; }
            }
            public string Name
            {
                get { return this._Name; }
                set { this._Name = value; }
            }
            public string Mobile
            {
                get { return this._Mobile; }
                set { this._Mobile = value; }
            }
            public string ID
            {
                get { return this._ID; }
                set { this._ID = value; }
            }
            public decimal Salary
            {
                get { return this._Salary; }
                set { this._Salary = value; }
            }
            public string JobName
            {
                get { return this._JobName; }
                set { this._JobName = value; }
            }
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            public string GurdianshipName
            {
                get { return this._GurdianshipName; }
                set { this._GurdianshipName = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_ProjectSuppliers
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                ProjectName,
                SupplierName,
                ProjectID,
                SupplierID,
                CategoryID,
                ItemID,
                ItemName,
                CategoryName,
                FullItemName,
                WasSupplied,
                Rest,
            }

            #region Fields
            private string _ProjectName;
            private string _SupplierName;
            private int _ProjectID;
            private int _SupplierID;
            private int _CategoryID;
            private int _ItemID;
            private string _ItemName;
            private string _CategoryName;
            private string _FullItemName;
            private string _WasSupplied;
            private int _Rest;
            #endregion

            #region Properties
            public string ProjectName
            {
                get { return this._ProjectName; }
                set { this._ProjectName = value; }
            }
            public string SupplierName
            {
                get { return this._SupplierName; }
                set { this._SupplierName = value; }
            }
            public int ProjectID
            {
                get { return this._ProjectID; }
                set { this._ProjectID = value; }
            }
            public int SupplierID
            {
                get { return this._SupplierID; }
                set { this._SupplierID = value; }
            }
            public int CategoryID
            {
                get { return this._CategoryID; }
                set { this._CategoryID = value; }
            }
            public int ItemID
            {
                get { return this._ItemID; }
                set { this._ItemID = value; }
            }
            public string ItemName
            {
                get { return this._ItemName; }
                set { this._ItemName = value; }
            }
            public string CategoryName
            {
                get { return this._CategoryName; }
                set { this._CategoryName = value; }
            }
            public string FullItemName
            {
                get { return this._FullItemName; }
                set { this._FullItemName = value; }
            }
            public string WasSupplied
            {
                get { return this._WasSupplied; }
                set { this._WasSupplied = value; }
            }
            public int Rest
            {
                get { return this._Rest; }
                set { this._Rest = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_ProjectSupplies
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                ProjectName,
                ProjectID,
                CategoryID,
                ItemID,
                ItemName,
                CategoryName,
                FullItemName,
                WasSupplied,
                Rest,
                QTY,
                TotalSupplied,
                PK_ID,
            }

            #region Fields
            private string _ProjectName;
            private int _ProjectID;
            private int _CategoryID;
            private int _ItemID;
            private string _ItemName;
            private string _CategoryName;
            private string _FullItemName;
            private string _WasSupplied;
            private int _Rest;
            private decimal _QTY;
            private decimal _TotalSupplied;
            private int _PK_ID;
            #endregion

            #region Properties
            public string ProjectName
            {
                get { return this._ProjectName; }
                set { this._ProjectName = value; }
            }
            public int ProjectID
            {
                get { return this._ProjectID; }
                set { this._ProjectID = value; }
            }
            public int CategoryID
            {
                get { return this._CategoryID; }
                set { this._CategoryID = value; }
            }
            public int ItemID
            {
                get { return this._ItemID; }
                set { this._ItemID = value; }
            }
            public string ItemName
            {
                get { return this._ItemName; }
                set { this._ItemName = value; }
            }
            public string CategoryName
            {
                get { return this._CategoryName; }
                set { this._CategoryName = value; }
            }
            public string FullItemName
            {
                get { return this._FullItemName; }
                set { this._FullItemName = value; }
            }
            public string WasSupplied
            {
                get { return this._WasSupplied; }
                set { this._WasSupplied = value; }
            }
            public int Rest
            {
                get { return this._Rest; }
                set { this._Rest = value; }
            }
            public decimal QTY
            {
                get { return this._QTY; }
                set { this._QTY = value; }
            }
            public decimal TotalSupplied
            {
                get { return this._TotalSupplied; }
                set { this._TotalSupplied = value; }
            }
            public int PK_ID
            {
                get { return this._PK_ID; }
                set { this._PK_ID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_ProjectWorker
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                ProjectId,
                ProjectName,
                WorkerId,
                WorkerName,
            }

            #region Fields
            private int _ProjectId;
            private string _ProjectName;
            private int _WorkerId;
            private string _WorkerName;
            #endregion

            #region Properties
            public int ProjectId
            {
                get { return this._ProjectId; }
                set { this._ProjectId = value; }
            }
            public string ProjectName
            {
                get { return this._ProjectName; }
                set { this._ProjectName = value; }
            }
            public int WorkerId
            {
                get { return this._WorkerId; }
                set { this._WorkerId = value; }
            }
            public string WorkerName
            {
                get { return this._WorkerName; }
                set { this._WorkerName = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_Security
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                EmployeeName,
                Mobile,
                ID,
                JobName,
                Salary,
                UserName,
                Password,
                FK_RoleID,
                EmployeePK_ID,
                RoleName,
                PageName,
                ArabicName,
                PagePK_ID,
                Access,
                Tbl_RolePermissionPK_ID,
            }

            #region Fields
            private string _EmployeeName;
            private string _Mobile;
            private string _ID;
            private string _JobName;
            private decimal _Salary;
            private string _UserName;
            private string _Password;
            private int _FK_RoleID;
            private int _EmployeePK_ID;
            private string _RoleName;
            private string _PageName;
            private string _ArabicName;
            private int _PagePK_ID;
            private string _Access;
            private int _Tbl_RolePermissionPK_ID;
            #endregion

            #region Properties
            public string EmployeeName
            {
                get { return this._EmployeeName; }
                set { this._EmployeeName = value; }
            }
            public string Mobile
            {
                get { return this._Mobile; }
                set { this._Mobile = value; }
            }
            public string ID
            {
                get { return this._ID; }
                set { this._ID = value; }
            }
            public string JobName
            {
                get { return this._JobName; }
                set { this._JobName = value; }
            }
            public decimal Salary
            {
                get { return this._Salary; }
                set { this._Salary = value; }
            }
            public string UserName
            {
                get { return this._UserName; }
                set { this._UserName = value; }
            }
            public string Password
            {
                get { return this._Password; }
                set { this._Password = value; }
            }
            public int FK_RoleID
            {
                get { return this._FK_RoleID; }
                set { this._FK_RoleID = value; }
            }
            public int EmployeePK_ID
            {
                get { return this._EmployeePK_ID; }
                set { this._EmployeePK_ID = value; }
            }
            public string RoleName
            {
                get { return this._RoleName; }
                set { this._RoleName = value; }
            }
            public string PageName
            {
                get { return this._PageName; }
                set { this._PageName = value; }
            }
            public string ArabicName
            {
                get { return this._ArabicName; }
                set { this._ArabicName = value; }
            }
            public int PagePK_ID
            {
                get { return this._PagePK_ID; }
                set { this._PagePK_ID = value; }
            }
            public string Access
            {
                get { return this._Access; }
                set { this._Access = value; }
            }
            public int Tbl_RolePermissionPK_ID
            {
                get { return this._Tbl_RolePermissionPK_ID; }
                set { this._Tbl_RolePermissionPK_ID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_SubContractorExtract
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                WorkNameID,
                ExecutedQTY,
                FK_ProjectID,
            }

            #region Fields
            private int _WorkNameID;
            private int _ExecutedQTY;
            private int _FK_ProjectID;
            #endregion

            #region Properties
            public int WorkNameID
            {
                get { return this._WorkNameID; }
                set { this._WorkNameID = value; }
            }
            public int ExecutedQTY
            {
                get { return this._ExecutedQTY; }
                set { this._ExecutedQTY = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_SubContractorExtractNewOrder
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                NewExtractOrder,
                FK_ProjectID,
                LastPaid,
            }

            #region Fields
            private int _NewExtractOrder;
            private int _FK_ProjectID;
            private decimal _LastPaid;
            #endregion

            #region Properties
            public int NewExtractOrder
            {
                get { return this._NewExtractOrder; }
                set { this._NewExtractOrder = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public decimal LastPaid
            {
                get { return this._LastPaid; }
                set { this._LastPaid = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class view_subcontractorWork
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                SubContractorId,
                SubContractorName,
                WorkName,
            }

            #region Fields
            private int _SubContractorId;
            private string _SubContractorName;
            private string _WorkName;
            #endregion

            #region Properties
            public int SubContractorId
            {
                get { return this._SubContractorId; }
                set { this._SubContractorId = value; }
            }
            public string SubContractorName
            {
                get { return this._SubContractorName; }
                set { this._SubContractorName = value; }
            }
            public string WorkName
            {
                get { return this._WorkName; }
                set { this._WorkName = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_SubContractorWorkNames
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                SubContractorID,
                WorkName,
                WorkId,
            }

            #region Fields
            private int _SubContractorID;
            private string _WorkName;
            private int _WorkId;
            #endregion

            #region Properties
            public int SubContractorID
            {
                get { return this._SubContractorID; }
                set { this._SubContractorID = value; }
            }
            public string WorkName
            {
                get { return this._WorkName; }
                set { this._WorkName = value; }
            }
            public int WorkId
            {
                get { return this._WorkId; }
                set { this._WorkId = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_SupplierExtract
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                SupplyNameID,
                ExecutedQTY,
                FK_ProjectID,
            }

            #region Fields
            private int _SupplyNameID;
            private int _ExecutedQTY;
            private int _FK_ProjectID;
            #endregion

            #region Properties
            public int SupplyNameID
            {
                get { return this._SupplyNameID; }
                set { this._SupplyNameID = value; }
            }
            public int ExecutedQTY
            {
                get { return this._ExecutedQTY; }
                set { this._ExecutedQTY = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class View_SupplierExtractNewOrder
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
                NewExtractOrder,
                FK_ProjectID,
                LastPaid,
            }

            #region Fields
            private int _NewExtractOrder;
            private int _FK_ProjectID;
            private decimal _LastPaid;
            #endregion

            #region Properties
            public int NewExtractOrder
            {
                get { return this._NewExtractOrder; }
                set { this._NewExtractOrder = value; }
            }
            public int FK_ProjectID
            {
                get { return this._FK_ProjectID; }
                set { this._FK_ProjectID = value; }
            }
            public decimal LastPaid
            {
                get { return this._LastPaid; }
                set { this._LastPaid = value; }
            }
            #endregion

            #region Storded Procedures
            #endregion

        }
        public class StordedProcedures
        {
            private DB_OperationProcess DB = new DB_OperationProcess();
            public enum Fields
            {
                ALL,
            }

            #region Fields
            #endregion

            #region Properties
            #endregion

            #region Storded Procedures
            public DataSet CompanyExtract(int ExractOrder, int ProjectID)
            {
                DB.AddSqlParameter("@ExractOrder", ExractOrder);
                DB.AddSqlParameter("@ProjectID", ProjectID);
                return (DataSet)DB.ExecuteSqlStored("CompanyExtract", N_Tier_Classes.DataAccessLayer.DB_OperationProcess.ResultReturnedDataType.DataSet);
            }
            public DataSet DailyWorkerExtract(int ExractOrder, int ProjectID, int WorkerId)
            {
                DB.AddSqlParameter("@ExractOrder", ExractOrder);
                DB.AddSqlParameter("@ProjectID", ProjectID);
                DB.AddSqlParameter("@WorkerId", WorkerId);
                return (DataSet)DB.ExecuteSqlStored("DailyWorkerExtract", N_Tier_Classes.DataAccessLayer.DB_OperationProcess.ResultReturnedDataType.DataSet);
            }
            public DataSet DailyWorkerLastExtract(int ExractOrder, int ProjectID, int WorkerId)
            {
                DB.AddSqlParameter("@ExractOrder", ExractOrder);
                DB.AddSqlParameter("@ProjectID", ProjectID);
                DB.AddSqlParameter("@WorkerId", WorkerId);
                return (DataSet)DB.ExecuteSqlStored("DailyWorkerLastExtract", N_Tier_Classes.DataAccessLayer.DB_OperationProcess.ResultReturnedDataType.DataSet);
            }
            public DataSet SubContractorExtract(int ExractOrder, int ProjectID, int SubContractorId)
            {
                DB.AddSqlParameter("@ExractOrder", ExractOrder);
                DB.AddSqlParameter("@ProjectID", ProjectID);
                DB.AddSqlParameter("@SubContractorId", SubContractorId);
                return (DataSet)DB.ExecuteSqlStored("SubContractorExtract", N_Tier_Classes.DataAccessLayer.DB_OperationProcess.ResultReturnedDataType.DataSet);
            }
            public DataSet SupplierExtract(int ExractOrder, int ProjectID, int SupplierID)
            {
                DB.AddSqlParameter("@ExractOrder", ExractOrder);
                DB.AddSqlParameter("@ProjectID", ProjectID);
                DB.AddSqlParameter("@SupplierID", SupplierID);
                return (DataSet)DB.ExecuteSqlStored("SupplierExtract", N_Tier_Classes.DataAccessLayer.DB_OperationProcess.ResultReturnedDataType.DataSet);
            }
            public DataSet SelectTestTableVariable(DataTable TableVar)
            {
                DB.AddSqlParameter("@TableVar", TableVar);
                return (DataSet)DB.ExecuteSqlStored("SelectTestTableVariable", N_Tier_Classes.DataAccessLayer.DB_OperationProcess.ResultReturnedDataType.DataSet);
            }
            #endregion

        }
    }
}
