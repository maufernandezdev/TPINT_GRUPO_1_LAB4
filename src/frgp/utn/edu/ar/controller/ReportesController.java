package frgp.utn.edu.ar.controller;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.negocioImp.TurnoNegocio;

@Controller
public class ReportesController {
	@RequestMapping("reportes.html")
    public ModelAndView mostrarReportes() {
		ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
    	TurnoNegocio turnoNegocio = (TurnoNegocio) appContext.getBean("beanTurnoNegocio");
        ModelAndView mv = new ModelAndView("reportes");
        
        Map<String, Long> reporte = turnoNegocio.ObtenerPresentesAusentesEntreFechas();
        for (Map.Entry<String, Long> entry : reporte.entrySet()) {
            mv.addObject(entry.getKey(), entry.getValue());
        }
        
        return mv;
   }
}