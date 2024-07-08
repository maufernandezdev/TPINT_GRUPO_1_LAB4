package frgp.utn.edu.ar.daoImp;

import java.sql.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import frgp.utn.edu.ar.dao.IdaoEspecialidad;
import frgp.utn.edu.ar.dao.IdaoHorario;
import frgp.utn.edu.ar.entidad.Especialidad;
import frgp.utn.edu.ar.entidad.Horario;
import frgp.utn.edu.ar.entidad.Medico;


public class DaoHorario implements IdaoHorario {
    private ConfigHibernate conexion;
   
	public DaoHorario() {}
	
	public DaoHorario(ConfigHibernate conexion) {
		this.conexion = conexion;
	}

    public boolean Add(Horario horario) {
        boolean estado = true;
        conexion = new ConfigHibernate();
        Session session = null;

        try {
            session = conexion.abrirConexion();
            session.beginTransaction();
            session.save(horario);
            session.flush();
            session.getTransaction().commit();
            Especialidad savedEspecialidad = (Especialidad) session.get(Especialidad.class, horario.getId());
            
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
    
    public List<Horario> getAvailableTimesByMedic(int medicoId, Date fecha) {
        Session session = null;
        boolean exists = false;

        try {
            session = conexion.abrirConexion();
            String hql = "FROM Horario WHERE medico_id = :medicoId AND dia = :fecha";
    	    List<Horario> horarios = session.createQuery(hql)
          .setParameter("especialidadId", medicoId)
          .setParameter("fecha", fecha)
          .list();
    	    
    	    session.getTransaction().commit();
    	    conexion.cerrarSession();
    	    System.out.println("horarios disponibles: " + horarios);
    	    return horarios;
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
		return null;
    }
    
    public List<Especialidad> ReadAll() {
		conexion = new ConfigHibernate();
	    Session session = conexion.abrirConexion();
        session.beginTransaction();
        List<Especialidad> especialidades = session.createQuery("FROM Especialidad").list();
        return especialidades;
	}
}