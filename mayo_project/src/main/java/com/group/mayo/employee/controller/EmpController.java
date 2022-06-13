package com.group.mayo.employee.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.group.mayo.employee.model.service.EmpServiceImpl;

@Controller
@RequestMapping("member")
public class EmpController {
	@Autowired
	private EmpServiceImpl service;
	
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
		//루트, 트리 노드 저장용
		List<Object> treeList = new ArrayList<Object>();
		
		Map <String,Object> root = new HashMap<String, Object>();
		Map <String,Object> rootState = new HashMap<String, Object>();
		
		
		root.put("id", "0");
		root.put("parent", "#");
		root.put("text", "마요그룹");
		rootState.put("opened", true);
		root.put("state", rootState);
		
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		
		String jsonEmp = gson.toJson(emp);
		
		System.out.println(jsonEmp);
		
		return "왔다감";
	}
}
