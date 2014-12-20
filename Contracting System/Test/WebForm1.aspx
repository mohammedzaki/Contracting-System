﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Users.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Contracting_System.Test.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <script type="text/javascript">
        function CheckFileExistence() {

            var filePath = document.getElementById('ctl00_ctl00_MainContent_UsersMainContent_file1').value;

            if (filePath.length < 1) {

                alert("File Name Can not be empty"); return false;
            }

            var validExtensions = new Array();
            var ext = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();

            validExtensions[0] = 'xdf';

            for (var i = 0; i < validExtensions.length; i++) {

                if (ext == validExtensions[i]) return true;
            }

            alert('The file extension ' + ext.toUpperCase() + ' is not allowed!');

            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <input id="file1" type="file" onchange="CheckFileExistence()" runat="server" />
    <br />
    <asp:Button ID="btn_Import" runat="server" Text="Import Saved Data From Local" OnClick="btn_Import_Click" />
</asp:Content>
