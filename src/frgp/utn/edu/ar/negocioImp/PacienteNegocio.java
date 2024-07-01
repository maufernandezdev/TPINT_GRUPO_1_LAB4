package frgp.utn.edu.ar.negocioImp;

import java.util.List;

import frgp.utn.edu.ar.dao.IdaoPaciente;
import frgp.utn.edu.ar.daoImp.DaoPaciente;
import frgp.utn.edu.ar.entidad.Paciente;
import frgp.utn.edu.ar.exceptions.PacienteAlreadyExistsException;
import frgp.utn.edu.ar.negocio.IPacienteNegocio;

public class PacienteNegocio implements IPacienteNegocio{
	
	private IdaoPaciente daoPaciente;

	public PacienteNegocio() {

	}
	
	public PacienteNegocio(DaoPaciente paciente) {
		this.setDaoPaciente(paciente);
	}
	
	
	public boolean Add(Paciente paciente) {
		if (daoPaciente.Exist(paciente.getDni())) {
            throw new PacienteAlreadyExistsException("El paciente con DNI " + paciente.getDni() + " ya existe.");
        }
		return daoPaciente.Add(paciente);
	}
	
	public Paciente ReadOne(int dni) {
		return daoPaciente.ReadOne(dni);
	}

	public List<Paciente> ReadAll() {
		return daoPaciente.ReadAll();
	}

	public boolean Update(Paciente paciente) {
		return daoPaciente.Update(paciente);
	}

	public boolean Delete(int dni) {
		return daoPaciente.Delete(dni);
	}

	public boolean Exist(int dni) {
		return daoPaciente.Exist(dni);
	}
	
	public List<Paciente> listarPacientesActivos() {
        return daoPaciente.listarPacientesActivos();
    }

	public IdaoPaciente getDaoPaciente() {
		return daoPaciente;
	}

	public void setDaoPaciente(IdaoPaciente daoPaciente) {
		this.daoPaciente = daoPaciente;
	}
	public List<Paciente> Paciente_xDni(String dni){
		return this.daoPaciente.Paciente_xDni(dni);
	}
}
