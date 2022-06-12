package com.group.mayo.template;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("template")
public class TemplateController {
	
	@GetMapping("/header")
	public ModelAndView template(ModelAndView mv) {
		
		
		mv.setViewName("template_header");
		return mv;
	}
}
