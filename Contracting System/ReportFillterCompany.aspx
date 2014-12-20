<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="ReportFillterCompany.aspx.cs" Inherits="Contracting_System.ReportFillterCompany" %>
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
            }
        });
    });
    function Print() {
        window.location.href = "ReportViewer.aspx?Report=1&ExractOrder=" + $("#ex").val() + "&ProjectID=" + $("#cbo_ProjectName").val() + "&PersonID=1";
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

<input type="button" value="طباعة" onclick="Print()" class="btn_Save"/>
</asp:Content>
