using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data;
using N_Tier_Classes.DataAccessLayer;

namespace Contracting_System
{
    public class DataBase
    {
        public void InsertData(string Query)
        {
            SqlConnection _conn = new SqlConnection(DB_OperationProcess.ConnectionString);
            _conn.Open();
            SqlCommand cmd = new SqlCommand(Query,_conn);
            cmd.ExecuteNonQuery();
            _conn.Close();
        }

        public DataTable ReturnTable(string Query)
        {
            SqlConnection _conn = new SqlConnection(DB_OperationProcess.ConnectionString);
            _conn.Open();
            SqlCommand cmd = new SqlCommand(Query, _conn);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable DT = new DataTable();
            DT.Load(dr);
            _conn.Close();
            return DT;
        }

        public DataRow ReturnRow(string Query)
        {
            SqlConnection _conn = new SqlConnection(DB_OperationProcess.ConnectionString);
            _conn.Open();
            SqlCommand cmd = new SqlCommand(Query, _conn);
            SqlDataReader dr = cmd.ExecuteReader();
            
            DataTable DT = new DataTable();
            DT.Load(dr);
            _conn.Close();
            DataRow row;
            if (DT.Rows.Count > 0)
            {
                row = DT.Rows[0];  
            }
            else
            {
                row = null;
            }
            
            
            return row;

        }

    }
}