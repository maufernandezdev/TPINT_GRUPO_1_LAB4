package frgp.utn.edu.ar.entidad;

import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="Medicos")
public class Medico implements Serializable{

	private static final long serialVersionUID = 1L;
	public enum Estado {
	    INACTIVO, ACTIVO
	}
	
	@Id
	@Column(name="legajo")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int legajo;
	@Column(name="nombre")
	private String nombre;
	@Column(name="apellido")
	private String apellido;
	@Column(name="sexo")
	private String sexo;
	@Column(name="fechaNac")
	private LocalDate fechaNac;
	@Column(name="direccion")
	private String direccion;
	@Column(name="localidad")
	private String localidad;
	@Column(name="correo")
	private String correo;
	@Column(name="telefono")
	private String telefono;
	@Column(name = "estado")
    private Estado estado;

	// TIPO DE RELACION CON USUARIO
	@OneToOne(cascade= (CascadeType.ALL))
	@JoinColumn(name="usuario_c")
	private Usuario usuario;
	
	// TIPO DE RELACION CON ESPECIALIDAD
		@ManyToOne
		@JoinColumn(name = "id_especialidad")
		private Especialidad especialidad;
	
	// TIPO DE RELACION CON TURNO
	@OneToMany(mappedBy = "medico", cascade = {CascadeType.ALL}, fetch = FetchType.LAZY)
	private List<Turno> listaTurnos = new ArrayList<Turno>();
	
	// Nueva columna para la relación con los horarios
    @Column(name="horario_id")
    private Long horarioId;	
	
	// Getters & Setters de ListaTurnos
	public List<Turno> getListaTurnos() {
		return listaTurnos;
	}
	
	public void setListaTurnos(List<Turno> listaTurnos) {
		this.listaTurnos = listaTurnos;
	}
	
	public Long getHorarioId() {
        return horarioId;
    }
    
    public void setHorarioId(Long horarioId) {
        this.horarioId = horarioId;
    }
	
    
    // Contructor y demás métodos
	public Medico() {	}
	
	
	public Medico(String nombre, String apellido, String sexo, LocalDate fechaNac, String direccion,
			String localidad, String correo, String telefono, Usuario usuario, Especialidad especialidad) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.sexo = sexo;
		this.fechaNac = fechaNac;
		this.direccion = direccion;
		this.localidad = localidad;
		this.correo = correo;
		this.telefono = telefono;
		this.usuario = usuario;
		this.especialidad = especialidad;
	}
	

	//Para facilitar 
	public void setMedicoDetails(String nombre, String apellido, String sexo, LocalDate fechaNac, String direccion,
		            String localidad, String correo, String telefono, Usuario usuario, Especialidad especialidad) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.sexo = sexo;
		this.fechaNac = fechaNac;
		this.direccion = direccion;
		this.localidad = localidad;
		this.correo = correo;
		this.telefono = telefono;
		this.usuario = usuario;
		this.especialidad = especialidad;
		}
	

	public Especialidad getEspecialidad() {
		return especialidad;
	}

	public void setEspecialidad(Especialidad especialidad) {
		this.especialidad = especialidad;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
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

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public LocalDate getFechaNac() {
		return fechaNac;
	}

	public void setFechaNac(LocalDate fechaNac) {
		this.fechaNac = fechaNac;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getLocalidad() {
		return localidad;
	}

	public void setLocalidad(String localidad) {
		this.localidad = localidad;
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public int getLegajo() {
		return legajo;
	}
	
	public Estado getEstado() {
        return estado;
    }

    public void setEstado(Estado estado) {
        this.estado = estado;
    }

	@Override
	public String toString() {
	    StringBuilder sb = new StringBuilder();
	    sb.append("Medico {").append("\n")
	      .append("  legajo: ").append(legajo).append(",\n")
	      .append("  nombre: ").append(nombre).append(",\n")
	      .append("  apellido: ").append(apellido).append(",\n")
	      .append("  sexo: ").append(sexo).append(",\n")
	      .append("  fechaNac: ").append(fechaNac).append(",\n")
	      .append("  direccion: ").append(direccion).append(",\n")
	      .append("  localidad: ").append(localidad).append(",\n")
	      .append("  correo: ").append(correo).append(",\n")
	      .append("  telefono: ").append(telefono).append(",\n")
	      .append("  estado: ").append(estado).append(",\n")
	      .append("  usuario: ").append(usuario != null ? usuario.getNombreUser() : "N/A").append(",\n")
	      .append("  especialidad: ").append(especialidad != null ? especialidad.getNombre() : "N/A").append("\n")
	      .append("}");
	    return sb.toString();
	}
}