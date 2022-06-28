package com.group.mayo.employee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
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
@RequestMapping("/commute")
public class CommuteController {

	@Autowired
	private CommuteService service; 


//	좌측메뉴 - 출퇴근
	@RequestMapping(value = "leftAttInfo",method =RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String leftAttInfo() {
		String id = "202230001";
		
		// 1. 로그인한 사람 오늘 출근시간/ 퇴근시간 있는지 조회 
		CommuteRecord userInfo = service.myCommuteStatus(id);
		return new Gson().toJson(userInfo);
	}
	
	
//	개인근태상세보기 - 페이지띄우기 
	@RequestMapping(value = "/status", method = RequestMethod.GET)
	public ModelAndView commuteMyStatus(ModelAndView mv) {
		
		String id = "202230001";
		
		// 2. 출퇴근 리스트 불러오기 
		//List<CommuteRecord> commuteMystatus = service.myCommuteStatusList();
		
		//3.사원번호 ,사원명 ,직함 , 부서명, 연락처 
		CommuteEmployee commuteMyInfo=service.commuteMyInfo();
		mv.addObject("commuteMyInfo",commuteMyInfo);
		mv.setViewName("commute/myCommute");
		return mv;
		
		//mv.addObject("StatusList",commuteMystatus);
		
	}
	
	
//	개인근태상세보기 - 출근버튼 클릭시
	@RequestMapping(value="/statusAtt",produces="text/plain;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody //produces 꼭 써줘야함. 한글깨짐있음(반환자료형 String임)
	public String statusAtt() {
		
		String resultAtt = null;
		String id = "202230001";
		CommuteRecord statusAtt = service.statusAtt(id);
		System.out.println(statusAtt);
		
		if(statusAtt !=null) {
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			resultAtt = gson.toJson(statusAtt);
		}else {
			resultAtt= "fail";
		}
		
		return resultAtt;
	}
	
//	개인근태상세보기 - 퇴근버튼 클릭시
	@RequestMapping(value = "/statusLeave", produces = "text/plain;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public String statusLeave() {
		
		String resultLeave=null;
		String id = "202230001";
		CommuteRecord statusLeave = service.statusLeave(id);
		System.out.println(statusLeave);
		if(statusLeave != null) {
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			resultLeave = gson.toJson(statusLeave);
			
		}else {
			resultLeave="fail";
		}
		return resultLeave;
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
