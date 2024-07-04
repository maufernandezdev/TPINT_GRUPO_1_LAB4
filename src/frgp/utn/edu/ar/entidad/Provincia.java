package frgp.utn.edu.ar.entidad;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="Provincias")
public class Provincia {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_provincia;
	private String nombre;
	
	@OneToMany(mappedBy = "provincia", cascade = {CascadeType.ALL})
	private List<Localidad> localidades = new ArrayList<Localidad>();
	
	
	
	public Provincia() {}
	
	public Provincia(String nombreProvincia) {
		this.nombre= nombreProvincia;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public List<Localidad> getLocalidades() {
		return localidades;
	}

	public void setLocalidades(List<Localidad> localidades) {
		this.localidades = localidades;
	}

	public int getId_provincia() {
		return id_provincia;
	}

	@Override
	public String toString() {
		return "Provincia [id_provincia=" + id_provincia + ", nombre=" + nombre + ", localidades=" + localidades + "]";
	}
	
}
