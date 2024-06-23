package frgp.utn.edu.ar.dao;

import java.util.List;

import frgp.utn.edu.ar.entidad.Paciente;

public interface IdaoPaciente {
	public boolean Add(Paciente paciente);
	public Paciente ReadOne(int dni);
	public List<Paciente> ReadAll();
	public boolean Exist(int dni);
	public boolean Update(Paciente paciente);
	public boolean Delete(int dni);
}
