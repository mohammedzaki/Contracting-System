<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="AddSaverItem.aspx.cs" Inherits="Contracting_System.AddSaverItem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
<script type="text/jscript">
    $(function () {
        $("#btn_Save").on("click", function () {
            if ($("#txt_SaverItem").val() != '') {
                $.ajax({
                    url: "SaveData.aspx",
                    type: "POST",
                    data: {
                        txt_SaverItem: $("#txt_SaverItem").val(),
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
                اسم البند :
            </td>
            <td>
                <input id="txt_SaverItem" type="text"/>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="button" id="btn_Save" class="btn_Save" value="حفظ" />
            </td>
        </tr>
    </table>
</asp:Content>
