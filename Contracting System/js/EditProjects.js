
LoadPage();
var subData = null;

//function DeleteSubContractor(obj) {
//    var rowIndex = $(obj).parent().closest("tr").prevAll().length;
//    //ده الجزء اللى بعد راس الجدول
//    var ContractorID = $("#Tbody1 tr:eq(" + rowIndex + ") td:eq(3)").html();
//    
//    $.ajax({
//        url: "EditProjects.aspx",
//        type: "POST",
//        data: {
//            ContractorID: ContractorID,
//            action: "DeleteSubContractor"
//        },
//        success: function (data) {
//            if ($(data).filter('main').find('Exception').text() == '') {
//                alert("تم الاغلاق بنجاح");
//                //$("btn_Import").prop("enabled", true);
//                window.location = "Default.aspx";
//            } else {
//                alert($(data).filter('main').find('Exception').text());
//            }
//        },
//        error: function (error) {
//            alert("Error happened please contact System Administrator : " + error.statusText);
//        }
//    });
//}

function LoadPage() {
    $.ajax({
        url: "EditProjects.aspx",
        type: "POST",
        data: {
            action: "LoadPage"
        },
        success: function (data) {
            subData = data;
            $(subData).filter('main').find('Tbl_Project').each(function () {
                //$("#cbo_SubcontractorInNewProject").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');

                $("#txt_ProjectName").val($(this).find('Name').text());
                $("#txt_SupervisingAuthority").val($(this).find('Supervisor').text());
                $("#txt_ProjectPeriod").val($(this).find('ProjectPeriodPerMonth').text());
                $("#txt_ProjectCost").val($(this).find('ProjectCost').text());
                var d = new Date($(this).find('StartDate').text());
                $("#txt_ProjectStartDate1").val(d.toDateString());
                d = new Date($(this).find('TechnicalOpenDate').text());
                $("#txt_ProjectStartTechnicalDate1").val(d.toDateString());
                d = new Date($(this).find('DateOfReceiptOfTheSite').text());
                $("#txt_ReceptionLocationDate1").val(d.toDateString());
                d = new Date($(this).find('EndDate').text());
                $("#txt_ProjectEndDate1").val(d.toDateString());
            });
            $(subData).filter('main').find('Tbl_Subcontractor').each(function () {
                $("#cbo_SubcontractorInNewProject").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $(subData).filter('main').find('Tbl_WorkCategories').each(function () {
                $("#cbo_SubContractorWorkCategory").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $(subData).filter('main').find('Tbl_Category').each(function () {
                $("#cbo_ProjectSuppliesCategory").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $(subData).filter('main').find('Tbl_DailyWorker').each(function () {
                $("#cbo_DailyWorker").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $(subData).filter('main').find('Tbl_Employees').each(function () {
                $("#cbo_Employees").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $("btn_Import").prop("enabled", false);

            $(subData).filter('main').find('View_AddedStimation').each(function () {
                $("#cbo_EstimationItems").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $(subData).filter('main').find('Tbl_ProjectEmployees').each(function () {
                $("#grid_Employee").append('<tr class="ItemRow"><td class="style16"><input type="text" name="EmployeeName" style="width: 180px" value="' + $(this).find('Name').text() + '"/></td><td class="style22"><input type="text" name="EmployeeCode" readonly="readonly" value="' + $(this).find('PK_ID').text() + '"/></td><%--<td class="tbl_td_buttonRemove"><input type="button" value=" " style="background-color: silver;border: silver;"/></td>--%></tr>');
            });
            /*
            $(subData).filter('main').find('Tbl_ProjectDailyWorker').each(function () {
                $("#grid_DailyWork").append('<tr class="ItemRow"><td class="style16"><input name="WorkerName" style="width: 180px" value="' + $(this).find('Name').text() + '"/></td><td class="style22"><input type="text" name="WorkStartDate" value=""/></td><td class="style18"><input type="text" name="WorkWageDay" value="' + $(this).find('PK_ID').text() + '"/></td></tr>');
            });
            */
            $(subData).filter('main').find('Tbl_ProjectSubContractor').each(function () {
                $("#Tbody1").append('<tr><td class="style16"> ' + $(this).find('ContractorName').text() + ' </td><td class="style9"> ' + $(this).find('WorkCategory').text() + ' </td><td class="style11"> ' + $(this).find('WorkType').text() + ' </td></tr>');
            });

            $(subData).filter('main').find('Tbl_ProjectSubContractor').each(function () {
                $("#grid_DailyWork").append('<tr class="ItemRow"><td class="style16"><input name="WorkerName" style="width: 180px" value="' + $(this).find('WorkType').text() + '"/></td><td class="style22"><input type="text" name="WorkStartDate" value="' + $(this).find('WorkType').text() + '"/></td><td class="style18"><input type="text" name="WorkWageDay" value="' + $(this).find('WorkType').text() + '"/></tr>');
            });

        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });

    RefreshAppliedEstemation();
}

function SelectSubItems() {
    $("#cbo_ProjectSuppliesItems").html('<option></option>');
    $(subData).filter('main').find('Tbl_Items').each(function () {
        if ($("#cbo_ProjectSuppliesCategory").val() == $(this).find('FK_CategoryID').text()) {
            $("#cbo_ProjectSuppliesItems").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('ItemType').text() + '</option>');
        }
    });
}

function SelectEstimations() {

    $(subData).filter('main').find('View_AddedStimation').each(function () {
        if ($("#cbo_EstimationItems").val() == $(this).find('PK_ID').text()) {
            $("#txt_EstemationQTY").val($(this).find('Quantity').text());
            $("#txt_EstemationQTY").text($(this).find('EquationItemPK_ID').text());
        }
    });
    
}


//function SelectSubContractor() {
//    $("#txt_SubContractorCode").val($("#Cbo_SubContractorNewProject").val());
//    //$(subData).filter('main').find('Tbl_Subcontractor').find("[id id22='22']")..text();
//    $(subData).filter('main').find('Tbl_Subcontractor').each(function () {
//        if ($(this).find('SubContractorId').text() == $("#Cbo_SubContractorNewProject").val())
//            $("#txt_WorkTypeNewProject").val($(this).find('WorkName').text());
//    });
//}

function SelectAll() {

    $(".TheCheckBox").each(function () {
        $(this).prop( "checked", true );
    });    
}
function DisSelectAll() {

    $(".TheCheckBox").each(function () {
        $(this).prop("checked", false);
    });
}
function SelectWorkType() {
    $("#Cbo_SubContractorWorkType").empty();
//    $("#Cbo_SubContractorWorkType").append('<input type="checkbox" />This is checkbox<br />');
    $(subData).filter('main').find('Tbl_WorkType').each(function () {
        if ($(this).find('FK_WorkCategory').text() == $("#cbo_SubContractorWorkCategory  option").filter(":selected").val()) {
            $("#Cbo_SubContractorWorkType").append('<input class="TheCheckBox" type="checkbox" value="' + $(this).find('PK_ID').text() + '" /> ' + $(this).find('Name').text() + '<br />');
        }
    });
}

function CloseProject() {
    if ($("#txt_ProjectName").val() != '' &&
        $("#txt_SupervisingAuthority").val() != '' &&
        $("#txt_ProjectPeriod").val() != '' &&
        $("#txt_ProjectStartDate").val() != '' &&
        $("#txt_ReceptionLocationDate").val() != '' &&
        $("#txt_ProjectEndDate").val() != '') {

        $.ajax({
            url: "EditProjects.aspx",
            type: "POST",
            data: {
                action: "CloseProject"
            },
            success: function (data) {
                if ($(data).filter('main').find('Exception').text() == '') {
                    alert("تم الاغلاق بنجاح");
                    //$("btn_Import").prop("enabled", true);
                    window.location = "Default.aspx";
                } else {
                    alert($(data).filter('main').find('Exception').text());
                }
            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("لا يوجد مشروع ليتم اغلاقه");
    }
}

function AddNewEstimation() {
    if ($("#txt_NewEstemation").val() != '' && $("#txt_EstimationUnit").val() != '' && $("#txt_Quantity").val() != '' && $("#txt_QuantityPrice").val() != '') {

        $.ajax({
            url: "EditProjects.aspx",
            type: "POST",
            data: {
                TheEstimation: $("#txt_NewEstemation").val(),
                TheUnit: $("#txt_EstimationUnit").val(),
                Quantity: $("#txt_Quantity").val(),
                QuantityPrice:$("#txt_QuantityPrice").val(), 
                action: "AddNewEstimation"
            },
            success: function (data) {
                $(data).filter('main').find('View_AddedStimation').each(function () {
                        $("#cbo_EstimationItems").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    alert("تمت الإضافة بنجاح");
                
            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("برجاء كتابة كافة البيانات أولاً");
    }
}

function SaveProjectData() {
    if ($("#txt_ProjectName").val() != '' &&
        $("#txt_SupervisingAuthority").val() != '' &&
        $("#txt_ProjectPeriod").val() != '' &&
        $("#txt_ProjectStartDate").val() != '' &&
        $("#txt_ReceptionLocationDate").val() != '' &&
        $("#txt_ProjectEndDate").val() != '') {

        $.ajax({
            url: "EditProjects.aspx",
            type: "POST",
            data: {
                txt_ProjectName: $("#txt_ProjectName").val(),
                txt_SupervisingAuthority: $("#txt_SupervisingAuthority").val(),
                txt_ProjectPeriod: $("#txt_ProjectPeriod").val(),
                txt_ProjectStartDate: $("#txt_ProjectStartDate").val(),
                txt_ReceptionLocationDate: $("#txt_ReceptionLocationDate").val(),
                txt_ProjectEndDate: $("#txt_ProjectEndDate").val(),
                txt_ProjectCost: $("#txt_ProjectCost").val(),
                txt_ProjectStartTechnicalDate: $("#txt_ProjectStartTechnicalDate").val(),
                action: "SaveProjectData"
            },
            success: function (data) {
                if ($(data).filter('main').find('Exception').text() == '') {
                    alert("تم الحفظ");
                    $("btn_Import").prop("enabled", true);
                } else {
                    alert($(data).filter('main').find('Exception').text());
                }
            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("Please Correct project data");
    }
}

function SaveNewSubContractor() {
    $("#Cbo_SubContractorWorkType").children().each(function () {
        
        if ($(this).prop('tagName') == 'INPUT' && $(this).is(":checked") == true) {
            var ty = $(this).parent();
            $.ajax({
                url: "EditProjects.aspx",
                type: "POST",
                data: {
                    WorkID: $(this).val(),
                    txt_SubContractorCode: $("#txt_SubContractorCode").val(),
                    action: "SaveNewSubContractor"
                },
                success: function (data) {
                    if ($(data).filter('main').find('Exception').text() == '') {
                        alert("تم الحفظ");
                        $("#Tbody1").append('<tr><td class="style16"> ' + $("#cbo_SubcontractorInNewProject").text() + ' </td><td class="style9"> ' + $("#cbo_SubContractorWorkCategory").text() + ' </td><td class="style11"> ' + $(ty).text() + ' </td></tr>');
                    } else {
                        alert($(data).filter('main').find('Exception').text());
                    }
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });
        }
    });
   
}

function SaveProjectEstimation() {

    
    if ($("#txt_ProjectSuppliesQTY").val() != '') {
        $.ajax({
            url: "EditProjects.aspx",
            type: "POST",
            data: {
                txt_ProjectSuppliesQTY: $("#txt_ProjectSuppliesQTY").val(),
                cbo_ProjectSuppliesItems: $("#cbo_ProjectSuppliesItems option:selected").val(),
                cbo_ProjectSupplies: $("#cbo_ProjectSupplies option:selected").val(),
                action: "SaveProjectSupply"
            },
            success: function (data) {
                if ($(data).filter('main').find('Exception').text() == '') {
                    alert("تم الحفظ");
                } else {
                    alert($(data).filter('main').find('Exception').text());
                }
            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("Please Correct project data");
    }
}

function SaveDailyWorker() {
    if ($("#cbo_DailyWorker").val() != '') {
        $.ajax({
            url: "EditProjects.aspx",
            type: "POST",
            data: {
                DailyWorkerID: $("#cbo_DailyWorker").val(),
                DailyWorkStartDate: $("#DailyWorkStartDate").val(),
                txt_DailyWorkerWageDay: $("#txt_DailyWorkerWageDay").val(),
                action: "SaveDailyWorker"
            },
            success: function (data) {
                if ($(data).filter('main').find('Exception').text() == '') {
                    alert("تم الحفظ");
                    $("#grid_DailyWork").append('<tr class="ItemRow"><td class="style16"><input name="WorkerName" style="width: 180px" value="' + $("#cbo_DailyWorker option:selected").text() + '"/></td><td class="style22"><input type="text" name="WorkStartDate" value="' + $("#txt_DailyWorkerStartDate").val() + '"/></td><td class="style18"><input type="text" name="WorkWageDay" value="' + $("#txt_DailyWorkerWageDay").val() + '"/></td></tr>');
                } else {
                    alert($(data).filter('main').find('Exception').text());
                }
            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("Please Correct Daily Worker data");
    }
}


function SaveEmployee() {
    if ($("#cbo_Employees").val() != '') {
        $.ajax({
            url: "EditProjects.aspx",
            type: "POST",
            data: {
                txt_EmployeeCode: $("#cbo_Employees").val(),
                action: "SaveEmployee"
            },
            success: function (data) {
                if ($(data).filter('main').find('Exception').text() == '') {
                    alert("تم الحفظ");
                    $("#grid_Employee").append('<tr class="ItemRow"><td class="style16"><input type="text" name="EmployeeName" style="width: 180px" value="' + $("#cbo_Employees option:selected").text() + '"/></td><td class="style22"><input type="text" name="EmployeeCode" readonly="readonly" value="' + $("#txt_EmployeeCode").val() + '"/></td><%--<td class="tbl_td_buttonRemove"><input type="button" value=" " style="background-color: silver;border: silver;"/></td>--%></tr>');
                } else {
                    alert($(data).filter('main').find('Exception').text());
                }
            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
    } else {
        alert("Please Correct Employee data");
    }

}

function CheckFileExistence() {

    var filePath = document.getElementById('ctl00_ctl00_MainContent_UsersMainContent_file1').value;

    if (filePath.length < 1) {

        alert("File Name Can not be empty"); return false;
    }

    var validExtensions = new Array();
    var ext = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();

    validExtensions[0] = 'xdf';

    for (var i = 0; i < validExtensions.length; i++) {

        if (ext == validExtensions[i]) return true;
    }

    alert('The file extension ' + ext.toUpperCase() + ' is not allowed!');

    return false;
}

function AddEquation() {

    if ($("#txt_Percentage").val() != '' && parseFloat($("#txt_Percentage").val()) > 0 && parseInt($("#cbo_ProjectSuppliesItems").val()) > 0) {
        
        if ($("#txt_DeviedTo").val() == '') {

            $("#txt_DeviedTo").val(1);
        } else if ($("#txt_DeviedTo").val() == '0') {
            $("#txt_DeviedTo").val(1); 
        }
        
        
        $.ajax({
            url: "EditProjects.aspx",
            type: "POST",
            data: {
                FK_EstimationItemEquationID: $("#txt_EstemationQTY").text(),
                FK_ItemID: $("#cbo_ProjectSuppliesItems").val(),
                ItemBY: $("#txt_Percentage").val(),
                ItemDevid: $("#txt_DeviedTo").val(),
                action: "AddEquation"
            },
            success: function(data) {
               var subDatas = data;
                alert($(subDatas).filter('main').find('Messeage').text());
            },
            error: function(error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });
        
    } else {
        alert("من فضلك تأكد ان كل المدخلات صحيحة فى المعادلة");
    }
}

function ApplyEstimation() {

    $.ajax({
        url: "EditProjects.aspx",
        type: "POST",
        data: {
            PK_ID_EstimationItemEquation: $("#txt_EstemationQTY").text(),
            action: "FinishEstimation"
        },
        success: function (data) {
            subData = data;
            $("#cbo_SubcontractorInNewProject option").remove();
            $("#cbo_SubcontractorInNewProject").append('<option> </option>');
            $(subData).filter('main').find('Tbl_Subcontractor').each(function () {
                $("#cbo_SubcontractorInNewProject").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $("#cbo_SubContractorWorkCategory option").remove();
            $("#cbo_SubContractorWorkCategory").append('<option> </option>');
            $(subData).filter('main').find('Tbl_WorkCategories').each(function () {
                $("#cbo_SubContractorWorkCategory").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $("#cbo_ProjectSuppliesCategory option").remove();
            $("#cbo_ProjectSuppliesCategory").append('<option> </option>');
            $(subData).filter('main').find('Tbl_Category').each(function () {
                $("#cbo_ProjectSuppliesCategory").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $("#cbo_DailyWorker option").remove();
            $("#cbo_DailyWorker").append('<option> </option>');
            $(subData).filter('main').find('Tbl_DailyWorker').each(function () {
                $("#cbo_DailyWorker").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $("#cbo_Employees option").remove();
            $("#cbo_Employees").append('<option> </option>');
            $(subData).filter('main').find('Tbl_Employees').each(function () {
                $("#cbo_Employees").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $("btn_Import").prop("enabled", false);
            $("#cbo_EstimationItems option").remove();
            $("#cbo_EstimationItems").append('<option> </option>');
            $(subData).filter('main').find('View_AddedStimation').each(function () {
                $("#cbo_EstimationItems").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
            $("#txt_EstemationQTY").val(0);
            $("#txt_EstemationQTY").text(0);
        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
//    LoadPage();
}

function RefreshAppliedEstemation() {

    $.ajax({
        url: "EditProjects.aspx",
        type: "POST",
        data: {
            action: "RefreshAppliedEstemation"
        },
        success: function (data) {
            var subDatas = data;
            $("#grid_ProjectSupplies tr").remove();
            $(subDatas).filter('main').find('Tbl_ProjectSupplies').each(function () {
                $("#grid_ProjectSupplies").append('<tr class="ItemRow"> <td class="style17"> <input type="text" value="' + $(this).find('Name').text() + '" style="width: 163px" name="ItemCategory"/>  </td> <td class="style14"> <input type="text" style="width: 181px" name="ItemType" value="' + $(this).find('ItemType').text() + '"/>  </td> <td class="style15"> <input type="text" style="width: 176px" name="ItemQTY" value="' + $(this).find('QTY').text() + '"/> </td></tr>');
            });

        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}