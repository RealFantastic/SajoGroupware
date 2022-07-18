package com.group.mayo.schedule.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.employee.domain.Employee;
import com.group.mayo.schedule.domain.Schedule;
import com.group.mayo.schedule.model.service.ScheduleService;

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
}
