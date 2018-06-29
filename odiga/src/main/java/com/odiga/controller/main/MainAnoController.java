package com.odiga.controller.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainAnoController {
	
	@RequestMapping(value = "home.do")
	public ModelAndView main() {
		return new ModelAndView("home");
	}
}