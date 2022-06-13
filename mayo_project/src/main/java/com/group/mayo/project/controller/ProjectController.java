package com.group.mayo.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.project.domain.Project;
import com.group.mayo.project.model.service.ProjectService;
import com.group.mayo.work.domain.Work;
import com.group.mayo.work.model.service.WorkService;

@Controller
@RequestMapping("project")
public class ProjectController {

	@Autowired
	private ProjectService service;
	@Autowired
	private WorkService workService;
	
	@GetMapping("/list")
	public ModelAndView selectAllProj(ModelAndView mv){
		
		List<Project> proj = service.selectAllProj();
		
		List<Work> work = workService.selectAllWork();
		
		mv.addObject("work", work);
		
		mv.addObject("project", proj);
		mv.setViewName("project/main");
		return mv;
	}
	
	@PostMapping("/insert")
	public ModelAndView insertProj(ModelAndView mv, Project proj, RedirectAttributes rttr) {
		
		int result = service.insertProj(proj);
		
		if(result <= 0) {
			System.out.println("프로젝트 등록 실패");
		} else {
			System.out.println("프로젝트 등록 성공");
			rttr.addFlashAttribute("msg", "프로젝트가 등록되었습니다!");
			mv.setViewName("redirect:/project/list");
		}
		
		return mv;
	}
	
}