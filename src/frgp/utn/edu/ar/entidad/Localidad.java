package frgp.utn.edu.ar.entidad;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="Localidades")
public class Localidad {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_localidad;
	private String nombre;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "id_provincia")
	private Provincia provincia;
	
	
	public Localidad() {}


	public Localidad(int id_localidad, String nombre, Provincia provincia) {
		super();
		this.id_localidad = id_localidad;
		this.nombre = nombre;
		this.provincia = provincia;
	}


	public String getNombre() {
		return nombre;
	}


	public void setNombre(String nombre) {
		this.nombre = nombre;
	}


	public Provincia getProvincia() {
		return provincia;
	}


	public void setProvincia(Provincia provincia) {
		this.provincia = provincia;
	}


	public int getId_localidad() {
		return id_localidad;
	}


	@Override
	public String toString() {
		return "Localidad [id_localidad=" + id_localidad + ", nombre=" + nombre + ", provincia=" + provincia + "]";
	}
	
	
}
