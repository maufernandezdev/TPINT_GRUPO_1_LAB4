package frgp.utn.edu.ar.dao;

import java.sql.Date;
import java.util.List;
import frgp.utn.edu.ar.entidad.Horario;

public interface IdaoHorario {
	
    boolean Add(Horario horario);
	public List<Horario> getAvailableTimesByMedic(int medicoId, Date fecha);
}
