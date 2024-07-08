package frgp.utn.edu.ar.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.entidad.Localidad;
import frgp.utn.edu.ar.entidad.Paciente;
import frgp.utn.edu.ar.entidad.Provincia;

import frgp.utn.edu.ar.exceptions.PacienteAlreadyExistsException;

import frgp.utn.edu.ar.negocioImp.LocalidadNegocio;
import frgp.utn.edu.ar.negocioImp.PacienteNegocio;
import frgp.utn.edu.ar.negocioImp.ProvinciaNegocio;

@Controller
public class PacienteController {
	private final static String MENSAJE_AGREGADO = "AGREGADO CORRECTAMENTE";
	private final static String MENSAJE_MODIFICADO = "MODIFICADO CORRECTAMENTE";
	private final static String MENSAJE_ELIMINADO = "ELIMINADO CORRECTAMENTE";
    private final static String MENSAJE_ERROR_ELIMINAR = "ERROR AL BORRAR PACIENTE";
	
    private ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
    private PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");
    private ProvinciaNegocio provinciaNegocio = (ProvinciaNegocio) appContext.getBean("beanProvinciaNegocio");
    private LocalidadNegocio localidadNegocio = (LocalidadNegocio) appContext.getBean("beanLocalidadNegocio");
	private Localidad localidadEncontrada = (Localidad) appContext.getBean("beanLocalidad");	
	
	
	
    @RequestMapping("/pacientes")
    public ModelAndView pacientes() {
    	
        ModelAndView mv = new ModelAndView();
        List<Provincia> provincias = provinciaNegocio.ReadAll();
        List<Localidad> localidades = localidadNegocio.ReadAll();
        
        mv.addObject("provincias", provincias);
        mv.addObject("localidades", localidades);
        mv.setViewName("pacientes");
        return mv;
    }
    
    @RequestMapping("listarPacientes.html")
    public ModelAndView listarPacientes() {
    	
        ModelAndView mv = new ModelAndView("listarPacientes");
        List<Paciente> pacientes = pacienteNegocio.listarPacientesActivos();
        mv.addObject("listaPacientes", pacientes);
        
        for (Paciente p1: pacientes) {
			System.out.println(p1.toString());
		}
        
        return mv;
    }
    
    @RequestMapping("listarPacientesActivos.html")
    public ModelAndView listarPacientesActivos() {
        
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
            Integer localidadId,
            Date fechaNac,
            String correo) {
        ModelAndView mv = new ModelAndView("pacientes");
        Paciente paciente = new Paciente();
        
        int dniParsed = 0; // Define dniParsed fuera del bloque try-catch
        
        try {
            dniParsed = Integer.parseInt(dni); // Asigna valor dentro del try-catch
        } catch (NumberFormatException e) {
            mv.addObject("errorMessage", "Error al parsear el DNI: " + e.getMessage());
            return mv;
        }
        
        
		localidadEncontrada = localidadNegocio.ReadOneById(localidadId);
		
		List<Provincia> provincias = provinciaNegocio.ReadAll();
		List<Localidad> localidades = localidadNegocio.ReadAll();
       
        try {
            paciente.setDni(dniParsed);
            paciente.setNombre(nombre);
            paciente.setApellido(apellido);
            paciente.setTelefono(telefono);
            paciente.setDireccion(direccion);
            paciente.setFechaNac(fechaNac);
           
            paciente.setLocalidad(localidadEncontrada);
            paciente.setCorreo(correo);
            paciente.setEstado(Paciente.Estado.ACTIVO);
            
            boolean pacienteAgregado = pacienteNegocio.Add(paciente);

            if (pacienteAgregado) {
                mv.addObject("successMessage", "Paciente: " + dniParsed + " " + MENSAJE_AGREGADO);
                mv.addObject("paciente", new Paciente()); // Reinicia el formulario
            } else {
                mv.addObject("errorMessage", "No se pudo agregar el paciente.");
            }
        } catch (PacienteAlreadyExistsException e) {
            mv.addObject("errorMessage", e.getMessage());
        } catch (Exception e) {
            mv.addObject("errorMessage", "Error al guardar el paciente: " + e.getMessage());
        }
        
        mv.addObject("provincias", provincias);
        mv.addObject("localidades", localidades);
      
        return mv;
    }
    
    
    @RequestMapping(value = "modificar_paciente.html", method = RequestMethod.POST)
    public ModelAndView modificarPaciente(
            @RequestParam int dni,
            @RequestParam String nombre,
            @RequestParam String apellido,
            @RequestParam String telefono,
            @RequestParam String direccion,
            @RequestParam(name = "provincia") int provincia,
            @RequestParam(name = "localidad") int localidad,
            @RequestParam Date fechaNac,
            @RequestParam String correo) {

        ModelAndView mv = new ModelAndView("listarPacientes");

        // Obtener paciente por DNI
        Paciente paciente = pacienteNegocio.ReadOne(dni);
        
       
        localidadEncontrada = localidadNegocio.ReadOneById(localidad);
        
        if (paciente != null) {
            paciente.setNombre(nombre);
            paciente.setApellido(apellido);
            paciente.setTelefono(telefono);
            paciente.setDireccion(direccion);
            
            paciente.setLocalidad(localidadEncontrada);
            paciente.setFechaNac(fechaNac);
            paciente.setCorreo(correo);

            // Actualizar paciente
            boolean actualizado = pacienteNegocio.Update(paciente);

            if (actualizado) {
                mv.addObject("successMessage", "Paciente: " + dni + " " + MENSAJE_MODIFICADO);
            } else {
                mv.addObject("errorMessage", "Error al modificar paciente con DNI: " + dni);
            }
        } else {
        	
            mv.addObject("errorMessage", "No se encontró paciente con DNI: " + dni);
        }
        List<Paciente> pacientes = pacienteNegocio.listarPacientesActivos();
        mv.addObject("listaPacientes", pacientes);
        for (Paciente p1 : pacientes) {
            System.out.println(p1.toString());
        }
        return mv;
    }
    
    
    @RequestMapping(value = "eliminar_paciente.html", method = RequestMethod.GET)
    public ModelAndView eliminarPaciente(@RequestParam int dni) {
        ModelAndView mv = new ModelAndView("listarPacientes");
        
        try {
            boolean eliminado = pacienteNegocio.Delete(dni);
            if (eliminado) {
            	
                mv.addObject("successMessage", "Paciente con DNI " + dni + " " + MENSAJE_ELIMINADO);
            } else {
            	
                mv.addObject("errorMessage", "Paciente con DNI " + dni + " " + MENSAJE_ERROR_ELIMINAR);
            }
        } catch (Exception e) {
            System.out.println("Error al borrar paciente: " + e.getMessage());
            mv.addObject("errorMessage", "Error al borrar paciente: " + e.getMessage());
        }
        List<Paciente> pacientes = pacienteNegocio.listarPacientesActivos();
        mv.addObject("listaPacientes", pacientes);
        for (Paciente p1 : pacientes) {
            System.out.println(p1.toString());
        }
        return mv;
     }
    
    @RequestMapping("listarPaciente_xDni.html")
    public ModelAndView listarMedico_xNombre(@RequestParam("txtBuscarPaciente_xDni") String dniStr) {
        
        ModelAndView mv = new ModelAndView("listarPacientes");
        
        if (dniStr != null && !dniStr.isEmpty()) {
            List<Paciente> pacientes = pacienteNegocio.Paciente_xDni(dniStr);    	        
            mv.addObject("listaPacientes", pacientes);
        } else {
            // Si no se puede parsear, carga la lista de pacientes vacía
            mv.addObject("listaPacientes", new ArrayList<Paciente>());
        }
        
        return mv;
    }
    
}

