package frgp.utn.edu.ar.negocio;

import java.sql.Date;
import java.util.List;

import org.json.JSONArray;

import frgp.utn.edu.ar.entidad.Horario;
import frgp.utn.edu.ar.entidad.Medico;

public interface IHorarioNegocio {
    public boolean Add(Medico medico, List<Horario> horariosList);
	public List<Horario> getAvailableTimesByMedic(int medicoId, Date fecha);
	public List<Horario> getList(JSONArray horariosList);
	public List<Horario> ReadAll();
}
