package frgp.utn.edu.ar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PageController {
	
	@RequestMapping("login.html")
	public ModelAndView loginEvent(String username, String password) {
		ModelAndView MV = new ModelAndView();
		MV.addObject("error", "");
		System.out.println("username: " + username);
		System.out.println("password: " + password);
		if (username.equals("Gaston") && password.equals("1234")) {
			 System.out.println("login exitoso!");
	        MV.setViewName("inicio");
	        MV.addObject("user", username);
	     } else {
            MV.setViewName("login");
            MV.addObject("error", "El usuario no existe!");
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
