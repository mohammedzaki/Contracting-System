
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
                $("#cbo_Employees").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                $("#cbo_Employees").on("change", function () {
                    $(subData).filter('main').find('Tbl_Data').each(function () {
                        if ($("#cbo_Employees").val() == $(this).find('PK_ID').text()) {
                            $("#txt_EmployeeName").val($(this).find('Name').text());
                            $("#txt_EmployeeMobile").val($(this).find('Mobile').text());
                            $("#txt_EmployeeID").val($(this).find('ID').text());
                            $("#txt_JobName").val($(this).find('JobName').text());
                            $("#txt_Salary").val($(this).find('Salary').text());
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

function AddEmployee() {

    $.ajax({
        url: "EditEmployee.aspx",
        type: "POST",
        data: {
            action: "UpdateEmployee",
            id: $("#cbo_Employees").val(),
            Name: $("#txt_EmployeeName").val(),
            Mobile: $("#txt_EmployeeMobile").val(),
            EmployeeID: $("#txt_EmployeeID").val(),
            JobName: $("#txt_JobName").val(),
            Salary: $("#txt_Salary").val()
        },
        success: function (data) {
            //$("#txt_DailyWorkerCode").val($(data).filter('Main').find('PK').text());
            alert("تمت التعديل بنجاح");
            window.location.reload();
        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}