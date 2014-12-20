<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="EditDailyWorkerExtract.aspx.cs" Inherits="Contracting_System.EditDailyWorkerExtract" %>

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
                    $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><select name="WorkItem" class="b_width addrow" onchange="onChangeItem(this)"><option></option></select></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" onchange="onChangePrice(this)" class="s_width addrow"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="ExchangeRate" onchange="onChangePrice(this)" class="s_width addrow"/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td><input type="button" value="      " disabled/></td></tr>');

                    $("#cbo_ProjectName").on("change", function () {
                        $("#cbo_DailyWorker").html('<option></option>');
                        $(subData).filter('main').find('ProjectDailyWorkers').each(function () {
                            if ($(this).find('ProjectID').text() == $("#cbo_ProjectName").val()) {
                                $("#cbo_DailyWorker").append('<option value="' + $(this).find('DailyWorkerID').text() + '" >' + $(this).find('DailyWorkerName').text() + '</option>');
                            }
                        });
                    });
                    $("#cbo_DailyWorker").on("change", function () {

                        $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><input name="WorkItem" class="b_width addrow" readonly/></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td style="display: none;"><input type="hidden" name="PK_ID" class="s_width addrow" readonly/></td></tr>');

                        $(subData).filter('main').find('Tbl_DailyWorkerExtract').each(function () {
                            if ($(this).find('DailyWorkerID').text() == $("#cbo_DailyWorker").val()) {
                                $("#cbo_ExractOrder").append('<option value="' + $(this).find('ExractOrder').text() + '" >' + $(this).find('PK_ID').text() + '</option>');
                            }
                        });
                    });
                    $("#cbo_ExractOrder").on("change", function () {
                        $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><input name="WorkItem" class="b_width addrow" readonly/></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td style="display: none;"><input type="hidden" name="PK_ID" class="s_width addrow" readonly/></td></tr>');
                        $("#txt_LastPaid").val('');
                        $("#txt_NetDue").val('');
                        $("#TotalExtractPrice").val('');
                        $("#txt_Deductions").val('');
                        $("#txt_BusinessGuarantee").val('');
                        $("#txt_DateTo").val('');
                        $("#txt_DateFrom").val('');
                        $(subData).filter('main').find('Tbl_DailyWorkerExtract').each(function () {
                            if ($(this).find('PK_ID').text() == $("#cbo_ExractOrder").val()) {
                                $("#grid_ExtractDetails").html('');
                                $("#txt_LastPaid").val($(this).find('LastPaid').text());
                                $("#txt_NetDue").val($(this).find('NetDue').text());
                                $("#TotalExtractPrice").val($(this).find('TotalExtractPrice').text());
                                $("#txt_Deductions").val($(this).find('Deductions').text());
                                $("#txt_BusinessGuarantee").val($(this).find('BusinessGuarantee').text());
                                $("#txt_DateTo").val($(this).find('DateTo').text());
                                $("#txt_DateFrom").val($(this).find('DateFrom').text());

                                $(subData).filter('main').find('Tbl_DailyWorkerExtractItems').each(function () {
                                    if ($(this).find('FK_DailyWorkerExractID').text() == $("#cbo_ExractOrder").val()) {
                                        $("#grid_ExtractDetails").append('<tr class="ItemRow"><td class="style16"><input name="WorkItem" class="b_width addrow" value="' + $(this).find('WorkName').text() + '" readonly/></td><td class="style18"><input name="Price" class="s_width addrow" value="' + $(this).find('Price').text() + '" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" value="' + $(this).find('LastExitExecutedQTY').text() + '" onchange="onChangePrice(this)" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" value="' + $(this).find('CurrentExecutedQTY').text() + '" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" value="' + $(this).find('TotalExecutedQTY').text() + '" readonly/></td><td class="style18"><input type="text" name="ExchangeRate" onchange="onChangePrice(this)" class="s_width addrow" value="' + $(this).find('ExchangeRatio').text() + '"/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" value="' + $(this).find('TotalPrice').text() + '" readonly/></td><td style="display: none;"><input type="hidden" name="PK_ID" class="s_width addrow" value="' + $(this).find('PK_ID').text() + '" readonly/></td></tr>');
                                    }
                                });
                                calcuPrice();
                            }
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

        });

        function calcuPrice() {
            var TotalPrice;
            var count = $('#grid_ExtractDetails').children().length;
            var TotalPriceCount = 0.0;
            for (var i = 0; i < count; i++) {
                //Check if Total Price not Equal 0
                TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(6)').children(0);
                TotalPriceCount += parseFloat($(TotalPrice).val());
            }
            $("#TotalExtractPrice").val(TotalPriceCount);
            onChangeDeductions();
        }

        function onChangeItem(parent) {
            var rowIndex = $(parent)
                                    .closest('tr') // Get the closest tr parent element
                                    .prevAll() // Find all sibling elements in front of it
                                    .length; // Get their count
            var
            Price = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(1)').children(0),
            LastDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(2)').children(0),
            CurrentDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(3)').children(0),
            TotalDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(4)').children(0),
            ExchangeRate = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(5)').children(0),
            TotalPrice = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(6)').children(0);
            $(LastDoneQTY).val(0);
            $(subData).filter('main').find('View_DailyWorkerExtract').each(function () {
                if ($(this).find('WorkNameID').text() == $(parent).val()) {
                    $(LastDoneQTY).val($(this).find('ExecutedQTY').text());
                }
            });
        }

        function onChangePrice(parent) {
            var rowIndex = $(parent)
                                    .closest('tr') // Get the closest tr parent element
                                    .prevAll() // Find all sibling elements in front of it
                                    .length; // Get their count
            var
            Price = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(1)').children(0),
            LastDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(2)').children(0),
            CurrentDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(3)').children(0),
            TotalDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(4)').children(0),
            ExchangeRate = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(5)').children(0),
            TotalPrice = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(6)').children(0);

            $(TotalDoneQTY).val(parseInt((LastDoneQTY).val()) + parseInt($(CurrentDoneQTY).val()));
            $(TotalPrice).val(parseFloat($(Price).val()) * parseInt($(TotalDoneQTY).val()) * (parseFloat($(ExchangeRate).val()) / 100));
            var count = $('#grid_ExtractDetails').children().length;
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
            categories = "";
            $(subData).filter('main').find('View_ProjectDailyWorkers').each(function () {
                if ($(this).find('DailyWorkerID').text() == $("#cbo_DailyWorker").val()) {
                    categories += '<option value="' + $(this).find('ItemID').text() + '" >' + $(this).find('FullItemName').text() + '</option>';
                }
            });
            var CurrentCell = $(CellChildInput).parent();
            var CurrentCellName = $(CellChildInput).attr('name');
            var CurrentRow = $(CurrentCell).parent();
            var AfterCurrentRow = $(CurrentRow).next();
            if ($(AfterCurrentRow).hasClass("ItemRow") == false) {
                $("#grid_ExtractDetails").append('<tr class="ItemRow"><td class="style16"><select name="WorkItem" class="b_width addrow" onchange="onChangeItem(this)"><option></option>' + categories + '</select></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="ExchangeRate" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td><input type="button" value="حذف" onclick="RemoveRow(this)"/></td></tr>');
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

        function SaveDailyWorkerExtract() {
            if ($("#cbo_Employee").val() != '') {
                var count = $('#grid_ExtractDetails').children().length;
                var orderCounter = 0;
                var xmlDailyWorkerExtract = "<DailyWorkerExtract>";
                var save = false;
                if ($("#cbo_ProjectName").val() == '') {
                    alert("إختر المشروع اولا");
                    return;
                }
                xmlDailyWorkerExtract += "<DailyWorkerExtractInfo>";
                xmlDailyWorkerExtract += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlDailyWorkerExtract += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlDailyWorkerExtract += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlDailyWorkerExtract += "<BusinessGuarantee>" + $("#txt_BusinessGuarantee").val() + "</BusinessGuarantee>";
                xmlDailyWorkerExtract += "<Deductions>" + $("#txt_Deductions").val() + "</Deductions>";
                xmlDailyWorkerExtract += "<LastPaid>" + $("#txt_LastPaid").val() + "</LastPaid>";
                xmlDailyWorkerExtract += "<TotalExtractPrice>" + $("#TotalExtractPrice").val() + "</TotalExtractPrice>";
                xmlDailyWorkerExtract += "<NetDue>" + $("#txt_NetDue").val() + "</NetDue>";
                xmlDailyWorkerExtract += "<ExractOrder>" + $("#ExtractNumber").html() + "</ExractOrder>";
                xmlDailyWorkerExtract += "<DailyWorkerName>" + $("#cbo_DailyWorker option:selected").val() + "</DailyWorkerName>";
                xmlDailyWorkerExtract += "<DailyWorkerId>" + $("#cbo_DailyWorker").val() + "</DailyWorkerId>";
                xmlDailyWorkerExtract += "<DailyWorkerExractPK_ID>" + $("#cbo_ExractOrder").val() + "</DailyWorkerExractPK_ID>";
                xmlDailyWorkerExtract += "</DailyWorkerExtractInfo>";

                if (count == 0) return;
                xmlDailyWorkerExtract += "<DailyWorkerExtractItems>";
                for (var i = 0; i < count; i++) {
                    //Check if Total Price not Equal 0
                    var
                    WorkNameID = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).val(),
                    WorkName = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).find('option:selected').text(),
                    Price = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(1)').children(0).val(),
                    LastExecutedQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(2)').children(0).val(),
                    CurrentExecutedQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(3)').children(0).val(),
                    TotalExecutedQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(4)').children(0).val(),
                    ExchangeRatio = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(5)').children(0).val(),
                    TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(6)').children(0).val(),
                    ExtractItemPK_ID = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(7)').children(0).val();
                    if (WorkNameID == '') {
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

                    //DailyWorkerId DailyWorkerName $( '#'+$('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).attr('id')+' option:selected' ).text()
                    xmlDailyWorkerExtract += "<Item>";
                    xmlDailyWorkerExtract += "<WorkNameID>" + WorkNameID + "</WorkNameID>";
                    xmlDailyWorkerExtract += "<WorkName>" + WorkName + "</WorkName>";
                    xmlDailyWorkerExtract += "<Price>" + Price + "</Price>";
                    xmlDailyWorkerExtract += "<LastExitExecutedQTY>" + parseInt(LastExecutedQTY) + "</LastExitExecutedQTY>";
                    xmlDailyWorkerExtract += "<LastExecutedQTY>" + (parseInt(LastExecutedQTY) + parseInt(CurrentExecutedQTY)) + "</LastExecutedQTY>";
                    xmlDailyWorkerExtract += "<CurrentExecutedQTY>" + CurrentExecutedQTY + "</CurrentExecutedQTY>";
                    xmlDailyWorkerExtract += "<TotalExecutedQTY>" + TotalExecutedQTY + "</TotalExecutedQTY>";
                    xmlDailyWorkerExtract += "<ExchangeRatio>" + ExchangeRatio + "</ExchangeRatio>";
                    xmlDailyWorkerExtract += "<TotalPrice>" + TotalPrice + "</TotalPrice>";
                    xmlDailyWorkerExtract += "<ExtractItemPK_ID>" + ExtractItemPK_ID + "</ExtractItemPK_ID>";
                    xmlDailyWorkerExtract += "</Item>";
                }
                xmlDailyWorkerExtract += "</DailyWorkerExtractItems>";

                xmlDailyWorkerExtract += "</DailyWorkerExtract>";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: "{ xmlDailyWorkerExtract: '" + xmlDailyWorkerExtract + "'}",
                    url: "SaveData.aspx/UpdateDailyWorkerExtract",
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
        <tr>
            <td colspan="4" class="td_center">
                <h1>
                    تعديل مستخلص العماله اليوميه</h1>
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
                <select id="cbo_DailyWorker" class="b_width">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            
            <td class="style23">
                رقم المستخلص :
            </td>
            <td>
                <input type="text" id="ex" class="IsNumberOnly b_width" />
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
                    <select name="WorkItem" class="b_width addrow"  onchange="onChangeItem(this)">
                        <option></option>
                    </select>
                </td>
                <td class="style22">
                    <input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/>
                </td>
                <td class="style18">
                    <input type="text" name="LastDoneQTY" class="s_width addrow" readonly/>
                </td>
                <td class="style18">
                    <input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/>
                </td>
                <td class="style18">
                    <input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/>
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
