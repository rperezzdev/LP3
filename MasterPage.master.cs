using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Si hay una sesión iniciada mostramos el nombre de usuario en todas las páginas
        if (this.Session["logueado"] != null && this.Session["usuario"] != null)
        {
            this.LabelUsuario.Text = "Sesión iniciada como: " + this.Server.HtmlEncode(this.Session["usuario"].ToString());
        }
    }
}
