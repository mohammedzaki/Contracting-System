<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="EditDailyCashbook.aspx.cs" Inherits="Contracting_System.EditDailyCashbook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/javascript">
        $(function () {
            var pk_id;
            var subData;
            $.ajax({
                url: "LoadData.aspx",
                type: "POST",
                data: {
                    action: location.pathname.substr(location.pathname.lastIndexOf('/') + 1, (location.pathname.length - 6))
                },
                success: function (data) {
                    subData = data;
                    $(subData).filter('main').find('Tbl_Project').each(function () {
                        $("#cbo_ProjectName").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    $("#cbo_ProjectName").on("change", function () {
                        $("#cbo_Guradianship").html('<option></option>');
                        $(subData).filter('main').find('View_ProjectGurdianship').each(function () {
                            if ($("#cbo_ProjectName").val() == $(this).find('FK_ProjectID').text()) {
                                $("#cbo_Guradianship").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('GurdianshipName').text() + '</option>');
                            }
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Search").on("click", function () {
                $("#grid_GuardianshipDetails").html('');
                $(subData).filter('main').find('View_Guradianship').each(function () {
                    if ($("#cbo_Guradianship").val() == $(this).find('FK_ProjectGuardianshipID').text()) {
                        var categroy = '';
                        var item = '';
                        var WorkFullName = '';
                        if ($(this).find('PersonTypeId').text() == '-4') {
                            categroy = "مقاولين";
                            item = $(this).find('PersonName').text();
                            WorkFullName = $(this).find('WorkFullName').text();
                        } else if ($(this).find('PersonTypeId').text() == '-3') {
                            categroy = "موردين";
                            item = $(this).find('PersonName').text();
                            WorkFullName = $(this).find('WorkFullName').text();
                        } else if ($(this).find('PersonTypeId').text() == '-2') {
                            categroy = "عمالة باليوميه";
                            item = $(this).find('PersonName').text();
                        } else if ($(this).find('PersonTypeId').text() == '-1') {
                            categroy = "موظفين";
                            item = $(this).find('PersonName').text();
                        } else {
                            categroy = $(this).find('ExpensesCategoryName').text();
                            item = $(this).find('ExpensesItemName').text();
                        }
                        $("#grid_GuardianshipDetails").append('<tr class="ItemRow"><td class="b_width"> ' + categroy + ' </td><td class="b_width"> ' + item + ' </td><td class="b_width"> ' + WorkFullName + ' </td><td class="b_width"> ' + $(this).find('GuardianshipItemAmount').text() + ' </td><td class="b_width"> ' + $(this).find('GuardianshipItemDate').text() + ' </td><td class="hiddenElemnet">' + $(this).find('GuardianshipItemsId').text() + '</td><td class="b_width"><input type="button" value="تعديل" class="update"/></td></tr>');
                    }
                });

                $(".overlay,.popup-close").click(function () {
                    $(".popup-container").hide();
                });
                ////////////////////validate popup event
                $(".update").click(function (e) {
                    e.preventDefault();
                    pk_id = $(this).parent().prev().html();
                    $("#txt_value").val($(this).parent().prev().prev().prev().html());
                    $(".popup-save").show();
                });
            });

            $("#btn_Save").on("click", function () {
                if (
                $("#txt_value").val() != '') {
                    $.ajax({
                        url: "SaveData.aspx",
                        type: "POST",
                        data: {
                            pk_id: pk_id,
                            txt_value: $("#txt_value").val(),
                            action: location.pathname.substr(location.pathname.lastIndexOf('/') + 1, (location.pathname.length - 6))
                        },
                        success: function (data) {
                            if ($(data).filter('main').find('Exception').text() == '') {
                                alert("تم الحفظ");
                                window.location.reload();
                            } else {
                                alert($(data).filter('main').find('Exception').text());
                            }
                        },
                        error: function (error) {
                            alert("Error happened please contact System Administrator : " + error.statusText);
                        }
                    });
                } else {
                    alert("ادخل باقى البيانات اولا");
                }
            });
        });
    </script>
    <style>
        .popup-container {
            display: none;
        }

        .overlay {
            position: fixed;
            height: 100%;
            width: 100%;
            top: 0px;
            left: 0px;
            background-color: black;
            background-color: rgba(0,0,0,0.7);
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=70)";
            filter: alpha(opacity=70);
            -moz-opacity: 0.7;
            -khtml-opacity: 0.7;
            opacity: 0.7;
        }

        .div-popup {
            display: block;
            width: 450px;
            -webkit-border-radius: 15px;
            -moz-border-radius: 15px;
            border-radius: 15px;
            background-color: white;
            min-height: 100px;
            z-index: 100;
            position: fixed;
            top: 30%;
            left: 30%;
            padding: 20px;
        }

        .popup-header {
            font-size: 18px;
            color: #d1015f;
            font-family: Calibri;
            font-weight: bold;
        }

        .text-center {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <table>
        <tr>
            <td class="style24">
                اسم المشروع :
            </td>
            
            <td class="style24">
                العهدة :
            </td>
        </tr>
        <tr>
            <td>
                <select id="cbo_ProjectName" class="b_width">
                    <option></option>
                </select>
            </td>
            <td>
                <select id="cbo_Guradianship" class="b_width">
                    <option></option>
                </select>
            </td>
            <td rowspan="2" style="text-align: center;">
                <input type="button" id="btn_Search" class="btn_Save" value="عرض" />
            </td>
        </tr>
    </table>
    <h1>
        بيانات العهدة</h1>
    <table>
        <thead>
            <tr class="HeaderRow">
                <td class="style16">
                    البند
                </td>
                <td class="style22">
                    الاسم
                </td>
                <td class="style18">
                    نوع العمل
                </td>
                <td class="style18">
                    القيمه
                </td>
                <td class="style18">
                    التاريخ
                </td>
                <td class="hiddenElemnet">
                    الكود
                </td>
                <td ></td>
            </tr>
        </thead>
        <tbody id="grid_GuardianshipDetails">
            <tr class="ItemRow">
                <td class="b_width">
                    البند
                </td>
                <td class="b_width">
                    الاسم
                </td>
                <td class="b_width">
                    نوع العمل
                </td>
                <td class="b_width">
                    القيمة
                </td>
                <td class="b_width">
                    التاريخ
                </td>
                <td class="hiddenElemnet"></td>
                <td class="b_width"><input type="button" value="تعديل" class="update"/></td>
            </tr>
        </tbody>
    </table>
    <div class="popup-container popup-save">
        <div class="overlay">
        </div>
        <div class="div-popup">
            القيمه : <input type="text" id="txt_value" class="b_width IsNumberOnly" /><br />
            <input id="btn_Save" type="button" class="btn_Save popup-close" value="حفظ" />
            <input type="button" class="btn_Save btn-primary popup-close" value="إلغاء" />
        </div>
    </div>
</asp:Content>

