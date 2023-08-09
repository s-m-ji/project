package com.project.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

/**
 * root-context에 component-scan을 패키지에 적용해야 빈으로 등록!!
 * web.xml에도 등록을 해야함 !!
 * 
 * 🙂 ControllerAdvice
 * 	컨트롤러에 대한 예외를 처리하는 객체임을 명시
 * 	컨트롤러가 실행중 발생되는 오류 이므로 500번 오류가 발생 하는경우 실행됩니다.
 * 
 * 🙂 ExceptionHandler 
 * 	Controller, RestController가 적용된 Bean내에서 발생하는 예외를 
 * 	하나의 메서드에서 처리해주는 기능을 한다.
 * 
 */
@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handel404(NoHandlerFoundException ex) {
		return "/error/error404"; 
	}
}













