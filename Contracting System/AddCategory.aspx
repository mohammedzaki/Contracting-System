<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="AddCategory.aspx.cs" Inherits="Contracting_System.AddCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    
     <style type="text/css">
        .style1
        {
            width: 92px;
        }
    .style2
    {
        font-size: x-large;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div style="direction: rtl">
    <h3 class="style2"> <strong>إضافة مادة جديدة </strong> </h3>
        <table style="width: 100%;">
        <tr>
            <td class="style1">
                &nbsp;
                اسم المادة:</td>
            <td>
                &nbsp;
            <input type="text" style="width: 137px" id="txt_CategoryName" /></td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;
                قائمة المواد الخام :</td>
            <td>
                &nbsp;
            <select multiple="multiple" id="lst_CategoryList" 
                    style="width: 139px; height: 100px;" name="D1">
            <option></option>
        </select></td>
        </tr>
        </table>
        &nbsp;<p>
            <input id="Button1" type="button" value="إضافة" onclick="AddCategory()" class="btn_Save"/>
        </p>
    </div>
    <script src="js/AddCategory.js" type="text/javascript"></script>
</asp:Content>
