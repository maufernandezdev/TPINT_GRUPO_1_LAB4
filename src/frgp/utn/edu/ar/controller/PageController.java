package frgp.utn.edu.ar.controller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.entidad.Usuario;
import frgp.utn.edu.ar.entidad.Usuario.TipoDeUsuario;
import frgp.utn.edu.ar.negocioImp.UsuarioNegocio;

@Controller
public class PageController {
	
	@RequestMapping("dashboard.html")
	public ModelAndView loginEvent(String username, String password) {
		ApplicationContext appContext = new ClassPathXmlApplicationContext("frgp/utn/edu/ar/resources/Beans.xml");
		UsuarioNegocio usuarioNegocio = (UsuarioNegocio) appContext.getBean("beanUsuarioNegocio");
		ModelAndView MV = new ModelAndView();
		MV.addObject("error", "");
		System.out.println("username: " + username);
		System.out.println("password: " + password);
		Usuario usuario = usuarioNegocio.Login(username);
		System.out.println("usuario: " + usuario);
		if(usuario == null) {
			 MV.setViewName("login");
	         MV.addObject("error", "El usuario no existe!");
	         return MV;
		}
		if(password.equals(usuario.getContrasenia())) {
			System.out.println("login exitoso!");
			MV.addObject("user", username);
			if(usuario.getTipoDeUsuario().equals(TipoDeUsuario.ADMINISTRADOR)) {
				 MV.setViewName("dashboard-admin");
			} else {
				 MV.setViewName("dashboard-medico");
			}
		} else {
			System.out.println("Contraseņa invalida!");
			 MV.setViewName("login");
			 MV.addObject("error", "La contraseņa es incorrecta!");
		}
		return MV;
	}
	
	@RequestMapping("redirect_login.html")
	public ModelAndView initEvent() {
		ModelAndView MV = new ModelAndView();
		MV.setViewName("login");
		return MV;
	}
}
