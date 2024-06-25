package frgp.utn.edu.ar.daoImp;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import frgp.utn.edu.ar.dao.IdaoEspecialidad;
import frgp.utn.edu.ar.entidad.Especialidad;


public class DaoEspecialidad implements IdaoEspecialidad {
    private ConfigHibernate conexion;
   
	public DaoEspecialidad() {}
	
	public DaoEspecialidad(ConfigHibernate conexion) {
		this.conexion = conexion;
	}

    public boolean Add(Especialidad especialidad) {
        boolean estado = true;
        conexion = new ConfigHibernate();
        Session session = null;

        try {
            session = conexion.abrirConexion();
            session.beginTransaction();
            session.save(especialidad);
            session.flush();
            session.getTransaction().commit();
            Especialidad savedEspecialidad = (Especialidad) session.get(Especialidad.class, especialidad.getId());
            
            if (savedEspecialidad == null) {
                estado = false;
            }
        } catch (Exception e) {
            if (session != null) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
            estado = false;
        } finally {
            if (session != null) {
                conexion.cerrarSession();
            }
        }

        return estado;
    }
    
    public boolean Exist(String nombreEspecialidad) {
        Session session = null;
        boolean exists = false;

        try {
            session = conexion.abrirConexion();
            String hql = "FROM Especialidad e WHERE e.nombre = :nombre";
            Query query = session.createQuery(hql);
            query.setParameter("nombre", nombreEspecialidad);
            Especialidad especialidad = (Especialidad) query.uniqueResult();
            if(especialidad != null)
            	exists = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return exists;
    }
    
    public List<Especialidad> ReadAll() {
		conexion = new ConfigHibernate();
	    Session session = conexion.abrirConexion();
        session.beginTransaction();
        List<Especialidad> especialidades = session.createQuery("FROM Especialidad").list();
        return especialidades;
	}
}