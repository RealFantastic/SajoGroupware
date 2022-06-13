package com.group.mayo.work.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.group.mayo.work.domain.Work;
import com.group.mayo.work.model.service.WorkService;

@Controller
@RequestMapping("work")
public class WorkController {
	
	@Autowired
	private WorkService service;
	
//	@GetMapping("/list")
//	public ModelAndView selectAllWork(ModelAndView mv) {
//		
//		List<Work> work = service.selectAllWork();
//		
//		mv.addObject("work", work);
//		mv.setViewName("project/main");
//		
//		return mv;
//	}

}
