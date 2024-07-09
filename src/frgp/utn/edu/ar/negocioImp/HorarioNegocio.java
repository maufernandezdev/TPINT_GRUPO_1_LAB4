package frgp.utn.edu.ar.negocioImp;

import java.sql.Date;
import java.util.List;

import org.json.JSONArray;

import frgp.utn.edu.ar.daoImp.DaoHorario;
import frgp.utn.edu.ar.entidad.Horario;
import frgp.utn.edu.ar.entidad.Medico;
import frgp.utn.edu.ar.negocio.IHorarioNegocio;


public class HorarioNegocio implements IHorarioNegocio {
	
    private DaoHorario daoHorario;

    public void setDaoHorario(DaoHorario daoHorario) {
        this.daoHorario = daoHorario;
    }

    public boolean Add(Medico medico, List<Horario> horariosList) {
       return daoHorario.Add(medico, horariosList);
    }
    
    public List<Horario> getAvailableTimesByMedic(int medicoId, Date fecha) {
        return daoHorario.getAvailableTimesByMedic(medicoId, fecha);
    }
    
	public List<Horario> getList(JSONArray horariosList){
		return daoHorario.getList(horariosList);
	}
	
	public List<Horario> ReadAll(){
		return daoHorario.ReadAll();
	}
}