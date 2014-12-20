/// <reference path="Refrences.js" />



function ConvertCurrency() {
    var depositValue = $("#txt_Value").val();
    // 1 USD = EGP * EGP rate
    // 2 RMB = USD * RMB rate
    var USD = 0, RMB = 0, EGP = 0, EGPRateToUSD = 0, RMBRateToUSD = 0;
    EGPRateToUSD = $("#txt_EGPRateToUSD").val();
    RMBRateToUSD = $("#txt_USDRateToRMB").val();
    USD = depositValue / EGPRateToUSD;
    RMB = USD * RMBRateToUSD;
    $("#txt_EGPInUSD").val(USD);
    $("#txt_USDInRMB").val(RMB);
}