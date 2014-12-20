using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using N_Tier_Classes.DataAccessLayer;
using N_Tier_Classes.ObjectLayer.ContractingSystem;
using System.Data.SqlClient;

namespace Contracting_System
{
    public partial class RestoreDatabase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
        }

        DB_OperationProcess DB = new DB_OperationProcess();
        SqlConnection conn = new SqlConnection();
        SqlCommand command = new SqlCommand();

        protected void btn_Import_Click(object sender, EventArgs e)
        {
            if (file1.Value != "")
            {
                string fileExtension = file1.PostedFile.FileName.Substring(file1.PostedFile.FileName.Length - 4);
                if (fileExtension == ".bac")
                {
                    try
                    {
                        File.Delete(Server.MapPath("~/backup.bac"));
                        file1.PostedFile.SaveAs(Server.MapPath("~/backup.bac"));
                        string DiPath = Server.MapPath("~/backup.bac");
                        conn.ConnectionString = DB_OperationProcess.ConnectionString;
                        conn.Open();
                        conn.ChangeDatabase("master");
                        command.Connection = conn;

                        string query = "";

                        query = @"USE master alter database ContractingSystem set single_user with rollback immediate";
                        command.CommandText = query;
                        command.ExecuteNonQuery();

                        query = @"USE master RESTORE DATABASE ContractingSystem FROM  DISK = N'" + DiPath + "' WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 10";
                        command.CommandText = query;
                        command.ExecuteNonQuery();

                        query = @"USE master alter database ContractingSystem set multi_user";
                        command.CommandText = query;
                        command.ExecuteNonQuery();

                        conn.Close();
                        Response.Write("Import Successfull");
                    }
                    catch (Exception exp)
                    {
                        DB.RollBackTransaction();
                        Response.Write(exp.Message);
                    }
                }
                else
                {

                }
            }
        }
    }
}