
/// <reference path="Refrences.js" />

LoadLst_Units();

function LoadLst_Units() {
    $.ajax({
        url: "AddMeasurementUnit.aspx",
        type: "POST",
        data: {
            action: "LoadLst_Units"
        },
        success: function(data) {
            $(data).filter('Tbl_MeasurementUnit').find('unit').each(function() {
                $("#Lst_Units").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
                
            });
            // alert("Add Done");

        },
        error: function(error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}

function SaveMeasurementUnit() {
    if ($("#txt_MeasurUnit").val().length > 0) {
        $.ajax({
            url: "AddMeasurementUnit.aspx",
            type: "POST",
            data: {
                unit: $("#txt_MeasurUnit").val(),
                action: "SaveMeasurementUnit"
            },
            success: function (data) {
                // var res = $(data).filter('main').find('result').text();
                //$("#cbo_Units").append("<option>" + res + "</option>");
                $("#txt_MeasurUnit").text(' ');
                $("#Lst_Units option").remove();
                $(data).filter('Tbl_MeasurementUnit').find('unit').each(function () {
                    $("#Lst_Units").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
                });
                $("#txt_MeasurUnit").val("");
                alert("تمت الاضافة بنجاح");

            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("برجاء إدخال اسم الوحدة");
    }

}



