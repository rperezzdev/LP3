using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (this.IsValid)
        {
            object usuarioEncontrado = null;
            SqlConnection conexion = new SqlConnection(Utiles.CadenaConexion());
            try
            {
                conexion.Open();

                //Buscamos en la tabla usuarios un registro con ese usuario y esa clave (encriptada)
                SqlCommand comando = new SqlCommand("select usuario from usuarios " +
                    "where usuario=@usuario and clave=@clave", conexion);
                comando.Parameters.AddWithValue("@usuario", this.txtUsuario.Text.Trim());
                comando.Parameters.AddWithValue("@clave", Utiles.Encriptar(this.txtClave.Text));
                usuarioEncontrado = comando.ExecuteScalar();
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

            if (usuarioEncontrado == null)
            {
                this.Label1.Text = "Usuario o contraseña incorrectos";
            }
            else
            {
                //Guardamos el usuario en la sesión y la marcamos como iniciada
                this.Session["usuario"] = usuarioEncontrado.ToString();
                this.Session["logueado"] = "si";
                this.Response.Redirect("documentos.aspx");
            }
        }
    }
}
