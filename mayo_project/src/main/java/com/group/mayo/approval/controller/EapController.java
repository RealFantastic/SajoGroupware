package com.group.mayo.approval.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.group.mayo.approval.domain.EapDomain;
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
	@ResponseBody
	@PostMapping(value="/insert", produces="text/plain;charset=UTF-8")
	public String insertEap(EapDomain eap) {
//		String fmt = new SimpleDateFormat("yyyy").format(new Date());
//		
//		eap.setEa_no(fmt + "-" + eap.getForm_code() + "-");
		
		int result = service.insertEap(eap);
		String msg = "컨트롤러";
//		if(result != 0) {
//			msg = "complete";
//			
//		}else {
//			msg = "fail"; 
//		}
		System.out.println(eap.toString());
		return msg;
	}
}
