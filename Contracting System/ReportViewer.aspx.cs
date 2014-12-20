using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using N_Tier_Classes.DataAccessLayer;
using System.Data;
namespace Contracting_System
{
    public partial class ReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // ReportViewer.aspx?ExractOrder=&ProjectID=&PersonID=
            if (Request.QueryString["Report"] == "1")
            {
                CrystalReportSource1.Report.FileName = Server.MapPath("company.rpt");
                CrystalReportSource1.ReportDocument.DataSourceConnections[0].IntegratedSecurity = DB_OperationProcess.IntegratedSecurity;
                CrystalReportSource1.ReportDocument.DataSourceConnections[0].SetConnection(DB_OperationProcess.ServerName, DB_OperationProcess.DatabaseName, DB_OperationProcess.UserID, DB_OperationProcess.UserPassword);
                CrystalReportSource1.ReportDocument.SetParameterValue("@ExractOrder", int.Parse(Request.QueryString["ExractOrder"]));
                CrystalReportSource1.ReportDocument.SetParameterValue("@ProjectID", int.Parse(Request.QueryString["ProjectID"]));
            }
            else if (Request.QueryString["Report"] == "2")
            {
                CrystalReportSource1.Report.FileName = Server.MapPath("SupplierEX.rpt");
                CrystalReportSource1.ReportDocument.DataSourceConnections[0].IntegratedSecurity = DB_OperationProcess.IntegratedSecurity;
                CrystalReportSource1.ReportDocument.DataSourceConnections[0].SetConnection(DB_OperationProcess.ServerName, DB_OperationProcess.DatabaseName, DB_OperationProcess.UserID, DB_OperationProcess.UserPassword);
                CrystalReportSource1.ReportDocument.SetParameterValue("@ExractOrder", int.Parse(Request.QueryString["ExractOrder"]));
                CrystalReportSource1.ReportDocument.SetParameterValue("@ProjectID", int.Parse(Request.QueryString["ProjectID"]));
                CrystalReportSource1.ReportDocument.SetParameterValue("@SupplierID", int.Parse(Request.QueryString["PersonID"]));
            }
            else if (Request.QueryString["Report"] == "3")
            {
                CrystalReportSource1.Report.FileName = Server.MapPath("SubContractor.rpt");
                CrystalReportSource1.ReportDocument.DataSourceConnections[0].IntegratedSecurity = DB_OperationProcess.IntegratedSecurity;
                CrystalReportSource1.ReportDocument.DataSourceConnections[0].SetConnection(DB_OperationProcess.ServerName, DB_OperationProcess.DatabaseName, DB_OperationProcess.UserID, DB_OperationProcess.UserPassword);
                CrystalReportSource1.ReportDocument.SetParameterValue("@ExractOrder", int.Parse(Request.QueryString["ExractOrder"]));
                CrystalReportSource1.ReportDocument.SetParameterValue("@ProjectID", int.Parse(Request.QueryString["ProjectID"]));
                CrystalReportSource1.ReportDocument.SetParameterValue("@SubContractorId", int.Parse(Request.QueryString["PersonID"]));
            }
            else if (Request.QueryString["Report"] == "4")
            {
                CrystalReportSource1.Report.FileName = Server.MapPath("DailyWorkerExract.rpt");
                CrystalReportSource1.ReportDocument.DataSourceConnections[0].IntegratedSecurity = DB_OperationProcess.IntegratedSecurity;
                CrystalReportSource1.ReportDocument.DataSourceConnections[0].SetConnection(DB_OperationProcess.ServerName, DB_OperationProcess.DatabaseName, DB_OperationProcess.UserID, DB_OperationProcess.UserPassword);
                CrystalReportSource1.ReportDocument.SetParameterValue("@ExractOrder", int.Parse(Request.QueryString["ExractOrder"]));
                CrystalReportSource1.ReportDocument.SetParameterValue("@ProjectID", int.Parse(Request.QueryString["ProjectID"]));
                CrystalReportSource1.ReportDocument.SetParameterValue("@WorkerId", int.Parse(Request.QueryString["PersonID"]));
            }
        }
    }
}