<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="AddSupplier.aspx.cs" Inherits="Contracting_System.AddSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 322px;
        }
        #Text1
        {
            width: 225px;
        }
        #Text2
        {
            width: 180px;
        }
        #Text3
        {
            width: 225px;
        }
        #Text4
        {
            width: 180px;
        }
        #Text5
        {
            width: 225px;
        }
        #Select1
        {
            width: 161px;
        }
        .style2
        {
            width: 107px;
        }
        #TextArea1
        {
            height: 133px;
        }
        #Button2
        {
            width: 61px;
        }
        #Select2
        {
            width: 101px;
        }
        #suppliesList
        {
            width: 185px;
            height: 79px;
        }
        #suppliesTypes
        {
            width: 185px;
        }
        #Cbo_Items
        {
            width: 121px;
        }
        #Cbo_ItemsAddSupplier
        {
            width: 180px;
        }
        #lst_SuppliesList
        {
            width: 177px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <%--<link rel="stylesheet" href="../Styles/CodeJqueryCom/stylesheet.css" type="text/css" />
    <script src="../Styles/CodeJqueryCom/1.js" type="text/javascript"></script>
    <script src="../Styles/CodeJqueryCom/2.js" type="text/javascript"></script>--%>
   <script>
        $(function () {
            $("#accordion").accordion();
        });

        $(function () {
            $("#datepicker").datepicker();
        });

        $(function () {
            var spinner = $("#spinner").spinner();

            $("#disable").click(function () {
                if (spinner.spinner("option", "disabled")) {
                    spinner.spinner("enable");
                } else {
                    spinner.spinner("disable");
                }
            });
            $("#destroy").click(function () {
                if (spinner.data("ui-spinner")) {
                    spinner.spinner("destroy");
                } else {
                    spinner.spinner();
                }
            });
            $("#getvalue").click(function () {
                alert(spinner.spinner("value"));
            });
            $("#setvalue").click(function () {
                spinner.spinner("value", 5);
            });

            $("button").button();
        });

        function addSelectedType(obj) {
            var selected = $(obj).val();
            $("#suppliesList").append('<option value="1">' + selected + '</option>');
        }
</script>

    <div id="accordion">
        <h3 class="ui-datepicker-rtl">
            تسجيل بيانات مورد
        </h3>
        <div style="direction: rtl">
            <table style="width: 100%;">
                <tr>
                    <td class="style1">
                        &nbsp; اسم المورد :<input id="txt_SupplierName" type="text" />
                    </td>
                    <td>
                        &nbsp; رقم الكود :&nbsp;&nbsp;
                        <input id="txt_SupplierCode" type="text" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        &nbsp; الموبايل :&nbsp;
                        <input id="txt_SupplierMobile" type="text" class="IsNumberOnly"/>
                    </td>
                    <td>
                        &nbsp; الأرضى :&nbsp;&nbsp;&nbsp;
                        <input id="txt_SupplierTel" type="text" class="IsNumberOnly"/>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        العنــــوان :&nbsp;
                        <input id="txt_SupplierAddress" type="text" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        <input id="btn_SaveSupplier" type="button" value="حفظ" onclick="SaveNewSupplier()" class="btn_Save"/>
                        <input id="Button3" type="button" value="إضافة مورد جديد" onclick="document.location.reload()" class="btn_Save"/>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <h3 class="ui-datepicker-rtl">
            تحديد نوع المادة الخامات
        </h3>
        <div style="direction: rtl">
            <table style="width: 100%;">
                <tr>
                    <td class="style2">
                        &nbsp; النوع 
                        التوريد :
                    </td>
                    <td>
                        <select id="Cbo_ItemsAddSupplier" >
                            <option></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        قائمة التوريدات :
                    </td>
                    <td>
                        <select name="drop1" id="lst_SuppliesList" size="4" multiple="multiple">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        <input id="Button1" type="button" value="حفظ" onclick="SelectFromCbo_Items()" class="btn_Save" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script src="js/AddSupplier.js" type="text/javascript"></script>
</asp:Content>
