<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true"
    CodeBehind="ProjectSaver.aspx.cs" Inherits="Contracting_System.ProjectSaver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url: "LoadData.aspx",
                type: "POST",
                data: {
                    action: location.pathname.substr(location.pathname.lastIndexOf('/') + 1, (location.pathname.length - 6))
                },
                success: function (data) {
                    subData = data;
                    //$(subData).filter('main').find('Tbl_Savers').each(function () {
                    //    $("#cbo_CompanySaver").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    //});
                    $(subData).filter('main').find('Tbl_Project').each(function () {
                        $("#cbo_ProjectName").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    $(subData).filter('main').find('Tbl_SaverItems').each(function () {
                        $("#cbo_SaverItem").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });
                    //$("#cbo_CompanySaver").on("change", function () {
                    //    $(subData).filter('main').find('Tbl_Savers').each(function () {
                    //        if ($("#cbo_CompanySaver").val() == $(this).find('PK_ID').text()) {
                    //            $("#txt_currentAmount").val($(this).find('Amount').text());
                    //        }
                    //    });
                    //});
                    /*
                    $("#cbo_ProjectName").on("change", function () {
                        $(subData).filter('main').find('Tbl_Project').each(function () {
                            if ($("#cbo_ProjectName").val() == $(this).find('PK_ID').text()) {
                                $("#txt_currentAmount").val($(this).find('Amount').text());
                            }
                        });
                    });
                    */
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Save").on("click", function () {
                if (
                $("#cbo_SaverItem").val() != '' &&
                $("#cbo_CompanySaver").val() != '' &&
                $("#cbo_SaverItemType").val() != '' &&
                $("#txt_value").val() != '' &&
                $("#txt_Date").val() != '' &&
                $("#txt_Description").val() != '') {
                    var r = true;
                    if ($("#cbo_ProjectName").val() == '') {
                        //var r = confirm("ملحوظه: لم تختر اسم المشروع هل تريد الاستمرار ؟");
                        r = false;
                    }
                    if (r == true) {
                        $.ajax({
                            url: "SaveData.aspx",
                            type: "POST",
                            data: {
                                //cbo_CompanySaver: $("#cbo_CompanySaver").val(),
                                cbo_ProjectName: $("#cbo_ProjectName").val(),
                                cbo_SaverItem: $("#cbo_SaverItem").val(),
                                //cbo_SaverItemType: $("#cbo_SaverItemType").val(),
                                txt_value: $("#txt_value").val(),
                                txt_Date: $("#txt_Date").val(),
                                txt_Description: $("#txt_Description").val(),
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
                    }
                } else {
                    alert("ادخل باقى البيانات اولا");
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <table>
        <tr>
            <td class="style23">خزنة المشروع :
            </td>
            <td>
                <select id="cbo_ProjectName" class="b_width">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">البند :
            </td>
            <td>
                <select id="cbo_SaverItem" class="b_width">
                    <option></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style23">التاريخ :
            </td>
            <td>
                <input type="text" id="txt_Date" class="b_width IsDate" />
            </td>
        </tr>
        <tr>
            <td class="style23">القيمه :
            </td>
            <td>
                <input type="text" id="txt_value" class="b_width IsNumberOnly" />
            </td>
        </tr>
        <tr>
            <td class="style23">الوصف :
            </td>
            <td>
                <input type="text" id="txt_Description" class="b_width" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="button" id="btn_Save" class="btn_Save" value="إيداع" />
            </td>
        </tr>
    </table>
</asp:Content>
