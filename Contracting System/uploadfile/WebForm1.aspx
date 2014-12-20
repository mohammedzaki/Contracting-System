<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="stellar.uploadfile.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #L_transparent {
            float: left;
            left: 0px;
            top: 0px;
            height: 100%; /* or whatever you want */
            width: 100%; /* or whatever you want */
            background-color: rgba(0,0,0,0.5);
            position: fixed;
            /* opacity: 0.5;*/
            display: none;
            z-index: 99999999;
        }

        #L_content {
            color: #2187e7;
            font-weight: bold;
            text-align: center;
            display: none;
            z-index: 99999999;
        }

        #L_modebox {
            position: fixed;
            top: 200px;
            right: 0;
            bottom: 5;
            left: 0;
            background: rgba (0,0,0,0.8);
            z-index: 999999999;
            /*opacity:0;*/
            -webkit-transition: opacity 400ms ease-in;
            -moz-transition: opacity 400ms ease-in;
            transition: opacity 400ms ease-in;
            pointer-events: none;
        }

            #L_modebox:target {
                /*opacity:1;*/
                pointer-events: auto;
            }

            #L_modebox > div {
                width: 300px;
                position: relative;
                margin: 0 auto;
                padding: 5px 5px 5px 5px;
                border-radius: 10px;
                box-shadow: 0 0 35px #FFF;
                opacity: 1;
                background: #fff;
                z-index: 9999999;
            }
    </style>
    <script src="../js/jquery-1.9.1.js"></script>
    <script>
        function displayLoading() {
            document.getElementById("L_transparent").style.display = 'block';
            document.getElementById("L_content").style.display = 'block';
            document.getElementById("L_modebox").style.display = 'block';
        }

        function hideLoading() {
            document.getElementById("L_transparent").style.display = 'none';
            document.getElementById("L_content").style.display = 'none';
        }

        function clickUpload() {
            $('#upload').click();
        }

        function uploadCV() {
            displayLoading();
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
                        hideLoading();
                        alert(res);
                    },
                    error: function (res) {
                        hideLoading();
                        alert(res);
                    }
                });
            }
        }

    </script>
</head>
<body>
    <div id="L_transparent">
        <div id="L_modebox">
            <div id="L_content">
                <img src="images/ajax-loader.gif" />
                <p id="L_plz">
                    Please Wait...
                </p>
            </div>
        </div>
    </div>
    <form enctype="multipart/form-data" id="frm" method="POST" runat="server">
        <input type="hidden" name="MAX_FILE_SIZE" value="100000" />
        <input id="upload" name="file" style="width: 0px; height: 0px; display: none;" type="file" onchange="uploadCV();" />
        <a class="p1_s4_UploadCVButton" href="#" onclick="clickUpload()">Upload C.V</a>
    </form>
</body>
</html>
