using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    public partial class Site : System.Web.UI.MasterPage
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

        protected void Page_Load(object sender, EventArgs e)
        {
            userId = int.Parse(Session["UserId"].ToString());
            UserName.InnerText = Session["UserName"].ToString();
            Tbl_Security = (DataTable)Session["Tbl_Security"];

            if (userId > 0)
            {
                //doc.LoadHtml(menuSite.InnerHtml);
                doc1.LoadHtml(StandardClass.menuHtml);

                ULMenuNode = doc1.DocumentNode.SelectNodes("//ul")[0];
                Link_Nodes = ULMenuNode.SelectNodes("//a[@href]");

                doc2.LoadHtml(StandardClass.shortMenuHtml);

                ULShortMenuNode = doc2.DocumentNode.SelectNodes("//ul")[0];
                Link_NodesShort = ULShortMenuNode.SelectNodes("//a[@href]");
                
                foreach (HtmlNode currentLink in Link_Nodes)
                {
                    if (currentLink.Attributes["href"].Value != "#" && currentLink.Attributes["href"].Value != "")
                    {
                        PageName = currentLink.Attributes["href"].Value;
                        rows = Tbl_Security.Select("PageName = '" + PageName + "'");
                        if (rows.Count() > 0)
                        {
                            accessType = bool.Parse(rows[0]["Access"].ToString());
                        }
                        else
                        {
                            accessType = false;
                        }
                        if (!accessType)
                        {
                            currentLink.ParentNode.Remove();
                        }
                    }
                }
                foreach (HtmlNode currentLink in Link_NodesShort)
                {
                    if (currentLink.Attributes["href"].Value != "#" && currentLink.Attributes["href"].Value != "")
                    {
                        PageName = currentLink.Attributes["href"].Value;
                        rows = Tbl_Security.Select("PageName = '" + PageName + "'");
                        if (rows.Count() > 0)
                        {
                            accessType = bool.Parse(rows[0]["Access"].ToString());
                        }
                        else
                        {
                            accessType = false;
                        }
                        if (!accessType)
                        {
                            currentLink.ParentNode.Remove();
                        }
                    }
                }
                arrangeMenu(ULMenuNode);
                menuSite.InnerHtml = ULMenuNode.OuterHtml;
                shortMenu.InnerHtml = ULShortMenuNode.OuterHtml;
                btn_LogIn.Visible = false;
                btn_LogOut.Visible = true;
            }
            else
            {
                menuSite.InnerHtml = "";
                shortMenu.InnerHtml = "<ul></ul>";
                btn_LogIn.Visible = true;
                btn_LogOut.Visible = false;
            }
        }

        public void arrangeMenu(HtmlNode MenuNode)
        {
            HtmlNodeCollection uls = MenuNode.SelectNodes("//ul");
            foreach (HtmlNode currentNode in uls.Reverse())
            {
                int count = 0;
                foreach (var item in currentNode.ChildNodes)
                {
                    if (item.Name == "li")
                        count++;
                }
                if (count == 0)
                {
                    currentNode.ParentNode.Remove();
                }
            }

        }

        protected void btn_LogIn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("LogIn.aspx");
        }

        protected void btn_LogOut_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("LogOut.aspx");
        }
    }
}