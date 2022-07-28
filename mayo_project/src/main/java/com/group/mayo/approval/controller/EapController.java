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
import com.group.mayo.employee.domain.Employee;
import com.group.mayo.employee.domain.Holiday;
import com.group.mayo.employee.domain.HolidayEmployee;
import com.group.mayo.employee.model.service.HolidayService;
import com.group.mayo.holidayEmp.service.EmpHolidayService;

@Controller
@RequestMapping("eap")
public class EapController {
	
	@Autowired
	private EapService service;
	
	@Autowired
	private HolidayService hservice;
	
	@Autowired
	private EmpHolidayService ehservice;
	
	@GetMapping("/main")
	public ModelAndView mainPage(ModelAndView mv,HttpSession session,
			@RequestParam(name="form_code",required=false) String form_code) {
		session.setAttribute("formlist",service.selectListEaForm());
		Employee curUser =(Employee)session.getAttribute("loginSsInfo");
		mv.addObject("proceeding", service.selectMyListProceeding(curUser));
		mv.addObject("completeList",service.selectMyListComplete(curUser));
		mv.addObject("form_code",form_code);
		mv.setViewName("eap/main");
		
		return mv;
	}
	@PostMapping(value="/select/user/holiday", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String selectLoginUserHoliday(HttpSession session) {
		String result = null;
		Employee curUser = (Employee)session.getAttribute("loginSsInfo");
		String emp_no = curUser.getEmp_no();
		double count = 0;
		try {
			count = service.selectLoginUserHoliday(emp_no);			
		}catch(NullPointerException e) {
			e.printStackTrace();
			count = 0;
		}
		result = Double.toString(count);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping(value="/insert/ar", produces="text/plain;charset=UTF-8")
	public String insertEap(EapDomain eap
			,HttpSession session
			,Holiday holiday
			,HolidayEmployee hemployee
			) {
		Employee curUser = (Employee)session.getAttribute("loginSsInfo");
		String msg = "컨트롤러";
		if(curUser != null) {
			eap.setDrafter_id(curUser.getEmp_no());
			eap.setFirst_approver(curUser.getEmp_no());
		}
		String eaNo = service.selectNewEaNo(eap);
		if(eaNo != null) {
			eap.setEa_no(eaNo);
			holiday.setEa_no(eaNo);
		}else {
			msg = "fail";
			return msg;
		}
		int statusCode = 1;
		for(int i = 0; i < 3; i++) {
			if(eap.getApprover_emp_no() != null) {
				int ap_cnt = eap.getApprover_emp_no().size();
				if(i < ap_cnt) {
					String empNo = eap.getApprover_emp_no().get(i);
					statusCode = statusCode + (1<<(i+1));
					if(i==0) {
						eap.setSecond_approver(empNo);
					} else if (i==1) {
						eap.setThird_approver(empNo);
					} else if (i==2) {
						eap.setFinal_approver(empNo);
					}
				}
			}
		}
		eap.setStatus_code(statusCode);
		int isComplete = 0;
		int result = service.insertEap(eap);
		if(result != 0) {
			switch(eap.getForm_code()) {
			case "AR":
				holiday.setHd_reason(eap.getEa_content());
				int insertAR = hservice.insertHoliday(holiday);
				if(insertAR != 0) {
					ehservice.updateEmpHd(hemployee);
				}
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
			if(result==0) {
				String msg="회수에 실패했습니다. 다시 시도하세요.";
				rttr.addFlashAttribute("msg", msg);
			}
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
		Employee curUser = (Employee)session.getAttribute("loginSsInfo");
		String emp_no= curUser.getEmp_no();
		
		List<EapDomain> waitApproveList = service.selectListWaitApprove(emp_no);
		
		if(waitApproveList != null) {
			mv.addObject("waitList", waitApproveList);
			mv.setViewName("eap/waitApprove");
		}else {
			String msg = "요청에 실패했습니다.";
			rttr.addFlashAttribute("msg", msg);
			mv.setViewName("redirect:/eap/main");
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
			,Holiday holiday
			,@RequestParam(name="return_reson", required=false) String return_reson
			,HttpServletRequest req
			) {
		System.out.println(eap);
		String result = null;
		String ea_no = eap.getEa_no();
		String form_code = eap.getForm_code();
		
		//반려로 전환
		eap.setResult_code(3);
		
		
		int rejectResult = service.updateReject(eap);
		
		if(rejectResult != 0) {
			switch(form_code) {
			case "AR":
				result = "complete";
				break;
			case "BP":
				//TODO 업무기안
				break;
			}
		}
		
		
		
		return result;
	}
	
	
}
