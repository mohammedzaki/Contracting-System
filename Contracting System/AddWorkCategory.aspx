<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="AddWorkCategory.aspx.cs" Inherits="Contracting_System.AddWorkCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    
     <style type="text/css">
        .style1
        {
             width: 106px;
         }
    .style2
    {
        font-size: x-large;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <script src="js/AddWorkCategory.js" type="text/javascript"></script>
    <div style="direction: rtl">
    <h3 class="style2"> <strong>إضافة عمل مقاولى باطن جديد </strong> </h3>
        <table style="width: 100%;">
        <tr>
            <td class="style1">
                &nbsp;
                 العمل :</td>
            <td>
                &nbsp;
            <input type="text" style="width: 137px" id="txt_WorkName" /></td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;
                قائمة اعمال مقاول الباطن :</td>
            <td>
                &nbsp;
            <select multiple="multiple" id="lst_WorkList" style="width: 139px" name="D1">
            <option></option>
        </select></td>
        </tr>
        </table>
        &nbsp;<p>
            <input id="Button1" type="button" value="إضافة" onclick="AddWorkType()" class="btn_Save"/>
        </p>
    </div>
</asp:Content>
