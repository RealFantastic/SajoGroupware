package com.group.mayo.company.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.group.mayo.company.domain.Company;
import com.group.mayo.company.model.service.CompanyService;

@Controller
@RequestMapping("company")
public class CompanyController {

	@Autowired
	private CompanyService service;
	
//	@GetMapping("/enroll")
	@RequestMapping(value = "enroll", method = RequestMethod.GET)
	public ModelAndView pageInsert(ModelAndView mv) {
		mv.setViewName("company/insert");
		return mv;
	}
	@PostMapping("/enroll")
	public ModelAndView insert(ModelAndView mv
//			, @RequestParam(name="title", defaultValue = "aaa") String t1
//			, @RequestParam(name="title", required = false) String t1
			//, RedirectAttributes rttr
			, Company company
			, HttpServletRequest req
			) {
//		암호화 member.setPasswd(pwdEncoding.encode(member.getPasswd()));
	
		int result = service.insertCompany(company);
		if(result < 1) {
			//rttr.addFlashAttribute("msg", "가입에 실패했습니다. 다시 회원가입 시도해주세요.");
			mv.setViewName("redirect:/company/enroll");
			return mv;
		}
		mv.setViewName("redirect:/");
		return mv;
	}	
	
	//사업자번호 중복 체크
	 @PostMapping(value="/check",produces="text/plain;charset=UTF-8")
	 @ResponseBody
	 public String checkCpNumber(
			 @RequestParam("cp_number") String cp_number
			 ) {
		 	
		 	int result=service.checkCpNumber(cp_number);  
		 	String ro = null;
		 	if(result == 1) {
		 		ro= "false";
		 	}else {
		 		ro ="ok";
		 	}
		 	
		 	return ro;
	 }
//	 @PostMapping(value="/check",produces="text/plain;charset=UTF-8")
////	 @ResponseBody
//	 public void checkCpNumber(
//			 @RequestParam("cp_number") String cp_number,
//			 HttpServletResponse res
//			 ) {
//		 	
//		 	int result=service.checkCpNumber(cp_number);  
//		 	
//		 	try {
//				PrintWriter out = res.getWriter();
//				if(result ==1) {
//					
//					out.print(0);
//					out.flush();
//					out.close();
//				}else {
//					out.print(result);
//					out.flush();
//					out.close();
//				}
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		 	
//	 }
}
