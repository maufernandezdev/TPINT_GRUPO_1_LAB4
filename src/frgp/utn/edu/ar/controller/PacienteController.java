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

import frgp.utn.edu.ar.entidad.Medico;
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
    
    @RequestMapping("/listarPacientes")
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
    
}
