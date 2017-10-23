<%@ Page Title="" Language="C#" MasterPageFile="~/Carreras/MPCarreras.master" AutoEventWireup="true" CodeBehind="VerDatosCarrera.aspx.cs" Inherits="Sistema_de_etiquetas.Carreras.VerDatosCarrera" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contenidoPrincipal" runat="server">

    <h2>Ver Datos Carrera</h2>
    <p>
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
    </p>

</asp:Content>