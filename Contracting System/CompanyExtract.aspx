<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="CompanyExtract.aspx.cs" Inherits="Contracting_System.CompanyExtract" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        .b_width {
            width: 160px;
        }

        .s_width {
            width: 75px;
        }

        table tr td {
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        var categories = "";
        $(function () {
            $.ajax({
                url: "LoadData.aspx",
                type: "POST",
                data: {
                    action: location.pathname.substr(location.pathname.lastIndexOf('/') + 1, (location.pathname.length - 6))
                },
                success: function (data) {
                    subData = data;
                    $(subData).filter('main').find('Tbl_Project').each(function () {
                        $("#cbo_ProjectName").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    $(subData).filter('main').find('View_ProjectEstimation').each(function () {
                        if ($(this).find('FK_ProjectID').text() == $("#cbo_ProjectName").val()) {
                            categories += '<option value="' + $(this).find('FK_EstimationItemsID').text() + '" >' + $(this).find('BusinessStatement').text() + '</option>';
                        }
                    });
                    $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><select name="WorkItem" class="b_width addrow" onchange="onChangeEstimationItem(this)"><option></option>' + categories + '</select></td><td class="style22"><input name="QTY" class="s_width addrow" readonly/></td><td class="style18"><input name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="unit" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" onchange="onChangePrice(this)" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td class="style18"><input type="button" value="      " disabled/></td></tr>');
                    $(".IsDate").datepicker({ dateFormat: "dd/mm/yy" });
                    $(".addrow").change(function () {
                        AddRow(this);
                    });
                    $("#cbo_ProjectName").on("change", function () {
                        $(subData).filter('main').find('View_ProjectEstimation').each(function () {
                            if ($(this).find('FK_ProjectID').text() == $("#cbo_ProjectName").val()) {
                                categories += '<option value="' + $(this).find('FK_EstimationItemsID').text() + '" >' + $(this).find('BusinessStatement').text() + '</option>';
                            }
                        });
                        $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><select name="WorkItem" class="b_width addrow" onchange="onChangeEstimationItem(this)"><option></option>' + categories + '</select></td><td class="style22"><input name="QTY" class="s_width addrow" readonly/></td><td class="style18"><input name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="unit" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" onchange="onChangePrice(this)" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td class="style18"><input type="button" value="      " disabled/></td></tr>');
                        $(".addrow").change(function () {
                            AddRow(this);
                        });
                        $(subData).filter('main').find('Tbl_Project').each(function () {
                            if ($(this).find('PK_ID').text() == $("#cbo_ProjectName").val()) {
                                $("#txt_Supervisor").val($(this).find('Supervisor').text());
                            }
                        });
                        $("#ExtractNumber").html("1");
                        $("#txt_LastPaid").val(0);

                        $(subData).filter('main').find('View_CompanyExtractNewOrder').each(function () {
                            if ($(this).find('FK_ProjectID').text() == $("#cbo_ProjectName").val()) {
                                $("#ExtractNumber").html($(this).find('NewExtractOrder').text());
                                $("#txt_LastPaid").val($(this).find('LastPaid').text());
                            }
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

        });
        function onChangeEstimationItem(parent) {
            var cell = $(parent).parent().next().next().next().next().children(0);
            $(cell).val(0);

            $(subData).filter('main').find('View_CompanyExtract').each(function () {
                if ($(this).find('ProjectEstimationID').text() == $(parent).val()) {
                    $(cell).val($(this).find('ExecutedQTY').text());
                }
            });
            cell = $(parent).parent().next().children(0);
            var cell2 = $(parent).parent().next().next().children(0);
            $(subData).filter('main').find('View_ProjectEstimation').each(function () {
                if ($(this).find('FK_EstimationItemsID').text() == $(parent).val()) {
                    $(cell).val($(this).find('Quantity').text());
                    $(cell2).val($(this).find('Price').text());
                }
            });
        }
        function onChangePrice(parent) {
            var rowIndex = $(parent)
                                    .closest('tr') // Get the closest tr parent element
                                    .prevAll() // Find all sibling elements in front of it
                                    .length; // Get their count
            var
            Price = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(2)').children(0),
            unit = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(3)').children(0),
            LastDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(4)').children(0),
            CurrentDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(5)').children(0),
            TotalDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(6)').children(0),
            TotalPrice = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(7)').children(0);

            $(TotalDoneQTY).val(parseInt((LastDoneQTY).val()) + parseInt($(CurrentDoneQTY).val()));
            $(TotalPrice).val(parseFloat($(Price).val()) * parseInt($(TotalDoneQTY).val()));
            var count = $('#grid_ExtractDetails').children().length - 1;
            var TotalPriceCount = 0.0;
            for (var i = 0; i < count; i++) {
                //Check if Total Price not Equal 0
                TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(7)').children(0);
                TotalPriceCount += parseFloat($(TotalPrice).val());
            }
            $("#TotalExtractPrice").val(TotalPriceCount);
            onChangeDeductions();
        }

        function AddRow(CellChildInput) {
            $(subData).filter('main').find('View_ProjectEstimation').each(function () {
                if ($(this).find('FK_ProjectID').text() == $("#cbo_ProjectName").val()) {
                    categories += '<option value="' + $(this).find('FK_EstimationItemsID').text() + '" >' + $(this).find('BusinessStatement').text() + '</option>';
                }
            });
            var CurrentCell = $(CellChildInput).parent();
            var CurrentCellName = $(CellChildInput).attr('name');
            var CurrentRow = $(CurrentCell).parent();
            var AfterCurrentRow = $(CurrentRow).next();
            if ($(AfterCurrentRow).hasClass("ItemRow") == false) {
                $("#grid_ExtractDetails").append('<tr class="ItemRow"><td class="style16"><select name="WorkItem" class="b_width addrow" onchange="onChangeEstimationItem(this)"><option></option>' + categories + '</select></td><td class="style22"><input name="QTY" class="s_width addrow" readonly/></td><td class="style18"><input name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="unit" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" onchange="onChangePrice(this)" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td class="style18"><input type="button" value="حذف" onclick="RemoveRow(this)"/></td></tr>');
                $(".IsDate").datepicker({ dateFormat: "dd/mm/yy" });
                $(".addrow").change(function () {
                    AddRow(this);
                });
            }
        }

        function onChangeDeductions() {
            //id="txt_BusinessGuarantee" class="b_width IsNumberOnly" onchange="onChangeDeductions()"

            //txt_BusinessGuarantee
            //txt_Deductions
            //txt_LastPaid 
            //TotalExtractPrice
            //txt_NetDue

            $("#txt_NetDue").val(
            parseFloat($("#TotalExtractPrice").val()) -
            (parseFloat($("#txt_Deductions").val()) + parseFloat($("#txt_BusinessGuarantee").val()) + parseFloat($("#txt_LastPaid").val()))
            );

        }
        function RemoveRow(obj) {
            $(obj).parent().parent().remove();
        }

        function SaveCompanyExtract() {
            if ($("#cbo_Employee").val() != '') {
                var count = $('#grid_ExtractDetails').children().length - 1;
                var orderCounter = 0;
                var xmlCompanyExtract = "<CompanyExtract>";
                var save = false;
                if ($("#cbo_ProjectName").val() == '') {
                    alert("إختر المشروع اولا");
                    return;
                }
                xmlCompanyExtract += "<CompanyExtractInfo>";
                xmlCompanyExtract += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlCompanyExtract += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlCompanyExtract += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlCompanyExtract += "<BusinessGuarantee>" + $("#txt_BusinessGuarantee").val() + "</BusinessGuarantee>";
                xmlCompanyExtract += "<Deductions>" + $("#txt_Deductions").val() + "</Deductions>";
                xmlCompanyExtract += "<LastPaid>" + $("#txt_LastPaid").val() + "</LastPaid>";
                xmlCompanyExtract += "<TotalExtractPrice>" + $("#TotalExtractPrice").val() + "</TotalExtractPrice>";
                xmlCompanyExtract += "<NetDue>" + $("#txt_NetDue").val() + "</NetDue>";
                xmlCompanyExtract += "<ExractOrder>" + $("#ExtractNumber").html() + "</ExractOrder>";
                xmlCompanyExtract += "<Supervisor>" + $("#txt_Supervisor").val() + "</Supervisor>";
                xmlCompanyExtract += "</CompanyExtractInfo>";

                if (count == 0) return;
                xmlCompanyExtract += "<CompanyExtractItems>";
                for (var i = 0; i < count; i++) {
                    //Check if Total Price not Equal 0
                    var
                    ProjectEstimationID = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).val(),
                    EstimationName = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).find('option:selected').text(),
                    EstimationQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(1)').children(0).val(),
                    Price = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(2)').children(0).val(),
                    Unit = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(3)').children(0).val(),
                    LastExecutedQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(4)').children(0).val(),
                    CurrentExecutedQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(5)').children(0).val(),
                    TotalExecutedQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(6)').children(0).val(),
                    TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(7)').children(0).val();

                    if (ProjectEstimationID == '') {
                        alert("برجاء ادخال بيان الاعمال");
                        return;
                    }
                    if (Price == '') {
                        alert("برجاء ادخال الفئة");
                        return;
                    }
                    if (CurrentExecutedQTY == '') {
                        alert("برجاء ادخال الكمية الحالية المنفذه");
                        return;
                    }
                    xmlCompanyExtract += "<Item>";
                    xmlCompanyExtract += "<ProjectEstimationID>" + ProjectEstimationID + "</ProjectEstimationID>";
                    xmlCompanyExtract += "<EstimationName>" + EstimationName + "</EstimationName>";
                    xmlCompanyExtract += "<EstimationQTY>" + EstimationQTY + "</EstimationQTY>";
                    xmlCompanyExtract += "<Price>" + Price + "</Price>";
                    xmlCompanyExtract += "<Unit>" + Unit + "</Unit>";
                    xmlCompanyExtract += "<LastExitExecutedQTY>" + parseInt(LastExecutedQTY) + "</LastExitExecutedQTY>";
                    xmlCompanyExtract += "<LastExecutedQTY>" + (parseInt(LastExecutedQTY) + parseInt(CurrentExecutedQTY)) + "</LastExecutedQTY>";
                    xmlCompanyExtract += "<CurrentExecutedQTY>" + CurrentExecutedQTY + "</CurrentExecutedQTY>";
                    xmlCompanyExtract += "<TotalExecutedQTY>" + TotalExecutedQTY + "</TotalExecutedQTY>";
                    xmlCompanyExtract += "<TotalPrice>" + TotalPrice + "</TotalPrice>";
                    xmlCompanyExtract += "</Item>";
                }
                xmlCompanyExtract += "</CompanyExtractItems>";

                xmlCompanyExtract += "</CompanyExtract>";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: "{ xmlCompanyExtract: '" + xmlCompanyExtract + "'}",
                    url: "SaveData.aspx/SaveCompanyExtract",
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

    <table id="frm">
        <tr>
            <td colspan="4" class="td_center">
                <h1>مستخلص شركة ماسة</h1>
            </td>
        </tr>
        <tr>
            <td class="style23">اسم المشروع :
            </td>
            <td style="text-align: right;">
                <select id="cbo_ProjectName" class="b_width">
                    <option></option>
                </select>
            </td>
            <td class="style23">جهة الاشراف :
            </td>
            <td>
                <input type="text" id="txt_Supervisor" class="IsNumberOnly b_width" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <h1>مستخلص رقم (<span id="ExtractNumber"> </span>)</h1>
            </td>
        </tr>
        <tr>
            <td class="style23">الفترة من :
            </td>
            <td>
                <input type="text" id="txt_DateFrom" class="b_width IsDate" />
            </td>
            <td class="style23">الفترة الى :
            </td>
            <td>
                <input type="text" id="txt_DateTo" class="b_width IsDate" />
            </td>
        </tr>
    </table>
    <h1>بيانات المستخلص</h1>
    <table>
        <thead>
            <tr class="HeaderRow">
                <td rowspan="2">بيان الاعمال
                </td>
                <td rowspan="2">الكميه بالمقايسه
                </td>
                <td rowspan="2">الفئة
                </td>
                <td rowspan="2">وحده
                </td>
                <td colspan="3">الكميات المنفذة
                </td>
                <td rowspan="2">اجمالى السعر
                </td>
            </tr>
            <tr class="HeaderRow">
                <td>السابقه
                </td>
                <td>الحاليه
                </td>
                <td>الاجمالى
                </td>
            </tr>
        </thead>
        <tbody id="grid_ExtractDetails">
            <tr class="ItemRow">
                <td class="style16">
                    <select name="WorkItem" class="b_width addrow" onchange="onChangeEstimationItem(this)">
                        <option></option>
                    </select>
                </td>
                <td class="style22">
                    <input name="QTY" class="s_width addrow" readonly />
                </td>
                <td class="style18">
                    <input name="Price" class="s_width addrow" onchange="onChangePrice(this)" />
                </td>
                <td class="style18">
                    <input type="text" name="unit" class="s_width addrow" onchange="onChangePrice(this)" />
                </td>
                <td class="style18">
                    <input type="text" name="LastDoneQTY" class="s_width addrow" onchange="onChangePrice(this)" readonly />
                </td>
                <td class="style18">
                    <input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)" />
                </td>
                <td class="style18">
                    <input type="text" name="TotalDoneQTY" class="s_width addrow" readonly />
                </td>
                <td class="style18">
                    <input type="text" name="TotalPrice" class="s_width addrow" readonly />
                </td>
                <td class="style18">
                    <input type="button" value="        " disabled />
                </td>
            </tr>
        </tbody>
    </table>
    <table style="float: left; left: 33px; top: 5px; position: relative;">
        <tr>
            <td colspan="2" class="style23">إجمالى المستخلص :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="TotalExtractPrice" class="b_width IsNumberOnly" readonly />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="style23">السابق صرفه :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="txt_LastPaid" class="b_width IsNumberOnly" readonly />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="style23">الاستقطاعات :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="txt_Deductions" class="b_width IsNumberOnly" onchange="onChangeDeductions()" />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="style23">ضمان الاعمال :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="txt_BusinessGuarantee" class="b_width IsNumberOnly" onchange="onChangeDeductions()" />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="style23">الصافى المستحق :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="txt_NetDue" class="b_width IsNumberOnly" readonly />
            </td>
        </tr>
    </table>
    <input id="Button5" type="button" value="حفظ" onclick="SaveCompanyExtract()" class="btn_Save" />
    <input id="Button8" type="button" value="إلغاء" class="btn_Save" />
    <%--<script>
        jQuery.fn.serializeObject = function () {
            var arrayData, objectData;
            arrayData = this.serializeArray();
            objectData = {};

            $.each(arrayData, function () {
                var value;

                if (this.value != null) {
                    value = this.value;
                } else {
                    value = '';
                }

                if (objectData[this.name] != null) {
                    if (!objectData[this.name].push) {
                        objectData[this.name] = [objectData[this.name]];
                    }

                    objectData[this.name].push(value);
                } else {
                    objectData[this.name] = value;
                }
            });

            return objectData;
        };
        jQuery.fn.toJSON = function () {
            return JSON.stringify($(this).serializeObject());
        };
        jQuery.fn.validateForm = function () {
            var flag = true;
            $.each($(this).find("[name]"), function () {
                if ($(this)[0].hasAttribute('required')) {
                    if ($(this).val() == '') {
                        $(this).parent().parent().addClass('has-error');
                        $(this).parent().parent().children(0).removeClass('hidden');
                        flag = false;
                    } else {
                        $(this).parent().parent().removeClass('has-error');
                        $(this).parent().parent().children(0)[0].className = $(this).parent().parent().children(0)[0].className + ' hidden';
                    }
                }
            });

            return flag;
        };
        jQuery.fn.resetForm = function () {
            $(this)[0].reset();
        };

        function onclickbtn() {
            console.log($("#form1").toJSON());
        }
        {
            "WorkItem":         ["5","4",""],
            "QTY":              ["1560","200",""],
            "Price":            ["250","250",""],
            "unit":             ["2","25",""],
            "LastDoneQTY":      ["0","0",""],
            "CurrentDoneQTY":   ["25","25",""],
            "TotalDoneQTY":     ["25","25",""],
            "TotalPrice":       ["6250","6250",""]
        }
    </script>--%>
</asp:Content>
