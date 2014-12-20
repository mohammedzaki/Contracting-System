<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true" CodeBehind="EditSupplier.aspx.cs" Inherits="Contracting_System.EditSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">

    <div id="accordion">
        <h3>تعديل بيانات مورد
        </h3>
        <div style="direction: rtl">
            <table>
                <tr>
                    <td>اسم المورد :
                        </td>
                    <td>
                        <select id="Select2" onchange="EditSelectedType(this)" class="b_width">
                            <option></option>
                        </select>
                    </td>
                    <td>رقم الكود :
                        </td>
                    <td>
                        <input id="SupplierID" type="text" value="" readonly="readonly" class="b_width" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">الموبايل :</td>
                    <td>
                        <input id="Text3" type="text" class="b_width" />
                    </td>
                    <td>الأرضى :</td>
                    <td>
                        <input id="Text4" type="text" class="b_width" />
                    </td>
                </tr>
                <tr>
                    <td>العنــــوان :</td>
                    <td>
                        <input id="Text5" type="text" class="b_width" />
                    </td>
                </tr>
            </table>
        </div>
        <h3>تحديد نوع المادة الخام
        </h3>
        <div style="direction: rtl">
            <table>
                <tr>
                    <td class="style2">النوع :
                    </td>
                    <td>
                        <select id="Select1" name="D1" onchange="Select1_onclick(this)" class="b_width">
                            <option></option>
                        </select>
                        <input id="Button1" type="button" value="إضافة مادة جديدة" /></td>
                </tr>
                <tr>
                    <td class="style2">قائمة التوريدات :
                    </td>
                    <td>
                        <select id="SupList" multiple="multiple" class="b_width">
                        </select>

                        <input id="Button3" type="button" value="حذف المواد المختارة" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input id="Button2" type="button" value="حفظ التعديلات" class="btn_Save" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
