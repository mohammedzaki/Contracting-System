
/// <reference path="Refrences.js" />
/// <reference path="jquery-1.10.2.js" />
LoadCbo_WorkCategory();

function LoadCbo_WorkCategory() {
    $.ajax({
        url: "AddWorkType.aspx",
        type: "POST",
        data: {
            action: "LoadCbo_WorkCategory"
            //name: $("#txt_WorkName").val()
        },
        success: function (data) {
            // var res = $(data).filter('main').find('result').text();
            //$("#cbo_Units").append("<option>" + res + "</option>");
            //$("#txt_MeasurUnit").value = "";
            $("#Cbo_WorkCategory option").remove();
            $(data).filter('Main').find('Tbl_WorkCategories').find('Category').each(function () {
                $("#Cbo_WorkCategory").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');

            });
            $(data).filter('Main').find('Tbl_WorkType').find('WorkType').each(function () {
                $("#Tbl_Itemss").append('<tr class="ItemRow"> <td class="style14"> <input type="text" style="width: 160px" name="ItemNo" onchange="AddNewRow(this)" value="' + $(this).find('WorkCategory').text() + '" /></td>  <td class="style15">  <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)" onkeypress="return isNumber(event);" value="' + $(this).find('WorkTypeName').text() + '" /></td>  <td class="style16">');
            });
            // alert("Add Done");

        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}



function AddWorkType() {
    if ($("#Cbo_WorkCategory option").filter(":selected").text().length > 0) {

        if ($("#txt_WorkTYpe").val().length > 0) {


            $.ajax({
                url: "AddWorkType.aspx",
                type: "POST",
                data: {
                    action: "AddWorkType",
                    FK_WorkCategory: $("#Cbo_WorkCategory").val(),
                    Name: $("#txt_WorkTYpe").val()
                },
                success: function (data) {
                    // var res = $(data).filter('main').find('result').text();
                    //$("#cbo_Units").append("<option>" + res + "</option>");
                    //$("#txt_MeasurUnit").value = "";

                    $("#Tbl_Itemss").empty();
                    $("#Tbl_Itemss").append('<tr class="HeaderRow"><td class="style8">فئة العمل</td><td class="style9">نوع العمل</td> </tr>');
                    $(data).filter('Tbl_WorkType').find('WorkType').each(function () {
                        $("#Tbl_Itemss").append('<tr class="ItemRow"> <td class="style14"> <input type="text" style="width: 160px" name="ItemNo" onchange="AddNewRow(this)" value="' + $(this).find('WorkCategory').text() + '" /></td>  <td class="style15">  <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)" onkeypress="return isNumber(event);" value="' + $(this).find('WorkTypeName').text() + '" /></td>  <td class="style16">');
                    });
                    $("#Cbo_WorkCategory").val("");
                    $("#txt_WorkTYpe").val("");
                    alert("تمت الاضافة بنجاح");

                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });
        } else {

            alert("لابد من كتابة نوع العمل ");
        }
    } else {
        alert("لابد من اختيار فئة العمل ");
    }
}
