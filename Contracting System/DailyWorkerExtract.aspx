<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="DailyWorkerExtract.aspx.cs" Inherits="Contracting_System.DailyWorkerExtract" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        .b_width
        {
            width: 160px;
        }
        .s_width
        {
            width: 75px;
        }
        table tr td
        {
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
                    $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><input name="WorkDurationName" class="b_width addrow"/></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDays" class="s_width addrow"/></td><td class="style18"><input type="text" name="DeductionsDays" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="NetDays" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="ExchangeRate" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td><input type="button" value="      " disabled/></td></tr>');
                    $(".IsDate").datepicker({ dateFormat: "dd/mm/yy" });
                    $(".addrow").change(function () {
                        AddRow(this);
                    });
                    $("#cbo_ProjectName").on("change", function () {
                        $(subData).filter('main').find('ProjectWorkers').each(function () {
                            if ($(this).find('ProjectID').text() == $("#cbo_ProjectName").val()) {
                                $("#cbo_Workers").append('<option value="' + $(this).find('WorkerId').text() + '" >' + $(this).find('WorkerName').text() + '</option>');
                            }
                        });
                    });
                    $("#cbo_Workers").on("change", function () {

                        $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><input name="WorkDurationName" class="b_width addrow"/></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDays" class="s_width addrow"/></td><td class="style18"><input type="text" name="DeductionsDays" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="NetDays" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="ExchangeRate" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td><input type="button" value="      " disabled/></td></tr>');
                        var flag = true;
                        $(subData).filter('main').find('View_DailyWorkerExract').each(function () {
                            if ($(this).find('FK_ProjectID').text() == $("#cbo_ProjectName").val() && $(this).find('WorkerId').text() == $("#cbo_Workers").val()) {
                                if (flag) {
                                    $("#grid_ExtractDetails").html('');
                                    flag = false;
                                }
                                $("#grid_ExtractDetails").append('<tr class="ItemRow"><td class="style16"><input name="WorkDurationName" class="b_width addrow" value="فتره ' + $(this).find('ExractOrder').text() + '" disabled/></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)" value="' + $(this).find('Price').text() + '" disabled/></td><td class="style18"><input type="text" name="TotalDays" class="s_width addrow" value="' + $(this).find('TotalDays').text() + '" disabled/></td><td class="style18"><input type="text" name="DeductionsDays" class="s_width addrow" onchange="onChangePrice(this)" value="' + $(this).find('DeductionsDays').text() + '" disabled/></td><td class="style18"><input type="text" name="NetDays" class="s_width addrow" readonly value="' + $(this).find('NetDays').text() + '" disabled/></td><td class="style18"><input type="text" name="ExchangeRate" class="s_width addrow" onchange="onChangePrice(this)"value="' + $(this).find('ExchangeRatio').text() + '" disabled/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly value="' + $(this).find('TotalPrice').text() + '" disabled/></td><td><input type="button" value="      " disabled/></td></tr>');
                            }
                        });
                        if (!flag) {
                            $("#grid_ExtractDetails").append('<tr class="ItemRow"><td class="style16"><input name="WorkDurationName" class="b_width addrow"/></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDays" class="s_width addrow"/></td><td class="style18"><input type="text" name="DeductionsDays" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="NetDays" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="ExchangeRate" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td><input type="button" value="      " disabled/></td></tr>');
                            flag = true;
                        }
                        $(".addrow").change(function () {
                            AddRow(this);
                        });
                        $("#ExtractNumber").html("1");
                        $("#txt_LastPaid").val(0);

                        $(subData).filter('main').find('View_DailyWorkerExtractNewOrder').each(function () {
                            if ($(this).find('FK_ProjectID').text() == $("#cbo_ProjectName").val()) {
                                $("#ExtractNumber").html($(this).find('NewExtractOrder').text());
                            }
                        });

                        $(subData).filter('main').find('View_EmpolyeePaid').each(function () {
                            if ($(this).find('PersonID').text() == $("#cbo_Workers").val() && $(this).find('PersonTypeID').text() == "-4") {
                                $("#txt_LastPaid").val($(this).find('Last_Paid').text());
                            }
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

        });

        function onChangePrice(parent) {
            var rowIndex = $(parent)
                                    .closest('tr') // Get the closest tr parent element
                                    .prevAll() // Find all sibling elements in front of it
                                    .length; // Get their count
            var 
            Price = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(1)').children(0),
            TotalDays = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(2)').children(0),
            DeductionsDays = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(3)').children(0),
            NetDays = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(4)').children(0),
            ExchangeRate = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(5)').children(0),
            TotalPrice = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(6)').children(0);

            $(NetDays).val(parseInt((TotalDays).val()) - parseInt($(DeductionsDays).val()));
            $(TotalPrice).val(parseFloat($(Price).val()) * parseInt($(NetDays).val()) * (parseFloat($(ExchangeRate).val()) / 100));
            var count = $('#grid_ExtractDetails').children().length - 1;
            var TotalPriceCount = 0.0;
            for (var i = 0; i < count; i++) {
                //Check if Total Price not Equal 0
                TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(6)').children(0);
                TotalPriceCount += parseFloat($(TotalPrice).val());
            }
            $("#TotalExtractPrice").val(TotalPriceCount);
            onChangeDeductions();
        }

        function AddRow(CellChildInput) {
            var CurrentCell = $(CellChildInput).parent();
            var CurrentCellName = $(CellChildInput).attr('name');
            var CurrentRow = $(CurrentCell).parent();
            var AfterCurrentRow = $(CurrentRow).next();
            if ($(AfterCurrentRow).hasClass("ItemRow") == false) {
                $("#grid_ExtractDetails").append('<tr class="ItemRow"><td class="style16"><input name="WorkDurationName" class="b_width addrow"/></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDays" class="s_width addrow"/></td><td class="style18"><input type="text" name="DeductionsDays" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="NetDays" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="ExchangeRate" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td><input type="button" value="حذف" onclick="RemoveRow(this)"/></td></tr>');
                $(".addrow").change(function () {
                    AddRow(this);
                });
            }
        }

        function onChangeDeductions() {
            $("#txt_NetDue").val(
            parseFloat($("#TotalExtractPrice").val()) -
            (parseFloat($("#txt_Deductions").val()) + parseFloat($("#txt_LastPaid").val()))
            );

        }

        function RemoveRow(obj) {
            $(obj).parent().parent().remove();
        }

        function SaveDailyWorkerExtract() {
            if ($("#cbo_ProjectName").val() != '') {
                var count = $('#grid_ExtractDetails').children().length - 1;
                var orderCounter = 0;
                var xmlDailyWorkerExtract = "<DailyWorkerExtract>";
                var save = false;
                if ($("#cbo_Workers").val() == '') {
                    alert("إختر العامل اولا");
                    return;
                }
                xmlDailyWorkerExtract += "<DailyWorkerExtractInfo>";
                xmlDailyWorkerExtract += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlDailyWorkerExtract += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlDailyWorkerExtract += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlDailyWorkerExtract += "<Deductions>" + $("#txt_Deductions").val() + "</Deductions>";
                xmlDailyWorkerExtract += "<LastPaid>" + $("#txt_LastPaid").val() + "</LastPaid>";
                xmlDailyWorkerExtract += "<TotalExtractPrice>" + $("#TotalExtractPrice").val() + "</TotalExtractPrice>";
                xmlDailyWorkerExtract += "<NetDue>" + $("#txt_NetDue").val() + "</NetDue>";
                xmlDailyWorkerExtract += "<ExractOrder>" + $("#ExtractNumber").html() + "</ExractOrder>";
                xmlDailyWorkerExtract += "<WorkerName>" + $("#cbo_Workers option:selected").val() + "</WorkerName>";
                xmlDailyWorkerExtract += "<WorkerId>" + $("#cbo_Workers").val() + "</WorkerId>";
                xmlDailyWorkerExtract += "</DailyWorkerExtractInfo>";
                var rowsCount = 0;
                if (count == 0) return;
                xmlDailyWorkerExtract += "<DailyWorkerExtractItems>";
                for (var i = 0; i < count; i++) {
                    //Check if Total Price not Equal 0
                    var disabled = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).attr('disabled');
                    if (disabled == "disabled") {
                        continue;
                    }
                    var 
                    WorkDurationName = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).val(),
                    Price = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(1)').children(0).val(),
                    TotalDays = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(2)').children(0).val(),
                    DeductionsDays = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(3)').children(0).val(),
                    NetDays = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(4)').children(0).val(),
                    ExchangeRatio = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(5)').children(0).val(),
                    TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(6)').children(0).val();
                    if (WorkDurationName == '') {
                        alert("برجاء ادخال اسم الفتره");
                        return;
                    }
                    if (Price == '') {
                        alert("برجاء ادخال الفئة");
                        return;
                    }
                    if (DeductionsDays == '') {
                        alert("برجاء ادخال الخصومات بالايام");
                        return;
                    }

                    xmlDailyWorkerExtract += "<Item>";
                    xmlDailyWorkerExtract += "<WorkDurationName>" + WorkDurationName + "</WorkDurationName>";
                    xmlDailyWorkerExtract += "<Price>" + Price + "</Price>";
                    xmlDailyWorkerExtract += "<TotalDays>" + parseInt(TotalDays) + "</TotalDays>";
                    xmlDailyWorkerExtract += "<DeductionsDays>" + DeductionsDays + "</DeductionsDays>";
                    xmlDailyWorkerExtract += "<NetDays>" + NetDays + "</NetDays>";
                    xmlDailyWorkerExtract += "<ExchangeRatio>" + ExchangeRatio + "</ExchangeRatio>";
                    xmlDailyWorkerExtract += "<TotalPrice>" + TotalPrice + "</TotalPrice>";
                    xmlDailyWorkerExtract += "</Item>";
                    rowsCount++;
                }
                xmlDailyWorkerExtract += "</DailyWorkerExtractItems>";

                xmlDailyWorkerExtract += "</DailyWorkerExtract>";
                if (rowsCount == 0) return;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: "{ xmlDailyWorkerExtract: '" + xmlDailyWorkerExtract + "'}",
                    url: "SaveData.aspx/SaveDailyWorkerExtract",
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
                alert("يجب اختار المشروع اولا");
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <table>
        <tr>
            <td colspan="4" class="td_center">
                <h1>
                    مستخلص العماله اليوميه</h1>
            </td>
        </tr>
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
                اسم العامل :
            </td>
            <td style="text-align: right;">
                <select id="cbo_Workers" class="b_width">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <h1>
                    مستخلص رقم (<span id="ExtractNumber"> </span>)</h1>
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
    </table>
    <h1>
        بيانات المستخلص</h1>
    <table>
        <thead>
            <tr class="HeaderRow">
                <td rowspan="2">
                    فترات العمل
                </td>
                <td rowspan="2">
                    الفئة
                </td>
                <td colspan="3">
                    صافى ايام العمل
                </td>
                <td rowspan="2">
                    نسبة الصرف
                </td>
                <td rowspan="2">
                    الاجمالى
                </td>
            </tr>
            <tr class="HeaderRow">
                <td>
                    عدد الايام
                </td>
                <td>
                    الخصومات بالأيام
                </td>
                <td>
                    الصافى الفعلى
                </td>
            </tr>
        </thead>
        <tbody id="grid_ExtractDetails">
            <tr class="ItemRow">
                <td class="style16">
                    <input name="WorkDurationName" class="b_width addrow"  />
                </td>
                <td class="style22">
                    <input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/>
                </td>
                <td class="style18">
                    <input type="text" name="TotalDays" class="s_width addrow" />
                </td>
                <td class="style18">
                    <input type="text" name="DeductionsDays" class="s_width addrow" onchange="onChangePrice(this)"/>
                </td>
                <td class="style18">
                    <input type="text" name="NetDays" class="s_width addrow" readonly/>
                </td>
                <td class="style18">
                    <input type="text" name="ExchangeRate" class="s_width addrow" onchange="onChangePrice(this)"/>
                </td>
                <td class="style18">
                    <input type="text" name="TotalPrice" class="s_width addrow" readonly/>
                </td>
            </tr>
        </tbody>
    </table>
    <table style="float: left; left: 33px; top: 5px; position: relative;">
        <tr>
            <td colspan="2" class="style23">
                إجمالى المستخلص :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="TotalExtractPrice" class="b_width IsNumberOnly" readonly/>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="style23">
                السابق صرفه :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="txt_LastPaid" class="b_width IsNumberOnly" readonly/>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="style23">
                الاستقطاعات :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="txt_Deductions" class="b_width IsNumberOnly"  onchange="onChangeDeductions()"/>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="style23">
                الصافى المستحق :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="txt_NetDue" class="b_width IsNumberOnly" readonly/>
            </td>
        </tr>
    </table>
    <input id="Button5" type="button" value="حفظ" onclick="SaveDailyWorkerExtract()" class="btn_Save" />
    <input id="Button8" type="button" value="إلغاء" class="btn_Save" />
</asp:Content>
