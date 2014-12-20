<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="EditWorkType.aspx.cs" Inherits="Contracting_System.EditWorkType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/jscript">
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
                        $("#cbo_WorkCategory").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    $("#cbo_WorkCategory").on("change", function () {
                        $("#cbo_WorkCategoryTypes").html("<option></option>");
                        $(subData).filter('main').find('Tbl_Sub').each(function () {
                            if ($("#cbo_WorkCategory").val() == $(this).find('FK_WorkCategory').text()) {
                                $("#cbo_WorkCategoryTypes").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                            }
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Save").on("click", function () {
                if ($("#txt_WorkCategoryTypes").val() != '' && $("#cbo_WorkCategory").val() != '') {
                    $.ajax({
                        url: "SaveData.aspx",
                        type: "POST",
                        data: {
                            id: $("#cbo_WorkCategoryTypes").val(),
                            Name: $("#txt_WorkCategoryType").val(),
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
                    alert("ادخل الاسم اولا");
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <table>
        <tr>
            <td class="style23">
                اختر فئة عمل المقاول :
            </td>
            <td>
                <select id="cbo_WorkCategory">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">
                اختر نوع العمل :
            </td>
            <td>
                <select id="cbo_WorkCategoryTypes">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">
                الاسم الجديد :
            </td>
            <td>
                <input id="txt_WorkCategoryType" type="text" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="button" id="btn_Save" class="btn_Save" value="حفظ" />
            </td>
        </tr>
    </table>
</asp:Content>