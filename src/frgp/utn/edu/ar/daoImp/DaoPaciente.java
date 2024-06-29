package frgp.utn.edu.ar.daoImp;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import frgp.utn.edu.ar.dao.IdaoPaciente;
import frgp.utn.edu.ar.entidad.Paciente;
import frgp.utn.edu.ar.entidad.Paciente.Estado;

public class DaoPaciente implements IdaoPaciente{
	private ConfigHibernate conexion;
	
	public DaoPaciente() {
	}
	public DaoPaciente(ConfigHibernate conexion) {
		this.setConexion(conexion);
	}

	public boolean Add(Paciente paciente) {
		boolean estado = true;
	    conexion = new ConfigHibernate();
	    Session session = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        session.save(paciente);
	        session.flush();
	        session.getTransaction().commit();
	        Paciente savedPaciente = (Paciente) session.get(Paciente.class, paciente.getDni());
	        
	        if (savedPaciente == null) {
	            estado = false;
	        }
	        
	    } catch (Exception e) {
	        if (session != null) {
	            Transaction transaction = session.getTransaction();
	            if (transaction != null && transaction.isActive()) {
	                transaction.rollback();
	            }
	        }
	        e.printStackTrace();
	    } finally {
	        if (session != null && session.isOpen()) {
	            session.close();
	        }
	       }
	    
	    return estado;
	}

	public Paciente ReadOne(int dni) {
		Session session = conexion.abrirConexion();
		session.beginTransaction();
		Paciente paciente = (Paciente)session.get(Paciente.class,dni);
		return paciente;
	}

	
	public List<Paciente> ReadAll() {
		conexion = new ConfigHibernate();
	    Session session = conexion.abrirConexion();
        session.beginTransaction();
        List<Paciente> paciente = session.createQuery("FROM Paciente where estado = 1").list();
        return paciente;
	}

	public boolean Exist(int dni) {
		Session session = conexion.abrirConexion();
	    session.beginTransaction();
	    
	    String hql = "FROM Paciente p WHERE p.dni = :dni";
	    Query query = session.createQuery(hql);
	    query.setParameter("dni", dni);
	    Paciente paciente = (Paciente) query.uniqueResult();
	    
	    session.getTransaction().commit();
	    session.close();
	    
	    return paciente != null;
	}
	
	public boolean Update(Paciente paciente) {
		boolean estado = false;
	    Session session = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        session.merge(paciente);
	        session.flush();
	        session.getTransaction().commit();
	        Paciente savedPaciente = (Paciente) session.get(Paciente.class, paciente.getDni());
	        
	        if (savedPaciente != null) {
	        	 estado = true;
	        }
	    } catch (Exception e) {
	        if (session != null) {
	            session.getTransaction().rollback();
	        }
	        e.printStackTrace();
	    } finally {
	    }
	    
		return estado;
	}
	
	
	public boolean Delete(int dni) {
	    boolean estado = false;
	    conexion = new ConfigHibernate();
	    Session session = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        System.out.println("Paciente a eliminar DNI: " + dni);
	        Paciente pacienteDB = (Paciente)session.get(Paciente.class, dni);
	        if (pacienteDB != null) {
	        	pacienteDB.setEstado(Estado.INACTIVO);
	            session.update(pacienteDB);
	            session.getTransaction().commit();
	            estado = true;
	        }
	    } catch (Exception e) {
	        if (session != null) {
	            session.getTransaction().rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }

	    return estado;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Paciente> listarPacientesActivos() {
		List<Paciente> pacientes = null;
		conexion = new ConfigHibernate();
	    Session session = conexion.abrirConexion();
	    session.beginTransaction();
	    String hql = "FROM Paciente WHERE estado = :estado";
	    Query query = session.createQuery(hql);
        
        query.setParameter("estado", Estado.ACTIVO);
        
        pacientes = query.list();
        
	    return pacientes;
	}
	
	/*@SuppressWarnings("unchecked")
	public List<Paciente> listarPacientesActivos() {
	    Session session = null;
	    List<Paciente> pacientes = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	    
	        String hql = "FROM Paciente WHERE estado = :estado";
	        
	        Query query = session.createQuery(hql);
	        
	        query.setParameter("estado", Estado.ACTIVO);
	        
	        pacientes = query.list();
	        
	        session.getTransaction().commit();
	    } catch (Exception e) {
	        if (session != null) {
	            session.getTransaction().rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }

	    return pacientes;
	}*/
	
	
	public ConfigHibernate getConexion() {
		return conexion;
	}
	
	public void setConexion(ConfigHibernate conexion) {
		this.conexion = conexion;
	}

}
