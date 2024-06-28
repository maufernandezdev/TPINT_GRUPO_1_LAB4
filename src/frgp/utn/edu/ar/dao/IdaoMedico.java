package frgp.utn.edu.ar.dao;
import java.util.List;

import frgp.utn.edu.ar.entidad.Medico;

public interface IdaoMedico {
	public boolean Add(Medico medico);
	public Medico ReadOne(String nombreMedico);
	public Medico ReadOneById(int legajo);
	public List<Medico> ReadAll();
	public boolean Exist(String nombreUsuario);
	public boolean Update(Medico medico);
	public boolean Delete(int legajo);
}
