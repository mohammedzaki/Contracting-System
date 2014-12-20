<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="EditDailySuppliesbook.aspx.cs" Inherits="Contracting_System.EditDailySuppliesbook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">

    <script type="text/javascript">
        var pk_id;
        var subData;
        var searchData;
        var rest;
        var QTY;
        var SuppliesEventQTY;
        $(function () {
            $.ajax({
                url: "LoadData.aspx",
                type: "POST",
                data: {
                    action: location.pathname.substr(location.pathname.lastIndexOf('/') + 1, (location.pathname.length - 6))
                },
                success: function (data) {
                    subData = data;
                    //  
                    $(subData).filter('main').find('Tbl_Project').each(function () {
                        $("#cbo_ProjectName").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });

                    $(subData).filter('main').find('Tbl_Subcontractor').each(function () {
                        $("#cbo_SupplierNames").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });

                    $(subData).filter('main').find('Tbl_Category').each(function () {
                        $("#cbo_SupplieisCategory").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('Name').text() + '</option>');
                    });

                    $("#cbo_SupplieisCategory").on("change", function () {
                        $("#cbo_ItemType").html('<option></option>');
                        $(subData).filter('main').find('Tbl_Items').each(function () {
                            if ($("#cbo_SupplieisCategory").val() == $(this).find('FK_CategoryID').text()) {
                                $("#cbo_ItemType").append('<option value="' + $(this).find('PK_ID').text() + '" >' + $(this).find('ItemType').text() + '</option>');
                            }
                        });
                    });
                },
                error: function (error) {
                    alert("Error happened please contact System Administrator : " + error.statusText);
                }
            });

            $("#btn_Search").on("click", function () {
                $.ajax({
                    url: location.pathname.substr(1),
                    type: "POST",
                    data: {
                        cbo_ProjectName : $("#cbo_ProjectName").val(),
                        cbo_SupplierNames : $("#cbo_SupplierNames").val(),
                        cbo_SupplieisCategory : $("#cbo_SupplieisCategory").val(),
                        cbo_ItemType : $("#cbo_ItemType").val(),
                        txt_ReciptNo : $("#txt_ReciptNo").val(),
                        txt_DateFrom : $("#txt_DateFrom").val(),
                        txt_DateTo : $("#txt_DateTo").val(),
                        action: "LoadSearch"
                    },
                    success: function (data) {
                        searchData = data;
                        if ($(data).filter('main').find('Exception').text() == '') {
                            $("#grid_SuppliesDetails").html('');
                            $(data).filter('main').find('Tbl_Data').each(function () {
                                $("#grid_SuppliesDetails").append('<tr class="ItemRow"><td class="b_width">' + $(this).find('ProjectName').text() + '</td><td class="b_width">' + $(this).find('SupplierName').text() + '</td><td class="m_width">' + $(this).find('CategoryName').text() + '</td><td class="m_width">' + $(this).find('ItemName').text() + '</td><td class="s_width">' + $(this).find('ReceiptNO').text() + '</td><td class="b_width">' + $(this).find('SuppliesDate').text() + '</td><td class="hiddenElemnet">' + $(this).find('SuppliesEventID').text() + '</td><td class="ms_width"><input type="button" value="تعديل" class="update"/></td></tr>');
                            });
                            $(".overlay,.popup-close").click(function () {
                                $(".popup-container").hide();
                            });
                            ////////////////////validate popup event
                            $(".update").click(function (e) {
                                e.preventDefault();
                                pk_id = $(this).parent().prev().html();
                                $(searchData).filter('main').find('Tbl_Data').each(function () {
                                    if ($(this).find('SuppliesEventID').text() == pk_id)
                                    {
                                        rest = parseFloat($(this).find('Rest').text());
                                        QTY = parseInt($(this).find('QTY').text());
                                        SuppliesEventQTY = parseInt($(this).find('SuppliesEventQTY').text());
                                        $("#txt_UnitPrice").val($(this).find('UnitPrice').text());
                                        $("#txt_SuppliesQTY").val($(this).find('SuppliesEventQTY').text());
                                        $("#txt_TotalPrice").val($(this).find('TotalPrice').text());
                                        $("#txt_ReciptNoEdit").val($(this).find('ReceiptNO').text());
                                        $("#txt_WasSupplies").val(QTY - rest);
                                        $("#txt_RestSupplies").val($(this).find('Rest').text());
                                        $("#ProjectSupplies").val($(this).find('PK_ID').text());
                                    }
                                });
                                $(".popup-save").show();
                            });
                        } else {
                            alert($(data).filter('main').find('Exception').text());
                        }
                    },
                    error: function (error) {
                        alert("Error happened please contact System Administrator : " + error.statusText);
                    }
                });
            });

            $("#txt_UnitPrice").on("change", function () {
                $("#txt_TotalPrice").val(parseFloat($("#txt_UnitPrice").val()) * parseFloat($("#txt_SuppliesQTY").val()));
            });
            $("#txt_SuppliesQTY").on("change", function () {
                cal();
            });

            $("#btn_Save").on("click", function () {
                if (
                $("#txt_SuppliesQTY").val() != '') {
                    $.ajax({
                        url: "SaveData.aspx",
                        type: "POST",
                        data: {
                            pk_id: pk_id,
                            txt_UnitPrice: $("#txt_UnitPrice").val(),
                            txt_SuppliesQTY: $("#txt_SuppliesQTY").val(),
                            txt_TotalPrice: $("#txt_TotalPrice").val(),
                            txt_ReciptNoEdit: $("#txt_ReciptNoEdit").val(),
                            txt_WasSupplies: $("#txt_WasSupplies").val(),
                            txt_RestSupplies: $("#txt_RestSupplies").val(),
                            ProjectSupplies_PK_ID: $("#ProjectSupplies_PK_ID").val(),
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
                    alert("ادخل باقى البيانات اولا");
                }
            });

        });
        function cal() {
            $("#txt_TotalPrice").val(parseFloat($("#txt_UnitPrice").val()) * parseFloat($("#txt_SuppliesQTY").val()));
            if (parseInt($("#txt_SuppliesQTY").val()) > SuppliesEventQTY) {

                $("#txt_WasSupplies").val((QTY - rest) + (parseInt($("#txt_SuppliesQTY").val()) - SuppliesEventQTY));

                $("#txt_RestSupplies").val(QTY - parseInt($("#txt_WasSupplies").val()));

            } else if (parseInt($("#txt_SuppliesQTY").val()) < SuppliesEventQTY) {

                $("#txt_WasSupplies").val((QTY - rest) - (SuppliesEventQTY - parseInt($("#txt_SuppliesQTY").val())));

                $("#txt_RestSupplies").val(QTY - parseInt($("#txt_WasSupplies").val()));

            } else {
                $("#txt_WasSupplies").val(QTY - rest);

                $("#txt_RestSupplies").val(QTY - parseInt($("#txt_WasSupplies").val()));
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div>
        <table>
            <tr>
                <td class="style24">اسم المشروع :
                </td>
                <td class="style24">اسم المورد :
                </td>
                <td class="style24">المادة الخام :
                </td>
                <td class="style24">نوع المادة الخام :
                </td>
                <td class="style24">رقم البون :
                </td>
                <td class="style24">التاريخ من:
                </td>
                <td class="style24">التاريخ الى:
                </td>
            </tr>
            <tr>
                <td>
                    <select id="cbo_ProjectName" class="m_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_SupplierNames" class="m_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_SupplieisCategory" class="s_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <select id="cbo_ItemType" class="s_width">
                        <option></option>
                    </select>
                </td>
                <td>
                    <input id="txt_ReciptNo" type="text" class="ts_width" />
                </td>
                <td>
                    <input id="txt_DateFrom" type="text" class="s_width IsDate" />
                </td>
                <td>
                    <input id="txt_DateTo" type="text" class="s_width IsDate" />
                </td>
                <td rowspan="2" style="text-align: center;">
                    <input id="btn_Search" type="button" value="عرض" class="btn_Save" />
                </td>
            </tr>
        </table>
        <h3>التوريدات</h3>
        <table>
            <thead>
                <tr class="HeaderRow">
                    <td class="b_width">اسم المشروع
                    </td>
                    <td class="b_width">اسم المورد
                    </td>
                    <td class="m_width">المادة الخام
                    </td>
                    <td class="m_width">نوع المادة الخام
                    </td>
                    <td class="s_width">رقم البون
                    </td>
                    <td class="b_width">التاريخ
                    </td>
                    <td class="hiddenElemnet">الكود
                    </td>
                    <td class="ms_width"></td>
                </tr>
            </thead>
            <tbody id="grid_SuppliesDetails">
                <tr class="ItemRow">
                    <td class="b_width">اسم المشروع
                    </td>
                    <td class="b_width">اسم المورد
                    </td>
                    <td class="m_width">نوع المادة الخام
                    </td>
                    <td class="m_width">نوع الصنف
                    </td>
                    <td class="s_width">رقم البون
                    </td>
                    <td class="b_width">التاريخ
                    </td>
                    <td class="hiddenElemnet">الكود
                    </td>
                    <td class="ms_width">
                        <input type="button" value="تعديل" class="update" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="popup-container popup-save">
        <div class="overlay">
        </div>
        <div class="div-popup">
            <table>
                <tr>
                    <td class="style26">سعر الوحدة :<br />
                        <input id="txt_UnitPrice" type="text" class="m_width changePrice" />
                    </td>
                    <td class="style26">الكمية المورده :<br />
                        <input id="txt_SuppliesQTY" type="text" class="m_width changePrice" />
                    </td>
                    <td class="style26">إجمالى السعر :<br />
                        <input id="txt_TotalPrice" type="text" class="m_width" readonly />
                    </td>
                </tr>
                <tr>
                    <td class="style26">رقم البون :<br />
                        <input id="txt_ReciptNoEdit" type="text" class="m_width" />
                    </td>
                    <td class="style26">الكميات الاجمالية الموردة :<br />
                        <input id="txt_WasSupplies" type="text" class="m_width" readonly />
                    </td>
                    <td class="style26">الكميات المتبقية :<br />
                        <input id="txt_RestSupplies" type="text" class="m_width" readonly />
                    </td>
                </tr>
            </table>
            <input id="ProjectSupplies_PK_ID" type="hidden" />
            <input id="btn_Save" type="button" class="btn_Save popup-close" value="حفظ" />
            <input type="button" class="btn_Save btn-primary popup-close" value="إلغاء" />
        </div>
    </div>
</asp:Content>
