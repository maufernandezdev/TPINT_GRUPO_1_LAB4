package frgp.utn.edu.ar.negocio;

import java.sql.Date;
import java.util.List;
import frgp.utn.edu.ar.entidad.Horario;

public interface IHorarioNegocio {
	boolean Add(Horario horario);
	public List<Horario> getAvailableTimesByMedic(int medicoId, Date fecha);
}
