<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Image ID="ImageBanner" runat="server" ImageUrl="~/imagenes/banner.png"
        AlternateText="Asesoría Legal Global" CssClass="banner" />

    <h1>Bienvenido a Asesoría Legal Global</h1>
    <div class="presentacion">
        <asp:Image ID="ImageEmblema" runat="server" ImageUrl="~/imagenes/emblema.png"
            AlternateText="Emblema de la empresa" CssClass="emblema" />
        <p>
            Somos una consultoría legal que brinda asesoramiento en distintos temas jurídicos.
            En este sitio podés registrarte como cliente y subir tus documentos legales
            a tu propio espacio de forma segura.
        </p>
    </div>

    <h2>¿Cómo empezar?</h2>
    <ol>
        <li>Completá el formulario de <a href="registro.aspx">registro</a>.</li>
        <li><a href="login.aspx">Iniciá sesión</a> con tu usuario y contraseña.</li>
        <li>Cargá y consultá tus archivos en <a href="documentos.aspx">Mis documentos</a>.</li>
    </ol>

</asp:Content>
