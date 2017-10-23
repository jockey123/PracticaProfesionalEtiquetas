<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Sistema_de_etiquetas.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenidoMenuContextual" runat="server">

    <p>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Login"></asp:Label>
    </p>
    <p>
        <asp:Label ID="Label2" runat="server" Text="Usuario:"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox1" runat="server" Width="100px"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="Label3" runat="server" Text="Contraseña:"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox2" runat="server" Width="100px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:Button ID="Button1" runat="server" Text="Acceder" />
    </p>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenidoPrincipal" runat="server">

    <p>
        <h1>En este sector estaría una breve explicación del trabajo</h1>
        </p>

</asp:Content>
