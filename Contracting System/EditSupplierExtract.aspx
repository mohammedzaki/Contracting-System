<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="EditSupplierExtract.aspx.cs" Inherits="Contracting_System.EditSupplierExtract" %>
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
                    $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><input name="WorkItem" class="b_width addrow" readonly/></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td style="display: none;"><input type="hidden" name="PK_ID" class="s_width addrow" readonly/></td></tr>');
                    
                    $("#cbo_ProjectName").on("change", function () {
                        $("#cbo_Suppliers").html('<option></option>');
                        $(subData).filter('main').find('ProjectSuppliers').each(function () {
                            if ($(this).find('ProjectID').text() == $("#cbo_ProjectName").val()) {
                                $("#cbo_Suppliers").append('<option value="' + $(this).find('SupplierID').text() + '" >' + $(this).find('SupplierName').text() + '</option>');
                            }
                        });
                    });
                    $("#cbo_Suppliers").on("change", function () {
                        categories = "";
                        $(subData).filter('main').find('View_ProjectSuppliers').each(function () {
                            if ($(this).find('SupplierID').text() == $("#cbo_Suppliers").val() && $(this).find('ProjectId').text() == $("#cbo_ProjectName").val()) {
                                categories += '<option value="' + $(this).find('ItemID').text() + '" >' + $(this).find('FullItemName').text() + '</option>';
                            }
                        });
                        $("#grid_ExtractDetails").html('<tr class="ItemRow"><td class="style16"><input name="WorkItem" class="b_width addrow" readonly/></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td style="display: none;"><input type="hidden" name="PK_ID" class="s_width addrow" readonly/></td></tr>');

                        $(subData).filter('main').find('Tbl_SupplierExtract').each(function () {
                            if ($(this).find('SupplierId').text() == $("#cbo_Suppliers").val()) {
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
                        $(subData).filter('main').find('Tbl_SupplierExtract').each(function () {
                            if ($(this).find('PK_ID').text() == $("#cbo_ExractOrder").val()) {
                                $("#grid_ExtractDetails").html('');
                                $("#txt_LastPaid").val($(this).find('LastPaid').text());
                                $("#txt_NetDue").val($(this).find('NetDue').text());
                                $("#TotalExtractPrice").val($(this).find('TotalExtractPrice').text());
                                $("#txt_Deductions").val($(this).find('Deductions').text());
                                $("#txt_BusinessGuarantee").val($(this).find('BusinessGuarantee').text());
                                $("#txt_DateTo").val($(this).find('DateTo').text());
                                $("#txt_DateFrom").val($(this).find('DateFrom').text());

                                $(subData).filter('main').find('Tbl_SupplierExtractItems').each(function () {
                                    if ($(this).find('FK_SupplierExractID').text() == $("#cbo_ExractOrder").val()) {
                                        $("#grid_ExtractDetails").append('<tr class="ItemRow"><td class="style16"><input name="WorkItem" class="b_width addrow" value="' + $(this).find('SupplyName').text() + '" readonly/></td><td class="style18"><input name="Price" class="s_width addrow" value="' + $(this).find('Price').text() + '" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" value="' + $(this).find('LastExitExecutedQTY').text() + '" onchange="onChangePrice(this)" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" value="' + $(this).find('CurrentExecutedQTY').text() + '" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" value="' + $(this).find('TotalExecutedQTY').text() + '" readonly/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" value="' + $(this).find('TotalPrice').text() + '" readonly/></td><td style="display: none;"><input type="hidden" name="PK_ID" class="s_width addrow" value="' + $(this).find('PK_ID').text() + '" readonly/></td></tr>');
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
                TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(5)').children(0);
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
            //unit = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(3)').children(0),
            LastDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(2)').children(0),
            CurrentDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(3)').children(0),
            TotalDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(4)').children(0),
            TotalPrice = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(5)').children(0);
            $(LastDoneQTY).val(0);
            $(subData).filter('main').find('View_SupplierExtract').each(function () {
                if ($(this).find('SupplyNameID').text() == $(parent).val()) {
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
            //unit = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(3)').children(0),
            LastDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(2)').children(0),
            CurrentDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(3)').children(0),
            TotalDoneQTY = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(4)').children(0),
            TotalPrice = $('#grid_ExtractDetails tr:eq(' + rowIndex + ') td:eq(5)').children(0);

            $(TotalDoneQTY).val(parseInt((LastDoneQTY).val()) + parseInt($(CurrentDoneQTY).val()));
            $(TotalPrice).val(parseFloat($(Price).val()) * parseInt($(TotalDoneQTY).val()));
            var count = $('#grid_ExtractDetails').children().length;
            var TotalPriceCount = 0.0;
            for (var i = 0; i < count; i++) {
                //Check if Total Price not Equal 0
                TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(5)').children(0);
                TotalPriceCount += parseFloat($(TotalPrice).val());
            }
            $("#TotalExtractPrice").val(TotalPriceCount);
            onChangeDeductions();
        }

        function AddRow(CellChildInput) {
            categories = "";
            $(subData).filter('main').find('View_ProjectSuppliers').each(function () {
                if ($(this).find('SupplierID').text() == $("#cbo_Suppliers").val()) {
                    categories += '<option value="' + $(this).find('ItemID').text() + '" >' + $(this).find('FullItemName').text() + '</option>';
                }
            });
            var CurrentCell = $(CellChildInput).parent();
            var CurrentCellName = $(CellChildInput).attr('name');
            var CurrentRow = $(CurrentCell).parent();
            var AfterCurrentRow = $(CurrentRow).next();
            if ($(AfterCurrentRow).hasClass("ItemRow") == false) {
                $("#grid_ExtractDetails").append('<tr class="ItemRow"><td class="style16"><select name="WorkItem" class="b_width addrow" onchange="onChangeItem(this)"><option></option>' + categories + '</select></td><td class="style22"><input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="LastDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)"/></td><td class="style18"><input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/></td><td class="style18"><input type="text" name="TotalPrice" class="s_width addrow" readonly/></td><td><input type="button" value="حذف" onclick="RemoveRow(this)"/></td></tr>');
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

        function SaveSupplierExtract() {
            if ($("#cbo_Employee").val() != '') {
                var count = $('#grid_ExtractDetails').children().length;
                var orderCounter = 0;
                var xmlSupplierExtract = "<SupplierExtract>";
                var save = false;
                if ($("#cbo_ProjectName").val() == '') {
                    alert("إختر المشروع اولا");
                    return;
                }
                xmlSupplierExtract += "<SupplierExtractInfo>";
                xmlSupplierExtract += "<ProjectId>" + $("#cbo_ProjectName").val() + "</ProjectId>";
                xmlSupplierExtract += "<DateFrom>" + $("#txt_DateFrom").val() + "</DateFrom>";
                xmlSupplierExtract += "<DateTo>" + $("#txt_DateTo").val() + "</DateTo>";
                xmlSupplierExtract += "<BusinessGuarantee>" + $("#txt_BusinessGuarantee").val() + "</BusinessGuarantee>";
                xmlSupplierExtract += "<Deductions>" + $("#txt_Deductions").val() + "</Deductions>";
                xmlSupplierExtract += "<LastPaid>" + $("#txt_LastPaid").val() + "</LastPaid>";
                xmlSupplierExtract += "<TotalExtractPrice>" + $("#TotalExtractPrice").val() + "</TotalExtractPrice>";
                xmlSupplierExtract += "<NetDue>" + $("#txt_NetDue").val() + "</NetDue>";
                xmlSupplierExtract += "<ExractOrder>" + $("#ExtractNumber").html() + "</ExractOrder>";
                xmlSupplierExtract += "<SupplierName>" + $("#cbo_Suppliers option:selected").val() + "</SupplierName>";
                xmlSupplierExtract += "<SupplierId>" + $("#cbo_Suppliers").val() + "</SupplierId>";
                xmlSupplierExtract += "<SupplierExractPK_ID>" + $("#cbo_ExractOrder").val() + "</SupplierExractPK_ID>";
                xmlSupplierExtract += "</SupplierExtractInfo>";

                if (count == 0) return;
                xmlSupplierExtract += "<SupplierExtractItems>";
                for (var i = 0; i < count; i++) {
                    //Check if Total Price not Equal 0
                    var
                    SupplyNameID = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).val(),
                    SupplyName = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).find('option:selected').text(),
                    Price = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(1)').children(0).val(),
                    LastExecutedQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(2)').children(0).val(),
                    CurrentExecutedQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(3)').children(0).val(),
                    TotalExecutedQTY = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(4)').children(0).val(),
                    TotalPrice = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(5)').children(0).val(),
                    ExtractItemPK_ID = $('#grid_ExtractDetails tr:eq(' + i + ') td:eq(6)').children(0).val();
                    if (SupplyNameID == '') {
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

                    //SupplierId SupplierName $( '#'+$('#grid_ExtractDetails tr:eq(' + i + ') td:eq(0)').children(0).attr('id')+' option:selected' ).text()
                    xmlSupplierExtract += "<Item>";
                    xmlSupplierExtract += "<SupplyNameID>" + SupplyNameID + "</SupplyNameID>";
                    xmlSupplierExtract += "<SupplyName>" + SupplyName + "</SupplyName>";
                    xmlSupplierExtract += "<Price>" + Price + "</Price>";
                    xmlSupplierExtract += "<LastExecutedQTY>" + (parseInt(LastExecutedQTY) + parseInt(CurrentExecutedQTY)) + "</LastExecutedQTY>";
                    xmlSupplierExtract += "<CurrentExecutedQTY>" + CurrentExecutedQTY + "</CurrentExecutedQTY>";
                    xmlSupplierExtract += "<TotalExecutedQTY>" + TotalExecutedQTY + "</TotalExecutedQTY>";
                    xmlSupplierExtract += "<TotalPrice>" + TotalPrice + "</TotalPrice>";
                    xmlSupplierExtract += "<ExtractItemPK_ID>" + ExtractItemPK_ID + "</ExtractItemPK_ID>";
                    xmlSupplierExtract += "</Item>";
                }
                xmlSupplierExtract += "</SupplierExtractItems>";

                xmlSupplierExtract += "</SupplierExtract>";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: "{ xmlSupplierExtract: '" + xmlSupplierExtract + "'}",
                    url: "SaveData.aspx/UpdateSupplierExtract",
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
<asp:Content ID="Content3" ContentPlaceHolderID="UsersMainContent" runat="server">
    <table>
        <tr>
            <td colspan="4" class="td_center">
                <h1>
                    تعديل مستخلص الموردين</h1>
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
                اسم المورد :
            </td>
            <td style="text-align: right;">
                <select id="cbo_Suppliers" class="b_width">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">رقم المستخلص :
            </td>
            <td>
                <select id="cbo_ExractOrder" class="b_width">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">الفترة من :
            </td>
            <td>
                <input type="text" id="txt_DateFrom" class="b_width" readonly/>
            </td>
            <td class="style23">الفترة الى :
            </td>
            <td>
                <input type="text" id="txt_DateTo" class="b_width" readonly/>
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
                    <select name="WorkItem" class="b_width addrow" onchange="onChangeItem(this)">
                        <option></option>
                    </select>
                </td>
                <td class="style22">
                    <input type="text" name="Price" class="s_width addrow" onchange="onChangePrice(this)"/>
                </td>
                <td class="style18">
                    <input type="text" name="LastDoneQTY" class="s_width addrow" readonly />
                </td>
                <td class="style18">
                    <input type="text" name="CurrentDoneQTY" class="s_width addrow" onchange="onChangePrice(this)" />
                </td>
                <td class="style18">
                    <input type="text" name="TotalDoneQTY" class="s_width addrow" readonly/>
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
    <input id="Button5" type="button" value="حفظ" onclick="SaveSupplierExtract()" class="btn_Save" />
    <input id="Button8" type="button" value="إلغاء" class="btn_Save" />
</asp:Content>
