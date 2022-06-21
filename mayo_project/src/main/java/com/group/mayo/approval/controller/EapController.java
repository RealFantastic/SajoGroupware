package com.group.mayo.approval.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.group.mayo.approval.service.EapService;
import com.group.mayo.eaform.domain.EaForm;

@Controller
@RequestMapping("eap")
public class EapController {
	
	@Autowired
	private EapService service;
	
	@GetMapping("/main")
	public ModelAndView mainPage(ModelAndView mv) {
		
		mv.addObject("formlist", service.selectListEaForm());
		mv.setViewName("eap/main");
		
		return mv;
	}
	@RequestMapping("/new/ar")
	public ModelAndView showArForm(ModelAndView mv,
			@RequestParam(name="form_code", required=false) String form_code
			) {
		System.out.println(form_code);
		EaForm selectForm= service.selectForm(form_code);
		
		mv.addObject("selectForm", selectForm);
		mv.setViewName("ea_form/vacationForm");
		
		return mv;
	}
}
