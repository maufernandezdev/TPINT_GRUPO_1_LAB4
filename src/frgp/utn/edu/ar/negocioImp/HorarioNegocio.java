package frgp.utn.edu.ar.negocioImp;

import java.sql.Date;
import java.util.List;
import frgp.utn.edu.ar.daoImp.DaoHorario;
import frgp.utn.edu.ar.entidad.Horario;
import frgp.utn.edu.ar.negocio.IHorarioNegocio;


public class HorarioNegocio implements IHorarioNegocio {
	
    private DaoHorario daoHorario;

    public void setDaoHorario(DaoHorario daoHorario) {
        this.daoHorario = daoHorario;
    }

    public boolean Add(Horario horario) {
       return daoHorario.Add(horario);
    }
    
    public List<Horario> getAvailableTimesByMedic(int medicoId, Date fecha) {
        return daoHorario.getAvailableTimesByMedic(medicoId, fecha);
    }

}