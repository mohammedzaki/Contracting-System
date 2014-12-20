<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true" CodeBehind="EditItems.aspx.cs" Inherits="Contracting_System.EditItems" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
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
        .style7
        {
            height: 21px;
            width: 96px;
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
        .style13
        {
            height: 16px;
            width: 96px;
        }
        .style14
        {
            height: 16px;
            width: 163px;
        }
        .style15
        {
            height: 16px;
            width: 156px;
        }
        .style16
        {
            height: 16px;
            width: 137px;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div style="direction: rtl">
        <h3>
            قائمة انواع المواد الخام
        </h3>
        <table style="height: 55px;">
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
                        <td class="style10">
                            تعديل
                        </td>
                    </tr>
                </thead>
                <tbody id="billItems">
                    <tr class="ItemRow">
                        <td class="style14">
                            <input type="text" style="width: 160px" name="ItemNo" onchange="AddNewRow(this)"
                                value="حديد" />
                        </td>
                        <td class="style15">
                            <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)"
                                onkeypress="return isNumber(event);" value="10" />
                        </td>
                        <td class="style16">
                            <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"
                                style="width: 136px" value="طن" />
                        </td>

                        <td class="style16">
                             <input type="button"  value="تعديل" style="width: 50px" class="btn_Save"/>
                             <input type="button"  value="إلغاء" style="width: 50px" class="btn_Save"/>
                             </td>
                    </tr>
                    <tr class="ItemRow">
                        <td class="style14">
                            <input type="text" style="width: 160px" name="ItemNo" onchange="AddNewRow(this)"
                                value="خشب" />
                        </td>
                        <td class="style15">
                            <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)"
                                onkeypress="return isNumber(event);" value="زان" />
                        </td>
                        <td class="style16">
                            <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"
                                style="width: 136px" value="متر" />
                        </td>

                        <td class="style16">
                            <input type="button"  value="تعديل" style="width: 50px" class="btn_Save"/>
                             <input type="button"  value="إلغاء" style="width: 50px" class="btn_Save"/>
                             </td>
                    </tr>
                    <tr class="ItemRow">
                        <td class="style14">
                            <input type="text" style="width: 160px" name="ItemNo" onchange="AddNewRow(this)"
                                value="حديد" />
                        </td>
                        <td class="style15">
                            <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)"
                                onkeypress="return isNumber(event);" value="15" />
                        </td>
                        <td class="style16">
                            <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"
                                style="width: 136px" value="طن" />
                        </td>

                        <td class="style16">
                             <input type="button"  value="تعديل" style="width: 50px" class="btn_Save"/>
                             <input type="button"  value="إلغاء" style="width: 50px" class="btn_Save"/>
                             </td>
                    </tr>
                </tbody>
            </table>
        

        

    </div>
</asp:Content>
