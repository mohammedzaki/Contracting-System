<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true" CodeBehind="BackupDatabase.aspx.cs" Inherits="Contracting_System.BackupDatabase" %>
<asp:Content ID="Content3" ContentPlaceHolderID="UsersheadContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="UsersMainContent" runat="server">
<asp:Button ID="btn_Export" runat="server" Text="عمل نسخة احتياطيه" 
        onclick="btn_Export_Click" />
</asp:Content>
