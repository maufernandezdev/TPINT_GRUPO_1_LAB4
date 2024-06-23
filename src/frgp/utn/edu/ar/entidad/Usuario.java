package frgp.utn.edu.ar.entidad;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

@Entity
public class Usuario implements Serializable{
	
	public enum TipoDeUsuario {
	    MEDICO, ADMINISTRADOR
	}
	private static final long serialVersionUID = 1L;
	
	@Id
	private String nombreUser;
	private String contrasenia;
	private TipoDeUsuario tipoDeUsuario;
	
	// BIDERECCION CON MEDICO
	/*@OneToOne(mappedBy="usuario", fetch=FetchType.EAGER) // cuando son listas no conviene usar EAGER
	private Medico medico;*/
	
	
	public TipoDeUsuario getTipoDeUsuario() {
		return tipoDeUsuario;
	}

	public void setTipoDeUsuario(TipoDeUsuario tipoDeUsuario) {
		this.tipoDeUsuario = tipoDeUsuario;
	}

	public Usuario() {}
	
	/*public Medico getMedico() {
		return medico;
	}

	public void setMedico(Medico medico) {
		this.medico = medico;
	}*/

	
	public Usuario(String nombreUsuario, String contrasenia) {
		this.nombreUser=nombreUsuario;
		this.contrasenia=contrasenia;
	}

	public String getNombreUser() {
		return nombreUser;
	}

	public void setNombreUser(String nombreUser) {
		this.nombreUser = nombreUser;
	}

	public String getContrasenia() {
		return contrasenia;
	}

	public void setContrasenia(String contrasenia) {
		this.contrasenia = contrasenia;
	}

	@Override
	public String toString() {
		String mensaje= "Usuario [nombreUser=" + nombreUser + ", contrasenia=" + contrasenia + " Tipo de usuario=" + tipoDeUsuario;
		return mensaje;
	}
}