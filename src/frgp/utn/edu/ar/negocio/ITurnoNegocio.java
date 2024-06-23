package frgp.utn.edu.ar.negocio;

import java.util.List;

import frgp.utn.edu.ar.entidad.Turno;

public interface ITurnoNegocio {

	public boolean Add(Turno turno);
	public Turno ReadOne(int idTurno);
	public List<Turno> ReadAll();
	public boolean Exist(int idTurno);
	public boolean Update(Turno turno);
	public boolean Delete(int idTurno);
}


