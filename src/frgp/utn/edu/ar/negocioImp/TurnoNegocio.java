package frgp.utn.edu.ar.negocioImp;

import java.util.List;

import frgp.utn.edu.ar.dao.IdaoMedico;
import frgp.utn.edu.ar.dao.IdaoTurno;
import frgp.utn.edu.ar.daoImp.DaoMedico;
import frgp.utn.edu.ar.daoImp.DaoTurno;
import frgp.utn.edu.ar.entidad.Turno;
import frgp.utn.edu.ar.negocio.ITurnoNegocio;

public class TurnoNegocio implements ITurnoNegocio {

private IdaoTurno daoTurno;
	
	public TurnoNegocio()
	{		
	}
	
	public TurnoNegocio(DaoTurno daoTurno)
	{
		this.daoTurno = daoTurno;
	}
	
	public IdaoTurno getDaoTurno() {
		return daoTurno;
	}
	public void setDaoTurno(IdaoTurno daoTurno) {
		this.daoTurno = daoTurno;
	}
		
	public boolean Add(Turno turno) {
		return daoTurno.Add(turno);
	}

	public Turno ReadOne(int idTurno) {
		return daoTurno.ReadOne(idTurno);
	}

	public List<Turno> ReadAll() {
		return daoTurno.ReadAll();
	}

	public boolean Update(Turno turno) {
		return daoTurno.Update(turno);
	}

	public boolean Delete(int idTurno) {
		return daoTurno.Delete(idTurno);
	}
	public boolean Exist(int idTurno) {
		return daoTurno.Exist(idTurno);
	}

}
