package frgp.utn.edu.ar.controller;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.entidad.Especialidad;
import frgp.utn.edu.ar.entidad.Medico;
import frgp.utn.edu.ar.entidad.Medico.Estado;
import frgp.utn.edu.ar.entidad.Paciente;
import frgp.utn.edu.ar.entidad.Turno;
import frgp.utn.edu.ar.entidad.Usuario;
import frgp.utn.edu.ar.negocioImp.EspecialidadNegocio;
import frgp.utn.edu.ar.negocioImp.MedicoNegocio;
import frgp.utn.edu.ar.negocioImp.PacienteNegocio;
import frgp.utn.edu.ar.negocioImp.TurnoNegocio;
import frgp.utn.edu.ar.negocioImp.UsuarioNegocio;

@Controller
public class TurnoController {
	
	private final static String MENSAJE_AGREGADO = "AGREGADO CORRECTAMENTE";
	private final static String MENSAJE_YA_EXISTE = "YA EXISTE EN LA BASE DE DATOS";
	private final static String MENSAJE_MODIFICADO = "MODIFICADO CORRECTAMENTE";
	private final static String MENSAJE_ELIMINADO = "ELIMINADO CORRECTAMENTE";

	@RequestMapping("/turnos")
    public ModelAndView medicos() {
    	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
		PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");
		MedicoNegocio medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");
	    EspecialidadNegocio especialidadNegocio = (EspecialidadNegocio) appContext.getBean("beanEspecialidadNegocio");

		ModelAndView mv = new ModelAndView("asignacionTurnos");	
		
        List<Paciente> pacientes = pacienteNegocio.ReadAll();
        List<Medico> medicos = medicoNegocio.ReadAll();
        List<Especialidad> especialidades = especialidadNegocio.ReadAll();
        
        mv.addObject("medicos", medicos);
        mv.addObject("pacientes", pacientes);
        mv.addObject("especialidades", especialidades);	        
        
        return mv;
    }
	
	 @RequestMapping("guardar_turno.html")
	    public ModelAndView asignarTurno(
	    		 	@RequestParam("medico") int medicoLegajo,
	    	        @RequestParam("paciente") int pacienteDni,
	    	        @RequestParam("fecha") Date fecha,
	    	        @RequestParam("horario") String horaString
	    		) {
			String horaCompletaStr = horaString + ":00";
	        ModelAndView mv = new ModelAndView();
		 	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
			MedicoNegocio medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");
			PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");
			TurnoNegocio turnoNegocio = (TurnoNegocio) appContext.getBean("beanTurnoNegocio");			
			Turno turno = (Turno) appContext.getBean("beanTurno");
			Medico medico = (Medico) appContext.getBean("beanMedico");	
			Paciente paciente = (Paciente) appContext.getBean("beanPaciente");	
			boolean existeTurno = false;		
			List<Turno> listaTurnosCheck = null;
			listaTurnosCheck = turnoNegocio.ReadAll();
			//parse de hora
         Time hora = Time.valueOf(horaCompletaStr); // HH:mm:ss
         
			medico = medicoNegocio.ReadOneById(medicoLegajo);
			paciente = pacienteNegocio.ReadOne(pacienteDni);


			existeTurno = turnoNegocio.existeTurnoParaMedicoFechaYHora(medicoLegajo, fecha, hora);
         
			if (existeTurno) {
             mv.addObject("errorMessage", "El médico ya tiene un turno asignado en esa fecha y hora.");
             mv.setViewName("asignacionTurnos");
             return mv;				
			}
         
			turno.setTurnoDetails(medico, paciente, fecha, hora, "", "PENDIENTE");
			turnoNegocio.Add(turno);
			
	        mv.addObject("successMessage", "El turno ha sido agregado correctamente");
	        mv.setViewName("asignacionTurnos");
	        
	        return mv;
	 	}
	 
	 @RequestMapping("listarTurnos.html")
	    public ModelAndView listarTurnos(HttpSession session) {
	    	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
	    	TurnoNegocio turnoNegocio = (TurnoNegocio) appContext.getBean("beanTurnoNegocio");
			UsuarioNegocio usuarioNegocio = (UsuarioNegocio) appContext.getBean("beanUsuarioNegocio");	
			MedicoNegocio medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");	
			Medico medico = (Medico) appContext.getBean("beanMedico");
			Usuario usuario = (Usuario) appContext.getBean("beanUsuario");	
	    	String user = (String) session.getAttribute("user");
	    	List<Turno> listaTurnos = null;
	    			    	 
	    	ModelAndView mv = new ModelAndView("listarTurnos");
	        List<Turno> turnos = turnoNegocio.ReadAll();	        

	        mv.addObject("listaTurnos", turnos);
	        
	        return mv;
	    }
	 
	 
	 @RequestMapping("listarTurnosAsignados.html")
	    public ModelAndView listarTurnosAsignados(HttpSession session) {
	    	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
	    	TurnoNegocio turnoNegocio = (TurnoNegocio) appContext.getBean("beanTurnoNegocio");
			UsuarioNegocio usuarioNegocio = (UsuarioNegocio) appContext.getBean("beanUsuarioNegocio");	
			MedicoNegocio medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");	
			Medico medico = (Medico) appContext.getBean("beanMedico");
			Usuario usuario= (Usuario) appContext.getBean("beanUsuario");	
	    	String user = (String) session.getAttribute("user");
	    	List<Turno> listaTurnos = null;
	    	
	    	if (user != null) {
	    	    	medico = medicoNegocio.getMedicoByUser(user);  
	    	    	listaTurnos = turnoNegocio.getTurnosPorMedicoLegajo(medico.getLegajo());
	    	 }
	    		    	 
	    	ModelAndView mv = new ModelAndView("listarTurnos");
		     //   List<Turno> turnos = turnoNegocio.ReadAll();
	        
	        // filtro no null
	        List<Turno> turnosLista = listaTurnos.stream()
	                                          .filter(turno -> turno != null)
	                                          .collect(Collectors.toList());

	        mv.addObject("listaTurnos", turnosLista);
	        
	        return mv;
	    }
	 
	 
	 @RequestMapping(value = "marcarPresente.html", method = RequestMethod.POST)
	 public ModelAndView marcarPresente(@RequestParam("idTurno") int idTurno, 
	                                    @RequestParam("observaciones") String observaciones) {
	     ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
	     TurnoNegocio turnoNegocio = (TurnoNegocio) appContext.getBean("beanTurnoNegocio");
		 Turno turno = (Turno) appContext.getBean("beanTurno");

	     ModelAndView mv = new ModelAndView("redirect:listarTurnos.html");

	     turno = turnoNegocio.ReadOne(idTurno);
	     
	     turno.setObservacion(observaciones);
	     turno.setEstadoTurno("PRESENTE");
	     turnoNegocio.Update(turno);
	     

	     return mv;
	 }
	 
	 @RequestMapping(value = "marcarAusente.html", method = RequestMethod.POST)
	 public ModelAndView marcarAusente(@RequestParam("idTurno") int idTurno) {
	     ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
	     TurnoNegocio turnoNegocio = (TurnoNegocio) appContext.getBean("beanTurnoNegocio");

	     ModelAndView mv = new ModelAndView("redirect:listarTurnos.html");

	     Turno turno = turnoNegocio.ReadOne(idTurno);
	     turno.setEstadoTurno("AUSENTE");
	     turnoNegocio.Update(turno);
	     
	     return mv;
	 }
}
