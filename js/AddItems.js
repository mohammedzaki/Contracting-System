
/// <reference path="Refrences.js" />
/// <reference path="jquery-1.10.2.js" />
LoadCbo_MeasurementUnit();
LoadCbo_Category();

function LoadCbo_Category() {
    $.ajax({
        url: "AddItems.aspx",
        type: "POST",
        data: {
            action: "LoadCbo_Category"
            //name: $("#txt_WorkName").val()
        },
        success: function (data) {
            // var res = $(data).filter('main').find('result').text();
            //$("#cbo_Units").append("<option>" + res + "</option>");
            //$("#txt_MeasurUnit").value = "";
            $("#Cbo_Category option").remove();
            $(data).filter('Main').find('Tbl_Category').find('Category').each(function () {
                $("#Cbo_Category").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
                
            });
            // alert("Add Done");
            $(data).filter('Main').find('Tbl_Items').find('Item').each(function () {
                $("#Tbl_Itemss").append('<tr class="ItemRow"> <td class="style14"> <input type="text" style="width: 160px" name="ItemNo" onchange="AddNewRow(this)" value="' + $(this).find('Category').text() + '" /></td>  <td class="style15">  <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)" onkeypress="return isNumber(event);" value="' + $(this).find('ItemType').text() + '" /></td>  <td class="style16">  <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);" style="width: 136px" value="' + $(this).find('Unit').text() + '" /></td> </tr>');
            });
        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}
function LoadCbo_MeasurementUnit() {
    $.ajax({
        url: "AddItems.aspx",
        type: "POST",
        data: {
            action: "LoadCbo_MeasurementUnit"
        },
        success: function(data) {
            // var res = $(data).filter('main').find('result').text();
            //$("#cbo_Units").append("<option>" + res + "</option>");
            //$("#txt_MeasurUnit").value = "";
            $(data).filter('Tbl_MeasurementUnit').find('unit').each(function() {
                $("#cbo_TheUnits").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            
           

            // alert("Add Done");

        },
        error: function(error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}

function AddItem() {

    $.ajax({
        url: "AddItems.aspx",
        type: "POST",
        data: {
            action: "AddItem",
            FK_CategoryID: $("#Cbo_Category").val(),
            ItemType: $("#txt_ItemType").val(),
            FK_MeasurementUnitID: $("#cbo_TheUnits").val()
        },
        success: function (data) {
            // var res = $(data).filter('main').find('result').text();
            //$("#cbo_Units").append("<option>" + res + "</option>");
            //$("#txt_MeasurUnit").value = "";

            $("#Tbl_Itemss").empty();
            $("#Tbl_Itemss").append(' <tr class="HeaderRow"> <td class="style8">النوع</td><td class="style9">الوحدة                        </td><td class="style10">القياس</td></tr>');
            $(data).filter('Tbl_Items').find('Item').each(function () {
                $("#Tbl_Itemss").append('<tr class="ItemRow"> <td class="style14"> <input type="text" style="width: 160px" name="ItemNo" onchange="AddNewRow(this)" value="' + $(this).find('Category').text() + '" /></td>  <td class="style15">  <input type="text" style="width: 154px" name="ItemQTY" onchange="AddNewRow(this)" onkeypress="return isNumber(event);" value="' + $(this).find('ItemType').text() + '" /></td>  <td class="style16">  <input type="text" name="ItemUnitPrice" onchange="AddNewRow(this)" onkeypress="return isNumber(event);" style="width: 136px" value="' + $(this).find('Unit').text() + '" /></td> </tr>');
            });

            alert("تمت الاضافة بنجاح");

        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}
