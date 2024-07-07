package frgp.utn.edu.ar.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
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
            int id_provincia,
            int id_localidad,
            Date fechaNac,
            String correo) {
        ModelAndView mv = new ModelAndView("pacientes");
        Paciente paciente = new Paciente();
        Provincia provincia = provinciaNegocio.ReadOneById(id_provincia);
        Localidad localidad = localidadNegocio.ReadOneById(id_localidad);
        int dniParsed = 0;
     
        // Parsear el DNI a int
        try {
            dniParsed = Integer.parseInt(dni);
        } catch (NumberFormatException e) {
            System.out.println("Error al parsear el DNI: " + e.getMessage());
            mv.addObject("errorMessage", "Error al parsear el DNI: " + e.getMessage());
            return mv;
        }
        try {
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
            boolean pacienteAgregado = pacienteNegocio.Add(paciente);

            if (pacienteAgregado) {
                mv.addObject("successMessage", "Paciente: " + dniParsed + " " + MENSAJE_AGREGADO);

                // Reiniciar el formulario
                mv.addObject("paciente", new Paciente());
            } else {
                mv.addObject("errorMessage", "No se pudo agregar el paciente.");
            }
        } catch (PacienteAlreadyExistsException e) {
            System.out.println("Error: " + e.getMessage());
            mv.addObject("errorMessage", e.getMessage());
        } catch (Exception e) {
            System.out.println("Error al guardar el paciente: " + e.getMessage());
            mv.addObject("errorMessage", "Error al guardar el paciente: " + e.getMessage());
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
            @RequestParam int idProvincia,
            @RequestParam int idLocalidad,
            @RequestParam Date fechaNac,
            @RequestParam String correo) {

        ModelAndView mv = new ModelAndView("listarPacientes");

        // Obtener paciente por DNI
        Paciente paciente = pacienteNegocio.ReadOne(dni);
        
        Provincia provincia = provinciaNegocio.ReadOneById(idProvincia);
        Localidad localidad = localidadNegocio.ReadOneById(idLocalidad);
        
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
