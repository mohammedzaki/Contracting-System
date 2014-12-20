<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="SelectRoles.aspx.cs" Inherits="Contracting_System.SelectRoles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/javascript">
        LoadSelectRols();

        function SaveRole() {
            $.ajax({
                url: "SelectRoles.aspx",
                type: "POST",
                data: {
                    EmpID: $("#cbo_EmployeeNames option:selected").val(),
                    RoleID: $("#cbo_Roles option:selected").val(),
                    action: "SaveRole"
                },
                success: function (data) {
                    alert('تم اضافة الصلاحية بنجاح');


                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });
        }

        function LoadSelectRols() {
            $.ajax({
                url: "SelectRoles.aspx",
                type: "POST",
                data: {
                    action: "LoadSelectRols"
                },
                success: function (data) {

                    $(data).filter('main').find('Tbl_Employees').each(function () {
                        $("#cbo_EmployeeNames").append('<option value="' + $(this).find('ID').text() + '">' + $(this).find('Name').text() + '</option>');
                    });
                    $(data).filter('main').find('Tbl_Roles').each(function () {
                        $("#cbo_Roles").append('<option value="' + $(this).find('ID').text() + '">' + $(this).find('Name').text() + '</option>');
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
                    <label>مستوى الصلاحية :</label>
                </td>
                <td>
                    <select id="cbo_Roles">
                        
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <input class="btn_Save" type="button" id="btn_SaveUser" value="حفظ" onclick="SaveRole()"/>
                    <input class="btn_Save" type="button" id="btn_Cancel" value="الغاء" onclick="window.location='Default.aspx' "/>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
