using HtmlAgilityPack;
using N_Tier_Classes.DataAccessLayer;
using N_Tier_Classes.ObjectLayer.ContractingSystem;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        HtmlNode ULMenuNode;
        HtmlNodeCollection Link_Nodes;
        HtmlNode ULShortMenuNode;
        HtmlNodeCollection Link_NodesShort;
        DataTable Tbl_Security = new DataTable();
        HtmlDocument doc1 = new HtmlDocument();
        HtmlDocument doc2 = new HtmlDocument();
        DataRow[] rows;
        string PageName = "";
        int userId = 0;
        bool accessType = false;
        DB_OperationProcess DB = new DB_OperationProcess();
        protected void Page_Load(object sender, EventArgs e)
        {
            //doc.LoadHtml(menuSite.InnerHtml);
            doc1.LoadHtml(StandardClass.menuHtml);

            ULMenuNode = doc1.DocumentNode.SelectNodes("//ul")[0];
            Link_Nodes = ULMenuNode.SelectNodes("//a[@href]");

            foreach (HtmlNode currentLink in Link_Nodes)
            {
                if (currentLink.Attributes["href"].Value != "#" && currentLink.Attributes["href"].Value != "")
                {
                    PageName = currentLink.Attributes["href"].Value;
                    var obj = DB.SelectScalar(Tbl_Pages.Fields.PageName, PageName);
                    if (obj == null) {
                        DB.Insert(TablesNames.Tbl_Pages,
                            Tbl_Pages.Fields.PK_ID, DB.NewID(TablesNames.Tbl_Pages),
                            Tbl_Pages.Fields.PageName, PageName,
                            Tbl_Pages.Fields.ArabicName, currentLink.InnerText);
                    }
                }
            }

        }

    }
}