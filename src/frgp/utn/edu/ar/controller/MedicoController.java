package frgp.utn.edu.ar.controller;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
public class MedicoController {
	
	private final static String MENSAJE_AGREGADO = "AGREGADO CORRECTAMENTE";
	private final static String MENSAJE_YA_EXISTE = "YA EXISTE EN LA BASE DE DATOS";
	private final static String MENSAJE_MODIFICADO = "MODIFICADO CORRECTAMENTE";
	private final static String MENSAJE_ELIMINADO = "ELIMINADO CORRECTAMENTE";
	
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
	 
	 @RequestMapping("listarMedicos.html")
	    public ModelAndView listarMedicos() {
	    	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
	    	MedicoNegocio medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");
	        ModelAndView mv = new ModelAndView("listarMedicos");
	        List<Medico> medicos = medicoNegocio.ReadAll();
	        mv.addObject("listaMedicos", medicos);
	        
	        for (Medico p1: medicos) {
				System.out.println(p1.toString());
			}
	        
	        return mv;
	    }
	    
	 @RequestMapping(value = "modificar_medico.html", method = RequestMethod.POST)
	    public ModelAndView modificarMedico(
	            @RequestParam int legajo,
	            @RequestParam String nombre,
	            @RequestParam String apellido,
	            @RequestParam String correo,
	            @RequestParam String telefono,
	            @RequestParam String direccion,
	            @RequestParam String localidad
	            ) {
		 	System.out.println("legajo: " + legajo);
		 	System.out.println("nombre: " + nombre);
		 	System.out.println("apellido: " + apellido);
		 	System.out.println("correo: " + correo);
		 	System.out.println("telefono: " + telefono);
		 	System.out.println("direccion: " + direccion);
		 	System.out.println("localidad: " + localidad);
		 	
	        ModelAndView mv = new ModelAndView();
	        ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
	        MedicoNegocio medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");

	        Medico medico = medicoNegocio.ReadOneById(legajo);

	        if (medico != null) {
	        	medico.setNombre(nombre);
	        	medico.setApellido(apellido);
	        	medico.setTelefono(telefono);
	        	medico.setDireccion(direccion);
	        	medico.setLocalidad(localidad);
	        	/*medico.setFechaNac(fechaNac);*/
	        	medico.setCorreo(correo);

	            boolean actualizado = medicoNegocio.Update(medico);

	            if (actualizado) {
	                mv.setViewName("medicos");
	                mv.addObject("successMessage", "Medico: " + legajo + " " + MENSAJE_MODIFICADO);
	            } else {
	                mv.setViewName("medicos");
	                mv.addObject("errorMessage", "Error al modificar medico con legajo: " + legajo);
	            }
	        } else {
	            mv.setViewName("medicos");
	            mv.addObject("errorMessage", "No se encontró medico con legajo: " + legajo);
	        }

	        return mv;
	    }
	 
	 
	 @RequestMapping(value = "eliminar_medico.html", method = RequestMethod.GET)
	    public ModelAndView eliminarMedico(@RequestParam int legajo) {
		 	System.out.println("legajo: " + legajo);

	        ModelAndView mv = new ModelAndView();
	        ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
	        MedicoNegocio medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");

	        Medico medico = medicoNegocio.ReadOneById(legajo);

	        try {
	        	if (medico != null) {
	        		medicoNegocio.Delete(legajo);

	        	}
		    } catch (Exception e) {
		        System.out.println("Error al eliminar medico: " + e.getMessage());

		        mv.setViewName("redirect:/listarMedicos.html");
		        mv.addObject("errorMessage", "Error al parsear el LEGAJO: " + e.getMessage());
		        return mv;
		    } 
	        
	        
	        mv.setViewName("redirect:/listarMedicos.html");
	        mv.addObject("successMessage", "Medico con LEGAJO " + legajo + " eliminado correctamente");
	        return mv;
	    }
	 
	 
/*	 @RequestMapping("listarTurnos.html")
	    public ModelAndView listarTurnos() {
	    	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
	    	TurnoNegocio turnoNegocio = (TurnoNegocio) appContext.getBean("beanTurnoNegocio");
	        ModelAndView mv = new ModelAndView("listarTurnos");
	        List<Turno> turnos = turnoNegocio.ReadAll();
	        
	        mv.addObject("listaTurnos", turnos);
	        
	        for (Turno t1: turnos) {
				System.out.println(t1.toString());
			}
	        
	        return mv;
	    }*/
	 
	 
}
