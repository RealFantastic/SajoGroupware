package com.group.mayo.calendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("calendar")
public class CalendarController {

	@GetMapping("/view")
	public ModelAndView viewCal(ModelAndView mv) {
		
		mv.setViewName("calendar/view");
		return mv;
	}
}
