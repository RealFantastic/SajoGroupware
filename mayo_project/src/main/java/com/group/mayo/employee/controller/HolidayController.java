package com.group.mayo.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.domain.HolidayEmployee;
import com.group.mayo.employee.model.service.HolidayService;

@Controller
@RequestMapping("holiday")
public class HolidayController {
	
	@Autowired
	private HolidayService service;


//	직원연차상세보기
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView holidayMyList(ModelAndView mv, HttpSession session) {
		
		Employee emp=(Employee) session.getAttribute("loginSsInfo");
		String id=emp.getEmp_no();
		
		//본인의 사원번호, 사원명, 직함, 부서명, 연락처
		CommuteEmployee commuteMyInfo=service.commuteMyInfo(id);
		mv.addObject("commuteMyInfo",commuteMyInfo);
		mv.setViewName("holiday/myHoliday");
		return mv;
	}

//	나의연차리스트
	@RequestMapping(value="/selectHolidayList", produces="text/plain;charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public String selectHolidayList(@RequestParam(name="birthYear", required = false) String birthYear
			,@RequestParam("empNo") String empNo
			, HttpSession session) throws Exception {
		
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("birthYear", birthYear);
		paramMap.put("id", empNo);

		System.out.println(birthYear);
		
		List<Holiday> holidayList = service.holidayMystatus(paramMap);
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String result = gson.toJson(holidayList);
		
		return result;
	}





//	인사팀 - 직원별 연차내역 리스트
	@RequestMapping(value = "/empHolidayList", method = RequestMethod.GET)
	public ModelAndView holidayEmpList(ModelAndView mv, HttpSession session) {
		Employee emp=(Employee)session.getAttribute("loginSsInfo");
		String id=emp.getEmp_no();
		
		//직원전체 연차리스트
		List<HolidayEmployee>holidayEmpList=service.holidayEmpList();
		mv.addObject("holidayEmpList",holidayEmpList);
		mv.setViewName("holiday/empHolidayList");
		return mv;
	}



//	인사팀 - 직원별 연차내역 리스트 - 검색하기
	@RequestMapping(value ="/empCommuteSearch", produces="text/plain;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public String commuteEmpSearch(
			@RequestParam("search_type") String search_type
			,@RequestParam("search_keyword") String search_keyword
			,ModelAndView mv) throws Exception{
		CommuteEmployee empCommuteSearch = new CommuteEmployee(); 
		empCommuteSearch.setSearch_type(search_type);
		empCommuteSearch.setSearch_keyword(search_keyword);
		List<CommuteEmployee> emplist = service.commuteEmpSearch(empCommuteSearch);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String result = gson.toJson(emplist);
		return result;
	}
	
	
	
//	인사팀-직원연차상세보기
	@RequestMapping(value = "/empHolidayDetail", method = RequestMethod.POST)
	public ModelAndView holidayEmpDetail(ModelAndView mv, HttpSession session) {
		
		Employee emp=(Employee) session.getAttribute("loginSsInfo");
		String id=emp.getEmp_no();
		
		//본인의 사원번호, 사원명, 직함, 부서명, 연락처
		CommuteEmployee commuteMyInfo=service.commuteMyInfo(id);
		mv.addObject("commuteMyInfo",commuteMyInfo);
		mv.setViewName("holiday/empHoliday");
		return mv;
	}
	
	
	
	
}
