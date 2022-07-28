package com.group.mayo;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.group.mayo.approval.domain.EapDomain;
import com.group.mayo.approval.service.EapService;
import com.group.mayo.employee.domain.Employee;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	EapService service;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpSession session) {
		Employee curUser = (Employee)session.getAttribute("loginSsInfo");
		String emp_no= curUser.getEmp_no();
		
		List<EapDomain> waitApproveList = service.selectListWaitApprove(emp_no);
		
		model.addAttribute("waitList", waitApproveList);
		
		return "home";
	}
}
