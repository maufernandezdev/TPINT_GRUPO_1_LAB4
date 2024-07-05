package frgp.utn.edu.ar.dao;

import java.util.List;

import frgp.utn.edu.ar.entidad.Localidad;
import frgp.utn.edu.ar.entidad.Provincia;

public interface IdaoLocalidad {

	public List<Localidad> ReadAll();
	public Localidad ReadOneById(int id_localidad);
}
