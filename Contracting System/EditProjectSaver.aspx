<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="EditProjectSaver.aspx.cs" Inherits="Contracting_System.EditProjectSaver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/javascript">
        var subData;
        var pk_id;
        $(function () {
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
                    $(subData).filter('main').find('Tbl_SaverItems').each(function () {
                        $("#cbo_SaverItem").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Search").on("click", function () {
                $.ajax({
                    url: location.pathname.substr(1),
                    type: "POST",
                    data: {
                        cbo_ProjectName: $("#cbo_ProjectName").val(),
                        cbo_SaverItem: $("#cbo_SaverItem").val(),
                        txt_DateFrom: $("#txt_DateFrom").val(),
                        txt_DateTo: $("#txt_DateTo").val(),
                        action: "LoadSearch"
                    },
                    success: function (data) {
                        if ($(data).filter('main').find('Exception').text() == '') {
                            $("#grid_DepositDetails").html('');
                            $(data).filter('main').find('Tbl_Data').each(function () {
                                $("#grid_DepositDetails").append('<tr class="ItemRow"><td class="b_width">' + $(this).find('ItemName').text() + '</td><td class="b_width">' + $(this).find('Date').text() + '</td><td class="b_width">' + $(this).find('Amount').text() + '</td><td class="b_width">' + $(this).find('Description').text() + '</td><td class="hiddenElemnet">' + $(this).find('PK_ID').text() + '</td><td class="s_width"><input type="button" name="btn_Save" value="تعديل" class="update"/></td></tr>');
                            });
                            $(".overlay,.popup-close").click(function () {
                                $(".popup-container").hide();
                            });
                            ////////////////////validate popup event
                            $(".update").click(function (e) {
                                e.preventDefault();
                                pk_id = $(this).parent().prev().html();
                                $("#txt_value").val($(this).parent().prev().prev().prev().html());
                                $("#txt_Description").val($(this).parent().prev().prev().html());
                                $(".popup-save").show();
                            });
                        } else {
                            alert($(data).filter('main').find('Exception').text());
                        }
                    },
                    error: function (error) {
                        alert("Error happened please contact System Administrator : " + error.statusText);
                    }
                });
            });

            $("#btn_Save").on("click", function () {
                if (
                $("#txt_value").val() != '' &&
                $("#txt_Description").val() != '') {
                    $.ajax({
                        url: "SaveData.aspx",
                        type: "POST",
                        data: {
                            pk_id: pk_id,
                            txt_value: $("#txt_value").val(),
                            txt_Description: $("#txt_Description").val(),
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
            <td class="style24">خزنة المشروع :
            </td>
            <td class="style24">البند :
            </td>
            <td class="style24">التاريخ من :
            </td>
            <td class="style24">التاريخ الى :
            </td>
        </tr>
        <tr>
            <td>
                <select id="cbo_ProjectName" class="b_width">
                    <option></option>
                </select>
            </td>
            <td>
                <select id="cbo_SaverItem" class="b_width">
                    <option></option>
                </select>
            </td>
            <td>
                <input type="text" id="txt_DateFrom" class="b_width IsDate" />
            </td>
            <td>
                <input type="text" id="txt_DateTo" class="b_width IsDate" />
            </td>
            <td rowspan="2" style="text-align: center;">
                <input type="button" id="btn_Search" class="btn_Save" value="بحث" />
            </td>
        </tr>

    </table>
    <table>
        <thead>
            <tr class="HeaderRow">
                <td style="text-align: center;">البند
                </td>
                <td style="text-align: center;">التاريخ
                </td>
                <td style="text-align: center;">القيمه
                </td>
                <td style="text-align: center;">الوصف
                </td>
                <td class="hiddenElemnet">كود الايداع
                </td>
                <td style="text-align: center;"></td>
            </tr>
        </thead>
        <tbody id="grid_DepositDetails">
            <tr class="ItemRow">
                <td class="b_width"></td>
                <td class="b_width"></td>
                <td class="b_width"></td>
                <td class="b_width"></td>
                <td class="hiddenElemnet"></td>
                <td class="s_width"></td>
            </tr>
        </tbody>
    </table>

    <div class="popup-container popup-save">
        <div class="overlay">
        </div>
        <div class="div-popup">
            القيمه : <input type="text" id="txt_value" class="b_width IsNumberOnly" /><br />
            الوصف : <input type="text" id="txt_Description" class="b_width" /><br />
            <input id="btn_Save" type="button" class="btn_Save popup-close" value="حفظ" />
            <input type="button" class="btn_Save btn-primary popup-close" value="إلغاء" />
        </div>
    </div>
</asp:Content>
