<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="SubContractorExtract.aspx.cs" Inherits="Contracting_System.SubContractorExtract" %>

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
                    $(".IsDate").datepicker({ dateFormat: "dd/mm/yy" });
                    $(".addrow").change(function () {
                        AddRow(this);
                    });
                    $("#cbo_ProjectName").on("change", function () {
                        $(subData).filter('main').find('ProjectSubContractors').each(function () {
                            if ($(this).find('ProjectID').text() == $("#cbo_ProjectName").val()) {
                                $("#cbo_SubContractor").append('<option value="' + $(this).find('SubContractorID').text() + '" >' + $(this).find('SubContractorName').text() + '</option>');
                            }
                        });
                    });
                    $("#cbo_SubContractor").on("change", function () {
                        categories = "";
                        $(subData).filter('main').find('View_ProjectSubContractors').each(function () {
                            if ($(this).find('SubContractorId').text() == $("#cbo_SubContractor").val() && $(this).find('ProjectId').text() == $("#cbo_ProjectName").val()) {
                                categories += '<option value="' + $(this).find('FK_WorkID').text() + '" >' + $(this).find('FullWorkName').text() + '</option>';
                            }
                        });
                        $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><select name="WorkItem" class="b_width addrow" onchange="onChangeItem(this)"><option></option>' + categories + '</select></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="ExchangeRate" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td><input type="button" value="      " disabled/></td></tr>');
                        $(".addrow").change(function () {
                            AddRow(this);
                        });
                        $("#ExtractNumber").html("1");
                        $("#txt_LastPaid").val(0);

                        $(subData).filter('main').find('View_SubContractorExtractNewOrder').each(function () {
                            if ($(this).find('FK_ProjectID').text() == $("#cbo_ProjectName").val()) {
                                $("#ExtractNumber").html($(this).find('NewExtractOrder').text());
                            }
                        });
                        $(subData).filter('main').find('View_EmpolyeePaid').each(function () {
                            if ($(this).find('PersonID').text() == $("#cbo_SubContractor").val() && $(this).find('PersonTypeID').text() == "-4") {
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
            $(subData).filter('main').find('View_SubContractorExtract').each(function () {
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
            categories = "";
            $(subData).filter('main').find('View_ProjectSubContractors').each(function () {
                if ($(this).find('SubContractorID').text() == $("#cbo_SubContractor").val()) {
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

        function SaveSubContractorExtract() {
            if ($("#cbo_Employee").val() != '') {
                var count = $('#grid_ExtractDetails').children().length - 1;
                var orderCounter = 0;
                var xmlSubContractorExtract = "<SubContractorExtract>";
                var save = false;
                if ($("#cbo_ProjectName").val() == '') {
                    alert("إختر المشروع اولا");
                    return;
                }
                xmlSubContractorExtract += "<SubContractorExtractInfo>";
                xmlSubContractorExtract += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlSubContractorExtract += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlSubContractorExtract += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlSubContractorExtract += "<BusinessGuarantee>" + $("#txt_BusinessGuarantee").val() + "</BusinessGuarantee>";
                xmlSubContractorExtract += "<Deductions>" + $("#txt_Deductions").val() + "</Deductions>";
                xmlSubContractorExtract += "<LastPaid>" + $("#txt_LastPaid").val() + "</LastPaid>";
                xmlSubContractorExtract += "<TotalExtractPrice>" + $("#TotalExtractPrice").val() + "</TotalExtractPrice>";
                xmlSubContractorExtract += "<NetDue>" + $("#txt_NetDue").val() + "</NetDue>";
                xmlSubContractorExtract += "<ExractOrder>" + $("#ExtractNumber").html() + "</ExractOrder>";
                xmlSubContractorExtract += "<SubContractorName>" + $("#cbo_SubContractor option:selected").val() + "</SubContractorName>";
                xmlSubContractorExtract += "<SubContractorId>" + $("#cbo_SubContractor").val() + "</SubContractorId>";
                xmlSubContractorExtract += "</SubContractorExtractInfo>";

                if (count == 0) return;
                xmlSubContractorExtract += "<SubContractorExtractItems>";
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
                    TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(6)').children(0).val();
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

                    //SubContractorId SubContractorName $( '#'+$('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).attr('id')+' option:selected' ).text()
                    xmlSubContractorExtract += "<Item>";
                    xmlSubContractorExtract += "<WorkNameID>" + WorkNameID + "</WorkNameID>";
                    xmlSubContractorExtract += "<WorkName>" + WorkName + "</WorkName>";
                    xmlSubContractorExtract += "<Price>" + Price + "</Price>";
                    xmlSubContractorExtract += "<LastExitExecutedQTY>" + parseInt(LastExecutedQTY) + "</LastExitExecutedQTY>";
                    xmlSubContractorExtract += "<LastExecutedQTY>" + (parseInt(LastExecutedQTY) + parseInt(CurrentExecutedQTY)) + "</LastExecutedQTY>";
                    xmlSubContractorExtract += "<CurrentExecutedQTY>" + CurrentExecutedQTY + "</CurrentExecutedQTY>";
                    xmlSubContractorExtract += "<TotalExecutedQTY>" + TotalExecutedQTY + "</TotalExecutedQTY>";
                    xmlSubContractorExtract += "<ExchangeRatio>" + ExchangeRatio + "</ExchangeRatio>";
                    xmlSubContractorExtract += "<TotalPrice>" + TotalPrice + "</TotalPrice>";
                    xmlSubContractorExtract += "</Item>";
                }
                xmlSubContractorExtract += "</SubContractorExtractItems>";

                xmlSubContractorExtract += "</SubContractorExtract>";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: "{ xmlSubContractorExtract: '" + xmlSubContractorExtract + "'}",
                    url: "SaveData.aspx/SaveSubContractorExtract",
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
                    مستخلص مقاولين الباطن</h1>
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
                اسم المقاول :
            </td>
            <td style="text-align: right;">
                <select id="cbo_SubContractor" class="b_width">
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
                    بيان الاعمال
                </td>
                <td rowspan="2">
                    الفئة
                </td>
                <td colspan="3">
                    الكميات المنفذة
                </td>
                <td rowspan="2">
                    نسبة الصرف
                </td>
                <td rowspan="2">
                    اجمالى السعر
                </td>
            </tr>
            <tr class="HeaderRow">
                <td>
                    السابقه
                </td>
                <td>
                    الحاليه
                </td>
                <td>
                    الاجمالى
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
                ضمان الاعمال :
            </td>
            <td colspan="2" style="text-align: right;">
                <input type="text" id="txt_BusinessGuarantee" class="b_width IsNumberOnly" onchange="onChangeDeductions()"/>
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
    <input id="Button5" type="button" value="حفظ" onclick="SaveSubContractorExtract()" class="btn_Save" />
    <input id="Button8" type="button" value="إلغاء" class="btn_Save" />
</asp:Content>
