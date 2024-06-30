package frgp.utn.edu.ar.negocio;

import java.util.List;
import frgp.utn.edu.ar.entidad.Medico;

public interface IMedicoNegocio {
	public boolean Add(Medico user);
	public List<Medico> Medico_xNombre(String nombre);
	public Medico ReadOne(String nombreMedico);
	public Medico ReadOneById(int legajo);
	public List<Medico> ReadAll();
	public boolean Update(Medico medico);
	public boolean Delete(int legajo);
	public boolean Exist(String nombreUsuario);
	public List<Medico> getMedicosByEspecialidadId(int especialidadId);
	public Medico getMedicoByUser(String user);
}
