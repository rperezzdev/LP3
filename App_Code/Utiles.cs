using System;
using System.Text;
using System.Security.Cryptography;

//Clase con funciones que usan varias páginas del sitio
public class Utiles
{
    //Devuelve la cadena de conexión guardada en el web.config
    public static string CadenaConexion()
    {
        return System.Configuration.ConfigurationManager.ConnectionStrings["asesoria"].ConnectionString;
    }

    //Encripta la clave con SHA-256 para no guardarla como texto plano en la base de datos
    public static string Encriptar(string texto)
    {
        SHA256 sha = SHA256.Create();
        byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(texto));
        StringBuilder resultado = new StringBuilder();
        foreach (byte b in bytes)
        {
            resultado.Append(b.ToString("x2"));
        }
        return resultado.ToString();
    }
}
