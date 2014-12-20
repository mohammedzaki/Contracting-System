<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="SelectProject.aspx.cs" Inherits="Contracting_System.SelectProject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/javascript">
        LoadCbo_SelectProject();
        function LoadCbo_SelectProject() {
            
            $.ajax({
                url: "SelectProject.aspx",
                type: "POST",
                data: {
                    action: "LoadCbo_SelectProject"
                },
                success: function (data) {
                    // var res = $(data).filter('main').find('result').text();
                    //$("#cbo_Units").append("<option>" + res + "</option>");
                    //$("#txt_MeasurUnit").value = "";
                    $("#cbo_SelectProject").find('option').remove().end().append('<option selected="selected" value="whatever">اختر المشروع من هنا</option>');
                    $(data).filter('Tbl_CurrentProjects').find('Project').each(function () {
                        $("#cbo_SelectProject").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });



                    // alert("Add Done");

                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });
        }

        function SetPK_ID() {
            $.ajax({
                url: "SelectProject.aspx",
                type: "POST",
                data: {
                    action: "SetPK_ID",
                    PK_ID: $("#cbo_SelectProject option:selected").val()
                },
                success: function () {

                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });
        }

        function SelectCurrentProject() {
            
            if ($("#cbo_SelectProject option:selected").val() > 0) {

                window.location = "EditProjects.aspx";
            } else {
                alert("من فضلك قم باختيار المشروع اولاً");
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div>
        <table>
            <tr>
                <td>
                    <h3>اختار مشروع :</h3>
                </td>
                <td>
                   <select id="cbo_SelectProject" onchange="SetPK_ID()">
                       <option></option>
                   </select>
                </td>
            </tr>
            <tr>
               
                <td colspan = "2" class="style29">
                    <input type="button" class="btn_Save" id="btn_Select" value="اختر" onclick="SelectCurrentProject()"/>
                    <input type="button" class="btn_Save" id="btn_Back" value="عودة للخلف" onclick="window.history.go(-1)"/>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
