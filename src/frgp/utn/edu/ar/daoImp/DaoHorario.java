package frgp.utn.edu.ar.daoImp;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONObject;

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

	
	//Agregar horario por médico y horarios
	public boolean Add(Medico medico, List<Horario> horariosList) {
	    boolean estado = true;
	    ConfigHibernate conexion = new ConfigHibernate();
	    Session session = null;
	    System.out.println("ENTRE AL DAO HORARIO ADD");
        
	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        
	        for (Horario horario : horariosList) {
	            // Asignar el medico a cada horario
	        	 System.out.println("ENTRÉ AL FOR DE HORARIO MEDICO:");
	        	 
	            horario.setMedico(medico);
	            session.save(horario);
	        }
	        
	        session.flush();
	        session.getTransaction().commit();
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

	public List<Horario> getList (JSONArray horariosList){
		
		List<Horario> listaHorarios = new ArrayList<>();
		 // Procesar cada objeto de 'horarios' para pasarlo al formato que corresponde
        for (int i = 0; i < horariosList.length(); i++) {
            JSONObject horarioJson = horariosList.getJSONObject(i);
            String dia = horarioJson.getString("dia");
            String horaInicio = horarioJson.getString("horaInicio");
            String horaFin = horarioJson.getString("horaFin");

            // datos
            System.out.println("Horario recibido: dia=" + dia + ", horaInicio=" + horaInicio + ", horaFin=" + horaFin);
        
            // Convertir strings de hora a Time
            Time horaInicioH = Time.valueOf(horaInicio + ":00");
            Time horaFinH = Time.valueOf(horaFin + ":00");

            // Creo objeto Horario para dps guardarlo con medico
            Horario horario = new Horario();
            horario.setDia(dia);
            horario.setHoraInicio(horaInicioH);
            horario.setHoraFin(horaFinH);


            // Agrego a la lista
            listaHorarios.add(horario);		            
        }
        return listaHorarios;
	}
    
/*    public boolean Add(Horario horario) {
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
    }*/
    
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