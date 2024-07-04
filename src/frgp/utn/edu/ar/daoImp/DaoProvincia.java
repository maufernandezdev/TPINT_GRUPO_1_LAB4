package frgp.utn.edu.ar.daoImp;

import java.util.List;

import org.hibernate.Session;

import frgp.utn.edu.ar.dao.IdaoProvincia;
import frgp.utn.edu.ar.entidad.Provincia;
import frgp.utn.edu.ar.entidad.Turno;

public class DaoProvincia implements IdaoProvincia{

	private ConfigHibernate conexion;
	
	public DaoProvincia() {
	}
	
	public DaoProvincia(ConfigHibernate conexion) {
		this.conexion = conexion;
	}
	
	
	public List<Provincia> ReadAll() {
		conexion = new ConfigHibernate();
	    Session session = conexion.abrirConexion();
        session.beginTransaction();
        List<Provincia> listProvincia = session.createQuery("FROM Provincia").list();
        return listProvincia;
	}
}
