<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="ReportFillterSub.aspx.cs" Inherits="Contracting_System.ReportFillterSub" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
<script>
    $(function () {
        $.ajax({
            url: "LoadData.aspx",
            type: "POST",
            data: {
                action: "LoadExtract"
            },
            success: function (data) {
                subData = data;
                $(subData).filter('main').find('Tbl_Project').each(function () {
                    $("#cbo_ProjectName").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                });
                $(subData).filter('main').find('Tbl_Subcontractor').each(function () {
                    $("#Select1").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                });
            }
        });
    });
    function Print() {
        window.location.href = "ReportViewer.aspx?Report=3&ExractOrder=" + $("#ex").val() + "&ProjectID=" + $("#cbo_ProjectName").val() + "&PersonID=" + $("#Select1").val();
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
رقم المستخلص :
<input type="text" id="ex"/>
<br />

اسم المشروع :
<select id="cbo_ProjectName">
    <option></option>
</select>
<br />

اسم المقاول :
<select id="Select1">
    <option></option>
</select>
<br />

<input type="button" value="طباعة" onclick="Print()" class="btn_Save"/>
</asp:Content>
