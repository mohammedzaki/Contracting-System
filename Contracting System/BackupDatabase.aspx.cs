using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using N_Tier_Classes.DataAccessLayer;
using System.Data;
using System.Data.SqlClient;

namespace Contracting_System
{
    public partial class BackupDatabase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Security();
        }
        
        DB_OperationProcess DB = new DB_OperationProcess();
        SqlConnection conn = new SqlConnection();
        SqlCommand command = new SqlCommand();
        protected void btn_Export_Click(object sender, EventArgs e)
        {
            Response.AppendHeader("Content-Disposition", "attachment; filename=backup.bac");
            Response.ContentType = "application/bac";
            File.Delete(Server.MapPath("~/backup.bac"));
            string DiPath = Server.MapPath("~/backup.bac");
            conn.ConnectionString = DB_OperationProcess.ConnectionString;
            conn.Open();
            string query = @"use master BACKUP DATABASE ContractingSystem TO DISK = N'" + DiPath + "' WITH NOFORMAT, NOINIT, NAME = N'<Database_Name, sysname, Database_Name>-Full Database Backup', SKIP, STATS = 10;";
            command.CommandText = query;
            command.Connection = conn;
            command.ExecuteNonQuery();
            conn.Close();
            Response.WriteFile(Server.MapPath("~/backup.bac"));
            Response.End();
        }

    }
}