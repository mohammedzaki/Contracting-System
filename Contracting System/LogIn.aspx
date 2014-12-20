<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="Contracting_System.LogIn" %>

<!DOCTYPE html >
<html>
<head runat="server">
    <title>أهلا وسهلا</title>
    <link href="css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/jquery-ui.js" type="text/javascript"></script>
    <link href="css/style.css" rel="stylesheet" type="text/css">
    <link href="css/menu/mlddmenu.css" rel="stylesheet" type="text/css" />
    <script src="css/menu/mlddmenu.js" type="text/javascript"></script>
    <script type="text/javascript">
        function resetAll() {
            $("#txt_loginUser").val('');
            $("#txt_LoginPassword").val('');
        }
        function ExitLogin() {
            window.location = 'Default.aspx';
        }
        function CheckLogin() {
            if ($("#txt_loginUser").val() != '' && $("#txt_LoginPassword").val() != '') {
                $.ajax({
                    url: "LogIn.aspx",
                    type: "POST",
                    data: {
                        userID: $("#txt_loginUser").val(),
                        pasword: $("#txt_LoginPassword").val(),
                        action: "LogIn"
                    },
                    success: function (data) {
                        $(data).filter('main').find('Tbl_Employees').each(function () {

                            if ($(this).find('ID').text() == 'true') {
                                window.location = 'Default.aspx';
                            } else {
                                alert('من فضلك تأكد من كلمة المرور واسم المستخدم');
                            }
                        });


                    },
                    error: function (error) {
                        alert("Error happened please contact System Administrator : " + error.statusText);
                    }
                });
            } else {
                alert('من فضلك تأكد من كلمة المرور واسم المستخدم');
            }
        }
    </script>
</head>
<body>
    <form id="form2" runat="server">
    <div class="main-out">
        <div class="main">
            <div class="page">
                <div class="top">
                    <div class="header">
                        <div class="header-top">
                            
                        </div>
                        <div class="topmenu">
                        </div>
                        <div class="header-img">
                        </div>
                    </div>
                    <div class="content">
                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <label>
                                            اسم المستخدم :</label>
                                    </td>
                                    <td>
                                        <input type="text" id="txt_loginUser" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>
                                            كلمة المرور :</label>
                                    </td>
                                    <td>
                                        <input type="password" id="txt_LoginPassword" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-align: center">
                                        <input type="button" id="btn_Login" value="تسجيل دخول" class="btn_Save" onclick="CheckLogin()"/>
                                        <input type="button" id="btn_cancel" value="الغاء" class="btn_Save" onclick="resetAll()"/>
                                        <input type="button" value="رجوع" class="btn_Save" onclick="ExitLogin()"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="bottom">
                    <ul>
                        <li style="border-left: medium none;"><a href="#">عن الشركة</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(".IsNumberOnly").keypress(function (evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                {
                    return false;
                }
            }
            return true;
        });
        $(".IsDate").datepicker({ dateFormat: "dd/mm/yy" });
        $(document).ready(function () {
            $('.toggle').hide();
            $('a.togglelink').on('click', function (e) {
                e.preventDefault();
                var elem = $(this).next('.toggle');
                $('.toggle').not(elem).hide('fast');
                elem.toggle('fast');
            });
        });
    </script>
    </form>
</body>
</html>
