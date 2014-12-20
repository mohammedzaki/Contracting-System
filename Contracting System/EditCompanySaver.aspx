<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="EditCompanySaver.aspx.cs" Inherits="Contracting_System.EditCompanySaver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/jscript">
        $(function () {
            $.ajax({
                url: "LoadData.aspx",
                type: "POST",
                data: {
                    action: "LoadCompanySaver"
                },
                success: function (data) {
                    subData = data;
                    $(subData).filter('main').find('Tbl_Savers').each(function () {
                        $("#cbo_CompanySaver").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });

                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Save").on("click", function () {
                if ($("#txt_CompanySaver").val() != '' && $("#cbo_CompanySaver").val() != '') {
                    $.ajax({
                        url: "SaveData.aspx",
                        type: "POST",
                        data: {
                            cbo_CompanySaver: $("#cbo_CompanySaver").val(),
                            txt_CompanySaver: $("#txt_CompanySaver").val(),
                            action: "EditCompanySaver"
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
                اختر الخزنة :
            </td>
            <td>
                <select id="cbo_CompanySaver">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">
                الاسم الجديد :
            </td>
            <td>
                <input id="txt_CompanySaver" type="text" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="button" id="btn_Save" class="btn_Save" value="حفظ" />
            </td>
        </tr>
    </table>
</asp:Content>
