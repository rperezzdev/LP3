<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="registro.aspx.cs" Inherits="registro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1>Registro de clientes</h1>
    <p>Todos los campos son obligatorios.</p>

    <div class="formulario">

        <div class="campo">
            <asp:Label ID="Label2" runat="server" Text="Nombre:" AssociatedControlID="txtNombre"></asp:Label>
            <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="txtNombre" ErrorMessage="Debe ingresar el nombre"
                ForeColor="Red">*</asp:RequiredFieldValidator>
        </div>

        <div class="campo">
            <asp:Label ID="Label3" runat="server" Text="Apellido:" AssociatedControlID="txtApellido"></asp:Label>
            <asp:TextBox ID="txtApellido" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                ControlToValidate="txtApellido" ErrorMessage="Debe ingresar el apellido"
                ForeColor="Red">*</asp:RequiredFieldValidator>
        </div>

        <div class="campo">
            <asp:Label ID="Label4" runat="server" Text="Correo electrónico:" AssociatedControlID="txtMail"></asp:Label>
            <asp:TextBox ID="txtMail" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                ControlToValidate="txtMail" ErrorMessage="Debe ingresar el correo electrónico"
                ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                ControlToValidate="txtMail" ErrorMessage="El formato del correo electrónico no es válido"
                ForeColor="Red" Display="Dynamic"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
        </div>

        <div class="campo">
            <asp:Label ID="Label5" runat="server" Text="Nombre de usuario:" AssociatedControlID="txtUsuario"></asp:Label>
            <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                ControlToValidate="txtUsuario" ErrorMessage="Debe ingresar el nombre de usuario"
                ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                ControlToValidate="txtUsuario"
                ErrorMessage="El usuario solo puede tener letras, números, guión y guión bajo (entre 3 y 30 caracteres)"
                ForeColor="Red" Display="Dynamic"
                ValidationExpression="[A-Za-z0-9_-]{3,30}">*</asp:RegularExpressionValidator>
        </div>

        <div class="campo">
            <asp:Label ID="Label6" runat="server" Text="Edad:" AssociatedControlID="txtEdad"></asp:Label>
            <asp:TextBox ID="txtEdad" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                ControlToValidate="txtEdad" ErrorMessage="Debe ingresar la edad"
                ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator1" runat="server"
                ControlToValidate="txtEdad" ErrorMessage="La edad debe ser un número mayor de 15 años"
                ForeColor="Red" Display="Dynamic" Type="Integer"
                MinimumValue="16" MaximumValue="120">*</asp:RangeValidator>
        </div>

        <div class="campo">
            <asp:Label ID="Label7" runat="server" Text="Contraseña:" AssociatedControlID="txtClave"></asp:Label>
            <asp:TextBox ID="txtClave" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                ControlToValidate="txtClave" ErrorMessage="Debe ingresar la contraseña"
                ForeColor="Red">*</asp:RequiredFieldValidator>
        </div>

        <div class="campo">
            <asp:Label ID="Label8" runat="server" Text="Repita la contraseña:" AssociatedControlID="txtClave2"></asp:Label>
            <asp:TextBox ID="txtClave2" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                ControlToValidate="txtClave2" ErrorMessage="Debe repetir la contraseña"
                ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server"
                ControlToValidate="txtClave2" ControlToCompare="txtClave"
                ErrorMessage="Las contraseñas ingresadas son distintas"
                ForeColor="Red" Display="Dynamic" Operator="Equal" Type="String">*</asp:CompareValidator>
        </div>

        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />

        <asp:Button ID="Button1" runat="server" Text="Registrar" onclick="Button1_Click" CssClass="boton" />
        <br />
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </div>

    <p>¿Ya tenés cuenta? <a href="login.aspx">Iniciá sesión</a></p>

</asp:Content>
