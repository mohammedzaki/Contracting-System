<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="EditRoles.aspx.cs" Inherits="Contracting_System.EditRoles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/javascript">
        $.ajax({
            url: "SetRoles.aspx",
            type: "POST",
            data: {
                action: "LoadPages"
            },
            success: function (data) {

                $(data).filter('Tbl_Pages').find('Page').each(function () {
                    $("#Cbo_SubContractorWorkType").append('<input class="TheCheckBox" type="checkbox" value="' + $(this).find('Id').text() + '" /><label style="font-size: 16px"> ' + $(this).find('Name').text() + '</label><br />');
                });

            },
            error: function (error) {
                alert("Error happened please contact System Administrator : " + error.statusText);
            }
        });

        function AddRole() {
            var IsChecked = false;
            $("#Cbo_SubContractorWorkType").children().each(function () {
                if ($(this).prop('tagName') == 'INPUT' && $(this).is(":checked") == true) {
                    IsChecked = true;
                }
            });

            if ($("#txt_RoleName").val() != '' && IsChecked == true) {
                var messg = '';
                var RoleID = 0;
                $.ajax({
                    url: "SetRoles.aspx",
                    type: "POST",
                    data: {
                        RoleName: $("#txt_RoleName").val(),
                        action: "AddRole"
                    },
                    success: function (data) {
                        $(data).filter('Role').find('RoleID').each(function () {
                            RoleID = parseInt($(this).find('ID').text());
                        });


                        $("#Cbo_SubContractorWorkType").children().each(function () {
                            if ($(this).prop('tagName') == 'INPUT' && $(this).is(":checked") == true) {
                                var ty = $(this).parent();
                                $.ajax({
                                    url: "SetRoles.aspx",
                                    type: "POST",
                                    data: {
                                        PageID: $(this).val(),
                                        RoleID: RoleID,
                                        Access: "1",
                                        action: "AddRoleByID"
                                    },
                                    success: function (data2) {
                                        $(data2).filter('Role').find('RoleID').each(function () {
                                            messg = $(this).find('ID').text();
                                        });
                                    },
                                    error: function (error) {
                                        alert("Error happened please contact System Administrator : " + error.statusText);
                                    }
                                });
                            } else if ($(this).prop('tagName') == 'INPUT' && $(this).is(":checked") == false) {
                                var ty = $(this).parent();
                                $.ajax({
                                    url: "SetRoles.aspx",
                                    type: "POST",
                                    data: {
                                        PageID: $(this).val(),
                                        RoleID: RoleID,
                                        Access: "0",
                                        action: "AddRoleByID"
                                    },
                                    success: function (data2) {
                                        $(data2).filter('Role').find('RoleID').each(function () {
                                            messg = $(this).find('ID').text();
                                        });
                                    },
                                    error: function (error) {
                                        alert("Error happened please contact System Administrator : " + error.statusText);
                                    }
                                });
                            }
                        });

                    },
                    error: function (error) {
                        alert("Error happened please contact System Administrator : " + error.statusText);
                    }
                });
                alert('تمت الاضافة بنجاح');


            } else {
                alert('برجاء قم بكتابة اسم الصلاحية واختيار بنودها');
            }
        }

        function DisSelectAll() {

            $(".TheCheckBox").each(function () {
                $(this).prop("checked", false);
            });
            $("#txt_RoleName").val('');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div>
        <table>
            <tr>
                <td>
                    <label>
                        اسم الصلاحية :
                    </label>
                </td>
                <td>
                    <input type="text" id="txt_RoleName" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    <h2>شاشات البرنامج</h2>
                    <div id="Cbo_SubContractorWorkType" class="checklistbox" style="height: 200px">
                    </div>
                </td>

            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <input type="button" id="btn_AddRole" class="btn_Save" value="اضافة" onclick="AddRole()" />
                    <input type="button" id="Button1" class="btn_Save" value="إلغاء" onclick="DisSelectAll()" />
                </td>

            </tr>
        </table>


    </div>
</asp:Content>
