package com.group.mayo.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.group.mayo.employee.domain.Employee;

public class LoginInterceptor implements HandlerInterceptor{

	//preHandle
	//컨트롤러 실행 전, 즉 컨트롤러로 request 들어가기 전에 수행한다. 
	//그리고 리턴할 때 true이면 컨트롤러 uri로 가고, false이면 컨트롤러 요청을 하지 않는다.
	
	@Override
	public boolean preHandle(HttpServletRequest req
							,HttpServletResponse res
							,Object handler
							)throws Exception {
		HttpSession session = req.getSession();
//		String emp_no = (String)session.getAttribute("emp_no");
		Employee loginSsInfo = (Employee)session.getAttribute("loginSsInfo");
		
		System.out.println("[preHandle]"+loginSsInfo);
		
		//로그인하지 않은경우 로그인 페이지로 redirect.
		if(loginSsInfo == null) {
			String urlPrior = req.getRequestURL().toString() + "?" +req.getQueryString();
			req.getSession().setAttribute("urlPrior", urlPrior); //직전 url를 session에 저장.
			
			res.sendRedirect(req.getContextPath()+"/member/login");
			return false; // 그리고 더 이상 컨트롤러의 핸들러를 진행하지 않도록 false 리턴.
		}
		
		return true; // 컨트롤러 핸들러 진행.
	}
	//postHandle 
	//컨트롤러(핸들러) 실행 하고 나서 뷰 실행 전, 즉 컨트롤러의 핸들러 처리가 끝나 return 되고, 뷰 화면을 response 되기 직전에 postHandle 메서드를 수행한다.
	
	@Override
	public void postHandle(HttpServletRequest req
							,HttpServletResponse res
							,Object handler
							,ModelAndView mv) throws Exception{
		System.out.println("[postHandle]");
		HandlerInterceptor.super.postHandle(req, res, handler, mv);
	}
	//afterCompletion 
	// 뷰 화면을 response 끝난 뒤에 수행한다. 

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		System.out.println("[afterCompletion]");
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}
	
//	@Override
//	public void afterCompletion(HttpServletRequest req
//								,HttpServletResponse res
//								,Object handler
//								,Exception ex) throws Exception{
//		System.out.println("[afterCompletion]");
//		HandlerInterceptor.super.afterCompletion(req, res, handler, ex);
//	}
	
	
}
