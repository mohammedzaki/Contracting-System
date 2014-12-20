<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="AddItems.aspx.cs" Inherits="Contracting_System.AddItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script src="js/AddItems.js" type="text/javascript"></script> 
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
        .style10
        {
            height: 21px;
            width: 137px;
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
<a href="AddCategory.aspx">إضافة فئة توريد جديدة</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;

        <a href="AddMeasurementUnit.aspx">اضافة وحدة قياس</a>
        <p>
            المادة الخام :&nbsp; &nbsp;
            <select id="Cbo_Category" style="width: 73px">
                <option></option>
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; نوع المادة الخام : &nbsp;
        <input id="txt_ItemType" type="text" />
        &nbsp;&nbsp;&nbsp;&nbsp;
        وحدة القياس : &nbsp;
        <select id="cbo_TheUnits">
            <option></option>
        </select>
        </p>
        <p>
            <input id="Button1" type="button" value="إضافة" onclick="AddItem()" class="btn_Save"/> 
            &nbsp;&nbsp;
            <input id="Button2" type="button" value="إلغاء" class="btn_Save"/> 
        </p>
           <h3> انواع المواد الخام المسجلة</h3>
           <table id="Tbl_Itemss" style="height: 55px;">
                <thead>
                    <tr class="HeaderRow">
                        <td class="style8">
                            النوع
                        </td>
                        <td class="style9">
                            الوحدة
                        </td>
                        <td class="style10">
                            القياس
                        </td>
                    </tr>
                </thead>
                <tbody id="billItems">
                   
                </tbody>
            </table>
            
            
        
    </div>
</asp:Content>
