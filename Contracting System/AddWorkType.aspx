<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="AddWorkType.aspx.cs" Inherits="Contracting_System.AddWorkType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script src="js/AddWorkType.js" type="text/javascript"></script>
    <style type="text/css">
        .auto-style1
        {
            height: 32px;
        }
        
        .auto-style2
        {
            height: 32px;
            width: 160px;
        }
        
        .auto-style3
        {
            width: 261px;
        }
        .style8
        {
            height: 21px;
            width: 163px;
        }
        .style9
        {
            height: 21px;
            width: 156px;
        }
        .HeaderRow
        {
            background-color: Blue;
            color: White;
        }
        .ItemRow
        {
            background-color: Silver;
            color: White;
        }
        #cbo_Safe
        {
            width: 202px;
        }
        #cbo_Currency
        {
            width: 199px;
        }
        #txt_Description
        {
            width: 388px;
            height: 25px;
        }
        #cbo_Currency0
        {
            width: 199px;
        }
        #txt_ReceiptNo
        {
            width: 198px;
        }
        #txt_BillDeposit
        {
            width: 200px;
        }
        #cbo_TheUnits
        {
            width: 81px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div style="direction: rtl">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="AddWorkCategory.aspx">إضافة فئة عمل جديدة</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;

        <p>
            فئة العمل :&nbsp; &nbsp;
            <select id="Cbo_WorkCategory" style="width: 73px">
                <option></option>
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; نوع العمل  : &nbsp;
        <input id="txt_WorkTYpe" type="text" />
         <br/>
            <input id="Button1" type="button" value="إضافة" onclick="AddWorkType()" class="btn_Save"/> 
            &nbsp;&nbsp;
            </p>
           <h3>اعمال مقاولى الباطن المسجلة</h3>
           <table id="Tbl_Itemss" style="height: 55px;">
                <thead>
                    <tr class="HeaderRow">
                        <td class="style8">
                            فئة العمل
                        </td>
                        <td class="style9">
                            نوع العمل
                        </td>
                    </tr>
                </thead>
                <tbody id="billItems">
                   
                </tbody>
            </table>
            
            
        
    </div>
</asp:Content>
