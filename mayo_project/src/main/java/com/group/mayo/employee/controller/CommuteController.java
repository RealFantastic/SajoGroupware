package com.group.mayo.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.group.mayo.employee.domain.CommuteEmployee;
import com.group.mayo.employee.domain.CommuteRecord;
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.model.service.CommuteService;

@Controller
@RequestMapping("/commute")
public class CommuteController {

	@Autowired
	private CommuteService service;

//	좌측메뉴 - 출퇴근 확인
	@RequestMapping(value = "leftAttInfo", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String leftAttInfo(HttpSession session) {
		Employee emp = (Employee) session.getAttribute("loginSsInfo");
		String id = emp.getEmp_no();

		// 1. 로그인한 사람 오늘 출근시간/ 퇴근시간 있는지 조회
		CommuteRecord userInfo = service.myCommuteStatus(id);
		return new Gson().toJson(userInfo);
	}

//	개인근태상세보기 - 출근버튼 클릭시
	@RequestMapping(value = "/statusAtt", produces = "text/plain;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody // produces 꼭 써줘야함. 한글깨짐있음(반환자료형 String임)
	public String statusAtt(HttpSession session) {

		String resultAtt = null;
		Employee emp = (Employee) session.getAttribute("loginSsInfo");
		String id = emp.getEmp_no();
		CommuteRecord statusAtt = service.statusAtt(id);
		System.out.println(statusAtt);

		if (statusAtt != null) {
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			resultAtt = gson.toJson(statusAtt);
		} else {
			resultAtt = "fail";
		}

		return resultAtt;
	}

//	개인근태상세보기 - 퇴근버튼 클릭시
	@RequestMapping(value = "/statusLeave", produces = "text/plain;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public String statusLeave(HttpSession session) {

		String resultLeave = null;
		Employee emp = (Employee) session.getAttribute("loginSsInfo");
		String id = emp.getEmp_no();
		CommuteRecord statusLeave = service.statusLeave(id);
		System.out.println(statusLeave);
		if (statusLeave != null) {
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			resultLeave = gson.toJson(statusLeave);

		} else {
			resultLeave = "fail";
		}
		return resultLeave;
	}

//	개인근태상세보기 - 페이지띄우기 
	@RequestMapping(value = "/status", method = RequestMethod.GET)
	public ModelAndView commuteMyStatus(ModelAndView mv, HttpSession session) {

		Employee emp = (Employee) session.getAttribute("loginSsInfo");
		String id = emp.getEmp_no();

		// 2. 출퇴근 리스트 불러오기
		/*
		 * List<CommuteRecord> commuteMystatus = service.commuteMystatus(id);
		 * mv.addObject("commuteMystatus", commuteMystatus);
		 */
		// 3.사원번호 ,사원명 ,직함 , 부서명, 연락처
		CommuteEmployee commuteMyInfo = service.commuteMyInfo(id);
		mv.addObject("commuteMyInfo", commuteMyInfo);
		mv.setViewName("commute/myCommute");
		return mv;

		// mv.addObject("StatusList",commuteMystatus);

	}

	@RequestMapping(value = "/selectCommuteList", produces = "text/plain;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public String selectCommuteList(@RequestParam("start_dt") String startDt, @RequestParam("end_dt") String endDt,
			ModelAndView mv, HttpSession session) throws Exception {

		Employee emp = (Employee) session.getAttribute("loginSsInfo");

		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("startDt", startDt);
		paramMap.put("endDt", endDt);
		paramMap.put("id", emp.getEmp_no());
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<CommuteRecord> commuteList = service.commuteMystatus(paramMap);
		CommuteRecord chartData = service.chartData(paramMap);
		resultMap.put("commuteList", commuteList);
		resultMap.put("chartData", chartData);

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String result = gson.toJson(resultMap);
		return result;
	}

//	인사팀 - 직원별 근태내역 리스트
	@RequestMapping(value = "/empCommuteList", method = RequestMethod.GET)
	public ModelAndView commuteEmpList(ModelAndView mv, HttpSession session) {

		Employee emp = (Employee) session.getAttribute("loginSsInfo");
		String id = emp.getEmp_no();

		// 직원전체근태 리스트
		List<CommuteEmployee> commuteEmpList = service.empCommuteList();
		mv.addObject("empCommuteList", commuteEmpList);
		mv.setViewName("commute/empCommuteList");
		return mv;
	}

//	인사팀 - 직원별 근태내역 리스트 - 검색하기
	@RequestMapping(value = "/empCommuteSearch", produces = "text/plain;charset=UTF-8", method = RequestMethod.GET)
	@ResponseBody
	public String commuteEmpSearch(@RequestParam("search_type") String search_type,
			@RequestParam("search_keyword") String search_keyword, ModelAndView mv) throws Exception {
		CommuteEmployee empCommuteSearch = new CommuteEmployee();
		empCommuteSearch.setSearch_type(search_type);
		empCommuteSearch.setSearch_keyword(search_keyword);
		List<CommuteEmployee> emplist = service.commuteEmpSearch(empCommuteSearch);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String result = gson.toJson(emplist);
		return result;
	}

	private String RequestParam(String string) {
		// TODO Auto-generated method stub
		return null;
	}

	// 인사팀 - 직원근태상세보기
	@RequestMapping(value = "/empCommuteSelect", method = RequestMethod.GET)
	public ModelAndView commuteEmpSelect(ModelAndView mv, HttpServletRequest request) {
		String empNo = request.getParameter("empNo");
		// 3.사원번호 ,사원명 ,직함 , 부서명, 연락처
		CommuteEmployee commuteStaffInfo = service.commuteMyInfo(empNo);
		mv.addObject("commuteStaffInfo", commuteStaffInfo);
		mv.addObject("empNo", empNo);
		mv.setViewName("commute/empCommute");
		return mv;
	}
	@RequestMapping(value = "/selectEmpCommuteList", produces = "text/plain;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public String selectEmpCommuteList(@RequestParam("start_dt") String startDt, @RequestParam("end_dt") String endDt,
			ModelAndView mv, @RequestParam("empNo") String empNo) throws Exception {

		

		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("startDt", startDt);
		paramMap.put("endDt", endDt);
		paramMap.put("id", empNo);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<CommuteRecord> commuteList = service.commuteMystatus(paramMap);
		CommuteRecord chartData = service.chartData(paramMap);
		resultMap.put("commuteList", commuteList);
		resultMap.put("chartData", chartData);

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String result = gson.toJson(resultMap);
		return result;
	}

}
