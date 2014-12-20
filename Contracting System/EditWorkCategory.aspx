<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="EditWorkCategory.aspx.cs" Inherits="Contracting_System.EditWorkCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script src="js/EditWorkCategory.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div style="direction: rtl">
    <h3 class="style2"> <strong>تعديل أعمال مقاولى الباطن</strong> </h3>
        <table style="width:auto;">
        <tr>
            <td class="style1">
                &nbsp;
                اسم العمل:</td>
            <td>
                &nbsp;<select id="Cbo_EditCategory" onchange="SelectEditCategory()">
                          <option></option>
                      </select></td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;
                التعديل :</td>
            <td>
                &nbsp;
                <input id="txt_EditCategory" type="text"/>
           
        </td>
        </tr>
        </table>
        &nbsp;<p>
            <input id="Button1" type="button" value="حفظ" onclick="UpdateCategory()" class="btn_Save"/>
        </p>
    </div>
</asp:Content>
