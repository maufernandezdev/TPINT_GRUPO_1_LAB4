package frgp.utn.edu.ar.controller;

import java.sql.Date;
import java.sql.Time;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.entidad.Especialidad;
import frgp.utn.edu.ar.entidad.Horario;
import frgp.utn.edu.ar.entidad.Medico;
import frgp.utn.edu.ar.entidad.Paciente;
import frgp.utn.edu.ar.entidad.Turno;
import frgp.utn.edu.ar.entidad.Usuario;
import frgp.utn.edu.ar.negocioImp.EspecialidadNegocio;
import frgp.utn.edu.ar.negocioImp.HorarioNegocio;
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
	
	private PacienteNegocio pacienteNegocio;
	private MedicoNegocio medicoNegocio;
	private EspecialidadNegocio especialidadNegocio;
	private TurnoNegocio turnoNegocio;
	private UsuarioNegocio usuarioNegocio;
	private Usuario nuevoUsuario;
	private HorarioNegocio horarioNegocio;
	private Turno nuevoTurno;
	private Medico nuevoMedico;
	private Paciente nuevoPaciente;
	

	@PostConstruct
	public void init() {
		ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
        this.pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");
        this.medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");
        this.especialidadNegocio = (EspecialidadNegocio) appContext.getBean("beanEspecialidadNegocio");
        this.turnoNegocio = (TurnoNegocio) appContext.getBean("beanTurnoNegocio");
        this.usuarioNegocio = (UsuarioNegocio) appContext.getBean("beanUsuarioNegocio");
        this.nuevoUsuario = (Usuario) appContext.getBean("beanUsuario");
        this.horarioNegocio = (HorarioNegocio) appContext.getBean("beanHorarioNegocio");
		this.nuevoMedico = (Medico) appContext.getBean("beanMedico");
		this.nuevoTurno = (Turno) appContext.getBean("beanTurno");
        this.nuevoPaciente = (Paciente) appContext.getBean("beanPaciente");
	}

	@RequestMapping("/turnos")
    public ModelAndView medicos() {
		ModelAndView mv = new ModelAndView("asignacionTurnos");	
        List<Paciente> pacientes = pacienteNegocio.ReadAll();
        List<Medico> medicos = medicoNegocio.ReadAll();
        List<Especialidad> especialidades = especialidadNegocio.ReadAll();
        List<Turno> turnos = turnoNegocio.ReadAll();
        List<Horario> horarios = horarioNegocio.ReadAll();
        
        mv.addObject("medicos", medicos);
        mv.addObject("pacientes", pacientes);
        mv.addObject("especialidades", especialidades);
        mv.addObject("turnos", turnos);
        mv.addObject("horarios", horarios);
        
        return mv;
    }
	
	 @RequestMapping("guardar_turno.html")
	    public ModelAndView asignarTurno(
	    		 	@RequestParam("medico") int medicoLegajo,
	    	        @RequestParam("paciente") int pacienteDni,
	    	        @RequestParam("fecha") Date fecha,
	    	        @RequestParam("horario") String horaString
	    		) {
		 	
	        ModelAndView mv = new ModelAndView();
		 	
			boolean existeTurno = false;		

			Time hora = Time.valueOf(horaString);
	        List<Paciente> pacientes = pacienteNegocio.ReadAll();
	        List<Medico> medicos = medicoNegocio.ReadAll();
	        List<Especialidad> especialidades = especialidadNegocio.ReadAll();
	        List<Turno> turnos = turnoNegocio.ReadAll();
	        List<Horario> horarios = horarioNegocio.ReadAll();
	        
			nuevoMedico = medicoNegocio.ReadOneById(medicoLegajo);
			nuevoPaciente = pacienteNegocio.ReadOne(pacienteDni);

			existeTurno = turnoNegocio.existeTurnoParaMedicoFechaYHora(medicoLegajo, fecha, hora);
         
			if (existeTurno) {
	             mv.addObject("errorMessage", "El médico ya tiene un turno asignado en esa fecha y hora.");
	 	         mv.addObject("medicos", medicos);
		         mv.addObject("pacientes", pacientes);
		         mv.addObject("especialidades", especialidades);
		         mv.addObject("turnos", turnos);
		         mv.addObject("horarios", horarios);
	             mv.setViewName("asignacionTurnos");
	             return mv;				
			}
         
			nuevoTurno.setTurnoDetails(nuevoMedico, nuevoPaciente, fecha, hora, "", "PENDIENTE");
			turnoNegocio.Add(nuevoTurno);
			
	        mv.addObject("successMessage", "El turno ha sido agregado correctamente");
	        mv.addObject("medicos", medicos);
	        mv.addObject("pacientes", pacientes);
	        mv.addObject("especialidades", especialidades);
	        mv.addObject("turnos", turnos);
	        mv.addObject("horarios", horarios);
	        
	        mv.setViewName("asignacionTurnos");

	        return mv;
	 	}
	 
	 @RequestMapping("listarTurnos.html")
	    public ModelAndView listarTurnos(HttpSession session) {
	    	
	    	String user = (String) session.getAttribute("user");
	    	
	    	List<Medico> listaMedicos = medicoNegocio.ReadAll();
	    	List<Especialidad> listaEspecialidades = especialidadNegocio.ReadAll();
	    			    	 
	    	ModelAndView mv = new ModelAndView("listarTurnos");
	        List<Turno> turnos = turnoNegocio.ReadAll();	        

	        mv.addObject("listaTurnos", turnos);
	        mv.addObject("medicos",listaMedicos);
	        mv.addObject("especialidades",listaEspecialidades);
	        
	        return mv;
	    }
	 
	 
	  @RequestMapping("listarTurno_xDni.html")
	    public ModelAndView listarTurno_xDni(int txtBuscarTurno_xDni) {
	    	   	
	    	List<Turno> listaTurnos = turnoNegocio.Turno_xDni(txtBuscarTurno_xDni);
	    	
	    	//se cargan los medicos para el filtro de buscar
			List<Medico> listaMedicos = medicoNegocio.ReadAll();
	    	
	        ModelAndView mv = new ModelAndView("listarTurnos");	        
	        mv.addObject("listaTurnos",listaTurnos);
	        mv.addObject("medicos", listaMedicos);	       
	        
	        return mv;
	    }
	 
	 
	 
	  @RequestMapping("filtrarTurnos_xMedico.html")
	  public ModelAndView filtrarTurnos_xMedico(@RequestParam("ddl_medico") String idMedico) {
		  
		  List<Turno> listaTurnos = turnoNegocio.filtrarTurnos_xMedicos(idMedico);		  
		  
		  //se cargan los medicos para los filtros	  
		  List<Medico> listaMedicos = medicoNegocio.ReadAll();
		  
		  ModelAndView mv = new ModelAndView("listarTurnos");		  
		  mv.addObject("listaTurnos", listaTurnos);
		  mv.addObject("medicos", listaMedicos);
		  
		  return mv;
	  }
	  
	  
	  @RequestMapping("filtrarTurnos_xEstadoTurno.html")
	  public ModelAndView filtrarTurnos_xEstadoTurno(@RequestParam("ddl_EstadoTurno") String estadoTurno) {
		  
		  List<Turno> listaTurnos = turnoNegocio.filtrarTurnos_xEstado(estadoTurno);
		  
		  //se cargan los medicos para los filtros
		  List<Medico> listaMedicos = medicoNegocio.ReadAll();
		  
		  ModelAndView mv = new ModelAndView("listarTurnos");		  
		  mv.addObject("listaTurnos", listaTurnos);
		  mv.addObject("medicos", listaMedicos);
		  		  
		  return mv;
	  }
	  
	  
	 @RequestMapping("listarTurnosAsignados.html")
	    public ModelAndView listarTurnosAsignados(HttpSession session) {
	    	
	    	String user = (String) session.getAttribute("user");
	    	List<Turno> listaTurnos = null;
	    	
	    	if (user != null) {
	    	    	nuevoMedico = medicoNegocio.getMedicoByUser(user);  
	    	    	listaTurnos = turnoNegocio.getTurnosPorMedicoLegajo(nuevoMedico.getLegajo());
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
	     
	     ModelAndView mv = new ModelAndView("redirect:listarTurnos.html");

	     nuevoTurno = turnoNegocio.ReadOne(idTurno);
	     
	     nuevoTurno.setObservacion(observaciones);
	     nuevoTurno.setEstadoTurno("PRESENTE");
	     turnoNegocio.Update(nuevoTurno);
	     

	     return mv;
	 }
	 
	 @RequestMapping(value = "marcarAusente.html", method = RequestMethod.POST)
	 public ModelAndView marcarAusente(@RequestParam("idTurno") int idTurno,
			 							@RequestParam("observacionesAusente") String observacionesAusente) {
	    
	     ModelAndView mv = new ModelAndView("redirect:listarTurnos.html");

	     nuevoTurno = turnoNegocio.ReadOne(idTurno);
	     nuevoTurno.setObservacion(observacionesAusente);
	     nuevoTurno.setEstadoTurno("AUSENTE");
	     turnoNegocio.Update(nuevoTurno);
	     
	     return mv;
	 }
}
