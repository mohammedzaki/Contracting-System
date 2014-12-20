<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="DailySuppliesbook.aspx.cs" Inherits="Contracting_System.DailySuppliesbook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        #Select1
        {
            width: 153px;
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
            width: 160px;
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
        #Select4
        {
            width: 116px;
        }
        #UnitPrice
        {
            width: 72px;
        }
    </style>
    <script type="text/javascript">
        var subData = null;
        var ProjectSupplyID = '';
        $(function () {
            $.ajax({
                url: "LoadData.aspx",
                type: "POST",
                data: {
                    action: location.pathname.substr(location.pathname.lastIndexOf('/') + 1, (location.pathname.length - 6))
                },
                success: function (data) {
                    subData = data;
                    $(subData).filter('main').find('Tbl_Projects').each(function () {
                        $("#cbo_ProjectName").append('<option value="' + $(this).find('ProjectId').text() + '" >' + $(this).find('ProjectName').text() + '</option>');
                    });
                    $("#cbo_ProjectName").on("change", function () {
                        $("#cbo_SupplieisCategory").html('<option></option>');
                        $(subData).filter('main').find('Tbl_Categories').each(function () {
                            if ($("#cbo_ProjectName").val() == $(this).find('ProjectId').text()) {
                                $("#cbo_SupplieisCategory").append('<option value="' + $(this).find('CategoryID').text() + '" >' + $(this).find('CategoryName').text() + '</option>');
                            }
                        });
                    });
                    $("#cbo_SupplieisCategory").on("change", function () {
                        $("#cbo_SupplierNames").html('<option></option>');
                        $(subData).filter('main').find('Tbl_Suppliers').each(function () {
                            if ($("#cbo_SupplieisCategory").val() == $(this).find('CategoryID').text()) {
                                $("#cbo_SupplierNames").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                            }
                        });
                        $("#cbo_ItemType").html('<option></option>');
                        $(subData).filter('main').find('View_ProjectSupplies').each(function () {
                            if ($("#cbo_SupplieisCategory").val() == $(this).find('CategoryID').text() && $("#cbo_ProjectName").val() == $(this).find('ProjectId').text()) {
                                $("#cbo_ItemType").append('<option value="' + $(this).find('ItemID').text() + '" >' + $(this).find('ItemName').text() + '</option>');
                            }
                        });
                    });
                    $("#cbo_ItemType").on("change", function () {
                        $(subData).filter('main').find('View_ProjectSupplies').each(function () {
                            if ($("#cbo_ItemType").val() == $(this).find('ItemID').text()) {
                                $("#txt_RestSupplies").val($(this).find('Rest').text());
                                $("#txt_WasSupplies").val($(this).find('TotalSupplied').text());
                                ProjectSupplyID = $(this).find('PK_ID').text();
                            }
                        });
                    });
                    $(".changePrice").change(function () {
                        $("#txt_TotalPrice").val(parseFloat($("#txt_SuppliesQTY").val()) * parseFloat($("#txt_UnitPrice").val()));
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Save").on("click", function () {
                if ($("#cbo_ProjectName").val() != '' &&
                    $("#cbo_SupplieisCategory").val() != '' &&
                    $("#cbo_SupplierNames").val() != '' &&
                    $("#cbo_ItemType").val() != '' &&
                    $("#txt_SuppliesQTY").val() != '' &&
                    $("#txt_UnitPrice").val() != ''
                    ) {
                    $.ajax({
                        url: "SaveData.aspx",
                        type: "POST",
                        data: {
                            cbo_ProjectName: $("#cbo_ProjectName").val(),
                            cbo_SupplieisCategory: $("#cbo_SupplieisCategory").val(),
                            cbo_SupplierNames: $("#cbo_SupplierNames").val(),
                            cbo_ItemType: $("#cbo_ItemType").val(),
                            txt_SuppliesQTY: $("#txt_SuppliesQTY").val(),
                            txt_UnitPrice: $("#txt_UnitPrice").val(),
                            txt_TotalPrice: $("#txt_TotalPrice").val(),
                            txt_RestSupplies: $("#txt_RestSupplies").val(),
                            txt_ReciptNo: $("#txt_ReciptNo").val(),
                            txt_Date: $("#txt_Date").val(),
                            ProjectSupplyID: ProjectSupplyID,
                            action: location.pathname.substr(location.pathname.lastIndexOf('/') + 1, (location.pathname.length - 6))
                        },
                        success: function (data) {
                            if ($(data).filter('main').find('Exception').text() == '') {
                                $("#billItems").append('<tr class="ItemRow"><td class="style13">' + $("#txt_Date").val() + '</td><td class="style14">' + $("#cbo_SupplieisCategory option:selected").text() + ' - ' + $("#cbo_ItemType option:selected").text() + '</td><td class="style15">' + $("#txt_TotalPrice").val() + '</td><td class="style16">' + $("#txt_SuppliesQTY").val() + '</td><td class="style16">' + $("#cbo_SupplierNames option:selected").text() + '</td></tr>');
                            } else {
                                alert($(data).filter('main').find('Exception').text());
                            }
                        },
                        error: function (error) {
                            alert("Error happened please contact System Administrator : " + error.statusText);
                        }
                    });
                } else {
                    alert("ادخل الاسم اولا");
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div>
        <table>
            <tr>
                <td class="style22">
                    اسم المشروع :
                </td>
                <td>
                    <select id="cbo_ProjectName" class="b_width">
                        <option></option>
                    </select>
                </td>
                <td class="style22">
                    نوع المادة الخام :
                </td>
                <td>
                    <select id="cbo_SupplieisCategory" onchange="SelectTheCategory()" class="b_width">
                        <option></option>
                    </select>
                </td>
                <td class="style22">
                    اسم المورد :
                </td>
                <td>
                    <select id="cbo_SupplierNames" class="b_width">
                        <option></option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="style22">
                    نوع الصنف :
                </td>
                <td>
                    <select id="cbo_ItemType" onchange="SelectItemType()" class="b_width">
                        <option></option>
                    </select>
                </td>
                <td class="style22">
                    سعر الوحدة :
                </td>
                <td>
                    <input id="txt_UnitPrice" type="text" class="b_width changePrice" />
                </td>
                <td class="style22">
                    الكميات المتبقية :
                </td>
                <td>
                    <input id="txt_RestSupplies" type="text" class="b_width" readonly/>
                </td>
            </tr>
            <tr>
                <td class="style22">
                    الكميات الاجمالية الموردة :
                </td>
                <td>
                    <input id="txt_WasSupplies" type="text" class="b_width" readonly/>
                </td>
                <td class="style22">
                    الكمية المورده :
                </td>
                <td>
                    <input id="txt_SuppliesQTY" type="text" class="b_width changePrice" />
                </td>
                <td class="style22">
                    إجمالى السعر :
                </td>
                <td>
                    <input id="txt_TotalPrice" type="text" readonly="readonly" class="b_width" />
                </td>
            </tr>
            <tr>
                <td class="style22">
                    رقم البون :
                </td>
                <td>
                    <input id="txt_ReciptNo" type="text" class="b_width" />
                </td>
                <td class="style22">
                    التاريخ :
                </td>
                <td>
                    <input id="txt_Date" type="text" class="b_width IsDate" />
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <input id="btn_Save" type="button" value="توريد" class="btn_Save"/>
                </td>
            </tr>
        </table>
        <h3>
            توريدات المشروع</h3>
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
                        الفئة
                    </td>
                    <td class="style10">
                        الكمية
                    </td>
                    <td class="style10">
                        المورد
                    </td>
                </tr>
            </thead>
            <tbody id="billItems">
            </tbody>
        </table>
    </div>
</asp:Content>
