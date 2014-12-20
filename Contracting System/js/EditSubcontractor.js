
$(function () {
    $.ajax({
        url: "LoadData.aspx",
        type: "POST",
        data: {
            action: location.pathname.substr(1, (location.pathname.length - 6))
        },
        success: function (data) {
            subData = data;
            $(subData).filter('main').find('Tbl_Data').each(function () {
                $("#cbo_EditSubcontractors").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                $("#cbo_EditSubcontractors").on("change", function () {
                    $(subData).filter('main').find('Tbl_Data').each(function () {
                        if ($("#cbo_EditSubcontractors").val() == $(this).find('PK_ID').text()) {
                            $("#txt_SubContractorName").val($(this).find('Name').text());
                            $("#txt_SubContractorCode").val($(this).find('PK_ID').text());
                            $("#txt_SubContractorMobile").val($(this).find('Mobile').text());
                            $("#txt_SubContractorTel").val($(this).find('LandLine').text());
                            $("#txt_SubContractorAddress").val($(this).find('Address').text());
                        }
                    });
                });
            });
        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
});

/// <reference path="Refrences.js" />



function UpdateSubContractor() {
    if ($("#txt_SubContractorCode").val() > 0) {


        $.ajax({
            url: "EditSubcontractors.aspx",
            type: "POST",
            data: {
                action: "UpdateSubContractor",
                Id: $("#txt_SubContractorCode").val(),
                Name: $("#txt_SubContractorName").val(),
                Mobile: $("#txt_SubContractorMobile").val(),
                LandLine: $("#txt_SubContractorTel").val(),
                Address: $("#txt_SubContractorAddress").val()
            },
            success: function (data) {
                //$("#txt_SubContractorCode").val($(data).filter('Main').find('PK').text());
                alert("تمت التعديل بنجاح");
                window.location.reload();
            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("من فضلك تاكد من البيانات");
    }
}

function ResetPage() {
    $("#txt_SubContractorName").val("");
    $("#txt_SubContractorCode").val("");
    $("#txt_SubContractorMobile").val("");
    $("#txt_SubContractorTel").val("");
    $("#txt_SubContractorAddress").val("");

}