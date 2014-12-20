<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true" CodeBehind="EditItems.aspx.cs" Inherits="Contracting_System.EditItems" %>
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
                        $("#cbo_ItemCategory").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    $(subData).filter('main').find('Tbl_MeasurementUnit').each(function () {
                        $("#cbo_MeasurementUnit").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Unit').text() + '</option>');
                    });
                    $("#cbo_ItemCategory").on("change", function () {
                        $("#cbo_ItemCategoryTypes").html("<option></option>");
                        $(subData).filter('main').find('Tbl_Sub').each(function () {
                            if ($("#cbo_ItemCategory").val() == $(this).find('FK_CategoryID').text()) {
                                $("#cbo_ItemCategoryTypes").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('ItemType').text() + '</option>');
                            }
                        });
                    });
                    $("#cbo_ItemCategoryTypes").on("change", function () {
                        $(subData).filter('main').find('Tbl_Sub').each(function () {
                            if ($("#cbo_ItemCategoryTypes").val() == $(this).find('PK_ID').text()) {
                                $("#txt_ItemCategoryType").val($(this).find('ItemType').text());
                                $("#cbo_MeasurementUnit").val($(this).find('FK_MeasurementUnitID').text());
                            }
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Save").on("click", function () {
                if ($("#txt_ItemCategoryTypes").val() != '' && $("#cbo_ItemCategory").val() != '') {
                    $.ajax({
                        url: "SaveData.aspx",
                        type: "POST",
                        data: {
                            id: $("#cbo_ItemCategoryTypes").val(),
                            Name: $("#txt_ItemCategoryType").val(),
                            MeasurementUnit: $("#cbo_MeasurementUnit").val(),
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
                اختر المادة الخام :
            </td>
            <td>
                <select id="cbo_ItemCategory">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">
                اختر نوع المادة الخام :
            </td>
            <td>
                <select id="cbo_ItemCategoryTypes">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">
                الاسم الجديد :
            </td>
            <td>
                <input id="txt_ItemCategoryType" type="text" />
            </td>
        </tr>
        <tr>
            <td class="style23">
                وحدة القياس :
            </td>
            <td>
                <select id="cbo_MeasurementUnit">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="button" id="btn_Save" class="btn_Save" value="حفظ" />
            </td>
        </tr>
    </table>
</asp:Content>
