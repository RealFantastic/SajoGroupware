package com.group.mayo.approval.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.approval.service.EapService;
import com.group.mayo.eaform.domain.EaForm;
import com.group.mayo.employee.domain.Employee;

@Controller
@RequestMapping("eap")
public class EapController {
	
	@Autowired
	private EapService service;
	
	@GetMapping("/main")
	public ModelAndView mainPage(ModelAndView mv) {
		
		mv.addObject("formlist", service.selectListEaForm());
		mv.setViewName("eap/main");
		
		return mv;
	}
	@RequestMapping("/new/ar")
	public ModelAndView showArForm(ModelAndView mv,
			@RequestParam(name="form_code", required=false) String form_code
			) {
		System.out.println(form_code);
		EaForm selectForm= service.selectForm(form_code);
		
		mv.addObject("selectForm", selectForm);
		mv.setViewName("ea_form/vacationForm");
		
		return mv;
	}
	@ResponseBody
	@PostMapping(value="/insert", produces="text/plain;charset=UTF-8")
	public String insertEap(EapDomain eap,HttpSession session) {
		Employee curUser = (Employee)session.getAttribute("loginSsInfo");
		
		//기안자, 1차결재자 지정
		if(curUser != null) {
			eap.setDrafter_id(curUser.getEmp_no());
			eap.setFirst_approver(curUser.getEmp_no());
		}
		
		//결재상태 코드 초기화
		int statusCode = 1;
		//기안자 제외 총 결재자 컬럼 3개만큼 반복문
		for(int i = 0; i < 3; i++) {
			//화면에서 받아온 결재자 배열이 null이 아닐때 동작
			if(eap.getApprover_emp_no() != null) {
				int ap_cnt = eap.getApprover_emp_no().size();//사용자가 지정한 추가 결재선의 개수
				//현재 index가 사용자 지정 결재선 인원보다 작아야함.
				//ex) 기준 결재선은 3명이지만 사용자 지정 결재선은 null(자기결재),1(추가1명),2(추가2명),3(추가3명)이므로
				//지정한 결재선 인원수 만큼만 동작되도록 해야함.
				if(i < ap_cnt) {
//					System.out.println(ap_cnt);
					String empNo = eap.getApprover_emp_no().get(i);//결재자 id를 담은 변수
					//비트마스킹
					// 1을 현재 index + 1만큼 왼쪽이동(2의 지수승) + 현재 statusCode으로 중복수 없이 결재선 인원에 맞는 특정 숫자 입력.
					statusCode = statusCode + (1<<(i+1));
					if(i==0) {
						//index 0이면 2차 결재선에 결재자id 대입 
						eap.setSecond_approver(empNo);
					} else if (i==1) {
						//index 1이면 3차 결재선에 결재자id 대입 
						eap.setThird_approver(empNo);
					} else if (i==2) {
						//index 2이면 3차 결재선에 결재자id 대입 
						eap.setFinal_approver(empNo);
					}
				}
			}
		}
		//결재선 개수에 따라 증가한 상태코드를 대입
		eap.setStatus_code(statusCode);
		
		int result = service.insertEap(eap);
		String msg = "컨트롤러";
		if(result != 0) {
			msg = "complete";
			
		}else {
			msg = "fail"; 
		}
		return msg;
	}
	
	//기안 문서함(내가 기안한 문서함)
	@GetMapping("/list/mylist")
	public ModelAndView selectMylist(ModelAndView mv
			, HttpSession session
			, RedirectAttributes rttr) {
		//세션 로그인 정보 가져옴.
		Employee curUser = (Employee)session.getAttribute("loginSsInfo");
		
		List<EapDomain> mylist = service.selectMyList(curUser);
		
		if(curUser != null) {
			mv.addObject("mylist", mylist);
			mv.setViewName("eap/mylist");
		}
		
		return mv;
	}
}
