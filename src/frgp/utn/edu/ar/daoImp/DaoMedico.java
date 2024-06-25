package frgp.utn.edu.ar.daoImp;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import frgp.utn.edu.ar.dao.IdaoMedico;
import frgp.utn.edu.ar.entidad.Medico;
import frgp.utn.edu.ar.entidad.Medico.Estado;

public class DaoMedico implements IdaoMedico {
	private ConfigHibernate conexion;
	
	public DaoMedico() {
	}
	
	public DaoMedico(ConfigHibernate conexion) {
		this.conexion = conexion;
	}
	
	public boolean Add(Medico medico) {
		boolean estado = true;
	    conexion = new ConfigHibernate();
	    Session session = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        session.save(medico);
	        session.flush();
	        session.getTransaction().commit();
	        Medico savedMedico = (Medico) session.get(Medico.class, medico.getLegajo());
	        
	        if (savedMedico == null) {
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
	
	public Medico ReadOne(String nombreMedico) {
		Session session = conexion.abrirConexion();
		session.beginTransaction();
        Medico medico = (Medico)session.get(Medico.class,nombreMedico);
        return medico;
	}

	public boolean Update(Medico medico) {
		boolean estado = true;
	    Session session = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        session.update(medico);
	        session.flush();
	        session.getTransaction().commit();
	        Medico savedMedico = (Medico) session.get(Medico.class, medico.getUsuario());
	        
	        if (savedMedico.equals(medico) == false) {
	            estado = false;
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
	
	public boolean Delete(int legajo) {	
	    boolean estado = true;
	    conexion = new ConfigHibernate();
	    Session session = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        System.out.println("medico a eliminar legajo: " + legajo);
		    Medico medicoDB = (Medico)session.get(Medico.class, legajo);
	        if (medicoDB != null) {
	            medicoDB.setEstado(Estado.INACTIVO);
	            session.update(medicoDB);
	            session.getTransaction().commit();
	            estado = true;
	        } else {
	            estado = false;
	        }
	    } catch (Exception e) {
	        if (session != null) {
	            session.getTransaction().rollback();
	        }
	        estado = false;
	        e.printStackTrace();
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }

	    return estado;
	}

	public List<Medico> ReadAll() {		
		conexion = new ConfigHibernate();
	    Session session = conexion.abrirConexion();
        session.beginTransaction();
        List<Medico> medicos = session.createQuery("FROM Medico").list();
        return medicos;
	}
	
	public ConfigHibernate getConexion() {
		return conexion;
	}

	public void setConexion(ConfigHibernate conexion) {
		this.conexion = conexion;
	}
	
	public boolean Exist(String nombreUsuario) {
		Session session = conexion.abrirConexion();
	    session.beginTransaction();
	    
	    String hql = "FROM Medico m WHERE m.usuario.nombreUser = :nombreUsuario";
	    Query query = session.createQuery(hql);
	    query.setParameter("nombreUsuario", nombreUsuario);
	    Medico medico = (Medico) query.uniqueResult();
	    
	    session.getTransaction().commit();
	    session.close();
	    
	    return medico != null;
	}
}
