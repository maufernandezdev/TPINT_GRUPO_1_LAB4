package frgp.utn.edu.ar.daoImp;

import java.util.List;

import org.hibernate.Session;

import frgp.utn.edu.ar.dao.IdaoLocalidad;
import frgp.utn.edu.ar.entidad.Localidad;
import frgp.utn.edu.ar.entidad.Provincia;

public class DaoLocalidad implements IdaoLocalidad{

private ConfigHibernate conexion;
	
	public DaoLocalidad() {
	}
	
	public DaoLocalidad(ConfigHibernate conexion) {
		this.conexion = conexion;
	}
	
	
	public List<Localidad> ReadAll() {
		conexion = new ConfigHibernate();
	    Session session = conexion.abrirConexion();
        session.beginTransaction();
        List<Localidad> listLocalidad = session.createQuery("FROM Localidad").list();
        return listLocalidad;
	}

	public Localidad ReadOneById(int id_localiad) {
		Session session = conexion.abrirConexion();
		session.beginTransaction();
		Localidad localiad = (Localidad)session.get(Provincia.class,id_localiad);
        return localiad;
	}
	
}
