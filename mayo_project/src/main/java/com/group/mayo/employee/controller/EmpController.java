package com.group.mayo.employee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.model.service.EmpService;

@Controller
@RequestMapping("member")
public class EmpController {
	@Autowired
	private EmpService service;
	
	@GetMapping("/list")
	public ModelAndView selectEmp(ModelAndView mv) {
		
		List<Employee> emp = service.selectListEmp();
		
		System.out.println(emp);
		mv.addObject("emp", emp);
		mv.setViewName("member/list");
		
		return mv;
	}
	
	@PostMapping(value="/empchart", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String selectEmpChart(ModelAndView mv) {
		
		List<Employee> emp = service.selectListEmp();
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		
		String jsonEmp = gson.toJson(emp);
		
		System.out.println(jsonEmp);
		
		return "왔다감";
	}
}
