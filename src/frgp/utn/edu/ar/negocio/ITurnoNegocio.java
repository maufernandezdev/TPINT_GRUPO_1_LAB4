package frgp.utn.edu.ar.negocio;

import java.sql.Date;
import java.sql.Time;
import java.util.List;
import java.util.Map;

import frgp.utn.edu.ar.entidad.Turno;

public interface ITurnoNegocio {

	public boolean Add(Turno turno);
	public Turno ReadOne(int idTurno);
	public List<Turno> ReadAll();
	public boolean Exist(int idTurno);
	public boolean Update(Turno turno);
	public boolean Delete(int idTurno);
	public boolean existeTurnoParaMedicoFechaYHora(int medicoLegajo, Date fecha, Time hora);
	public List<Turno> getTurnosPorMedicoLegajo(int medicoLegajo);
	public Map<String, Long> ObtenerPresentesAusentesEntreFechas();
}


