/// <reference path="Refrences.js" />

var BasicData;
getBasicData();

function getBasicData() {
    ShowSpinner();
    $.ajax({
        type: "POST",
        data: {
            action: "getBasicInfo"
        },
        url: "Bill.aspx",
        datatype: "xml",
        success: function (data) {
            BasicData = data;
            if ($(BasicData).filter('main').find('Exception').text() == '') {
                $(BasicData).filter('main').find('ClientsInfo').find('Client').each(function () {
                    $("#cbo_CustomerList").append("<option value='" + $(this).find('Id').text() + "'>" + $(this).find('Name').text() + "</option>");
                });
                $(BasicData).filter('main').find('SuppliersInfo').find('Supplier').each(function () {
                    $("#cbo_SupplierName").append("<option value='" + $(this).find('Id').text() + "'>" + $(this).find('Name').text() + "</option>");
                });
                $(BasicData).filter('main').find('DescriptionsInfo').find('Description').each(function () {
                    $("[name='Description']").append("<option value='" + $(this).find('Id').text() + "'>" + $(this).find('EnglishDescription').text() + "</option>");
                });
                $(BasicData).filter('main').find('SafesInfo').find('Safe').each(function () {
                    $("#cbo_Safe").append("<option value='" + $(this).find('SafeId').text() + "'>" + $(this).find('SafeName').text() + "</option>");
                });
                hideSpinner();
            } else {
                hideSpinner();
                alert($(BasicData).filter('main').find('Exception').text());
            }
        },
        error: function (error) {
            hideSpinner();
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}

function Fillter_cbo_Currency(obj) {
    var amounts;
    var safeId = $(obj).val();
    $(BasicData).filter('main').find('SafesInfo').find('Safe').each(function () {
        if ($(this).find('SafeId').text() == safeId) {
            $(this).find('SafeAmounts').find('Amount').each(function () {
                amounts += "<option value='" + $(this).find('CurrencyTypeId').text() + "'>" + $(this).find('CurrencyName').text() + "    " + $(this).find('Symbol').text() + "</option>";
            });
        }
    });
    $("#cbo_Currency").html('<option></option>' + amounts);
}

function AddNewRow(CellChildInput) {
    var CurrentCell = $(CellChildInput).parent();
    var CurrentCellName = $(CellChildInput).attr('name');
    var CurrentRow = $(CurrentCell).parent();
    var AfterCurrentRow = $(CurrentRow).next();
    if ($(AfterCurrentRow).hasClass("ItemRow") == false) {
        var descs = '';
        $(BasicData).filter('main').find('DescriptionsInfo').find('Description').each(function () {
            descs += "<option value='" + $(this).find('Id').text() + "'>" + $(this).find('EnglishDescription').text() + "</option>";
        });
        $("#billItems").append('<tr class="ItemRow"><td class="style12"><input type="button" value="Remove" onclick="RemoveRow(this)" /></td><td class="auto-style2"><select style="width: 235px" name="Description" onchange="AddNewRow(this)"><option></option>' + descs + '</select></td><td class="style3"><input type="text" style="width: 146px" name="ItemNo" onchange="AddNewRow(this)"/></td><td class="style4"><input type="text" style="width: 136px" name="ItemQTY" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"/></td><td class="style5"><input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);"/></td><td class="style6"><input type="text" name="ItemTotalPrice" onchange="AddNewRow(this)" style="width: 137px; cursor:text;" readonly="readonly" /></td></tr>');
    } else {
        switch (CurrentCellName) {
            case "ItemUnitPrice":
                var TotalPrice = $(CurrentCell).prev().children(0).val() * $(CellChildInput).val();
                $(CurrentCell).next().children(0).val(TotalPrice);
                var _Total_Price = 0.0;
                $("[name='ItemTotalPrice']").each(function () {
                    if ($.isNumeric($(this).val()))
                        _Total_Price += parseInt($(this).val());
                });
                $("#txt_TotalPrice").val(_Total_Price);
                var _Total_QTY = 0;
                $("[name='ItemQTY']").each(function () {
                    if ($.isNumeric($(this).val()))
                        _Total_QTY += parseInt($(this).val());
                });
                $("#txt_TotalQTY").val(_Total_QTY);
                break;
            case "ItemQTY":
                var TotalPrice = $(CurrentCell).next().children(0).val() * $(CellChildInput).val();
                $(CurrentCell).next().next().children(0).val(TotalPrice);
                var _Total_Price = 0.0;
                $("[name='ItemTotalPrice']").each(function () {
                    if ($.isNumeric($(this).val()))
                        _Total_Price += parseInt($(this).val());
                });
                $("#txt_TotalPrice").val(_Total_Price);
                var _Total_QTY = 0;
                $("[name='ItemQTY']").each(function () {
                    if ($.isNumeric($(this).val()))
                        _Total_QTY += parseInt($(this).val());
                });
                $("#txt_TotalQTY").val(_Total_QTY);
                break;
            default:
                //alert("Please Choose a valid QTY");
                //alert("Please Choose a valid Price");
                break;

        }
    }
}

function SetDeposit() {
    var DepositType = $("input[type='radio'][name='DepositType']:checked").val();
    if (DepositType == 'Company') {
        $("#txt_ReceiptNo").removeAttr("disabled");
        $("#cbo_Safe").removeAttr("disabled");
    } else if (DepositType == 'Client') {
        $("#txt_ReceiptNo").attr("disabled", "disabled");
        $("#cbo_Safe").attr("disabled", "disabled");
    }
}

function RemoveRow(obj) {
    $(obj).parent().parent().remove();
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        {
            return false;
        }
    }
    return true;
}

function submitBill() {
    if ($("#cbo_CustomerList").val() != '') {
        var count = $('#billItems').children().length - 1;
        var orderCounter = 0;
        var xmlBill = "<Bill>";
        var save = false;
        if ($("#BillRefrenceNumber").val() == '') {
            alert("Please provide the Bill Refrence Number");
            return;
        }
        var DepositType = $("input[type='radio'][name='DepositType']:checked").val();
        if (DepositType == 'Company') {
            if ($("#cbo_Safe").val() == '' || $("#txt_ReceiptNo").val() == '') {
                alert("Please provide the Safer Data");
                return;
            }
        } else if (DepositType == 'undefined') {
            alert("Please select the Deposit Type");
            return;
        }
        if ($("#txt_BillDeposit").val() == '') {
            alert("Please provide the Bill Deposit");
            return;
        }
        xmlBill += "<BillInfo>";
        xmlBill += "<BillRefrenceNumber>" + $("#BillRefrenceNumber").val() + "</BillRefrenceNumber>";
        xmlBill += "<BillInvoiceNumber>" + $("#BillInvoiceNumber").val() + "</BillInvoiceNumber>";
        xmlBill += "<SupplierId>" + $("#cbo_SupplierName").val() + "</SupplierId>";
        xmlBill += "<CustomerId>" + $("#cbo_CustomerList").val() + "</CustomerId>";
        xmlBill += "<BillAmount>" + $("#txt_TotalPrice").val() + "</BillAmount>";
        xmlBill += "<BillDeposit>" + $("#txt_BillDeposit").val() + "</BillDeposit>";
        xmlBill += "<DepositType>" + DepositType + "</DepositType>";
        xmlBill += "<SafeAmountId>" + $("#cbo_Safe").val() + "</SafeAmountId>";
        xmlBill += "<ReceiptNo>" + $("#txt_ReceiptNo").val() + "</ReceiptNo>";
        xmlBill += "</BillInfo>";
        
        if (count == 0) return;
        xmlBill += "<BillItems>";
        for (var i = 0; i < count; i++) {
            //Check if Total Price not Equal 0
            var 
                discription = $('#billItems tr:eq(' + i + ') td:eq(1)').children(0).val(),
                itemNo = $('#billItems tr:eq(' + i + ') td:eq(2)').children(0).val(),
                itemQTY = $('#billItems tr:eq(' + i + ') td:eq(3)').children(0).val(),
                itemPrice = $('#billItems tr:eq(' + i + ') td:eq(4)').children(0).val();

            if (discription == '') {
                alert("Please provide the item description");
                return;
            }
            if (itemNo == '') {
                alert("Please provide the item No");
                return;
            }
            if (itemQTY == '') {
                alert("Please provide the item QTY");
                return;
            }
            if (itemPrice == '') {
                alert("Please provide the item Price");
                return;
            }
            xmlBill += "<Item>";
            xmlBill += "<discription>" + discription + "</discription>";
            xmlBill += "<itemNo>" + itemNo + "</itemNo>";
            xmlBill += "<itemQTY>" + itemQTY + "</itemQTY>";
            xmlBill += "<itemPrice>" + itemPrice + "</itemPrice>";
            xmlBill += "</Item>";
        }
        xmlBill += "</BillItems>";

        xmlBill += "</Bill>";

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: "{ xmlBill: '" + xmlBill + "'}",
            url: "Bill.aspx/SaveBill",
            dataType: "json",
            success: function (data) {
                if (data.d > -1) {
                    alert("You Bill has been submitted successfully, And Bill Auto Number is : " + data.d);
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
        alert("Please Select Customer First.");
    }
}
