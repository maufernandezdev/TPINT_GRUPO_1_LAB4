package frgp.utn.edu.ar.daoImp;

import java.sql.Date;
import java.sql.Time;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public boolean existeTurnoParaMedicoFechaYHora(int medicoLegajo, Date fecha, Time hora) {
		conexion = new ConfigHibernate();
		Session session = null;

	    try {
			session = conexion.abrirConexion();
		    session.beginTransaction();
		    

	        String hql = "SELECT COUNT(*) FROM Turno t WHERE t.medico.legajo = :medicoLegajo AND t.fecha = :fecha AND t.hora = :hora";
	        Query query = session.createQuery(hql);
	        query.setParameter("medicoLegajo", medicoLegajo);
	        query.setParameter("fecha", fecha);
	        query.setParameter("hora", hora);

	        Long count = (Long) query.uniqueResult();

	        session.getTransaction().commit();

	        return count != null && count > 0;
	    } catch (Exception e) {
	        if (session != null && session.getTransaction() != null) {
	            session.getTransaction().rollback();
	        }
	        e.printStackTrace();
	        return false; 
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }
	}
	
	public List<Turno> getTurnosPorMedicoLegajo(int medicoLegajo) {
	    Session session = conexion.abrirConexion();
	    session.beginTransaction();

	    String hql = "FROM Turno t WHERE t.medico.legajo = :medicoLegajo";
	    Query query = session.createQuery(hql);
	    query.setParameter("medicoLegajo", medicoLegajo);

	    List<Turno> turnos = query.list();

	    session.getTransaction().commit();
	    session.close();

	    return turnos;
	}

    public Map<String, Long> ObtenerPresentesAusentesEntreFechas() {
    	conexion = new ConfigHibernate();
    	Session session = null;
    	try {
    		session = conexion.abrirConexion();
    		
    		Date fechaDeInicio = Date.valueOf("2024-01-01");
    		Date fechaFinal = Date.valueOf("2024-03-01");
    		
    		// Consulta para obtener la cantidad TOTAL de turnos en el rango de fechas SOLO CONTANDO LOS PRESENTES Y AUSENTES
    		Long cantidadTotal = (Long) session.createQuery(
    			    "SELECT COUNT(t) FROM Turno t WHERE t.fecha BETWEEN :startDate AND :endDate AND EstadoTurno IN (1, 2)")
    				.setParameter("startDate", fechaDeInicio)
                    .setParameter("endDate", fechaFinal)
    			    .uniqueResult();
    		
    		// Consulta para obtener la cantidad de TURNOS PRESENTES
    		Long cantidadPresentes = (Long) session.createQuery(
    				"SELECT COUNT(t.EstadoTurno) FROM Turno t WHERE t.EstadoTurno = 1 AND t.fecha BETWEEN :startDate AND :endDate")
    				.setParameter("startDate", fechaDeInicio)
                    .setParameter("endDate", fechaFinal)
    			    .uniqueResult();
    		
    		// Consulta para obtener la cantidad de TURNOS AUSENTES
    		Long cantidadAusentes = (Long) session.createQuery(
    				"SELECT COUNT(t.EstadoTurno) FROM Turno t WHERE t.EstadoTurno = 2 AND t.fecha BETWEEN :startDate AND :endDate") 
    				.setParameter("startDate", fechaDeInicio) 
    				.setParameter("endDate", fechaFinal) 
    				.uniqueResult();
    		
    		// Calcular porcentajes
    		double porcentajePresentes = 0;
    		double porcentajeAusentes = 0;
    		
    		if (cantidadTotal != null && cantidadTotal > 0) {
    			porcentajePresentes = (cantidadPresentes != null ? cantidadPresentes : 0) * 100.0 / cantidadTotal;
    			
    			porcentajeAusentes = (cantidadAusentes != null ? cantidadAusentes : 0) * 100.0 / cantidadTotal;
    		}
    		
            System.out.println("\nPorcentajes: ");
    		System.out.println("Cantidad Total: " + cantidadTotal);
    		System.out.println("Cantidad Presentes: " + cantidadPresentes);
    		System.out.println("Cantidad Ausentes: " + cantidadAusentes);
    		System.out.printf("Porcentaje Presentes: %.2f%%\n", porcentajePresentes);
    		System.out.printf("Porcentaje Presentes: %.2f%%\n", porcentajePresentes);
            long porcentajePresentesLong = (long) porcentajePresentes;
            long porcentajeAusentesLong = (long) porcentajeAusentes;
            Map<String, Long> result = new HashMap<>();
            result.put("cantidadTotal", cantidadTotal);
            result.put("cantidadPresentes", cantidadPresentes);
            result.put("cantidadAusentes", cantidadAusentes);
            result.put("porcentajePresentes", porcentajePresentesLong);
            result.put("porcentajePresentes", porcentajeAusentesLong);
            return result;
    	}
    	catch (Exception e) {
    		System.err.println("Error al obtener la cantidad de turnos: " + e);
        } finally {
        	if (session != null) {
	            session.close();
	        }
        }
		return null;        
    }
}

