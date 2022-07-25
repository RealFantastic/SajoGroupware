package com.group.mayo.schedule.controller;

import java.util.List;

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
import com.group.mayo.project.model.service.ProjectService;
import com.group.mayo.schedule.domain.Schedule;
import com.group.mayo.schedule.model.service.ScheduleService;
import com.group.mayo.work.domain.Work;

@Controller
@RequestMapping("schedule")
public class ScheduleController {

	@Autowired
	private ScheduleService service;
	
	@Autowired
	private ProjectService projservice;
	
	// 새 일정 등록
	@PostMapping(value="/insert", produces="text/plain;charset=UTF-8") 
	@ResponseBody
	public String insertSked(Schedule sked, HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("loginSsInfo");
		
		sked.setSked_emp_id(employee.getEmp_no());
		
		int result = service.insertSked(sked);
		
		String msg="";
		
		if(result<=0) {
			System.out.println("일정 등록 실패~!");
			msg = "일정 등록에 실패했습니다";
		} else {
			System.out.println("일정 등록 성공!");
			msg = "일정이 등록됐습니다";
		}
		return msg;
	}
	
	// 일정 페이지로 이동
	@PostMapping("/toSked") 
	public ModelAndView skedPage(ModelAndView mv,
			@RequestParam(name="proj_no", required=false) String proj_no
			, HttpSession session) {
		// 로그인 세션 불러오기
		Employee loginEmp = (Employee)session.getAttribute("loginSsInfo");
		String emp_no = loginEmp.getEmp_no();

			System.out.println("sked 페이지 들어왔니");
			List<Schedule> sked = service.selectSked(proj_no);
			List<Project> projList = projservice.selectAllProj(emp_no);
			Project proj = projservice.selectProj(proj_no);
			
			mv.addObject("sked", sked);
			mv.addObject("proj",projList);
			mv.addObject("project", proj);
			mv.addObject("loginEmp", loginEmp);
			
			mv.setViewName("project/insideprojectSked");
			
			return mv;
		}
	
	// 일정 상세보기
	@GetMapping("/view")
	public ModelAndView viewCal(ModelAndView mv, HttpSession session, 
			@RequestParam(name="sked_no", required = false) String sked_no ) { 
		
		Employee emp = (Employee)session.getAttribute("loginSsInfo");
		
		Schedule sked = service.viewSked(sked_no);
		
		mv.addObject("schedule", sked);
		mv.addObject("employee", emp);
		mv.setViewName("calendar/skedDetail");
		return mv;
	}
	
	// 일정 글 수정 페이지로 이동
	@PostMapping("/toUpdate") 
	public ModelAndView updateSkedPage(ModelAndView mv,
			@RequestParam(name="sked_no", required=false) String sked_no,
			HttpSession session) {

			// 로그인 세션 불러오기
			Employee loginEmp = (Employee)session.getAttribute("loginSsInfo");
			String emp_no = loginEmp.getEmp_no();
				
			System.out.println("sked 업데이트 들어왔니");
			Schedule sked = service.viewSked(sked_no);
			List<Project> proj = projservice.selectAllProj(emp_no);
			
			mv.addObject("sked", sked);
			mv.addObject("proj",proj);
			mv.setViewName("calendar/updateSked");
			
			return mv;
		}
	
	
	// 일정 수정하기
	@PostMapping(value="/update", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String updateSked(Schedule sked, HttpSession session) {
		
		int result = service.updateSked(sked);
		
		String msg="";
		
		if(result<=0) {
			System.out.println("일정 수정 실패~!");
			msg = "일정 수정에 실패했습니다";
		} else {
			System.out.println("일정 수정 성공!");
			msg = "일정이 수정됐습니다";
		}
		return msg;
	}
	
	// 일정 삭제하기
	@PostMapping(value="/delete", produces="text/plain;charset=UTF-8") 
	@ResponseBody
	public String deleteWork(@RequestParam(name="sked_no", required=false) String sked_no) {
		 
		System.out.println("sked delete로 들어왔냐" + sked_no);
		int result = service.deleteSked(sked_no);
		
		String msg="";
		
		if(result<=0) {
			System.out.println("일정 글 삭제 실패~!");
			msg="삭제에 실패했습니다";
		} else {
			System.out.println("일정 글 삭제 성공~!");
			msg="일정이 삭제되었습니다";
		}
		return msg;
	}
}
