using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class registro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //Los validadores ya controlaron campos obligatorios, mail, edad y contraseñas iguales
        if (this.IsValid)
        {
            SqlConnection conexion = new SqlConnection(Utiles.CadenaConexion());
            try
            {
                conexion.Open();

                //Primero verificamos que no exista otro usuario con el mismo nombre
                SqlCommand consulta = new SqlCommand("select count(*) from usuarios where usuario=@usuario", conexion);
                consulta.Parameters.AddWithValue("@usuario", this.txtUsuario.Text.Trim());
                int existe = (int)consulta.ExecuteScalar();
                if (existe > 0)
                {
                    this.Label1.ForeColor = System.Drawing.Color.Red;
                    this.Label1.Text = "Ya existe un usuario con ese nombre, elija otro";
                    return;
                }

                //Alta del usuario (la clave se guarda encriptada)
                SqlCommand comando = new SqlCommand("insert into usuarios(usuario,nombre,apellido,mail,edad,clave) " +
                    "values(@usuario,@nombre,@apellido,@mail,@edad,@clave)", conexion);
                comando.Parameters.AddWithValue("@usuario", this.txtUsuario.Text.Trim());
                comando.Parameters.AddWithValue("@nombre", this.txtNombre.Text.Trim());
                comando.Parameters.AddWithValue("@apellido", this.txtApellido.Text.Trim());
                comando.Parameters.AddWithValue("@mail", this.txtMail.Text.Trim());
                comando.Parameters.AddWithValue("@edad", Convert.ToInt32(this.txtEdad.Text));
                comando.Parameters.AddWithValue("@clave", Utiles.Encriptar(this.txtClave.Text));
                comando.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                this.Label1.ForeColor = System.Drawing.Color.Red;
                this.Label1.Text = "No se pudo registrar el usuario en la base de datos: " + this.Server.HtmlEncode(ex.Message);
                return;
            }
            finally
            {
                conexion.Close();
            }

            //La contraseña se almacena en una cookie (se guarda en el navegador del cliente)
            HttpCookie cookie1 = new HttpCookie("clave", this.txtClave.Text);
            cookie1.Expires = DateTime.Now.AddDays(30);
            this.Response.Cookies.Add(cookie1);

            //El nombre de usuario se almacena en una variable de sesión (se guarda en el servidor)
            this.Session["usuario"] = this.txtUsuario.Text.Trim();

            //Redireccionamos al login para que el usuario inicie sesión
            this.Response.Redirect("login.aspx");
        }
    }
}
