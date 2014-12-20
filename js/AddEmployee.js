
function AddEmployee() {

    $.ajax({
        url: "AddEmployee.aspx",
        type: "POST",
        data: {
            action: "AddEmployee",
            Name: $("#txt_EmployeeName").val(),
            Mobile: $("#txt_EmployeeMobile").val(),
            EmployeeID: $("#txt_EmployeeID").val(),
            JobName: $("#txt_JobName").val(),
            Salary: $("#txt_Salary").val()
        },
        success: function (data) {
            //$("#txt_DailyWorkerCode").val($(data).filter('Main').find('PK').text());
            alert("تمت الاضافة بنجاح");
        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}