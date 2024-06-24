package frgp.utn.edu.ar.entidad;

import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import frgp.utn.edu.ar.entidad.Medico.Estado;


@Entity
@Table(name="Pacientes")
public class Paciente implements Serializable{
	
	private static final long serialVersionUID = 1L;
	public enum Estado {
	    ACTIVO, INACTIVO
	}
	
	@Id
	private int dni;
	private String nombre;
	private String apellido;
	private String telefono;
	private String direccion;
	private String provincia;
	private String localidad;
	private Date fechaNac;
	private String correo;
    private Estado estado;
	
	// TIPO DE RELACION CON TURNO
	@OneToMany(mappedBy = "paciente", cascade = {CascadeType.ALL})
	private List<Turno> listaTurnos = new ArrayList<Turno>();
	
	// Getters & Setters de ListaTurnos
	public List<Turno> getListaTurnos() {
		return listaTurnos;
	}

	public void setListaTurnos(List<Turno> listaTurnos) {
		this.listaTurnos = listaTurnos;
	}

	public Paciente ( ) {}
	
	public Paciente(int dni, String nombre, String apellido, String telefono, String direccion, String provincia,
			String localidad, Date fechaNac, String correo) {
		super();
		this.dni = dni;
		this.nombre = nombre;
		this.apellido = apellido;
		this.telefono = telefono;
		this.direccion = direccion;
		this.provincia = provincia;
		this.localidad = localidad;
		this.fechaNac = fechaNac;
		this.correo = correo;
	}
	
	
	//facilitar
    public void setPacienteDetails(int dni, String nombre, String apellido, String telefono, String direccion,
            String provincia, String localidad, Date fechaNac, String correo) {
		this.dni = dni;
		this.nombre = nombre;
		this.apellido = apellido;
		this.telefono = telefono;
		this.direccion = direccion;
		this.provincia = provincia;
		this.localidad = localidad;
		this.fechaNac = fechaNac;
		this.correo = correo;
}

	public int getDni() {
		return dni;
	}

	public void setDni(int dni) {
		this.dni = dni;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellido() {
		return apellido;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public String getLocalidad() {
		return localidad;
	}

	public void setLocalidad(String localidad) {
		this.localidad = localidad;
	}

	public Date getFechaNac() {
		return fechaNac;
	}

	public void setFechaNac(Date fechaNac) {
		this.fechaNac = fechaNac;
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
	}

	public Estado getEstado() {
		return estado;
	}

	public void setEstado(Estado estado) {
		this.estado = estado;
	}
	
	@Override
	public String toString() {
		return "Paciente [dni=" + dni + ", nombre=" + nombre + ", apellido=" + apellido + ", telefono=" + telefono
				+ ", direccion=" + direccion + ", provincia=" + provincia + ", localidad=" + localidad + ", fechaNac="
				+ fechaNac + ", correo=" + correo + ", estado=" + estado + ", listaTurnos=" + listaTurnos + "]";
	}
	
}