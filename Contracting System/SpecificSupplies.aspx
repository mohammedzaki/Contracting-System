<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="SpecificSupplies.aspx.cs" Inherits="Contracting_System.NewProject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        #Select1
        {
            width: 129px;
        }
    </style>
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
        <p>
        اسم المورد : &nbsp;
        <select id="Select1">
            <option>احمد</option>
            <option>ابراهيم</option>
            <option>علاء</option>
        </select>
        &nbsp;&nbsp;&nbsp;
        كود المورد : &nbsp;
            <input id="Text1" type="text" />
        </p>
        <p>
           المشروع : &nbsp;
        <select id="Select2">
            <option>مشروع اسكان الجوهرة</option>
        </select> 
       <h3>قائمة التوريدات</h3>
       <table style="height: 55px;">
                <thead>
                    <tr class="HeaderRow">
                        <td class="style7">
                            التاريخ
                        </td>
                        <td class="style8">
                            نوع المادة الخام
                        </td>
                        <td class="style9">
                            الوحدة
                        </td>
                        <td class="style10">
                            الكمية
                        </td>
                        <td class="style10">
                            السعر
                        </td>
                        <td class="style10">
                            رقم الإيصال
                        </td>
                        <td class="style10">
                            الدفع
                        </td>
                    </tr>
                </thead>
                <tbody id="billItems">
                    <tr class="ItemRow">
                        <td class="style13">
                            <input type="text" style="width: 80px" value="1/12/2013" />
                        </td>
                        <td class="style14">
                            <input type="text" style="width: 100px" name="ItemNo" onchange="AddNewRow(this)"
                                value="حديد" />
                        </td>
                        <td class="style15">
                            <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)"
                                onkeypress="return isNumber(event);" value="10" />
                        </td>
                        <td class="style16">
                            <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"
                                style="width: 136px" value="5000" />
                        </td>
                        <td class="style16">
                            <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"
                                style="width: 100px" value="100" />
                        </td>

                        <td class="style16">
                            <input type="text"  value="1234" /></td>

                        <td class="style16">
                             <input type="button"  value="دفع" />
                             <input type="button"  value="دفع جزء" />
                             </td>
                    </tr>
                    <tr class="ItemRow">
                        <td class="style13">
                            <input type="text" style="width: 80px" value="1/12/2013" />
                        </td>
                        <td class="style14">
                            <input type="text" style="width: 100px" name="ItemNo" onchange="AddNewRow(this)"
                                value="خشب" />
                        </td>
                        <td class="style15">
                            <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)"
                                onkeypress="return isNumber(event);" value="زان" />
                        </td>
                        <td class="style16">
                            <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"
                                style="width: 136px" value="600" />
                        </td>
                        <td class="style16">
                            <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"
                                style="width: 100px" value="200" />
                        </td>
                         <td class="style16">
                            <input type="text"  value="1234" /></td>

                        <td class="style16">
                             <input type="button"  value="دفع" />
                             <input type="button"  value="دفع جزء" />
                             </td>
                    </tr>
                    <tr class="ItemRow">
                        <td class="style13">
                            <input type="text" style="width: 80px" value="1/12/2013" />
                        </td>
                        <td class="style14">
                            <input type="text" style="width: 100px" name="ItemNo" onchange="AddNewRow(this)"
                                value="حديد" />
                        </td>
                        <td class="style15">
                            <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)"
                                onkeypress="return isNumber(event);" value="15" />
                        </td>
                        <td class="style16">
                            <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"
                                style="width: 136px" value="20" />
                        </td>
                        <td class="style16">
                            <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"
                                style="width: 100px" value="600" />
                        </td>
                        <td class="style16">
                            <input type="text"  value="1234" /></td>

                        <td class="style16">
                             <input type="button"  value="دفع" />
                             <input type="button"  value="دفع جزء" />
                             </td>
                    </tr>
                </tbody>
            </table>
             
             
        </p>
    </div>
</asp:Content>
