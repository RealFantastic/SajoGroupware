package com.group.mayo.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@GetMapping("/list") // 전체 프로젝트, 업무 목록
	public ModelAndView selectAllProj(ModelAndView mv){
		
		List<Project> proj = service.selectAllProj();
		List<Work> work = workService.selectAllWork();		
		
		mv.addObject("work", work);
		
		mv.addObject("project", proj);
	
		mv.setViewName("project/main");
		return mv;
	}
	
	@PostMapping("/insert") // 새 프로젝트 만들기
	public ModelAndView insertProj(ModelAndView mv, Project proj, RedirectAttributes rttr) {
		
		int result = service.insertProj(proj);
		
		if(result <= 0) {
			System.out.println("프로젝트 등록 실패");
		} else {
			System.out.println("프로젝트 등록 성공");
			rttr.addFlashAttribute("msg", "프로젝트가 등록되었습니다");
			mv.setViewName("redirect:/project/list");
		}
		
		return mv;
	}
	
	@PostMapping("/update") // 프로젝트 수정
	@ResponseBody
	public String updateProj(@RequestParam(name="proj_no", required=false) Project proj) {
		int result = service.updateProj(proj);
		String msg="";
		
		if(result <= 0) {
			System.out.println("수정실패");
			msg="수정에 실패했습니다";
		} else {
			msg="프로젝트 정보가 수정되었습니다";
		}
		return msg;			
		
	}
	
	@PostMapping("/delete") // 프로젝트 삭제
	@ResponseBody
	public String deleteProj(@RequestParam(name="proj_no", required=false) int proj_no) {
		int result = service.deleteProj(proj_no);
		String msg="";
		
		if(result <= 0) {
			System.out.println("삭제실패");
			msg="삭제에 실패했습니다";
		} else {
			msg="프로젝트가 삭제되었습니니다";
		}
		return msg;			
		
	}
	
	
	
	@GetMapping("/select") // 특정 프로젝트 선택 - 프로젝트 내부로 이동
	public ModelAndView selectProj(ModelAndView mv, @RequestParam(name="proj_no", required=false) int proj_no) {
		
		System.out.println(proj_no);
		Project proj = service.selectProj(proj_no);
		System.out.println("프로젝트" + proj);
		
		mv.addObject("project", proj);
		mv.setViewName("project/insideproject");
		
		return mv;
	}
	
}
