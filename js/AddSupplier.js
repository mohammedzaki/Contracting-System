/// <reference path="Refrences.js" />


LoadCbo_Items();

function SelectFromCbo_Items() {

    if (parseInt($("#txt_SupplierCode").val()) > 0) {


        $.ajax({
            url: "AddSupplier.aspx",
            type: "POST",
            data: {
                action: "SelectFromCbo_Items",
                FK_CategoryID: $("#Cbo_ItemsAddSupplier").val(),
                FK_SupplierID: $("#txt_SupplierCode").val()
            },
            success: function (data) {
                $("#lst_SuppliesList option").remove();
                $(data).filter('Tbl_Category').find('Category').each(function () {
                    $("#lst_SuppliesList").append('<option>' + $(this).find('Name').text() + '</option>');
                });

            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("لا يوجد مورد لاضافة توريدات له ...");
    }
}

function LoadCbo_Items() {
        $.ajax({
            url: "AddSupplier.aspx",
            type: "POST",
            data: { action: "LoadCbo_Items" },
            success: function (data) {
                $("#Cbo_ItemsAddSupplier option").remove();
                $(data).filter('Tbl_Items').find('Item').each(function () {
                    $("#Cbo_ItemsAddSupplier").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('ItemName').text() + '</option>');
                });

            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    
}

function SaveNewSupplier() {

    if (!$("#txt_SupplierCode").val() > 0) {
        $.ajax({
            url: "AddSupplier.aspx",
            type: "POST",
            data: {
                action: "SaveNewSupplier",
                SupplierName: $("#txt_SupplierName").val(),
                SupplierMobile: $("#txt_SupplierMobile").val(),
                SupplierTel: $("#txt_SupplierTel").val(),
                SuuplierAddress: $("#txt_SupplierAddress").val()
            },
            success: function(data) {
                //            $("#Cbo_ItemsAddSupplier option").remove();
                //            $(data).filter('Tbl_Items').find('Item').each(function () {
                //                //$("#Cbo_ItemsAddSupplier").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('ItemName').text() + '</option>');
                //            });
                $("#txt_SupplierCode").val($(data).filter('Main').find('PK').text());
                alert("تمت الاضافة بنجاح");
            },
            error: function(error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("لقد قمت باضافته بالفعل");
    }
}
