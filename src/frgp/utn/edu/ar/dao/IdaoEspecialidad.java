package frgp.utn.edu.ar.dao;

import java.util.List;

import frgp.utn.edu.ar.entidad.Especialidad;

public interface IdaoEspecialidad {
	
    boolean Add(Especialidad especialidad);
	public boolean Exist(String nombreEspecialidad);
	public List<Especialidad> ReadAll();
}
