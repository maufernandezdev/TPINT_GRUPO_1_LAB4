package frgp.utn.edu.ar.controller;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.entidad.Paciente;
import frgp.utn.edu.ar.negocioImp.PacienteNegocio;

@Controller
public class PacienteController {
	

    @RequestMapping("/pacientes")
    public ModelAndView pacientes() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("pacientes");
        return mv;
    }
    
    // Mapeo para listar todos los pacientes y mostrarlos en la página
    @RequestMapping("listarPacientes.html")
    public ModelAndView listarPacientes() {
    	ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
		PacienteNegocio pacienteNegocio = (PacienteNegocio) appContext.getBean("beanPacienteNegocio");
        ModelAndView mv = new ModelAndView("pacientes");
        List<Paciente> pacientes = pacienteNegocio.ReadAll();
        mv.addObject("pacientes", pacientes);
        return mv;
    }
    
}
