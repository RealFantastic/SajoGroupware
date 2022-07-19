package com.group.mayo.common;

import org.springframework.web.bind.annotation.ExceptionHandler;

@org.springframework.web.bind.annotation.ControllerAdvice
public class ControllerAdvice {

	@ExceptionHandler(CustomException.class)
	public String handlerCustomException(CustomException e) {
	return "error.jsp";
	}
}
