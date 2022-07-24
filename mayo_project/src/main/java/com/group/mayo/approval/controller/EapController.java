package com.group.mayo.approval.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.approval.service.EapService;
import com.group.mayo.eaform.domain.EaForm;
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.model.service.HolidayService;

@Controller
@RequestMapping("eap")
public class EapController {
	
	@Autowired
	private EapService service;
	
	@Autowired
	private HolidayService hservice;
	
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
	@PostMapping(value="/insert/ar", produces="text/plain;charset=UTF-8")
	public String insertEap(EapDomain eap
			,HttpSession session
			,Holiday holiday
			,@RequestParam(name="hd_count", required=false) String hd_count) {
		Employee curUser = (Employee)session.getAttribute("loginSsInfo");
		String msg = "컨트롤러";
		//기안자, 1차결재자 지정
		if(curUser != null) {
			eap.setDrafter_id(curUser.getEmp_no());
			eap.setFirst_approver(curUser.getEmp_no());
		}
		//문서번호 생성에 실패했다면 메소드 종료 후 리턴
		String eaNo = service.selectNewEaNo(eap);
		if(eaNo != null) {
			eap.setEa_no(eaNo);
			holiday.setEa_no(eaNo);
		}else {
			msg = "fail";
			return msg;
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
		int isComplete = 0;
		int result = service.insertEap(eap);
		if(result != 0) {
			switch(eap.getForm_code()) {
			case "AR":
				//TODO 여기선 content의 태그문자 제거해야함.
				//화면에서 넘어오는 소숫점 숫자 .5는 String형태로 넘어옴. 그러므로 parse해준다.
				holiday.setHd_count(Double.parseDouble(hd_count));
				holiday.setHd_reason(eap.getEa_content());
				int insertAR = hservice.insertHoliday(holiday);
				isComplete = insertAR;
				break;
			case "BP":
				//TODO - 업무기안 구현시 다시 적어야함.
				break;
			}
		}
		if(isComplete != 0) {
			msg="complete";
		}else {
			msg="fail";
		}
		
		return msg;
	}
	
	//기안 문서함(내가 기안한 문서함) 리스트
	@PostMapping("/list/mylist")
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
	
	@PostMapping("/update/recall")
	public ModelAndView deleteEap(
			HttpServletRequest req,
			@RequestParam(name="ea_no", required=false) String ea_no
			,@RequestParam(name="form_code", required=false) String form_code
			,RedirectAttributes rttr
			,ModelAndView mv) {
		
		int deleteEap = service.deleteEap(ea_no);
		
		if(deleteEap ==0) {
			String msg="회수에 실패했습니다. 다시 시도하세요.";
			rttr.addFlashAttribute("msg", msg);
		}
		switch(form_code) {
		case "AR":
			int result= hservice.deleteHoliday(ea_no);
//			if(result==0) {
//				String msg="회수에 실패했습니다. 다시 시도하세요.";
//				rttr.addFlashAttribute("msg", msg);
//			}
			break;
		case "BP":
			//TODO 업무기안
		}
		req.setAttribute(View.RESPONSE_STATUS_ATTRIBUTE, HttpStatus.TEMPORARY_REDIRECT);
		mv.setViewName("redirect:/eap/list/mylist");
		return mv;
	}
	@PostMapping("/list/waitApprove")
	public ModelAndView selectListWaitApprove(ModelAndView mv
			, HttpSession session
			, RedirectAttributes rttr) {
		mv.setViewName("redirect:/eap/main");
		Employee curUser = (Employee)session.getAttribute("loginSsInfo");
		String emp_no= curUser.getEmp_no();
		
		List<EapDomain> waitApproveList = service.selectListWaitApprove(emp_no);
		
		if(waitApproveList != null) {
			mv.addObject("waitList", waitApproveList);
			mv.setViewName("eap/waitApprove");
		}else {
			String msg = "요청에 실패했습니다.";
			rttr.addFlashAttribute("msg", msg);
		}
		
		return mv;
	}
	@PostMapping("/list/detail")
	public ModelAndView selectWaitApprove(ModelAndView mv
			, HttpSession session
			, @RequestParam(name="ea_no", required=false) String ea_no
			, EapDomain eap) {
		
		System.out.println("기안자명 : " + eap.getDrafter_id());
		System.out.println("문서번호 : " + eap.getEa_no());
		
		EapDomain select = service.selectWait(eap);
		
		mv.addObject("detail",select);
		
		
		switch(select.getForm_code()) {
		case "AR":
			Holiday selectHoliday = hservice.selectHoliday(ea_no);
			mv.addObject("selectHoliday", selectHoliday);
			mv.setViewName("eap/selectVacation");
			break;
		case "BP":
			mv.setViewName("eap/selectBP");
			break;
		default:
			mv.setViewName("redirect:/");
			break;
		}

		return mv;
	}
	@PostMapping(value="/update/appr", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String updateAppr(EapDomain eap
			, HttpSession session
			, HttpServletResponse res) {
		int currentStatus = eap.getStatus_code();
		System.out.println("현재 "+currentStatus);
		int diffStatus = 1;
		String result = null;
		Employee curUser = (Employee)session.getAttribute("loginSsInfo");
		//결재자가 첫번째 결재자이면 status_code -1, result_code = 2로변경
		if(curUser.getEmp_no().equals(eap.getFirst_approver())) {
			currentStatus -= diffStatus;
			System.out.println(currentStatus);
			eap.setStatus_code(currentStatus);
			if(currentStatus == 0) {
				//뺀 결과가 0이면 결재 완료.
				eap.setResult_code(4);
			}else {
				eap.setResult_code(2);				
			}
		//결재자가 두번째 결재자이면 status_code -2, result_code = 2
		} else if (curUser.getEmp_no().equals(eap.getSecond_approver())) {
			currentStatus -= diffStatus<<1;
			System.out.println(currentStatus);
			eap.setStatus_code(currentStatus);
			if(currentStatus == 0) {
				//뺀 결과가 0이면 결재 완료.
				eap.setResult_code(4);
			}
		//결재자가 세번째 결재자이면 status_code -4, result_code = 2
		} else if (curUser.getEmp_no().equals(eap.getThird_approver())) {
			currentStatus -= diffStatus<<2;
			System.out.println(currentStatus);
			eap.setStatus_code(currentStatus);
			if(currentStatus == 0) {
				//뺀 결과가 0이면 결재 완료.
				eap.setResult_code(4);
			}
		//결재자가 네번쨰(최종) 결재자이면 status_code -8 result_code = 4
		} else if (curUser.getEmp_no().equals(eap.getFinal_approver())) {
			currentStatus -= diffStatus<<3;
			System.out.println(currentStatus);
			eap.setStatus_code(currentStatus);
			eap.setResult_code(4);
		} 
		
		 result = currentStatus + ", " + eap.getResult_code();
		
		
		int updateResult = service.updateAppr(eap);
		
		if(updateResult != 0) {
			result = "complete";
		}else {
			result = "fail";
		}
		
		return result;
	}
	
	@PostMapping(value="/update/reject", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String updateReject(EapDomain eap
			,@RequestParam(name="return_reson", required=false) String return_reson
			) {
		String result = null;
		String ea_no = eap.getEa_no();
		String form_code = eap.getForm_code();
		//반려로 전환
		eap.setResult_code(3);
		int rejectResult = service.updateReject(eap);
		
		if(rejectResult != 0) {
			switch(form_code) {
			case "AR":
				int deleteHoliday = hservice.deleteHoliday(ea_no);
				if(deleteHoliday != 0) {
					result = "complete";
				}else {
					result = "fail";
				}
				break;
			case "BP":
				//TODO 업무기안
				break;
			}
		}
		
		
		
		return result;
	}
	
	
}
