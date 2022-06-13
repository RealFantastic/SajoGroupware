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
import com.group.mayo.department.domain.Dept;
import com.group.mayo.department.service.DeptService;
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.model.service.EmpService;


@Controller
@RequestMapping("member")
public class EmpController {
	@Autowired
	private EmpService service;
	
	@Autowired
	private DeptService deptService;
	
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
		//사원 목록
		List<Employee> emplist = service.selectListEmp();
		//부서목록
		List<Dept> deptlist = deptService.selectDeptList();
		//루트, 트리 노드 저장용
		List<Object> treeList = new ArrayList<Object>();
	
		//루트 노드용 맵
		Map<String,Object> root = new HashMap<String, Object>();
//		Map<String,Object> root2 = new HashMap<String, Object>();
		Map<String,Object> rootState = new HashMap<String, Object>();
		

		root.put("id", "0");
		root.put("parent", "#");
		root.put("text", "마요그룹");
		rootState.put("opened", true);
		root.put("state", rootState);
		treeList.add(root);
		//부서목록 list -> map으로 변환
		for(Dept dept : deptlist) {
			Map<String,Object> tree = new HashMap<String, Object>();
			Map<String,Object> treeState = new HashMap<String, Object>();
			
			System.out.println("반복" + dept);
			tree.put("id", dept.getDept_no());
			tree.put("parent",root.get("id"));
			tree.put("text",dept.getDept_name());
			treeState.put("opened", true);
			tree.put("state", treeState);
			treeList.add(tree);
		}
		
		
		//사원목록 list -> map으로 변환
		for(Employee employee : emplist) {
			Map<String,Object> tree = new HashMap<String, Object>();
			Map<String,Object> treeState = new HashMap<String, Object>();

			System.out.println("반복" + employee);
			
			tree.put("id", employee.getEmp_no());
			tree.put("parent", employee.getDept_no());
			tree.put("text",employee.getEmp_name());
			treeState.put("opened", true);
			tree.put("state", treeState);
			treeList.add(tree);
		}
		
		
		//Json 형변환
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		
		String jsonRoot = gson.toJson(treeList);
		
		System.out.println(jsonRoot);
		
		return jsonRoot;
	}
}
