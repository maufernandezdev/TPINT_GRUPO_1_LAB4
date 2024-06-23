package frgp.utn.edu.ar.negocio;

import java.util.List;
import frgp.utn.edu.ar.entidad.Medico;

public interface IMedicoNegocio {
	public boolean Add(Medico user);
	public Medico ReadOne(String nombreMedico);
	public List<Medico> ReadAll();
	public boolean Update(Medico medico);
	public boolean Delete(int legajo);
	public boolean Exist(String nombreUsuario);
}
