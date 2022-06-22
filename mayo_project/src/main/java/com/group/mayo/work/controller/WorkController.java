package com.group.mayo.work.controller;

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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.group.mayo.project.model.service.ProjectService;
import com.group.mayo.work.domain.Work;
import com.group.mayo.work.model.service.WorkService;

@Controller
@RequestMapping("work")
public class WorkController {
	
	@Autowired
	private ProjectService projService;
	@Autowired
	private WorkService service;
	
	@PostMapping("/detail") // 업무 리스트 불러오기
	public ModelAndView detailWork(ModelAndView mv, @RequestParam("proj_no") String proj_no){
		
		System.out.println("detail 들어온 result" + proj_no);
		
		List<Work> work = service.selectWork(proj_no);
		
		mv.addObject("work", work);
		mv.setViewName("project/workDetail");
		return mv;
	}
	
//	@GetMapping("/select") // 해당 프로젝트의 전체 업무 - Ajax 사용할 예정
//	@ResponseBody
//	public String selectWork(@RequestParam("proj_no") String proj_no) { // String으로 받아도 됨
//		System.out.println("컨트롤러 온 프로젝트 번호 : " + proj_no);
//		
//		List<Work> work = service.selectWork(proj_no);
//		
//		Gson gobj = new GsonBuilder().setPrettyPrinting().create();
//
//        String result = gobj.toJson(work);
//        System.out.println("프로젝트 업무들"+result);
//        
//		return result;
//	}
	
	@PostMapping("/insert") // 새 업무 글 등록
	public ModelAndView insertWork(ModelAndView mv, Work work, RedirectAttributes rttr) {
		
		int result = service.insertWork(work);
		
		if(result <= 0) {
			System.out.println("업무 등록 실패 ㅠㅠ");
		} else {
			System.out.println("업무 등록 성공~!~!");
			mv.addObject("proj_no",work.getProj_no());
			mv.setViewName("redirect:/project/select");
		}
		
		return mv;
	}
	
//	@PostMapping("insert")
//	@ResponseBody
//	public String insertWork(Object newWork) {
//		
//		
//		int result = service.insertWork(work);
//		
//		return result;
//	}
	

}
