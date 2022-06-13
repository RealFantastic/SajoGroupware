package com.group.mayo.employee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("commute")
public class CommuteController {

		@GetMapping("/status")
		public ModelAndView commuteMyStatus(ModelAndView mv) {
			mv.setViewName("commute/myCommute");
			return mv;
		}
		
		
		
		@GetMapping("/empCommuteSelect")
		public ModelAndView commuteEmpCommuteSelect(ModelAndView mv) {
			mv.setViewName("commute/empCommute");
			return mv;
		}
}
