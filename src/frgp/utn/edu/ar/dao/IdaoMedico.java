package frgp.utn.edu.ar.dao;
import java.util.List;

import frgp.utn.edu.ar.entidad.Medico;

public interface IdaoMedico {
	public boolean Add(Medico medico);
	public List<Medico> Medico_xNombre(String nombre);
	public List<Medico> filtrarMedico_xSexo(String sexoMedico);
	public List<Medico> filtrarMedico_xEspecialidad(String especialidadMedico);
	public Medico ReadOne(String nombreMedico);
	public Medico ReadOneById(int legajo);
	public List<Medico> ReadAll();
	public boolean Exist(String nombreUsuario);
	public boolean Update(Medico medico);
	public boolean Delete(int legajo);
	public List<Medico> getMedicosByEspecialidadId(int especialidadId);
}
