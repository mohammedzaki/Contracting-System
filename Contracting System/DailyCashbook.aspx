<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="DailyCashbook.aspx.cs" Inherits="Contracting_System.DailyCashbook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url: "LoadData.aspx",
                type: "POST",
                data: {
                    action: location.pathname.substr(location.pathname.lastIndexOf('/') + 1, (location.pathname.length - 6))
                },
                success: function (data) {
                    subData = data;
                    /*$(subData).filter('main').find('Tbl_Savers').each(function () {
                        $("#cbo_CompanySaver").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    $("#cbo_CompanySaver").on("change", function () {
                        $(subData).filter('main').find('Tbl_Savers').each(function () {
                            if ($("#cbo_CompanySaver").val() == $(this).find('PK_ID').text()) {
                                $("#txt_currentAmount").val($(this).find('Amount').text());
                            }
                        });
                    });*/
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
                    $("#grid_GuardianshipDetails").html('<tr class="ItemRow"><td class="style16"><select name="ItemCategory" class="ItemCategory b_width addrow" onchange="onChangeItemCategory(this)"><option></option><option value="-4">مقاولين</option><option value="-3">موردين</option><option value="-2">عمالة يوميه</option><option value="-1">موظفين</option>' + categories + '</select></td><td class="style22"><select name="ItemName" class="ItemName b_width addrow" onchange="onChangeItemName(this)"><option></option></select></td><td class="style18"><select name="WorkType" class="WorkType b_width addrow"><option></option></select></td><td class="style18"><input type="text" name="Value" class="s_width addrow"/></td><td class="style18"><input type="text" name="Date" class="b_width IsDate addrow"/></td><td class="style18"><input type="button" value="     " disabled /></td></tr>');
                    $(".IsDate").datepicker({ dateFormat: "dd/mm/yy" });
                    $(".addrow").change(function () {
                        AddRow(this);
                    });
                    $("#cbo_ProjectName").on("change", function () {
                        var categories = "";
                        $(subData).filter('main').find('Tbl_ExpensesCategories').each(function () {
                            categories += '<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>';
                        });
                        $("#grid_GuardianshipDetails").html('<tr class="ItemRow"><td class="style16"><select name="ItemCategory" class="ItemCategory b_width addrow" onchange="onChangeItemCategory(this)"><option></option><option value="-4">مقاولين</option><option value="-3">موردين</option><option value="-2">عمالة يوميه</option><option value="-1">موظفين</option>' + categories + '</select></td><td class="style22"><select name="ItemName" class="ItemName b_width addrow" onchange="onChangeItemName(this)"><option></option></select></td><td class="style18"><select name="WorkType" class="WorkType b_width addrow"><option></option></select></td><td class="style18"><input type="text" name="Value" class="s_width addrow"/></td><td class="style18"><input type="text" name="Date" class="b_width IsDate addrow"/><td class="style18"><input type="button" value="     " disabled /></td></tr>');
                        $(".IsDate").datepicker({ dateFormat: "dd/mm/yy" });
                        $(".addrow").change(function () {
                            AddRow(this);
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

        });
        function onChangeItemCategory(parent) {
            var cell = $(parent).parent().next().children(0);
            var thirdcell = $(parent).parent().next().next().children(0);
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
                    case "-1": //Employees
                        $(thirdcell).hide();
                        $(subData).filter('main').find('Tbl_Employees').each(function () {
                                $(cell).append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                        });
                        break;
                    default:
                        break;
                }
            }
        }
        function onChangeItemName(parent) {
            var cell = $(parent).parent().next().children(0);
            var parentCategroy = $(parent).parent().prev().children(0);
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
                case "-1": //Employees

                    break;
                default:
                    break;
            }
        }
        function AddRow(CellChildInput) {
            var categories = "";
            $(subData).filter('main').find('Tbl_ExpensesCategories').each(function () {
                categories += '<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>';
            });
            var CurrentCell = $(CellChildInput).parent();
            var CurrentCellName = $(CellChildInput).attr('name');
            var CurrentRow = $(CurrentCell).parent();
            var AfterCurrentRow = $(CurrentRow).next();
            if ($(AfterCurrentRow).hasClass("ItemRow") == false) {
                $("#grid_GuardianshipDetails").append('<tr class="ItemRow"><td class="style16"><select name="ItemCategory" class="ItemCategory b_width addrow" onchange="onChangeItemCategory(this)"><option></option><option value="-4">مقاولين</option><option value="-3">موردين</option><option value="-2">عمالة يوميه</option><option value="-1">موظفين</option>' + categories + '</select></td><td class="style22"><select name="ItemName" class="ItemName b_width addrow" onchange="onChangeItemName(this)"><option></option></select></td><td class="style18"><select name="WorkType" class="WorkType b_width addrow"><option></option></select></td><td class="style18"><input type="text" name="Value" class="s_width addrow"/></td><td class="style18"><input type="text" name="Date" class="b_width IsDate addrow"/></td><td class="style18"><input type="button" value="حذف" onclick="RemoveRow(this)"/></td></tr>');
                $(".IsDate").datepicker({ dateFormat: "dd/mm/yy" });
                $(".addrow").change(function () {
                    AddRow(this);
                });
            }
        }

        function RemoveRow(obj) {
            $(obj).parent().parent().remove();
        }

        function SaveDailyCashBook() {
            if ($("#cbo_Employee").val() != '') {
                var count = $('#grid_GuardianshipDetails').children().length - 1;
                var orderCounter = 0;
                var xmlGuardianship = "<Guardianship>";
                var save = false;
                if ($("#cbo_ProjectName").val() == '') {
                    var r = confirm("ملحوظه: لم تختر اسم المشروع هل تريد الاستمرار ؟");
                    if (r == false)
                        return;
                }
                xmlGuardianship += "<GuardianshipInfo>";
                xmlGuardianship += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlGuardianship += "<EmployeeId>" + $("#cbo_Employee").val() + "</EmployeeId>";
                xmlGuardianship += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlGuardianship += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlGuardianship += "<Value>" + $("#txt_value").val() + "</Value>";
                xmlGuardianship += "<Rest>" + $("#txt_RestValue").val() + "</Rest>";
                //xmlGuardianship += "<SaverId>" + $("#cbo_CompanySaver").val() + "</SaverId>";
                xmlGuardianship += "</GuardianshipInfo>";

                if (count == 0) return;
                xmlGuardianship += "<GuardianshipItems>";
                for (var i = 0; i < count; i++) {
                    //Check if Total Price not Equal 0
                    var
                    ItemCategoryId = $('#grid_GuardianshipDetails tr:eq(' + i + ') td:eq(0)').children(0).val(),
                    ItemNameId = $('#grid_GuardianshipDetails tr:eq(' + i + ') td:eq(1)').children(0).val(),
                    WorkTypeId = $('#grid_GuardianshipDetails tr:eq(' + i + ') td:eq(2)').children(0).val(),
                    Value = $('#grid_GuardianshipDetails tr:eq(' + i + ') td:eq(3)').children(0).val(),
                    Date = $('#grid_GuardianshipDetails tr:eq(' + i + ') td:eq(4)').children(0).val();

                    if (ItemCategoryId == '') {
                        alert("برجاء ادخال الفئة");
                        return;
                    }
                    if (ItemNameId == '') {
                        alert("برجاء ادخال الاسم");
                        return;
                    }
                    if (Value == '') {
                        alert("برجاء ادخال القيمة");
                        return;
                    }
                    if (Date == '') {
                        alert("برجاء ادخال التاريخ");
                        return;
                    }
                    xmlGuardianship += "<Item>";
                    xmlGuardianship += "<ItemCategoryId>" + ItemCategoryId + "</ItemCategoryId>";
                    xmlGuardianship += "<ItemNameId>" + ItemNameId + "</ItemNameId>";
                    xmlGuardianship += "<WorkTypeId>" + WorkTypeId + "</WorkTypeId>";
                    xmlGuardianship += "<Value>" + Value + "</Value>";
                    xmlGuardianship += "<Date>" + Date + "</Date>";
                    xmlGuardianship += "</Item>";
                }
                xmlGuardianship += "</GuardianshipItems>";

                xmlGuardianship += "</Guardianship>";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: "{ xmlGuardianship: '" + xmlGuardianship + "'}",
                    url: "SaveData.aspx/SaveDailCashBook",
                    dataType: "json",
                    success: function (data) {
                        if (data.d > -1) {
                            //alert("You Bill has been submitted successfully, And Bill Auto Number is : " + data.d);
                            alert("تم الحفظ");
                            window.location.reload();
                        } else {
                            alert("Error happened please contact System Administrator");
                        }
                    },
                    error: function (error) {
                        alert("Error happened please contact System Administrator : " + error.statusText);
                    }
                });

            } else {
                alert("يجب اختار الموظف اولا");
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <table>
        <%--<tr>
            <td class="style23">
                اختر الخزنة :
            </td>
            <td>
                <select id="cbo_CompanySaver" class="b_width">
                    <option></option>
                </select>
            </td>
            <td class="style23">
                رصيد الخزنة الحالى :
            </td>
            <td>
                <input type="text" id="txt_currentAmount" class="b_width IsNumberOnly" readonly />
            </td>
        </tr>--%>
        <tr>
            <td class="style23">
                اسم المشروع :
            </td>
            <td>
                <select id="cbo_ProjectName" class="b_width">
                    <option></option>
                </select>
            </td>
            <td class="style23">
                الموظف :
            </td>
            <td>
                <select id="cbo_Employee" class="b_width">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">
                الفترة من :
            </td>
            <td>
                <input type="text" id="txt_DateFrom" class="b_width IsDate" />
            </td>
            <td class="style23">
                الفترة الى :
            </td>
            <td>
                <input type="text" id="txt_DateTo" class="b_width IsDate" />
            </td>
        </tr>
        <tr>
            <td class="style23">
                القيمه :
            </td>
            <td>
                <input type="text" id="txt_value" class="IsNumberOnly b_width" />
            </td>
            <td class="style23">
                المتبقى :
            </td>
            <td>
                <input type="text" id="txt_RestValue" class="IsNumberOnly b_width" />
            </td>
        </tr>
    </table>
    <h1>
        بيانات العهدة</h1>
    <table>
        <thead>
            <tr class="HeaderRow">
                <td class="style16">
                    البند
                </td>
                <td class="style22">
                    الاسم
                </td>
                <td class="style18">
                    نوع العمل
                </td>
                <td class="style18">
                    القيمه
                </td>
                <td class="style18">
                    التاريخ
                </td>
            </tr>
        </thead>
        <tbody id="grid_GuardianshipDetails">
            <%--<tr class="ItemRow">
                <td class="style16">
                    <select name="ItemCategory" class="ItemCategory b_width addrow" onchange="onChangeItemCategory(this)">
                        <option></option>
                        <option value="-4">مقاولين</option>
                        <option value="-3">موردين</option>
                        <option value="-2">عمالة يوميه</option>
                    </select>
                </td>
                <td class="style22">
                    <select name="ItemName" class="ItemName b_width addrow" onchange="onChangeItemName(this)">
                        <option></option>
                    </select>
                </td>
                <td class="style18">
                    <select name="WorkType" class="WorkType b_width addrow">
                        <option></option>
                    </select>
                </td>
                <td class="style18">
                    <input type="text" name="Value" class="s_width addrow" />
                </td>
                <td class="style18">
                    <input type="text" name="Date" class="b_width IsDate addrow" />
                </td>
                <td class="style18"><input type="button" value="        " disabled/></td>
            </tr>--%>
        </tbody>
    </table>
    <input id="Button5" type="button" value="حفظ" onclick="SaveDailyCashBook()" class="btn_Save" />
    <input id="Button8" type="button" value="إلغاء" class="btn_Save" />
</asp:Content>
