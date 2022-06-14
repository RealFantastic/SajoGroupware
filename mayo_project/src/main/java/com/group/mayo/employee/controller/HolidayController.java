package com.group.mayo.employee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.domain.HolidayEmployee;
import com.group.mayo.employee.model.service.HolidayService;

@Controller
@RequestMapping("holiday")
public class HolidayController {
	
	@Autowired
	private HolidayService service;
//	직원연차상세보기
	
	
//	인사팀-직원연차상세보기
	
	
//	인사팀 - 직원별 연차내역 리스트
	@RequestMapping(value = "/empHolidayList", method = RequestMethod.GET)
	public ModelAndView holidayEmpList(ModelAndView mv) {
		List<HolidayEmployee>holidayEmpList=service.holidayEmpList();
		mv.addObject("holidayEmpList",holidayEmpList);
		mv.setViewName("holiday/empHolidayList");
		return mv;
	}
}
