package com.group.mayo.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.employee.domain.Employee;
import com.group.mayo.project.domain.Project;
import com.group.mayo.project.domain.ProjectPic;
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
	
	// 전체 프로젝트, 업무 목록
	@GetMapping("/list") 
	public ModelAndView selectAllProj(ModelAndView mv, HttpSession session){
		
		// 로그인 세션 
		Employee loginEmp = (Employee)session.getAttribute("loginSsInfo");
		String emp_no = loginEmp.getEmp_no();
		
		List<Project> proj = service.selectAllProj(emp_no);
		List<Work> work = workService.selectAllWork(emp_no);		
		
		mv.addObject("work", work);
		
		mv.addObject("project", proj);
	
		mv.setViewName("project/main");
		return mv;
	}
	
	// 새 프로젝트 만들기
	@PostMapping("/insert") 
	public ModelAndView insertProj(ModelAndView mv, Project proj, RedirectAttributes rttr,
			HttpSession session) {
		
		// 로그인 세션 불러오기
		Employee loginEmp = (Employee)session.getAttribute("loginSsInfo");
		
		proj.setProj_mgr(loginEmp.getEmp_no());
		
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
	
	// 프로젝트 수정
	@PostMapping(value="/update", produces="text/plain;charset=UTF-8") 
	@ResponseBody
	public String updateProj(Project proj) {
		System.out.println("수정된 프로젝트!! "+proj);
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
	
	// 프로젝트 삭제
	@PostMapping(value="/delete", produces="text/plain;charset=UTF-8") 
	@ResponseBody
	public String deleteProj(@RequestParam(name="proj_no", required=false) int proj_no) {
		int result = service.deleteProj(proj_no);
		String msg="";
		
		if(result <= 0) {
			System.out.println("삭제실패");
			msg="삭제에 실패했습니다";
		} else {
			msg="프로젝트가 삭제되었습니다";
		}
		return msg;			
		
	}
	
	// 프로젝트 담당 직원 추가
	@PostMapping(value="/insertPic", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String insertPic(HttpServletRequest req
			,ProjectPic pic) {
		
		String msg="";
		
		pic.setProj_no(pic.getProj_no());
		System.out.println(pic.getEmp_no());
		
		String str = pic.getEmp_no();
		
		String[] emp_no = str.split(","); // , 기준으로 나누기
		
		int result = 0;
		for(int i = 0; i < emp_no.length; i++) {
			System.out.println(i + "번째 emp : " + emp_no[i]);
			pic.setEmp_no(emp_no[i]);
			result += service.insertPic(pic);
		}
		
		if(result <= 0) {
			System.out.println("직원 추가 실패!!");
			msg="직원 추가에 실패했습니다.";
		} else {
			msg="직원이 추가됐습니다.";
		}
		
		return msg;
	}
	
	// 프로젝트 담당 직원 삭제
	@PostMapping(value="/deletePic", produces="text/plain;charset=UTF-8") 
	@ResponseBody
	public String deletePic(@RequestParam(name="emp_no", required=false) String emp_no) {
		
		int result = service.deletePic(emp_no);
		String msg="";
		
		if(result <= 0) {
			System.out.println("직원 삭제 성공!!");
			msg="직원 삭제에 실패했습니다";
		} else {
			msg="직원이 삭제되었습니다";
		}
		
		return msg;
	}
	
	 // 특정 프로젝트 선택 - 프로젝트 내부로 이동
	@GetMapping("/select")
	public ModelAndView selectProj(ModelAndView mv
			, @RequestParam(name="proj_no", required=false) String proj_no
			, HttpSession session) {
		
		System.out.println(proj_no);
		// 로그인 세션 불러오기
		Employee loginEmp = (Employee)session.getAttribute("loginSsInfo");
		
		List<ProjectPic> projPic = service.selectPic(proj_no);
		Project proj = service.selectProj(proj_no);
		System.out.println("프로젝트" + proj);
		
		mv.addObject("projPic", projPic);
		mv.addObject("project", proj);
		mv.addObject("loginEmp", loginEmp);
		mv.setViewName("project/insideproject");
		
		return mv;
	}
	
}
