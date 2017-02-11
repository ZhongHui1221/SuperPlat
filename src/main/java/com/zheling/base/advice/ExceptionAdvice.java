package com.zheling.base.advice;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.zheling.base.exception.NoLoginException;
import com.zheling.base.util.RequestBinder;

@ControllerAdvice
public class ExceptionAdvice {

	@ExceptionHandler(value = { NoLoginException.class })
	public String handleException(Exception e) {
		Object code = RequestBinder.getRequest().getAttribute("code");
		return "redirect:/" + code;
	}

}