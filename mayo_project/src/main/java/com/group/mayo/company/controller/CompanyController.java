package com.group.mayo.company.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
			, Company company
			, RedirectAttributes rttr
			, HttpServletRequest req
			) {
//		암호화 member.setPasswd(pwdEncoding.encode(member.getPasswd()));
		int result = service.insertCompany(company);
		if(result < 1) {
			rttr.addFlashAttribute("msg", "가입에 실패했습니다. 다시 회원가입 시도해주세요.");
			mv.setViewName("redirect:/company/enroll");
			return mv;
		}
		mv.setViewName("redirect:/");
		return mv;
	}	
}
