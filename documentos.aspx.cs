using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text.RegularExpressions;
using System.Data.SqlClient;

public partial class documentos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Solo puede entrar a esta página quien inició sesión
        if (this.Session["logueado"] == null)
        {
            this.Response.Redirect("login.aspx");
        }
        if (this.IsPostBack == false)
        {
            this.MostrarArchivos();
        }
    }

    //Devuelve la carpeta propia del usuario (documentos/nombredeusuario)
    private string CarpetaUsuario()
    {
        string usuario = this.Session["usuario"].ToString();
        //Dejamos solo letras, números, guión y guión bajo para que el nombre sea un nombre de carpeta válido
        string carpeta = Regex.Replace(usuario, "[^a-zA-Z0-9_-]", "_");
        return this.Server.MapPath(".") + "/documentos/" + carpeta;
    }

    //Carga en el GridView los documentos del usuario que están registrados en la base de datos
    private void MostrarArchivos()
    {
        SqlConnection conexion = new SqlConnection(Utiles.CadenaConexion());
        try
        {
            conexion.Open();
            SqlCommand comando = new SqlCommand("select codigo, nombrearchivo, (tamanio + 1023) / 1024 as kb, fecha " +
                "from documentos where usuario=@usuario order by fecha desc", conexion);
            comando.Parameters.AddWithValue("@usuario", this.Session["usuario"].ToString());
            SqlDataReader registros = comando.ExecuteReader();
            this.GridView1.DataSource = registros;
            this.GridView1.DataBind();
            registros.Close();
        }
        catch (SqlException ex)
        {
            this.Label1.Text = "No se pudo consultar la base de datos: " + this.Server.HtmlEncode(ex.Message);
        }
        finally
        {
            conexion.Close();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //1 - Verificamos que haya seleccionado un archivo
        if (this.FileUpload1.HasFile == false)
        {
            this.Label1.Text = "Debe seleccionar un archivo";
            return;
        }

        //2 - Verificamos la extensión (solo se aceptan algunos tipos de archivo)
        string nombre = Path.GetFileName(this.FileUpload1.FileName);
        string extension = Path.GetExtension(nombre).ToLower();
        string[] permitidas = { ".pdf", ".doc", ".docx", ".txt", ".jpg", ".jpeg", ".png" };
        if (Array.IndexOf(permitidas, extension) < 0)
        {
            this.Label1.Text = "Tipo de archivo no permitido";
            return;
        }

        //3 - Verificamos el tamaño con la propiedad ContentLength (máximo 5 MB)
        int tamanio = this.FileUpload1.PostedFile.ContentLength;
        if (tamanio > 5 * 1024 * 1024)
        {
            this.Label1.Text = "El archivo supera el tamaño máximo de 5 MB";
            return;
        }

        //4 - Creamos la carpeta del usuario (si ya existe no hace nada)
        string carpeta = this.CarpetaUsuario();
        Directory.CreateDirectory(carpeta);

        //5 - Verificamos que no exista otro archivo con el mismo nombre
        string ruta = carpeta + "/" + nombre;
        if (File.Exists(ruta))
        {
            this.Label1.Text = "Existe un archivo con dicho nombre en el servidor";
            return;
        }

        //6 - Guardamos el archivo en el servidor y registramos sus datos en la base de datos
        this.FileUpload1.SaveAs(ruta);
        SqlConnection conexion = new SqlConnection(Utiles.CadenaConexion());
        try
        {
            conexion.Open();
            SqlCommand comando = new SqlCommand("insert into documentos(usuario,nombrearchivo,tamanio) " +
                "values(@usuario,@nombre,@tamanio)", conexion);
            comando.Parameters.AddWithValue("@usuario", this.Session["usuario"].ToString());
            comando.Parameters.AddWithValue("@nombre", nombre);
            comando.Parameters.AddWithValue("@tamanio", tamanio);
            comando.ExecuteNonQuery();
            this.Label1.Text = "Archivo subido";
        }
        catch (SqlException ex)
        {
            //Si falla el registro en la base borramos el archivo para que no quede huérfano
            File.Delete(ruta);
            this.Label1.Text = "No se pudo registrar el documento: " + this.Server.HtmlEncode(ex.Message);
        }
        finally
        {
            conexion.Close();
        }
        this.MostrarArchivos();
    }

    //Se ejecuta al presionar el enlace "Descargar" de una fila del GridView
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Descargar")
        {
            int codigo = Convert.ToInt32(e.CommandArgument);
            string nombre = null;

            SqlConnection conexion = new SqlConnection(Utiles.CadenaConexion());
            try
            {
                conexion.Open();
                //Buscamos el documento por su código pero solo si pertenece al usuario de la sesión
                SqlCommand comando = new SqlCommand("select nombrearchivo from documentos " +
                    "where codigo=@codigo and usuario=@usuario", conexion);
                comando.Parameters.AddWithValue("@codigo", codigo);
                comando.Parameters.AddWithValue("@usuario", this.Session["usuario"].ToString());
                object resultado = comando.ExecuteScalar();
                if (resultado != null)
                {
                    nombre = resultado.ToString();
                }
            }
            catch (SqlException ex)
            {
                this.Label1.Text = "No se pudo consultar la base de datos: " + this.Server.HtmlEncode(ex.Message);
                return;
            }
            finally
            {
                conexion.Close();
            }

            string ruta = this.CarpetaUsuario() + "/" + nombre;
            if (nombre == null || File.Exists(ruta) == false)
            {
                this.Label1.Text = "El archivo no se encuentra en el servidor";
                return;
            }

            //Enviamos el archivo al navegador como descarga (attachment)
            string nombreSimple = Regex.Replace(nombre, "[^\\x20-\\x7E]", "_");
            this.Response.Clear();
            this.Response.ContentType = "application/octet-stream";
            this.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + nombreSimple +
                "\"; filename*=UTF-8''" + Uri.EscapeDataString(nombre));
            this.Response.AddHeader("Content-Length", new FileInfo(ruta).Length.ToString());
            this.Response.TransmitFile(ruta);
            this.Response.End();
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        //Cerramos la sesión pero dejamos el usuario guardado para poder volver a ingresar
        this.Session.Remove("logueado");
        this.Response.Redirect("login.aspx");
    }
}
