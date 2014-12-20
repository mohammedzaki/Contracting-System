<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="AddEstimationItems.aspx.cs" Inherits="Contracting_System.AddEstimationItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        #lst_NotAddYet
        {
            width: 201px;
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div>
        <table>
            <tr>
                <td class="style23">
                    <label>اختر المقايسة :</label>
                </td>
                <td>
                     <input id="file1" type="file" runat="server" /><br/>
                        <asp:Button ID="btn_ImportEstemetion" runat="server" Text="احفظ المقايسة" OnClick="btn_ImportEstemetion_Click"/>
                        <input type="button" value="عودة للصفحة السابقة" onclick="window.history.go(-2)"/>
                </td>
            </tr>
           
        </table>
    </div>
</asp:Content>
