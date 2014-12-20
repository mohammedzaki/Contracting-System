/// <reference path="Refrences.js" />

var BasicData;
getBasicData();
$("#cbo_Currency").attr("disabled", "disabled");
$("#cbo_Safe").attr("disabled", "disabled");
$("#txt_EGPInUSD").attr("disabled", "disabled");
$("#txt_USDInRMB").attr("disabled", "disabled");
$("#txt_EGPRateToUSD").attr("disabled", "disabled");

$("#txt_ReceiptNo").attr("disabled", "disabled");
$("#chb_ReceiptNo").removeAttr("checked");

function getBasicData() {
    ShowSpinner();
    $.ajax({
        type: "POST",
        data: {
            action: "getBasicInfo"
        },
        url: "Expenses.aspx",
        datatype: "xml",
        success: function (data) {
            BasicData = data;
            if ($(BasicData).filter('main').find('Exception').text() == '') {
                $(BasicData).filter('main').find('ClientsInfo').find('Client').each(function () {
                    $("#cbo_CustomerList").append("<option value='" + $(this).find('Id').text() + "'>" + $(this).find('Name').text() + "</option>");
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
        error: function () {
            hideSpinner();
            alert("Error happened please contact System Administrator");
        }
    });
}

function Fillter_cbo_Currency(obj) {
    var amounts;
    var safeId = $(obj).val();
    $(BasicData).filter('main').find('SafesInfo').find('Safe').each(function () {
        if ($(this).find('SafeId').text() == safeId) {
            $(this).find('SafeAmounts').find('Amount').each(function () {
                amounts += "<option value='" + $(this).find('SafeAmountID').text() + "'>" + $(this).find('CurrencyName').text() + "    " + $(this).find('Symbol').text() + "</option>";
            });
        }
    });
    $("#cbo_Currency").html('<option></option>' + amounts);
}

function ConvertCurrency() {
    if (currencyName == '') {
        currencyName = 'RMB    ¥';
    }
    var depositValue = $("#txt_ExpenseValue").val();
    // 1 USD = EGP * EGP rate
    // 2 RMB = USD * RMB rate
    var USD = 0, RMB = 0, EGP = 0, EGPRateToUSD = 0, RMBRateToUSD = 0;
    EGPRateToUSD = $("#txt_EGPRateToUSD").val();
    RMBRateToUSD = $("#txt_USDRateToRMB").val();
    if (currencyName == 'RMB    ¥') {
        USD = depositValue / RMBRateToUSD;
        RMB = depositValue;
    } else if (!$("#txt_EGPRateToUSD").is(':disabled')) {
        USD = depositValue / EGPRateToUSD;
        RMB = USD * RMBRateToUSD;
    } else {
        RMB = depositValue / RMBRateToUSD;
        USD = depositValue;
    }
    $("#txt_EGPInUSD").val(USD);
    $("#txt_USDInRMB").val(RMB);
}

var currencyName = '';

function SetRateType() {
    currencyName = $("#cbo_Currency option:selected").text();
    switch (currencyName) {
        case "RMB    ¥":
            $("#txt_EGPRateToUSD").attr("disabled", "disabled");
            $("#txt_EGPRateToUSD").val('');
            break;
        case "USD    $":
            $("#txt_EGPRateToUSD").attr("disabled", "disabled");
            $("#txt_EGPRateToUSD").val('');
            break;
        case "EGP    L.E":
            $("#txt_EGPRateToUSD").removeAttr("disabled");
            break;
        default:
            break;
    }
}

function SetReceiptType() {
    if (!$('#chb_ReceiptNo').is(':checked')) {
        $("#cbo_Currency").attr("disabled", "disabled");
        $("#cbo_Safe").attr("disabled", "disabled");
        $("#txt_EGPInUSD").attr("disabled", "disabled");
        $("#txt_EGPRateToUSD").attr("disabled", "disabled");
        
        $("#txt_USDInRMB").attr("disabled", "disabled");
        $("#txt_ReceiptNo").attr("disabled", "disabled");
        $("#txt_ReceiptNo").val('');
        $("#cbo_Currency").val('');
        $("#cbo_Safe").val('');
        $("#txt_EGPInUSD").val('');
        $("#txt_EGPRateToUSD").val('');
        
        $("#txt_USDInRMB").val('');
    } else {
        $("#cbo_Currency").removeAttr("disabled");
        $("#cbo_Safe").removeAttr("disabled");
        //$("#txt_EGPInUSD").removeAttr("disabled");
        $("#txt_EGPRateToUSD").removeAttr("disabled");
        
        //$("#txt_USDInRMB").removeAttr("disabled");
        $("#txt_ReceiptNo").removeAttr("disabled");
    }
}

function btn_SaveExpense() {
    if ($("#cbo_CustomerList").val() == '') {
        alert("Please Select Customer First.");
        return;
    }
    if ($("#cbo_Currency").val() == '') {
        alert("Please provide the Deposit.");
        return;
    }
    if ($("#cbo_ExpenseType").val() == '') {
        alert("Please provide the Expense Type.");
        return;
    }
    if ($('#chb_ReceiptNo').is(':checked')) {
        if ($("#txt_ReceiptNo").val() == '') {
            alert("Please provide the Receipt No.");
            return;
        }
    }
    if ($("#txt_ExpenseValue").val() == '') {
        alert("Please provide the Deposit.");
        return;
    }
    if (!$("#txt_EGPRateToUSD").is(':disabled')) {
        if ($("#txt_EGPRateToUSD").val() == '') {
            alert("Please provide EGP Rate");
            return;
        }
    }
    if ($("#txt_USDRateToRMB").val() == '') {
        alert("Please provide USD Rate.");
        return;
    }
    if ($("#txt_Description").val() == '') {
        alert("Please provide the Description.");
        return;
    }
    var xmlExpense = '';
    xmlExpense += "<ExpenseInfo>";
    xmlExpense += "<CustomerId>" + $("#cbo_CustomerList").val() + "</CustomerId>";
    xmlExpense += "<ExpenseDescription>" + $("#txt_Description").val() + "</ExpenseDescription>";
    xmlExpense += "<ExpenseValue>" + $("#txt_ExpenseValue").val() + "</ExpenseValue>";
    xmlExpense += "<SafeAmountId>" + $("#cbo_Currency").val() + "</SafeAmountId>";
    xmlExpense += "<ReceiptNo>" + $("#txt_ReceiptNo").val() + "</ReceiptNo>";
    xmlExpense += "<USDRateToRMB>" + $("#txt_USDRateToRMB").val() + "</USDRateToRMB>";
    xmlExpense += "<EGPRateToUSD>" + $("#txt_EGPRateToUSD").val() + "</EGPRateToUSD>";
    xmlExpense += "<EGPInUSD>" + $("#txt_EGPInUSD").val() + "</EGPInUSD>";
    xmlExpense += "<USDInRMB>" + $("#txt_USDInRMB").val() + "</USDInRMB>";
    xmlExpense += "<IsEGP>" + $("#txt_EGPRateToUSD").is(':disabled') + "</IsEGP>";
    xmlExpense += "<IsReceipt>" + $('#chb_ReceiptNo').is(':checked') + "</IsReceipt>";
    xmlExpense += "<ExpenseType>" + $("#cbo_ExpenseType").val() + "</ExpenseType>";
    xmlExpense += "</ExpenseInfo>";
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: "{ xmlExpense: '" + xmlExpense + "'}",
        url: "Expenses.aspx/SaveExpense",
        dataType: "json",
        success: function (data) {
            if (data.d > -1) {
                alert("Expense has been submitted successfully.");
                window.location.reload();
            } else {
                alert("Error happened please contact System Administrator");
            }
        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}