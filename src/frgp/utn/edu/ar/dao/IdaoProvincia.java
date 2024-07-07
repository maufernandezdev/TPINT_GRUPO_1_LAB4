package frgp.utn.edu.ar.dao;

import java.util.List;

import frgp.utn.edu.ar.entidad.Provincia;
public interface IdaoProvincia {

	public List<Provincia> ReadAll();
	public Provincia ReadOneById(int id_provincia);
}
