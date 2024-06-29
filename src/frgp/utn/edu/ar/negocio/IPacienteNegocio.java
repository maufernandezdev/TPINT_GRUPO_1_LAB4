package frgp.utn.edu.ar.negocio;

import java.util.List;

import frgp.utn.edu.ar.entidad.Paciente;

public interface IPacienteNegocio {
	public boolean Add(Paciente paciente);
	public Paciente ReadOne(int dni);
	public List<Paciente> ReadAll();
	public boolean Update(Paciente paciente);
	public boolean Delete(int dni);
	public boolean Exist(int dni);
	public List<Paciente> listarPacientesActivos(); // nuevo método
}
