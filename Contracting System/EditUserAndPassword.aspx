<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="EditUserAndPassword.aspx.cs" Inherits="Contracting_System.EditUserAndPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/javascript">
        LoadEmps();

        function SaveUserAndPassword() {
            if ($("#txt_UserName").val() != '' && $("#txt_password").val() != '') {
                $.ajax({
                    url: "EditUserAndPassword.aspx",
                    type: "POST",
                    data: {
                        UserName: $("#txt_UserName").val(),
                        Password: $("#txt_password").val(),
                        EmpID: $("#cbo_EmployeeNames option:selected").val(),
                        action: "SaveUserAndPassword"
                    },
                    success: function (data) {

                        alert('تم الحفظ بنجاح');

                    },
                    error: function (error) {
                        alert("Error happened please contact System Administrator : " + error.statusText);
                    }
                });
            } else {
                alert(' من فضلك قم باختيار الموظف وتاكد من كتابة اسم المستخدم والباسورد');
            }
        }

        function LoadEmps() {
            $.ajax({
                url: "EditUserAndPassword.aspx",
                type: "POST",
                data: {
                    action: "LoadEmps"
                },
                success: function (data) {

                    $(data).filter('main').find('Tbl_Employees').each(function () {
                        $("#cbo_EmployeeNames").append('<option value="' + $(this).find('ID').text() + '">' + $(this).find('Name').text() + '</option>');
                    });

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
        <table>
            <tr>
                <td>
                    <label>اسم الموظف :</label>
                </td>
                <td>
                    <select id="cbo_EmployeeNames">
                        
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <label>اسم المستخدم :</label>
                </td>
                <td>
                    <input type="text" id="txt_UserName"/>
                </td>
            </tr>
             <tr>
                <td>
                    <label>كلمة السر :</label>
                </td>
                <td>
                    <input type="text" id="txt_password"/>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <input class="btn_Save" type="button" id="btn_SaveUser" value="حفظ" onclick="SaveUserAndPassword()"/>
                    <input class="btn_Save" type="button" id="btn_Cancel" value="الغاء" onclick="window.location = 'Default.aspx'"/>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
