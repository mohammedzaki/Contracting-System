/// <reference path="Refrences.js" />
/// <reference path="jquery-1.10.2.js" />

LoadWorkType();

function LoadWorkType() {
    $.ajax({
        url: "AddWorkCategory.aspx",
        type: "POST",
        data: {
            action: "LoadWorkType",
            name: $("#txt_WorkName").val()
        },
        success: function (data) {
            // var res = $(data).filter('main').find('result').text();
            //$("#cbo_Units").append("<option>" + res + "</option>");
            //$("#txt_MeasurUnit").value = "";
            $("#lst_WorkList option").remove();
            $(data).filter('Tbl_WorkType').find('WorkType').each(function () {
                $("#lst_WorkList").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            // alert("Add Done");

        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}

function AddWorkType() {
    if ($("#txt_WorkName").val().length > 0) {
        $.ajax({
            url: "AddWorkCategory.aspx",
            type: "POST",
            data: {
                action: "AddWorkTypee",
                name: $("#txt_WorkName").val()
            },
            success: function(data) {
                // var res = $(data).filter('main').find('result').text();
                //$("#cbo_Units").append("<option>" + res + "</option>");
                //$("#txt_MeasurUnit").value = "";
                $("#lst_WorkList option").remove();
                $(data).filter('Tbl_WorkType').find('WorkType').each(function() {
                    $("#lst_WorkList").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
                });
                $("#txt_WorkName").val("");
                // alert("Add Done");

            },
            error: function(error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("من فضلك أكتب اسم الفئة");
    }
}