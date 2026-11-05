<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1>Iniciar sesión</h1>

    <div class="formulario">

        <div class="campo">
            <asp:Label ID="Label2" runat="server" Text="Nombre de usuario:" AssociatedControlID="txtUsuario"></asp:Label>
            <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="txtUsuario" ErrorMessage="Debe ingresar el nombre de usuario"
                ForeColor="Red">*</asp:RequiredFieldValidator>
        </div>

        <div class="campo">
            <asp:Label ID="Label3" runat="server" Text="Contraseña:" AssociatedControlID="txtClave"></asp:Label>
            <asp:TextBox ID="txtClave" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                ControlToValidate="txtClave" ErrorMessage="Debe ingresar la contraseña"
                ForeColor="Red">*</asp:RequiredFieldValidator>
        </div>

        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />

        <asp:Button ID="Button1" runat="server" Text="Ingresar" onclick="Button1_Click" CssClass="boton" />
        <br />
        <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
    </div>

    <p>¿Todavía no sos cliente? <a href="registro.aspx">Registrate</a></p>

</asp:Content>
