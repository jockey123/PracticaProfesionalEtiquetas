<%@ Page Title="" Language="C#" MasterPageFile="~/Carreras/MPCarreras.master" AutoEventWireup="true" CodeBehind="AgregarCarrera.aspx.cs" Inherits="Sistema_de_etiquetas.Carreras.AgregarCarrera" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contenidoPrincipal" runat="server">

    <h2>Agregar Carrera</h2>
    <p>
        <table style="width: 100%">
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="Código de la Carrera:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="Nombre de la Carrera:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Agregar" />
                </td>
            </tr>
        </table>
&nbsp;</p>
    <p>&nbsp;</p>

</asp:Content>