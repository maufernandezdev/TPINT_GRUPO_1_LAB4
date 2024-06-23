package frgp.utn.edu.ar.negocioImp;

import java.util.List;

import frgp.utn.edu.ar.dao.IdaoUsuario;
import frgp.utn.edu.ar.daoImp.DaoUsuario;
import frgp.utn.edu.ar.entidad.Usuario;
import frgp.utn.edu.ar.negocio.IUsuarioNegocio;

public class UsuarioNegocio implements IUsuarioNegocio{
	
	private IdaoUsuario daoUsuario;

	public UsuarioNegocio() {}
	
	public UsuarioNegocio(DaoUsuario usuario) {
		this.setDaoUsuario(usuario);
	}
	
	public boolean Add(Usuario usuario) {
		 if (Exist(usuario.getNombreUser())){
             return false;
         } else {
             return daoUsuario.Add(usuario);
         }
	}

	public boolean Delete(String nombreUser) {
		return daoUsuario.Delete(nombreUser);
	}

	public boolean Exist(String nombreUser) {
		return daoUsuario.Exist(nombreUser);
	}
	
	public Usuario Login(String nombreUser) {
		return daoUsuario.Login(nombreUser);
	}
	
	public void setDaoUsuario(IdaoUsuario daoUsuario) {
		this.daoUsuario = daoUsuario;
	}
}
