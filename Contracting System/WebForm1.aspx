<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Contracting_System.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        function uploadCV() {
            var filedata = document.getElementById("upload"),
            formdata = false;
            if (window.FormData) {
                formdata = new FormData();
            }
            var i = 0, len = filedata.files.length, img, reader, file;

            for (; i < len; i++) {
                file = filedata.files[i];

                if (window.FileReader) {
                    reader = new FileReader();
                    reader.onloadend = function (e) {
                        //showUploadedItem(e.target.result, file.fileName);
                    };
                    reader.readAsDataURL(file);
                }
                if (formdata) {
                    formdata.append("file", file);
                }
            }
            if (formdata) {
                $.ajax({
                    url: "WebForm1.aspx",
                    type: "POST",
                    data: formdata,
                    processData: false,
                    contentType: false,
                    success: function (res) {
                        //alert(res);
                    },
                    error: function (res) {
                        //alert(res);
                    }
                });
            }
        }
    </script>
</head>
<body>
    <form enctype="multipart/form-data" id="frm" method="POST" runat="server">
        <input id="upload" name="file" style="/*width: 0px; height: 0px*/" type="file" />
        <input type="button" value="upload" onclick="uploadCV();" />
    </form>
</body>
</html>
