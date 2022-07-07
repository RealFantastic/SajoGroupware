package com.group.mayo.schedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.schedule.domain.Schedule;
import com.group.mayo.schedule.model.service.ScheduleService;

@Controller
@RequestMapping("schedule")
public class ScheduleController {

	@Autowired
	private ScheduleService service;
	
	@PostMapping(value="/insert", produces="text/plain;charset=UTF-8") // 새 일정 등록
	public String insertSked(Schedule sked) {
		
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
