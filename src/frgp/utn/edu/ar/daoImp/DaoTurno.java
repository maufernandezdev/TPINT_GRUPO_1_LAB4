package frgp.utn.edu.ar.daoImp;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import frgp.utn.edu.ar.dao.IdaoTurno;
import frgp.utn.edu.ar.entidad.Medico;
import frgp.utn.edu.ar.entidad.Paciente;
import frgp.utn.edu.ar.entidad.Turno;
import frgp.utn.edu.ar.entidad.Medico.Estado;
import frgp.utn.edu.ar.entidad.Turno.EstadoT;

public class DaoTurno implements IdaoTurno{

	private ConfigHibernate conexion;
	
	public DaoTurno() {
	}
	
	public DaoTurno(ConfigHibernate conexion) {
		this.conexion = conexion;
	}
	
	
	public boolean Add(Turno turno) {
		boolean estado = true;
	    conexion = new ConfigHibernate();
	    Session session = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        session.save(turno);
	        session.flush();
	        session.getTransaction().commit();
	        Turno savedTurno = (Turno) session.get(Turno.class, turno.getIdTurno());
	        
	        if (savedTurno == null) {
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

	public Turno ReadOne(int idTurno) {
		Session session = conexion.abrirConexion();
		session.beginTransaction();
        Turno turno = (Turno)session.get(Turno.class,idTurno);
        return turno;
	}

	public List<Turno> ReadAll() {
		conexion = new ConfigHibernate();
	    Session session = conexion.abrirConexion();
        session.beginTransaction();
        List<Turno> listTurno = session.createQuery("FROM Turno").list();
        return listTurno;
	}

	public boolean Update(Turno turno) {
		boolean estado = false;
	    Session session = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        session.update(turno);
	        session.flush();
	        session.getTransaction().commit();
	        Turno savedTurno = (Turno) session.get(Turno.class, turno.getIdTurno());
	        
	        if (savedTurno != null) {
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

	public boolean Delete(int idTurno) {
		boolean estado = false;
		conexion = new ConfigHibernate();
		Session session = null;
		
		try {
			session = conexion.abrirConexion();
			session.beginTransaction();
			System.out.println("Turno a eliminar IDturno: "+ idTurno);
			Turno turnoDB = (Turno)session.get(Turno.class, idTurno);
			if(turnoDB != null) {
				turnoDB.setEstado(EstadoT.INACTIVO);
				session.update(turnoDB);
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
	
	public boolean Exist(int idTurno) {
		Session session = conexion.abrirConexion();
	    session.beginTransaction();
	    
	    String hql = "FROM Turno t WHERE t.idTurno = :IDturno";
	    Query query = session.createQuery(hql);
	    query.setParameter("IDturno", idTurno);
	    Turno turno = (Turno) query.uniqueResult();
	    
	    session.getTransaction().commit();
	    session.close();
	    
	    return turno != null;
	}
}

