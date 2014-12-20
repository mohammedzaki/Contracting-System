
function AddDailyWorker() {

    $.ajax({
        url: "AddDailyWorker.aspx",
        type: "POST",
        data: {
            action: "AddDailyWorker",
            Name: $("#txt_DailyWorkerName").val(),
            Mobile: $("#txt_DailyWorkerMobile").val(),
            WorkerID: $("#txt_DailyWorkerID").val()
        },
        success: function (data) {
            $("#txt_DailyWorkerCode").val($(data).filter('Main').find('PK').text());
            alert("تمت الاضافة بنجاح");
        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}