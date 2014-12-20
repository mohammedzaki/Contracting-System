<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="ReportFillterDailyCashbook.aspx.cs" Inherits="Contracting_System.ReportFillterDailyCashbook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">

    <script type="text/javascript">
        var pk_id;
        var subData;
        var searchData;
        var rest;
        var QTY;
        var SuppliesEventQTY;

        $(function () {
            $.ajax({
                url: "LoadData.aspx",
                type: "POST",
                data: {
                    action: "DailyCashbook"
                },
                success: function (data) {
                    subData = data;
                    $(subData).filter('main').find('Tbl_Project').each(function () {
                        $("#cbo_ProjectName").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    $(subData).filter('main').find('Tbl_Employees').each(function () {
                        $("#cbo_Employee").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    var categories = "";
                    $(subData).filter('main').find('Tbl_ExpensesCategories').each(function () {
                        categories += '<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>';
                    });
                    $("#cbo_ExpensesCategories").html('<option></option><option value="-4">مقاولين</option><option value="-3">موردين</option><option value="-2">عمالة يوميه</option>' + categories);
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Search").on("click", function () {
                $.ajax({
                    url: "ReportFillterDailyCashbook.aspx",
                    type: "POST",
                    data: {
                        cbo_ProjectName: $("#cbo_ProjectName").val(),
                        cbo_ExpensesCategories: $("#cbo_ExpensesCategories").val(),
                        cbo_ExpensesItems: $("#cbo_ExpensesItems").val(),
                        cbo_ExpensesWorkType: $("#cbo_ExpensesWorkType").val(),
                        txt_DateFrom: $("#txt_DateFrom").val(),
                        txt_DateTo: $("#txt_DateTo").val(),
                        cbo_ProjectType: $("#cbo_ProjectType").val(),
                        action: "LoadSearch"
                    },
                    success: function (data) {
                        searchData = data;
                        if ($(searchData).filter('main').find('Exception').text() == '') {
                            $("#grid_GuardianshipDetails").html('');
                            $(searchData).filter('main').find('View_Guradianship').each(function () {
                                var categroy = '';
                                var item = '';
                                var WorkFullName = '';
                                if ($(this).find('PersonTypeId').text() == '-4') {
                                    categroy = "مقاولين";
                                    item = $(this).find('PersonName').text();
                                    WorkFullName = $(this).find('WorkFullName').text();
                                } else if ($(this).find('PersonTypeId').text() == '-3') {
                                    categroy = "موردين";
                                    item = $(this).find('PersonName').text();
                                    WorkFullName = $(this).find('WorkFullName').text();
                                } else if ($(this).find('PersonTypeId').text() == '-2') {
                                    categroy = "عمالة باليوميه";
                                    item = $(this).find('PersonName').text();
                                } else {
                                    categroy = $(this).find('ExpensesCategoryName').text();
                                    item = $(this).find('ExpensesItemName').text();
                                }
                                $("#grid_GuardianshipDetails").append('<tr class="ItemRow"><td class="m_width">' + $(this).find('Name').text() + '</td><td class="m_width">' + categroy + '</td><td class="m_width">' + item + '</td><td class="m_width">' + WorkFullName + '</td><td class="s_width">' + $(this).find('GuardianshipItemAmount').text() + '</td><td class="b_width">' + $(this).find('GuardianshipItemDate').text() + '</td></tr>');
                            });
                        } else {
                            alert($(searchData).filter('main').find('Exception').text());
                        }
                    },
                    error: function (error) {
                        alert("Error happened please contact System Administrator : " + error.statusText);
                    }
                });
            });
        });
        function onChangeItemCategory(parent) {
            var cell = $("#cbo_ExpensesItems");
            var thirdcell = $("#cbo_ExpensesWorkType");
            $(cell).html("<option></option>");
            if ($(parent).val() > 0) {
                $(thirdcell).hide();
                $(cell).html("<option></option>");
                $(subData).filter('main').find('Tbl_ExpensesItems').each(function () {
                    if ($(parent).val() == $(this).find('FK_ExpenseCategory').text()) {
                        $(cell).append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    }
                });
            } else {
                $(thirdcell).show();
                $(thirdcell).html("<option></option>");
                switch ($(parent).val().toString()) {
                    case "-4": // subContractor
                        $(subData).filter('main').find('View_ProjectContractors').each(function () {
                            if ($("#cbo_ProjectName").val() == $(this).find('ProjectId').text()) {
                                $(cell).append('<option value="' + $(this).find('SubContractorId').text() + '" >' + $(this).find('SubContractorName').text() + '</option>');
                            }
                        });
                        break;
                    case "-3": //Suppliers
                        $(subData).filter('main').find('Tbl_Supplier').each(function () {
                            if ($("#cbo_ProjectName").val() == $(this).find('ProjectID').text()) {
                                $(cell).append('<option value="' + $(this).find('SupplierID').text() + '" >' + $(this).find('SupplierName').text() + '</option>');
                            }
                        });
                        break;
                    case "-2": //DailyWorker
                        $(thirdcell).hide();
                        $(subData).filter('main').find('View_ProjectWorker').each(function () {
                            if ($("#cbo_ProjectName").val() == $(this).find('ProjectId').text()) {
                                $(cell).append('<option value="' + $(this).find('WorkerId').text() + '" >' + $(this).find('WorkerName').text() + '</option>');
                            }
                        });
                        break;
                    default:
                        break;
                }
            }
        }
        function onChangeItemName(parent) {
            var cell = $("#cbo_ExpensesWorkType");
            var parentCategroy = $("#cbo_ExpensesCategories");
            switch ($(parentCategroy).val().toString()) {
                case "-4": //subContractor
                    $(subData).filter('main').find('View_ProjectContractor').each(function () {
                        if ($(parent).val() == $(this).find('SubContractorID').text() && $("#cbo_ProjectName").val() == $(this).find('ProjectId').text()) {
                            $(cell).append('<option value="' + $(this).find('FK_WorkId').text() + '" >' + $(this).find('FullWorkName').text() + '</option>');
                        }
                    });
                    break;
                case "-3": //Suppliers
                    $(subData).filter('main').find('View_ProjectSuppliers').each(function () {
                        if ($(parent).val() == $(this).find('SupplierID').text()) {
                            $(cell).append('<option value="' + $(this).find('SupplierID').text() + '" >' + $(this).find('FullItemName').text() + '</option>');
                        }
                    });
                    break;
                case "-2": //DailyWorker

                    break;
                default:
                    break;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div>
        اختر نوع المشاريع
        <br />
        <select id="cbo_ProjectType">
            <option value="0">مشاريع مغلقة</option>
            <option value="1">مشاريع جاريه</option>
        </select>
    </div>
    <br />
    <div>
        <table>
            <tr>
                <td class="style24">اسم المشروع :
                </td>
                <td class="style24">البند :
                </td>
                <td class="style24">الاسم :
                </td>
                <td class="style24">نوع العمل :
                </td>
                <td class="style24">التاريخ من:
                </td>
                <td class="style24">التاريخ الى:
                </td>
            </tr>
            <tr>
                <td>
                    <select id="cbo_ProjectName" class="m_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_ExpensesCategories" class="m_width" onchange="onChangeItemCategory(this)">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_ExpensesItems" class="m_width" onchange="onChangeItemName(this)">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_ExpensesWorkType" class="m_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <input id="txt_DateFrom" type="text" class="s_width IsDate" />
                </td>
                <td>
                    <input id="txt_DateTo" type="text" class="s_width IsDate" />
                </td>
                <td rowspan="2" style="text-align: center;">
                    <input id="btn_Search" type="button" value="عرض" class="btn_Save" />
                </td>
            </tr>
        </table>
        <h3>المصروفات</h3>
        <table>
            <thead>
                <tr class="HeaderRow">
                    <td class="m_width">اسم المشروع
                    </td>
                    <td class="m_width">البند
                    </td>
                    <td class="m_width">الاسم
                    </td>
                    <td class="m_width">نوع العمل
                    </td>
                    <td class="s_width">القيمة
                    </td>
                    <td class="b_width">التاريخ
                    </td>
                </tr>
            </thead>
            <tbody id="grid_GuardianshipDetails">
                <tr class="ItemRow">
                    <td class="m_width">اسم المشروع
                    </td>
                    <td class="m_width">البند
                    </td>
                    <td class="m_width">الاسم
                    </td>
                    <td class="m_width">نوع العمل
                    </td>
                    <td class="s_width">القيمة
                    </td>
                    <td class="b_width">التاريخ
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
