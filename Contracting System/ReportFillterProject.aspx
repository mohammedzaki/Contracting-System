<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="ReportFillterProject.aspx.cs" Inherits="Contracting_System.ReportFillterProject" %>

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
                        $("#cbo_ProjectName1").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    $(subData).filter('main').find('Tbl_Employees').each(function () {
                        $("#cbo_Employee1").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    var categories = "";
                    $(subData).filter('main').find('Tbl_ExpensesCategories').each(function () {
                        categories += '<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>';
                    });
                    $("#cbo_ExpensesCategories1").html('<option></option><option value="-4">مقاولين</option><option value="-3">موردين</option><option value="-2">عمالة يوميه</option>' + categories);
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Search1").on("click", function () {
                $.ajax({
                    url: "ReportFillterDailyCashbook.aspx",
                    type: "POST",
                    data: {
                        cbo_ProjectName: $("#cbo_ProjectName1").val(),
                        cbo_ExpensesCategories: $("#cbo_ExpensesCategories1").val(),
                        cbo_ExpensesItems: $("#cbo_ExpensesItems1").val(),
                        cbo_ExpensesWorkType: $("#cbo_ExpensesWorkType1").val(),
                        txt_DateFrom: $("#txt_DateFrom1").val(),
                        txt_DateTo: $("#txt_DateTo1").val(),
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
            var cell = $("#cbo_ExpensesItems1");
            var thirdcell = $("#cbo_ExpensesWorkType1");
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
                            if ($("#cbo_ProjectName1").val() == $(this).find('ProjectId').text()) {
                                $(cell).append('<option value="' + $(this).find('SubContractorId').text() + '" >' + $(this).find('SubContractorName').text() + '</option>');
                            }
                        });
                        break;
                    case "-3": //Suppliers
                        $(subData).filter('main').find('Tbl_Supplier').each(function () {
                            if ($("#cbo_ProjectName1").val() == $(this).find('ProjectID').text()) {
                                $(cell).append('<option value="' + $(this).find('SupplierID').text() + '" >' + $(this).find('SupplierName').text() + '</option>');
                            }
                        });
                        break;
                    case "-2": //DailyWorker
                        $(thirdcell).hide();
                        $(subData).filter('main').find('View_ProjectWorker').each(function () {
                            if ($("#cbo_ProjectName1").val() == $(this).find('ProjectId').text()) {
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
            var cell = $("#cbo_ExpensesWorkType1");
            var parentCategroy = $("#cbo_ExpensesCategories1");
            switch ($(parentCategroy).val().toString()) {
                case "-4": //subContractor
                    $(subData).filter('main').find('View_ProjectContractor').each(function () {
                        if ($(parent).val() == $(this).find('SubContractorID').text() && $("#cbo_ProjectName1").val() == $(this).find('ProjectId').text()) {
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
                    action: "EditDailySuppliesbook"
                },
                success: function (data) {
                    subData = data;
                    //  
                    $(subData).filter('main').find('Tbl_Project').each(function () {
                        $("#cbo_ProjectName").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });

                    $(subData).filter('main').find('Tbl_Subcontractor').each(function () {
                        $("#cbo_SupplierNames").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });

                    $(subData).filter('main').find('Tbl_Category').each(function () {
                        $("#cbo_SupplieisCategory").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });

                    $("#cbo_SupplieisCategory").on("change", function () {
                        $("#cbo_ItemType").html('<option></option>');
                        $(subData).filter('main').find('Tbl_Items').each(function () {
                            if ($("#cbo_SupplieisCategory").val() == $(this).find('FK_CategoryID').text()) {
                                $("#cbo_ItemType").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('ItemType').text() + '</option>');
                            }
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Search").on("click", function () {
                $.ajax({
                    url: "EditDailySuppliesbook.aspx",
                    type: "POST",
                    data: {
                        cbo_ProjectName: $("#cbo_ProjectName").val(),
                        cbo_SupplierNames: $("#cbo_SupplierNames").val(),
                        cbo_SupplieisCategory: $("#cbo_SupplieisCategory").val(),
                        cbo_ItemType: $("#cbo_ItemType").val(),
                        txt_ReciptNo: $("#txt_ReciptNo").val(),
                        txt_DateFrom: $("#txt_DateFrom").val(),
                        txt_DateTo: $("#txt_DateTo").val(),
                        cbo_ProjectType: $("#cbo_ProjectType").val(),
                        action: "LoadSearch"
                    },
                    success: function (data) {
                        searchData = data;
                        if ($(data).filter('main').find('Exception').text() == '') {
                            $("#grid_SuppliesDetails").html('');
                            $(data).filter('main').find('Tbl_Data').each(function () {
                                $("#grid_SuppliesDetails").append('<tr class="ItemRow"><td class="b_width">' + $(this).find('ProjectName').text() + '</td><td class="b_width">' + $(this).find('SupplierName').text() + '</td><td class="m_width">' + $(this).find('CategoryName').text() + '</td><td class="m_width">' + $(this).find('ItemName').text() + '</td><td class="s_width">' + $(this).find('ReceiptNO').text() + '</td><td class="b_width">' + $(this).find('SuppliesDate').text() + '</td><td class="hiddenElemnet">' + $(this).find('SuppliesEventID').text() + '</td></tr>');
                            });
                            $(".overlay,.popup-close").click(function () {
                                $(".popup-container").hide();
                            });
                            ////////////////////validate popup event
                            $(".update").click(function (e) {
                                e.preventDefault();
                                pk_id = $(this).parent().prev().html();
                                $(searchData).filter('main').find('Tbl_Data').each(function () {
                                    if ($(this).find('SuppliesEventID').text() == pk_id) {
                                        rest = parseFloat($(this).find('Rest').text());
                                        QTY = parseInt($(this).find('QTY').text());
                                        SuppliesEventQTY = parseInt($(this).find('SuppliesEventQTY').text());
                                        $("#txt_UnitPrice").val($(this).find('UnitPrice').text());
                                        $("#txt_SuppliesQTY").val($(this).find('SuppliesEventQTY').text());
                                        $("#txt_TotalPrice").val($(this).find('TotalPrice').text());
                                        $("#txt_ReciptNoEdit").val($(this).find('ReceiptNO').text());
                                        $("#txt_WasSupplies").val(QTY - rest);
                                        $("#txt_RestSupplies").val($(this).find('Rest').text());
                                        $("#ProjectSupplies").val($(this).find('PK_ID').text());
                                    }
                                });
                                $(".popup-save").show();
                            });
                        } else {
                            alert($(data).filter('main').find('Exception').text());
                        }
                    },
                    error: function (error) {
                        alert("Error happened please contact System Administrator : " + error.statusText);
                    }
                });
            });

            $("#txt_UnitPrice").on("change", function () {
                $("#txt_TotalPrice").val(parseFloat($("#txt_UnitPrice").val()) * parseFloat($("#txt_SuppliesQTY").val()));
            });
            $("#txt_SuppliesQTY").on("change", function () {
                cal();
            });
            /*
            $("#btn_Save").on("click", function () {
                if (
                $("#txt_SuppliesQTY").val() != '') {
                    $.ajax({
                        url: "SaveData.aspx",
                        type: "POST",
                        data: {
                            pk_id: pk_id,
                            txt_UnitPrice: $("#txt_UnitPrice").val(),
                            txt_SuppliesQTY: $("#txt_SuppliesQTY").val(),
                            txt_TotalPrice: $("#txt_TotalPrice").val(),
                            txt_ReciptNoEdit: $("#txt_ReciptNoEdit").val(),
                            txt_WasSupplies: $("#txt_WasSupplies").val(),
                            txt_RestSupplies: $("#txt_RestSupplies").val(),
                            ProjectSupplies_PK_ID: $("#ProjectSupplies_PK_ID").val(),
                            action: "EditDailySuppliesbook"
                        },
                        success: function (data) {
                            if ($(data).filter('main').find('Exception').text() == '') {
                                alert("تم الحفظ");
                                window.location.reload();
                            } else {
                                alert($(data).filter('main').find('Exception').text());
                            }
                        },
                        error: function (error) {
                            alert("Error happened please contact System Administrator : " + error.statusText);
                        }
                    });
                } else {
                    alert("ادخل باقى البيانات اولا");
                }
            });
            */
        });
        function cal() {
            $("#txt_TotalPrice").val(parseFloat($("#txt_UnitPrice").val()) * parseFloat($("#txt_SuppliesQTY").val()));
            if (parseInt($("#txt_SuppliesQTY").val()) > SuppliesEventQTY) {

                $("#txt_WasSupplies").val((QTY - rest) + (parseInt($("#txt_SuppliesQTY").val()) - SuppliesEventQTY));

                $("#txt_RestSupplies").val(QTY - parseInt($("#txt_WasSupplies").val()));

            } else if (parseInt($("#txt_SuppliesQTY").val()) < SuppliesEventQTY) {

                $("#txt_WasSupplies").val((QTY - rest) - (SuppliesEventQTY - parseInt($("#txt_SuppliesQTY").val())));

                $("#txt_RestSupplies").val(QTY - parseInt($("#txt_WasSupplies").val()));

            } else {
                $("#txt_WasSupplies").val(QTY - rest);

                $("#txt_RestSupplies").val(QTY - parseInt($("#txt_WasSupplies").val()));
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
        <h3>مصروفات المشروع</h3>
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
                    <select id="cbo_ProjectName1" class="m_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_ExpensesCategories1" class="m_width" onchange="onChangeItemCategory(this)">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_ExpensesItems1" class="m_width" onchange="onChangeItemName(this)">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_ExpensesWorkType1" class="m_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <input id="txt_DateFrom1" type="text" class="s_width IsDate" />
                </td>
                <td>
                    <input id="txt_DateTo1" type="text" class="s_width IsDate" />
                </td>
                <td rowspan="2" style="text-align: center;">
                    <input id="btn_Search1" type="button" value="عرض" class="btn_Save" />
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
    <div>
        <h3>توريدات المشروع</h3>
        <table>
            <tr>
                <td class="style24">اسم المشروع :
                </td>
                <td class="style24">اسم المورد :
                </td>
                <td class="style24">نوع المادة الخام :
                </td>
                <td class="style24">نوع الصنف :
                </td>
                <td class="style24">رقم البون :
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
                    <select id="cbo_SupplierNames" class="m_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_SupplieisCategory" class="s_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_ItemType" class="s_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <input id="txt_ReciptNo" type="text" class="ts_width" />
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
        <h3>التوريدات</h3>
        <table>
            <thead>
                <tr class="HeaderRow">
                    <td class="b_width">اسم المشروع
                    </td>
                    <td class="b_width">اسم المورد
                    </td>
                    <td class="m_width">نوع المادة الخام
                    </td>
                    <td class="m_width">نوع الصنف
                    </td>
                    <td class="s_width">رقم البون
                    </td>
                    <td class="b_width">التاريخ
                    </td>
                    <td class="hiddenElemnet">الكود
                    </td>
                </tr>
            </thead>
            <tbody id="grid_SuppliesDetails">
                <tr class="ItemRow">
                    <td class="b_width">اسم المشروع
                    </td>
                    <td class="b_width">اسم المورد
                    </td>
                    <td class="m_width">نوع المادة الخام
                    </td>
                    <td class="m_width">نوع الصنف
                    </td>
                    <td class="s_width">رقم البون
                    </td>
                    <td class="b_width">التاريخ
                    </td>
                    <td class="hiddenElemnet">الكود
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
