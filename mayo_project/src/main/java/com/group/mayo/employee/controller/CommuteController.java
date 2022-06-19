package com.group.mayo.employee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;
import com.group.mayo.employee.model.service.CommuteService;

@Controller
@RequestMapping("commute")
public class CommuteController {
	
	@Autowired
	private CommuteService service; 
//	직원근태상세보기
	@RequestMapping(value = "/status", method = RequestMethod.GET)
	public ModelAndView commuteMyStatus(ModelAndView mv) {
		List<CommuteRecord> commuteMystatus=service.myCommuteStatus();
		mv.addObject("myCommuteStatus",commuteMystatus);
		mv.setViewName("commute/myCommute");
		return mv;
	}
	
	@RequestMapping(value="/statusAtt",produces="text/plain;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody //produces 꼭 써줘야함. 한글깨짐있음(반환자료형 String임)
	public String statusAtt() {
		
		String resultAtt = null;
		String id = "202230001";
		CommuteRecord statusAtt=service.statusAtt(id);
		System.out.println(statusAtt);
		if(statusAtt !=null) {
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			resultAtt = gson.toJson(statusAtt);
		}else {
			resultAtt= "fail";
		}
//	
		
		return resultAtt;
	}
		
//	인사팀 - 직원근태상세보기	
	@RequestMapping(value = "/empCommuteSelect", method = RequestMethod.GET)
	public ModelAndView commuteEmpSelect(ModelAndView mv) {
		mv.setViewName("commute/empCommute");
		return mv;
	}
		
//	인사팀 - 직원별 근태내역 리스트
	@RequestMapping(value = "/empCommuteList", method = RequestMethod.GET)
	public ModelAndView commuteEmpList(ModelAndView mv) {
		List<CommuteEmployee> commuteEmpList=service.empCommuteList();
		mv.addObject("empCommuteList",commuteEmpList);
		mv.setViewName("commute/empCommuteList");
		return mv;
	}
	
	
}
