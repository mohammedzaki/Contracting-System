/// <reference path="Refrences.js" />

var BasicData;
getBasicData();
$("#txt_EGPInUSD").attr("disabled", "disabled");
$("#txt_USDInRMB").attr("disabled", "disabled");

function getBasicData() {
    ShowSpinner();
    $.ajax({
        type: "POST",
        data: {
            action: "getBasicInfo"
        },
        url: "Deposits.aspx",
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
    var depositValue = $("#txt_DepositValue").val();
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

function btn_SaveDepoist() {
    if ($("#cbo_CustomerList").val() == '') {
        alert("Please Select Customer First.");
        return;
    }
    if ($("#cbo_Currency").val() == '') {
        alert("Please provide the Deposit.");
        return;
    }
    if ($("#txt_ReceiptNo").val() == '') {
        alert("Please provide the Receipt No.");
        return;
    }
    if ($("#txt_DepositValue").val() == '') {
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
    var xmlDeposit = '';
    xmlDeposit += "<DepositInfo>";
    xmlDeposit += "<CustomerId>" + $("#cbo_CustomerList").val() + "</CustomerId>";
    xmlDeposit += "<DepositDescription>" + $("#txt_Description").val() + "</DepositDescription>";
    xmlDeposit += "<DepositValue>" + $("#txt_DepositValue").val() + "</DepositValue>";
    xmlDeposit += "<SafeAmountId>" + $("#cbo_Currency").val() + "</SafeAmountId>";
    xmlDeposit += "<ReceiptNo>" + $("#txt_ReceiptNo").val() + "</ReceiptNo>";
    xmlDeposit += "<USDRateToRMB>" + $("#txt_USDRateToRMB").val() + "</USDRateToRMB>";
    xmlDeposit += "<EGPRateToUSD>" + $("#txt_EGPRateToUSD").val() + "</EGPRateToUSD>";
    xmlDeposit += "<EGPInUSD>" + $("#txt_EGPInUSD").val() + "</EGPInUSD>";
    xmlDeposit += "<USDInRMB>" + $("#txt_USDInRMB").val() + "</USDInRMB>";
    xmlDeposit += "<IsEGP>" + $("#txt_EGPRateToUSD").is(':disabled') + "</IsEGP>";
    xmlDeposit += "</DepositInfo>";
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: "{ xmlDeposit: '" + xmlDeposit + "'}",
        url: "Deposits.aspx/SaveDeposit",
        dataType: "json",
        success: function (data) {
            if (data.d > -1) {
                alert("Deposit has been submitted successfully.");
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