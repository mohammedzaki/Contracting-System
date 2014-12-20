<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true" CodeBehind="EditSupplier.aspx.cs" Inherits="Contracting_System.EditSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        .auto-style4 {
            width: 75px;
        }

        .auto-style6 {
            width: 74px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">

    <div id="accordion">
        <h3>تعديل بيانات مورد
        </h3>
        <br />
        <table style="width: auto">
            <tr>
                <td class="auto-style4">اختر المورد :
                </td>
                <td>
                    <select id="cbo_EditSuppliers" class="b_width">
                        <option></option>
                    </select>
                </td>
                <td class="auto-style6"></td>
                <td></td>
            </tr>
            <tr>
                <td class="auto-style4">
                    <br />
                </td>
                <td></td>
                <td class="auto-style6"></td>
                <td></td>
            </tr>
            <tr>
                <td class="auto-style4">اسم المقاول :
                </td>
                <td>
                    <input id="txt_SupplierName" type="text" class="b_width" />
                </td>
                <td class="auto-style6">كود المقاول :
                </td>
                <td>
                    <input id="txt_SupplierCode" readonly="readonly" type="text" class="b_width" />
                </td>
            </tr>
            <tr>
                <td class="auto-style4">الموبايل :
                </td>
                <td>
                    <input id="txt_SupplierMobile" type="text" class="IsNumberOnly b_width" />
                </td>
                <td class="auto-style6">الأرضى :
                </td>
                <td>
                    <input id="txt_SupplierTel" type="text" class="IsNumberOnly b_width" />
                </td>
            </tr>
            <tr>
                <td class="auto-style4">العنوان :
                </td>
                <td>
                    <input id="txt_SupplierAddress" type="text" class="b_width" />
                </td>
                <td class="auto-style6"></td>
                <td></td>
            </tr>
        </table>
        <br />
        <h3>تحديد نوع المادة الخام
        </h3>
        <br />
        <table style="width: auto">
            <tr>
                <td class="auto-style6">النوع :
                </td>
                <td>
                    <select class="b_width" id="cbo_SelectSupplies">
                        <option></option>
                    </select>
                    <input type="button" value="إضافة مادة جديدة" onclick="SelectFromCbo_Items()" /></td>
            </tr>
            <tr>
                <td class="auto-style6">قائمة التوريدات :
                </td>
                <td>
                    <select id="SupList" multiple="multiple" class="b_width">
                    </select>

                    <%--<input type="button" value="حذف المواد المختارة" />--%></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input id="Button6" type="button" value="حفظ" onclick="UpdateSupplier()" class="btn_Save" />
                    <input id="Button7" type="button" value="إلغاء" onclick="ResetPage()" class="btn_Save" />
                </td>
            </tr>
        </table>
    </div>
    <script src="js/EditSupplier.js" type="text/javascript"></script>
</asp:Content>
