/// <reference path="Refrences.js" />

LoadCbo_EditCategory();

function LoadCbo_EditCategory() {
    $.ajax({
        url: "EditWorkCategory.aspx",
        type: "POST",
        data: {
            action: "LoadCbo_EditCategory"
        },
        success: function (data) {
            // var res = $(data).filter('main').find('result').text();
            //$("#cbo_Units").append("<option>" + res + "</option>");
            //$("#txt_MeasurUnit").value = "";
            $("#Cbo_EditCategory option").remove();
            $("#Cbo_EditCategory").append('<option></option>');
            $(data).filter('Tbl_WorkCategories').find('Category').each(function () {
                $("#Cbo_EditCategory").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
            });


            // alert("Add Done");

        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}

function SelectEditCategory() {
    $("#txt_EditCategory").val($("#Cbo_EditCategory option").filter(":selected").text());
}

function UpdateCategory() {
    if ($("#txt_EditCategory").val().length > 0) {
        $.ajax({
            url: "EditWorkCategory.aspx",
            type: "POST",
            data: {
                action: "UpdateCategory",
                PK_ID: $("#Cbo_EditCategory option").filter(":selected").val(),
                Name: $("#txt_EditCategory").val()
            },
            success: function (data) {


                alert("تم حفظ التعديل بنجاح");
                $("#txt_EditCategory").val("");
            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
        LoadCbo_EditCategory();
    } else {
        alert("لابد من ادخال فئة");
    }
}