<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="EditExpenseItem.aspx.cs" Inherits="Contracting_System.EditExpenseItem" %>

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
                        $("#cbo_ExpensesCategory").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    $("#cbo_ExpensesCategory").on("change", function () {
                        $("#cbo_ExpensesItems").html("<option></option>");
                        $(subData).filter('main').find('Tbl_Sub').each(function () {
                            if ($("#cbo_ExpensesCategory").val() == $(this).find('FK_ExpenseCategory').text()) {
                                $("#cbo_ExpensesItems").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                            }
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Save").on("click", function () {
                if ($("#txt_ExpensesCategory").val() != '' && $("#cbo_ExpensesCategory").val() != '') {
                    $.ajax({
                        url: "SaveData.aspx",
                        type: "POST",
                        data: {
                            id: $("#cbo_ExpensesItems").val(),
                            Name: $("#txt_ExpenseItem").val(),
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
                اختر الفئة :
            </td>
            <td>
                <select id="cbo_ExpensesCategory">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">
                اختر البند :
            </td>
            <td>
                <select id="cbo_ExpensesItems">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">
                الاسم الجديد :
            </td>
            <td>
                <input id="txt_ExpenseItem" type="text" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="button" id="btn_Save" class="btn_Save" value="حفظ" />
            </td>
        </tr>
    </table>
</asp:Content>
