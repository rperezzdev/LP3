<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="documentos.aspx.cs" Inherits="documentos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1>Mis documentos legales</h1>
    <p>Formatos permitidos: PDF, Word, TXT, JPG y PNG. Tamaño máximo: 5 MB.</p>

    <div class="formulario">
        <asp:Label ID="Label2" runat="server" Text="Seleccione el documento a subir:"></asp:Label>
        <br />
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Subir documento" onclick="Button1_Click" CssClass="boton" />
        <br />
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </div>

    <h2>Documentos cargados</h2>
    <div class="lista-archivos">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            EmptyDataText="Todavía no subiste documentos" CssClass="grilla"
            onrowcommand="GridView1_RowCommand">
            <Columns>
                <asp:BoundField DataField="nombrearchivo" HeaderText="Archivo" />
                <asp:BoundField DataField="kb" HeaderText="Tamaño (KB)" />
                <asp:BoundField DataField="fecha" HeaderText="Fecha de carga"
                    DataFormatString="{0:dd/MM/yyyy HH:mm}" HtmlEncode="False" />
                <asp:TemplateField HeaderText="Descarga">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Descargar"
                            CommandArgument='<%# Eval("codigo") %>' CausesValidation="False">Descargar</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="Button2" runat="server" Text="Cerrar sesión" onclick="Button2_Click" CssClass="boton boton-secundario" />

</asp:Content>
