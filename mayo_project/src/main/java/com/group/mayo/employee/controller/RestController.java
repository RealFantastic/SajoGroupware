package com.group.mayo.employee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.group.mayo.employee.domain.Rest;
import com.group.mayo.employee.model.service.RestService;

@Controller
@RequestMapping("rest")
public class RestController {

	@Autowired
	private RestService service;
	
//	직원연차상세보기
	
	
//	인사팀-직원연차상세보기
	
	
//	인사팀 직원별 연차내역 리스트
	@RequestMapping(value = "/empList", method = RequestMethod.GET)
	public ModelAndView restEmpList(ModelAndView mv) {
		List<Rest>restEmpList=service.restEmpList();
		mv.addObject("restEmpList",restEmpList);
		mv.setViewName("rest/empRestList");
		return mv;
	}
}
