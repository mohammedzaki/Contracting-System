<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="AddSubcontractor.aspx.cs" Inherits="Contracting_System.AddSubcontractor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        #Cbo_SubContractorWorkType
        {
            width: 125px;
        }
        .style1
        {
            width: 167px;
        }
        #cbo_SubContractorWorkCategory
        {
            width: 124px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div style="direction: rtl">
        <h3>
            إضافة مقاول
        </h3>
        <table style="width: auto">
            <tr>
                <td>
                    اسم المقاول :&nbsp;
                </td>
                <td>
                    <input id="txt_SubContractorName" type="text" />
                </td>
                <td>
                    كود المقاول :
                </td>
                <td>
                    <input id="txt_SubContractorCode" readonly="readonly" type="text" />
                </td>
            </tr>
            <tr>
                <td>
                    الموبايل :&nbsp;
                </td>
                <td>
                    <input id="txt_SubContractorMobile" type="text" class="IsNumberOnly" />
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;الأرضى :
                </td>
                <td>
                    <input id="txt_SubContractorTel" type="text" class="IsNumberOnly" />
                </td>
            </tr>
            <tr>
                <td>
                    العنوان :
                </td>
                <td>
                    <input id="txt_SubContractorAddress" type="text" />
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <br />
        <input id="Button6" type="button" value="حفظ" onclick="AddSubContractor()" class="btn_Save" />
        <input id="Button7" type="button" value="إلغاء" onclick="ResetPage()" class="btn_Save" />
    </div>
    <script src="js/AddSubcontractor.js" type="text/javascript"></script>
</asp:Content>
