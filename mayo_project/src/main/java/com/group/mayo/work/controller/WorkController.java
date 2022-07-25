package com.group.mayo.work.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.employee.domain.Employee;
import com.group.mayo.schedule.domain.Schedule;
import com.group.mayo.schedule.model.service.ScheduleService;
import com.group.mayo.work.domain.Work;
import com.group.mayo.work.model.service.WorkService;

@Controller
@RequestMapping("work")
public class WorkController {
	
	@Autowired
	private WorkService service;
	@Autowired 
	private ScheduleService skedService;
	// 업무 리스트 불러오기
	@PostMapping("/detail") 
	public ModelAndView detailWork(ModelAndView mv, @RequestParam("proj_no") String proj_no){
		
		System.out.println("detail 들어온 result" + proj_no);
		
		List<Work> work = service.selectWork(proj_no);
		
		mv.addObject("work", work);
		mv.setViewName("project/workDetail");
		return mv;
	}
	
	@PostMapping("/detailS") 
	public ModelAndView detailSked(ModelAndView mv, @RequestParam("proj_no") String sked_category){
		
		List<Schedule> sked = skedService.selectSked(sked_category);
		
		mv.addObject("sked", sked);
		mv.setViewName("calendar/skedDetail");
		return mv;
	}
	
	// 새 업무 글 등록
	@PostMapping("/insert") 
	public ModelAndView insertWork(ModelAndView mv, Work work, RedirectAttributes rttr
			, @RequestParam(name="work_pic", required=false) String work_pic
			, HttpSession session
			, HttpServletRequest req) {

		// 로그인 세션 불러오기
		Employee employee = (Employee)session.getAttribute("loginSsInfo");
		if (employee == null) {
			mv.setViewName("redirect:/member/login");
			return mv;
		}
		// 로그인 아이디 저장 
		work.setWork_mgr(employee.getEmp_no());
		
		int result = service.insertWork(work);
		//
		if(result <= 0) {
			System.out.println("업무 등록 실패 ㅠㅠ");
		} else {
			System.out.println("업무 등록 성공~!~!");
			mv.addObject("proj_no",work.getProj_no());
			mv.setViewName("redirect:/project/select");
		}
		
		return mv;
	}
	
	// 업무 글 수정 페이지로 이동
	@PostMapping("/toUpdate") 
	public ModelAndView updateWorkPage(ModelAndView mv,
			@RequestParam(name="work_no", required=false) String work_no
			, HttpSession session) {

			// 로그인 세션 불러오기
			Employee loginEmp = (Employee)session.getAttribute("loginSsInfo");
			
			System.out.println("업데이트 들어왔니");
			Work work = service.viewWork(work_no);
			
			mv.addObject("work", work);
			mv.addObject("loginEmp", loginEmp);
			
			mv.setViewName("project/updateWork");
			
			return mv;
		}
	
	// 업무 글 수정
		@PostMapping("/update")
		public String updateWork(Work work) {
			
		int result= service.updateWork(work);
		
		String msg="";

		if(result <= 0) {
			System.out.println("업무 수정 실패 ㅠㅠ");
			msg="수정에 실패했습니다";
		} else {
			System.out.println("업무 수정 성공~!~!");
			msg="업무가 수정되었습니다";
		}
		return msg;
	}
	
	// 업무 글 삭제
	@PostMapping(value="/delete", produces="text/plain;charset=UTF-8") 
	@ResponseBody
	public String deleteWork(@RequestParam(name="work_no", required=false) String work_no) {
		 
		System.out.println("work delete로 들어왔냐" + work_no);
		int result = service.deleteWork(work_no);
		
		String msg="";
		
		if(result<=0) {
			System.out.println("업무 글 삭제 실패~!");
			msg="삭제에 실패했습니다";
		} else {
			System.out.println("업무 글 삭제 성공~!");
			msg="업무가 삭제되었습니다";
		}
		return msg;
	}

}
