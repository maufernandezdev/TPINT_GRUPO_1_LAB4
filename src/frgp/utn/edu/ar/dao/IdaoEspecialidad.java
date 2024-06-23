package frgp.utn.edu.ar.dao;

import frgp.utn.edu.ar.entidad.Especialidad;

public interface IdaoEspecialidad {
	
    boolean Add(Especialidad especialidad);
	public boolean Exist(String nombreEspecialidad);
}
