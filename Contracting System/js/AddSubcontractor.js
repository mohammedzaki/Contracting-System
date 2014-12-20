/// <reference path="Refrences.js" />



function AddSubContractor() {
    if (!$("#txt_SubContractorCode").val() > 0) {


        $.ajax({
            url: "AddSubcontractor.aspx",
            type: "POST",
            data: {
                action: "AddSubContractor",
                Name: $("#txt_SubContractorName").val(),
                Mobile: $("#txt_SubContractorMobile").val(),
                LandLine: $("#txt_SubContractorTel").val(),
                Address: $("#txt_SubContractorAddress").val()
            },
            success: function(data) {
                $("#txt_SubContractorCode").val($(data).filter('Main').find('PK').text());
                alert("تمت الاضافة بنجاح");
            },
            error: function(error) {
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
    $("#Cbo_SubContractorWorkType").val("");
    $("#cbo_SubContractorWorkCategory").val("");
    
}