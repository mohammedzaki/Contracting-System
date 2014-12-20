<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true" CodeBehind="AddMeasurementUnit.aspx.cs" Inherits="Contracting_System.AddMeasurementUnit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script src="js/AddMeasurementUnit.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            width: 121px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    
    <div style="direction: rtl">
    <h3 class="style2"> <strong>إضافةوحدة قياس جديدة </strong> </h3>
        <table style="width:auto; height: 121px">
        <tr>
            <td class="style1">
                &nbsp;
                وحدة القياس :</td>
            <td>
                &nbsp;
            <input type="text" id="txt_MeasurUnit" style="width: 137px;" /></td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;
                قائمة وحدات القياس :</td>
            <td>
                &nbsp;
            <select multiple="multiple" id="Lst_Units" style="width: 139px; height: 126px;"  
                    name="D1">
            
        </select></td>
        </tr>
        </table>
        &nbsp;<p>
            <input id="Button1" type="button" value="إضافة" onclick="SaveMeasurementUnit()" class="btn_Save"/>
            &nbsp;&nbsp;&nbsp;
        </p>
    </div>
    
</asp:Content>
