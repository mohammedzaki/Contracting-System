using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using N_Tier_Classes.DataAccessLayer;
using System.Data;

namespace Contracting_System
{
    public class Global : System.Web.HttpApplication
    {

        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            DB_OperationProcess.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string[] conn = DB_OperationProcess.ConnectionString.Split(
                new string[] { 
                    ";",
                    "Data Source=", 
                    "Initial Catalog=", 
                    "Integrated Security=", 
                    "User ID=", 
                    "password=" }, StringSplitOptions.RemoveEmptyEntries);
            DB_OperationProcess.ServerName = conn[0];
            DB_OperationProcess.DatabaseName = conn[1];
            DB_OperationProcess.IntegratedSecurity = bool.Parse(conn[2]);
            if (conn.Length > 3)
            {
                DB_OperationProcess.UserID = conn[3];
                DB_OperationProcess.UserPassword = conn[4];
            }
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }

        void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started
            Session.Add("UserId", -1);
            Session.Add("UserName", "");
            Session.Add("IsAdmin", false);
            Session.Add("Tbl_Security", new DataTable());
        }

        void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.

        }

    }
}
