<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="AddDailyWorker.aspx.cs" Inherits="Contracting_System.AddDailyWorker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style>
        .txt_DailyWorker
        {
            width: 150px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div>
        <h3>
            إضافة عامل</h3>
        <br />
        اسم العامل :
        <br />
        <input id="txt_DailyWorkerName" type="text" class="txt_DailyWorker" />
        <br />
        رقم البطاقة :
        <br />
        <input type="text" id="txt_DailyWorkerID" class="txt_DailyWorker" />
        <br />
        رقم الموبايل :
        <br />
        <input id="txt_DailyWorkerMobile" type="text" class="txt_DailyWorker" />
        <br />
        <input id="Button5" type="button" value="حفظ" onclick="AddDailyWorker()" class="btn_Save" />
        <input id="Button8" type="button" value="إلغاء" class="btn_Save" />
    </div>
    <script src="js/AddDailyWorker.js" type="text/javascript"></script>
</asp:Content>
