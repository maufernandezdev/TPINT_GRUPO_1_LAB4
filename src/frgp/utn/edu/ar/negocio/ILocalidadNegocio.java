package frgp.utn.edu.ar.negocio;

import java.util.List;

import frgp.utn.edu.ar.entidad.Localidad;

public interface ILocalidadNegocio {

	public List<Localidad> ReadAll();
	public Localidad ReadOneById(int id_localidad);
}
