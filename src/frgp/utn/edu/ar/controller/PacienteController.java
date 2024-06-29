package frgp.utn.edu.ar.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.entidad.Medico;
import frgp.utn.edu.ar.entidad.Paciente;
import frgp.utn.edu.ar.negocioImp.PacienteNegocio;

@Controller
public class PacienteController {
	private final static String MENSAJE_AGREGADO = "AGREGADO CORRECTAMENTE";
	private final static String MENSAJE_YA_EXISTE = "YA EXISTE EN LA BASE DE DATOS";
	private final static String MENSAJE_MODIFICADO = "MODIFICADO CORRECTAMENTE";
	
	
    @RequestMapping("/pacientes")
    public ModelAndView pacientes() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("pacientes");
        return mv;
    }
    
    @RequestMapping("listarPacientes.html")
    public ModelAndView listarPacientes() {
    	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
		PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");
        ModelAndView mv = new ModelAndView("listarPacientes");
        List<Paciente> pacientes = pacienteNegocio.ReadAll();
        mv.addObject("listaPacientes", pacientes);
        
        for (Paciente p1: pacientes) {
			System.out.println(p1.toString());
		}
        
        return mv;
    }
    
    @RequestMapping("listarPacientesActivos.html")
    public ModelAndView listarPacientesActivos() {
        ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
        PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");
        ModelAndView mv = new ModelAndView("listarPacientes");
        List<Paciente> pacientes = pacienteNegocio.listarPacientesActivos();
        mv.addObject("listaPacientes", pacientes);

        for (Paciente p1 : pacientes) {
            System.out.println(p1.toString());
        }

        return mv;
    }
    
    @RequestMapping("guardar_paciente.html")
    public ModelAndView guardarPaciente(
            String dni,
            String nombre,
            String apellido,
            String telefono,
            String direccion,
            String provincia,
            String localidad,
            Date fechaNac,
            String correo) {   	
    	ModelAndView mv = new ModelAndView();	 
    	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
		PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");
		Paciente paciente = (Paciente) appContext.getBean("beanPaciente");
		boolean yaExiste = false;
		int dniParsed = 0;			
	    // Parsear el DNI a int
	    try {
	        dniParsed = Integer.parseInt(dni);
	    } catch (NumberFormatException e) {
	        System.out.println("Error al parsear el DNI: " + e.getMessage());
	        mv.setViewName("redirect:/listarPacientes.html");
	        mv.addObject("errorMessage", "Error al parsear el DNI: " + e.getMessage());
	        return mv;
	    }    
	    yaExiste = pacienteNegocio.Exist(dniParsed);
	    
	    if (!yaExiste) {
	        paciente.setDni(dniParsed);
	        paciente.setNombre(nombre);
	        paciente.setApellido(apellido);
	        paciente.setTelefono(telefono);
	        paciente.setDireccion(direccion);
	        paciente.setFechaNac(fechaNac);
	        paciente.setProvincia(provincia);
	        paciente.setLocalidad(localidad);
	        paciente.setCorreo(correo);
	        paciente.setEstado(Paciente.Estado.ACTIVO);
	        
	        pacienteNegocio.Add(paciente);
	        
	        mv.setViewName("redirect:/listarPacientes.html");
	        mv.addObject("successMessage", "Paciente: " + dniParsed + MENSAJE_AGREGADO);

	    } else {
	        System.out.println("Paciente: " + dniParsed + MENSAJE_YA_EXISTE);
	        mv.setViewName("redirect:/listarPacientes.html");
	        mv.addObject("errorMessage", "Paciente: " + dniParsed + MENSAJE_YA_EXISTE);
	    }

	    return mv;
    }
    
    
    @RequestMapping(value = "modificar_paciente.html", method = RequestMethod.POST)
    public ModelAndView modificarPaciente(
            @RequestParam int dni,
            @RequestParam String nombre,
            @RequestParam String apellido,
            @RequestParam String telefono,
            @RequestParam String direccion,
            @RequestParam String provincia,
            @RequestParam String localidad,
            @RequestParam Date fechaNac,
            @RequestParam String correo) {

        ModelAndView mv = new ModelAndView();
        ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
        PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");

        // Obtener paciente por DNI
        Paciente paciente = pacienteNegocio.ReadOne(dni);

        if (paciente != null) {
            paciente.setNombre(nombre);
            paciente.setApellido(apellido);
            paciente.setTelefono(telefono);
            paciente.setDireccion(direccion);
            paciente.setProvincia(provincia);
            paciente.setLocalidad(localidad);
            paciente.setFechaNac(fechaNac);
            paciente.setCorreo(correo);

            // Actualizar paciente
            boolean actualizado = pacienteNegocio.Update(paciente);

            if (actualizado) {
                mv.setViewName("redirect:/listarPacientes.html"); 
                mv.addObject("successMessage", "Paciente: " + dni + " " + MENSAJE_MODIFICADO);
            } else {
                mv.setViewName("redirect:/listarPacientes.html");
                mv.addObject("errorMessage", "Error al modificar paciente con DNI: " + dni);
            }
        } else {
            mv.setViewName("redirect:/listarPacientes.html");
            mv.addObject("errorMessage", "No se encontró paciente con DNI: " + dni);
        }

        return mv;
    }
    
    
    @RequestMapping(value = "eliminar_paciente.html", method = RequestMethod.GET)
    public ModelAndView eliminarPaciente(@RequestParam int dni) {

        ModelAndView mv = new ModelAndView();
        ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
        PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");

        // Obtener paciente por DNI
        Paciente paciente = pacienteNegocio.ReadOne(dni);

        
        try {
        	boolean eliminado = pacienteNegocio.Delete(dni);
        	if (eliminado) {
        		mv.setViewName("redirect:/listarPacientes.html");
        		mv.addObject("successMessage", "Paciente con DNI " + dni + " eliminado correctamente");
        	} else {
        		mv.setViewName("redirect:/listarPacientes.html");	
        		mv.addObject("errorMessage","Error al borrar paciente: " + dni );
        	}
	    } catch (Exception e) {
	    	System.out.println("Error al borrar paciente: " + e.getMessage());
	        mv.setViewName("redirect:/listarPacientes.html");
	        mv.addObject("errorMessage", "Error al parsear el DNI: " + e.getMessage());
	    } 
        return mv;
    }
    
}
