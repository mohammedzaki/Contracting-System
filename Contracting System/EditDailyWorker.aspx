<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="EditDailyWorker.aspx.cs" Inherits="Contracting_System.EditDailyWorker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
<script>

    $(function () {
        $.ajax({
            url: "LoadData.aspx",
            type: "POST",
            data: {
                action: location.pathname.substr(location.pathname.lastIndexOf('/') + 1, (location.pathname.length - 6))
            },
            success: function (data) {
                subData = data;
                $(subData).filter('main').find('Tbl_Data').each(function () {
                    $("#cbo_WorkerName").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    $("#cbo_WorkerName").on("change", function () {
                        $(subData).filter('main').find('Tbl_Data').each(function () {
                            if ($("#cbo_WorkerName").val() == $(this).find('PK_ID').text()) {
                                $("#txt_DailyWorkerName").val($(this).find('Name').text());
                                $("#txt_DailyWorkerID").val($(this).find('WorkerID').text());
                                $("#txt_DailyWorkerMobile").val($(this).find('Mobile').text());
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
                action: "UpdateWorker",
                id: $("#cbo_WorkerName").val(),
                Name: $("#txt_DailyWorkerName").val(),
                Mobile: $("#txt_DailyWorkerMobile").val(),
                WorkerID: $("#txt_DailyWorkerID").val(),
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
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div>
        <h3>
            تعديل بيانات عامل</h3>
        <br />
        اختر العامل :
        <br />
         <select id="cbo_WorkerName" class="txt_DailyWorker" >
                <option></option>
            </select>
            <br />
        اسم العامل :
        <br />
        <input id="txt_DailyWorkerName" type="text" class="txt_DailyWorker" />
        <br />
        رقم البطاقة :
        <br />
        <input type="text" id="txt_DailyWorkerID" class="txt_DailyWorker" />
        <br />
        رقم الموبايل :
        <br />
        <input id="txt_DailyWorkerMobile" type="text" class="txt_DailyWorker" />
        <br />
        <input id="Button1" type="button" value="حفظ" onclick="AddEmployee()" class="btn_Save" />
        <input id="Button2" type="button" value="إلغاء" class="btn_Save" />
    </div>
</asp:Content>
