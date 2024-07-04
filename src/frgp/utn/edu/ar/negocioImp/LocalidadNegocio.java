package frgp.utn.edu.ar.negocioImp;

import java.util.List;

import frgp.utn.edu.ar.dao.IdaoLocalidad;
import frgp.utn.edu.ar.daoImp.DaoLocalidad;
import frgp.utn.edu.ar.entidad.Localidad;
import frgp.utn.edu.ar.negocio.ILocalidadNegocio;

public class LocalidadNegocio implements ILocalidadNegocio{

	private IdaoLocalidad daoLocalidad;
	
	public LocalidadNegocio()
	{		
	}
	
	public LocalidadNegocio(DaoLocalidad daoLocalidad)
	{
		this.daoLocalidad = daoLocalidad;
	}
	
	public IdaoLocalidad getDaoLocalidad() {
		return daoLocalidad;
	}
	public void setDaoLocalidad(IdaoLocalidad daoLocalidad) {
		this.daoLocalidad = daoLocalidad;
	}

	
	
	
	public List<Localidad> ReadAll() {
		return daoLocalidad.ReadAll();
	}

	
}
