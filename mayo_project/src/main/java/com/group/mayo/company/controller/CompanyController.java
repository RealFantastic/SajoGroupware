package com.group.mayo.company.controller;


import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.group.mayo.company.domain.Company;
import com.group.mayo.company.model.service.CompanyService;

@Controller
@RequestMapping("company")
public class CompanyController {

	@Autowired
	private CompanyService service;
	
	@Inject
	private JavaMailSender mailSender;
	
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
			, RedirectAttributes rttr
			, Company company
			, HttpServletRequest req
			) {
//		암호화 member.setPasswd(pwdEncoding.encode(member.getPasswd()));
	
		int result = service.insertCompany(company);
		if(result < 1) {
			rttr.addFlashAttribute("msg", "회사등록에 실패했습니다. 다시 시도해주세요.");
			mv.setViewName("redirect:/company/enroll");
			return mv;
		}
		rttr.addFlashAttribute("msg", "회사등록이 완료되었습니다.반드시 회원가입을 진행해주세요!");
		mv.setViewName("redirect:/member/enroll");
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
	 @RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	 @ResponseBody
	 public String mailCheck(@RequestParam("email") String totalemail) throws Exception{
	     int serti = (int)((Math.random()* (99999 - 10000 + 1)) + 10000);
	     
	     String from = "xeonsnee@naver.com";//보내는 이 메일주소
	     String to = totalemail;
	     String title = "[MAYO 그룹웨어] 회사등록시 필요한 인증번호 입니다.";
	     String content = "[인증번호] "+ serti +" 입니다. <br/> 인증번호 확인란에 기입해주십시오.";
	     String num = "";
	     try {
	     	 MimeMessage mail = mailSender.createMimeMessage();
	         MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
	         
	         mailHelper.setFrom(from);
	         mailHelper.setTo(to);
	         mailHelper.setSubject(title);
	         mailHelper.setText(content, true);       
	         
	         mailSender.send(mail);
	         num = Integer.toString(serti);
	         
	     } catch(Exception e) {
	         num = "error";
	     }
	     return num;
	 }

}
