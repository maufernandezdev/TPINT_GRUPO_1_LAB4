package frgp.utn.edu.ar.dao;

import frgp.utn.edu.ar.entidad.Usuario;

public interface IdaoUsuario {
	public boolean Add(Usuario usuario);
	public boolean Delete(String nombreUser);
	public boolean Exist(String nombreUser);
	public Usuario Login(String nombreUser);
}
