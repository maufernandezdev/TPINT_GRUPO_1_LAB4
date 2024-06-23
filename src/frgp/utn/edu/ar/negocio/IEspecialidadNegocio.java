package frgp.utn.edu.ar.negocio;

import frgp.utn.edu.ar.entidad.Especialidad;

public interface IEspecialidadNegocio {
	
    boolean Add(Especialidad especialidad);
	public boolean Exist(String nombreEspecialidad);

}
