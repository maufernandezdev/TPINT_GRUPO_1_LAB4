package frgp.utn.edu.ar.controller;
import java.time.LocalDate;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.entidad.Especialidad;
import frgp.utn.edu.ar.entidad.Medico;
import frgp.utn.edu.ar.entidad.Usuario;
import frgp.utn.edu.ar.negocioImp.EspecialidadNegocio;
import frgp.utn.edu.ar.negocioImp.MedicoNegocio;
import frgp.utn.edu.ar.negocioImp.UsuarioNegocio;

@Controller
public class MedicoController {
	
	private final static String MENSAJE_AGREGADO = "AGREGADO CORRECTAMENTE";
	private final static String MENSAJE_YA_EXISTE = "YA EXISTE EN LA BASE DE DATOS";
	
	@RequestMapping("/medicos")
    public ModelAndView medicos() {
		ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
		EspecialidadNegocio especialidadNegocio = (EspecialidadNegocio) appContext.getBean("beanEspecialidadNegocio");
        ModelAndView mv = new ModelAndView();
        List<Especialidad> especialidades = especialidadNegocio.ReadAll();
        mv.addObject("especialidades", especialidades);
        mv.setViewName("medicos");
        return mv;
    }
	
	 @RequestMapping("guardar_medico.html")
	    public ModelAndView guardarMedico(
	    		String nombre, 
	    		String apellido,
	    		String sexo, 
	    		String fechaDeNac,
	    		String direccion,
	    		String localidad,
	    		String correo,
	    		String telefono,
	    		String usuario,
	    		String contrasenia,
	    		Integer especialidad) {
	        ModelAndView mv = new ModelAndView();
	        boolean estado = false;
		 	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
	        UsuarioNegocio usuarioNegocio = (UsuarioNegocio) appContext.getBean("beanUsuarioNegocio");
			Usuario nuevoUsuario = (Usuario) appContext.getBean("beanUsuario");
			MedicoNegocio medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");
			Medico nuevoMedico = (Medico) appContext.getBean("beanMedico");	
			EspecialidadNegocio especialidadNegocio = (EspecialidadNegocio) appContext.getBean("beanEspecialidadNegocio");
			List<Especialidad> especialidades = especialidadNegocio.ReadAll();
			int idBuscado = especialidad; 
			Especialidad especialidadEncontrada = null;
			for (Especialidad item : especialidades) {
			    if (item.getId() == idBuscado) {
			        especialidadEncontrada = item;
			        break;
			    }
			}
			estado = medicoNegocio.Exist(usuario);
		     if(estado == false){
		    	 nuevoUsuario.setNombreUser(usuario);
				 nuevoUsuario.setContrasenia(contrasenia);
				 usuarioNegocio.Add(nuevoUsuario);
				 nuevoMedico.setMedicoDetails(nombre,apellido,sexo,LocalDate.parse(fechaDeNac),direccion,localidad,correo,telefono,nuevoUsuario,especialidadEncontrada);
		    	 medicoNegocio.Add(nuevoMedico);
		 	     System.out.println(MENSAJE_AGREGADO);	 
		     }
		     else {
		    	 System.out.println(MENSAJE_YA_EXISTE);
		     }
	        mv.setViewName("medicos");
	        return mv;
	 } 
	    
	    /*@RequestMapping("listarMedicos.html")
	    public ModelAndView listarPacientes() {
	    	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
			PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");
	        ModelAndView mv = new ModelAndView("pacientes");
	        List<Paciente> pacientes = pacienteNegocio.ReadAll();
	        mv.addObject("pacientes", pacientes);
	        return mv;
	    }*/
}
