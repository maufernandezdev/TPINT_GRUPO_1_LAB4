package frgp.utn.edu.ar.negocioImp;

import java.util.List;

import frgp.utn.edu.ar.daoImp.DaoEspecialidad;
import frgp.utn.edu.ar.entidad.Especialidad;
import frgp.utn.edu.ar.negocio.IEspecialidadNegocio;


public class EspecialidadNegocio implements IEspecialidadNegocio {
	
    private DaoEspecialidad daoEspecialidad;

    public void setDaoEspecialidad(DaoEspecialidad daoEspecialidad) {
        this.daoEspecialidad = daoEspecialidad;
    }

    public boolean Add(Especialidad especialidad) {
    	
    	 if (Exist(especialidad.getNombre())) {
             return false; // La especialidad ya existe
         } else {
             return daoEspecialidad.Add(especialidad);
         }
    }
    
    public boolean Exist(String nombreEspecialidad) {
        return daoEspecialidad.Exist(nombreEspecialidad);
    }
    
    public List<Especialidad> ReadAll() {
		return daoEspecialidad.ReadAll();
	}

}