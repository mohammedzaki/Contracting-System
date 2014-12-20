<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="AddEmployee.aspx.cs" Inherits="Contracting_System.AddEmployee" %>

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
            إضافة موظف</h3>
        <br />
        اسم الموظف :
        <br />
        <input id="txt_EmployeeName" type="text" class="txt_DailyWorker" />
        <br />
        رقم البطاقة :
        <br />
        <input type="text" id="txt_EmployeeID" class="txt_DailyWorker" />
        <br />
        رقم الموبايل :
        <br />
        <input id="txt_EmployeeMobile" type="text" class="txt_DailyWorker IsNumberOnly" />
        <br />
        اسم الوظيفه :
        <br />
        <input id="txt_JobName" type="text" class="txt_DailyWorker" />
        <br />
        المرتب الشهرى :
        <br />
        <input id="txt_Salary" type="text" class="txt_DailyWorker IsNumberOnly" />
        <br />
        <input id="Button5" type="button" value="حفظ" onclick="AddEmployee()" class="btn_Save" /> 
        <input id="Button8" type="button" value="إلغاء" class="btn_Save" />
        
    </div>
    <script src="js/AddEmployee.js" type="text/javascript"></script>
</asp:Content>
