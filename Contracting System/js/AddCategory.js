/// <reference path="Refrences.js" />

LoadCategory();

function LoadCategory() {
    
    $.ajax({
        url: "AddCategory.aspx",
        type: "POST",
        data: {
            action: "LoadCategory"
        },
        success: function (data) {
            // var res = $(data).filter('main').find('result').text();
            //$("#cbo_Units").append("<option>" + res + "</option>");
            //$("#txt_MeasurUnit").value = "";
            $("#lst_CategoryList option").remove();
            $(data).filter('Tbl_Category').find('Category').each(function () {
                $("#lst_CategoryList").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            // alert("Add Done");

        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}

function AddCategory() {

    if ($("#txt_CategoryName").val().length > 0) {
        $.ajax({
            url: "AddCategory.aspx",
            type: "POST",
            data: {
                action: "AddCategory",
                name: $("#txt_CategoryName").val()
            },
            success: function (data) {
                // var res = $(data).filter('main').find('result').text();
                //$("#cbo_Units").append("<option>" + res + "</option>");
                //$("#txt_MeasurUnit").value = "";
                $("#lst_CategoryList option").remove();
                $(data).filter('Tbl_Category').find('Category').each(function () {
                    $("#lst_CategoryList").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
                });
                $("#txt_CategoryName").val("");
                // alert("Add Done");

            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("برجاء إدخال اسم الفئة");    
    }
}