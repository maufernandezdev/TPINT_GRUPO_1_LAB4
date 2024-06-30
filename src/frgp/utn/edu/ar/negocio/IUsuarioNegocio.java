package frgp.utn.edu.ar.negocio;

import frgp.utn.edu.ar.entidad.Usuario;

public interface IUsuarioNegocio {
	public boolean Add(Usuario usuario);
	public boolean Delete(String nombreUser);
	public boolean Exist(String nombreUser);
	public Usuario Login(String nombreUser);
	public Usuario ReadOne(String usuario);
}
