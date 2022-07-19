package com.group.mayo.common;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common/error")
public class CommonErrorController {
	
	@RequestMapping(value = "/throwable")
	public String throwable(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "예외가 발생하였습니다.");
		return "common/error";
	}
	
	@RequestMapping(value = "/exception")
	public String exception(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "예외가 발생하였습니다.");
		return "common/error";
	}
	
	@RequestMapping(value = "/400")
	public String pageError400(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "잘못된 요청입니다.");
		return "common/error";
	}
	
	@RequestMapping(value = "/403")
	public String pageError403(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "접근이 금지되었습니다.");
		return "common/error";
	}
	
	@RequestMapping(value = "/404")
	public String pageError404(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "요청하신 페이지는 존재하지 않습니다.");
		return "common/error";
	}
	
	@RequestMapping(value = "/405")
	public String pageError405(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "요청된 메소드가 허용되지 않습니다.");
		return "common/error";
	}
	
	@RequestMapping(value = "/500")
	public String pageError500(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "서버에 오류가 발생하였습니다.");
		return "common/error";
	}
	
	@RequestMapping(value = "/503")
	public String pageError503(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "서비스를 사용할 수 없습니다.");
		return "common/error";
	}
}
