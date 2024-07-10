package frgp.utn.edu.ar.controller;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.util.MultiValueMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.entidad.Especialidad;
import frgp.utn.edu.ar.entidad.Horario;
import frgp.utn.edu.ar.entidad.Localidad;
import frgp.utn.edu.ar.entidad.Medico;
import frgp.utn.edu.ar.entidad.Provincia;
import frgp.utn.edu.ar.entidad.Usuario;
import frgp.utn.edu.ar.negocioImp.EspecialidadNegocio;
import frgp.utn.edu.ar.negocioImp.HorarioNegocio;
import frgp.utn.edu.ar.negocioImp.LocalidadNegocio;
import frgp.utn.edu.ar.negocioImp.MedicoNegocio;
import frgp.utn.edu.ar.negocioImp.ProvinciaNegocio;
import frgp.utn.edu.ar.negocioImp.UsuarioNegocio;

@Controller
public class MedicoController {
	
	private final static String MENSAJE_AGREGADO = "AGREGADO CORRECTAMENTE";
	private final static String MENSAJE_YA_EXISTE = "YA EXISTE EN LA BASE DE DATOS";
	private final static String MENSAJE_MODIFICADO = "MODIFICADO CORRECTAMENTE";
	private final static String MENSAJE_ELIMINADO = "ELIMINADO CORRECTAMENTE";
	private final static String MENSAJE_ERROR_ELIMINAR = "ERROR AL BORRAR PACIENTE";

	private MedicoNegocio medicoNegocio;
	private Medico nuevoMedico;
	private UsuarioNegocio usuarioNegocio;
	private Usuario nuevoUsuario;
	private EspecialidadNegocio especialidadNegocio;
	private Especialidad especialidadEncontrada;
	private ProvinciaNegocio provinciaNegocio;
	private LocalidadNegocio localidadNegocio;
	private Localidad localidadEncontrada;
	private HorarioNegocio horarioNegocio;
	
	@PostConstruct
	public void init() {
		ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
		this.medicoNegocio = (MedicoNegocio) appContext.getBean("beanMedicoNegocio");
		this.nuevoMedico = (Medico) appContext.getBean("beanMedico");
		this.usuarioNegocio = (UsuarioNegocio) appContext.getBean("beanUsuarioNegocio");
		this.nuevoUsuario = (Usuario) appContext.getBean("beanUsuario");
		this.especialidadNegocio = (EspecialidadNegocio) appContext.getBean("beanEspecialidadNegocio");
		this.especialidadEncontrada = (Especialidad) appContext.getBean("beanEspecialidad");
		this.provinciaNegocio = (ProvinciaNegocio) appContext.getBean("beanProvinciaNegocio");
		this.localidadNegocio = (LocalidadNegocio) appContext.getBean("beanLocalidadNegocio");
		this.localidadEncontrada = (Localidad) appContext.getBean("beanLocalidad");
		this.horarioNegocio = (HorarioNegocio) appContext.getBean("beanHorarioNegocio");
	}
	
	
	@RequestMapping("/medicos")
    public ModelAndView medicos() {
		
        ModelAndView mv = new ModelAndView();
        List<Especialidad> especialidades = especialidadNegocio.ReadAll();
        List<Provincia> provincias = provinciaNegocio.ReadAll();
        List<Localidad> localidades = localidadNegocio.ReadAll();        
        List<String> diasSemana = Arrays.asList("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo");
        List<String> minutos = Arrays.asList("00", "30");
        
        mv.addObject("diasSemana", diasSemana);
        mv.addObject("minutos", minutos);
        mv.addObject("especialidades", especialidades);
        mv.addObject("provincias", provincias);
        mv.addObject("localidades", localidades);
        mv.setViewName("medicos");
        return mv;
    }
	
	 @RequestMapping("guardar_medico.html")
	    public ModelAndView guardarMedico(
	    		String nombre, 
	    		String apellido,
	    		String sexo, 
	    		Date fechaDeNac,
	    		String direccion,
	    		Integer localidadId, // Cambiado a Integer para recibir el id de la localidad
	    		String correo,
	    		String telefono,
	    		String usuario,
	    		String contrasenia,
	    		Integer especialidad,
	    		@RequestBody MultiValueMap<String, String> formData	 ) { // para tomar los multiples valores json
		 	ModelAndView mv = new ModelAndView();
	        boolean estado = false;
		 	
			localidadEncontrada = localidadNegocio.ReadOneById(localidadId);
	        List<String> diasSemana = Arrays.asList("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo");
	        List<String> minutos = Arrays.asList("00", "30");
			List<Horario> horariosList = new ArrayList<>();
			
			  // Obtener el valor de 'horarios' del MultiValueMap ya que tiene el json
            String horariosJson = formData.getFirst("horarios");
            JSONArray horariosArray = new JSONArray(horariosJson);

            horariosList = horarioNegocio.getList(horariosArray);
            
			List<Provincia> provincias = provinciaNegocio.ReadAll();
			List<Localidad> localidades = localidadNegocio.ReadAll();
			List<Especialidad> especialidades = especialidadNegocio.ReadAll();
			
			int idBuscado = especialidad; 
			especialidadEncontrada = null;
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
				 nuevoMedico.setMedicoDetails(nombre,apellido,sexo,fechaDeNac,direccion,localidadEncontrada,correo,telefono,nuevoUsuario,especialidadEncontrada);
/*		    	 medicoNegocio.Add(nuevoMedico);*/
				 horarioNegocio.Add(medicoNegocio.Agregar(nuevoMedico), horariosList);

		         mv.addObject("successMessage", MENSAJE_AGREGADO);
		 	     System.out.println(MENSAJE_AGREGADO);	 
		     }
		     else {
		    	 mv.addObject("errorMessage", MENSAJE_YA_EXISTE);
		    	 System.out.println(MENSAJE_YA_EXISTE);
		     }
		     mv.addObject("diasSemana", diasSemana);
		     mv.addObject("minutos", minutos);
		     mv.addObject("provincias", provincias);
		     mv.addObject("localidades", localidades);
		     mv.addObject("especialidades", especialidades);
	        mv.setViewName("medicos");
	        return mv;
	 	}	 

	@RequestMapping("listarMedicos.html")
	    public ModelAndView listarMedicos() {
		
	    	//se obtienen las provincias y localidades para que se carguen en el modal de modificar
	        List<Localidad> localidades = localidadNegocio.ReadAll();
	        List<Provincia> provincias = provinciaNegocio.ReadAll();
	        
	    	//se cargan las especialidades para el filtro de buscar
			List<Especialidad> especialidades = especialidadNegocio.ReadAll();
	    	
	        ModelAndView mv = new ModelAndView("listarMedicos");
	        List<Medico> medicos = medicoNegocio.ReadAll();
	        mv.addObject("listaMedicos", medicos);
	        mv.addObject("localidades", localidades);
	        mv.addObject("provincias", provincias);
	        mv.addObject("especialidades", especialidades);
	        
	        for (Medico p1: medicos) {
				System.out.println(p1.toString());
			}
	        return mv;
	    }
	 
	 
	 @RequestMapping("listarMedico_xNombre.html")
	    public ModelAndView listarMedico_xNombre(String txtBuscarMedico_xNombre) {
	    	
	    	//se obtienen las provincias y localidades para que se carguen en el modal de modificar
	        List<Localidad> localidades = localidadNegocio.ReadAll();
	        List<Provincia> provincias = provinciaNegocio.ReadAll();
	    	
	    	//se cargan las especialidades para el filtro de buscar
			List<Especialidad> especialidades = especialidadNegocio.ReadAll();
	    	
	        ModelAndView mv = new ModelAndView("listarMedicos");
	        List<Medico> medicos = medicoNegocio.Medico_xNombre(txtBuscarMedico_xNombre);
	        mv.addObject("listaMedicos", medicos);
	        mv.addObject("especialidades", especialidades);
	        mv.addObject("localidades", localidades);
	        mv.addObject("provincias", provincias);
	        
	        return mv;
	    }
	 
	 
	 @RequestMapping("listarMedico_xSexo.html")
	    public ModelAndView listarMedico_xSexo(@RequestParam("ddl_sexo") String ddl_sexo ) {
		    
	    	//se obtienen las provincias y localidades para que se carguen en el modal de modificar
	        List<Localidad> localidades = localidadNegocio.ReadAll();
	        List<Provincia> provincias = provinciaNegocio.ReadAll();
	    	
	    	//se cargan las especialidades para el filtro de buscar
			List<Especialidad> especialidades = especialidadNegocio.ReadAll();
	    	
	        ModelAndView mv = new ModelAndView("listarMedicos");
	        List<Medico> medicos = medicoNegocio.filtrarMedico_xSexo(ddl_sexo);
	        mv.addObject("listaMedicos", medicos);
	        mv.addObject("especialidades", especialidades);
	        mv.addObject("localidades", localidades);
	        mv.addObject("provincias", provincias);
	        
	        for (Medico p1: medicos) {
				System.out.println(p1.toString());
			}	        
	        return mv;
	 }
	 
	 @RequestMapping("listarMedico_xEspecialidad.html")
	    public ModelAndView listarMedico_xEspecialidad(@RequestParam("ddl_especialidad") String ddl_especialidad ) {
		  
	    	//se obtienen las provincias y localidades para que se carguen en el modal de modificar
	        List<Localidad> localidades = localidadNegocio.ReadAll();
	        List<Provincia> provincias = provinciaNegocio.ReadAll();
	    	
	    	//se cargan las especialidades para el filtro de buscar
			List<Especialidad> especialidades = especialidadNegocio.ReadAll();
	    	
	        ModelAndView mv = new ModelAndView("listarMedicos");
	        List<Medico> medicos = medicoNegocio.filtrarMedico_xEspecialidad(ddl_especialidad);
	        mv.addObject("listaMedicos", medicos);
	        mv.addObject("especialidades", especialidades);
	        mv.addObject("localidades", localidades);
	        mv.addObject("provincias", provincias);
	                
	        return mv;
	 }
	    
	 @RequestMapping(value = "modificar_medico.html", method = RequestMethod.POST)
	    public ModelAndView modificarMedico(
	            @RequestParam int legajo,
	            @RequestParam String nombre,
	            @RequestParam String apellido,
	            @RequestParam int especialidad,
	            @RequestParam String sexo,
	            @RequestParam String correo,
	            @RequestParam String telefono,
	            @RequestParam String direccion,
	            @RequestParam(name = "provincia") int provincia,
	            @RequestParam(name = "localidad") int localidad,
	            @RequestParam Date fechaNac
	            ) {
		 	System.out.println("legajo: " + legajo);
		 	System.out.println("nombre: " + nombre);
		 	System.out.println("apellido: " + apellido);
		 	System.out.println("especialidad: " + especialidad);
		 	System.out.println("sexo: " + sexo);
		 	System.out.println("correo: " + correo);
		 	System.out.println("telefono: " + telefono);
		 	System.out.println("direccion: " + direccion);
		 	System.out.println("localidad: " + localidad);
		 	System.out.println("fechaNac: " + fechaNac);
		 	
	        ModelAndView mv = new ModelAndView();
	        
			localidadEncontrada = localidadNegocio.ReadOneById(localidad);
			
			List<Especialidad> especialidades = especialidadNegocio.ReadAll();
			int idEspecialidad = especialidad; 
			especialidadEncontrada = null;
			for (Especialidad item : especialidades) {
			    if (item.getId() == idEspecialidad) {
			        especialidadEncontrada = item;
			        break;
			    }
			}

	        Medico medico = medicoNegocio.ReadOneById(legajo);

	        if (medico != null) {
	        	medico.setNombre(nombre);
	        	medico.setApellido(apellido);
	        	medico.setEspecialidad(especialidadEncontrada);
	        	medico.setSexo(sexo);
	        	medico.setTelefono(telefono);
	        	medico.setDireccion(direccion);
	        	medico.setLocalidad(localidadEncontrada);
	        	medico.setFechaNac(fechaNac);
	        	medico.setCorreo(correo);

	            boolean actualizado = medicoNegocio.Update(medico);

	            if (actualizado) {
	            	mv.setViewName("redirect:/listarMedicos.html");
	                mv.addObject("successMessage", "Medico: " + legajo + " " + MENSAJE_MODIFICADO);
	            } else {
	            	mv.setViewName("redirect:/listarMedicos.html");
	                mv.addObject("errorMessage", "Error al modificar medico con legajo: " + legajo);
	            }
	        } else {
	        	mv.setViewName("redirect:/listarMedicos.html");
	            mv.addObject("errorMessage", "No se encontró medico con legajo: " + legajo);
	        }

	        return mv;
	    }

	 
	 @RequestMapping(value = "eliminar_medico.html", method = RequestMethod.GET)
	    public ModelAndView eliminarMedico(@RequestParam int legajo) {
		 	System.out.println("legajo: " + legajo);

	        ModelAndView mv = new ModelAndView();
	        
	        Medico medico = medicoNegocio.ReadOneById(legajo);

	        try {
	        	if (medico != null) {
	        		boolean eliminado = medicoNegocio.Delete(legajo);
	        		if (eliminado) {
	                    mv.addObject("successMessage", "Medico con Legajo " + legajo + " " + MENSAJE_ELIMINADO);
	                } else {
	                	
	                    mv.addObject("errorMessage", "Medico con Legajo " + legajo + " " + MENSAJE_ERROR_ELIMINAR);
	                }
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


	 
}
