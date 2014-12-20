<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true" CodeBehind="EditSubcontractors.aspx.cs" Inherits="Contracting_System.EditSubcontractors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        #Select5 {
            width: 112px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div style="direction: rtl">
        <h3>تعديل بيانات مقاول </h3>
        اختر المقاول :&nbsp;
        <select id="cbo_EditSubcontractors" class="b_width" >
            <option></option>
        </select>
        <table style="width: auto">
            <tr>
                <td>اسم المقاول :&nbsp;
                </td>
                <td>
                    <input id="txt_SubContractorName" type="text" />
                </td>
                <td>كود المقاول :
                </td>
                <td>
                    <input id="txt_SubContractorCode" readonly="readonly" type="text" />
                </td>
            </tr>
            <tr>
                <td>الموبايل :&nbsp;
                </td>
                <td>
                    <input id="txt_SubContractorMobile" type="text" class="IsNumberOnly" />
                </td>
                <td>&nbsp;&nbsp;&nbsp;الأرضى :
                </td>
                <td>
                    <input id="txt_SubContractorTel" type="text" class="IsNumberOnly" />
                </td>
            </tr>
            <tr>
                <td>العنوان :
                </td>
                <td>
                    <input id="txt_SubContractorAddress" type="text" />
                </td>
                <td></td>
                <td></td>
            </tr>
        </table>
        <br />
        <input id="Button6" type="button" value="حفظ" onclick="UpdateSubContractor()" class="btn_Save" />
        <input id="Button7" type="button" value="إلغاء" onclick="ResetPage()" class="btn_Save" />
    </div>
    <script src="js/EditSubcontractor.js" type="text/javascript"></script>
</asp:Content>
