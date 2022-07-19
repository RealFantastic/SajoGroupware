package com.group.mayo.schedule.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.employee.domain.Employee;
import com.group.mayo.project.domain.Project;
import com.group.mayo.schedule.domain.Schedule;
import com.group.mayo.schedule.model.service.ScheduleService;
import com.group.mayo.work.domain.Work;

@Controller
@RequestMapping("schedule")
public class ScheduleController {

	@Autowired
	private ScheduleService service;
	
	// 새 일정 등록
	@PostMapping(value="/insert", produces="text/plain;charset=UTF-8") 
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
	
	// 일정 리스트 
	
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
	
	// 일정 수정하기
	
	// 일정 삭제하기
}
