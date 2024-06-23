package frgp.utn.edu.ar.negocioImp;

import java.util.List;

import frgp.utn.edu.ar.dao.IdaoMedico;
import frgp.utn.edu.ar.daoImp.DaoMedico;
import frgp.utn.edu.ar.entidad.Medico;
import frgp.utn.edu.ar.negocio.IMedicoNegocio;


public class MedicoNegocio implements IMedicoNegocio {
	
	private IdaoMedico daoMedico;
	
	public MedicoNegocio()
	{
		
	}
	public MedicoNegocio(DaoMedico daoMedico)
	{
		this.daoMedico = daoMedico;
	}
	
	public IdaoMedico getDaoMedico() {
		return daoMedico;
	}
	public void setDaoMedico(IdaoMedico daoMedico) {
		this.daoMedico = daoMedico;
	}
	
	public boolean Add(Medico medico) {
		return daoMedico.Add(medico);
	}

	public Medico ReadOne(String nombreMedico) {
		return daoMedico.ReadOne(nombreMedico);
	}

	public List<Medico> ReadAll() {
		return daoMedico.ReadAll();
	}

	public boolean Update(Medico medico) {
		return daoMedico.Update(medico);
	}

	public boolean Delete(int legajo) {
		return daoMedico.Delete(legajo);
	}

	public IdaoMedico getDao() {
		return daoMedico;
	}

	public void setDao(IdaoMedico dao) {
		this.daoMedico = dao;
	}
	
	public boolean Exist(String nombreUsuario) {
		return daoMedico.Exist(nombreUsuario);
	}
}
