package com.pkt.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	@ExceptionHandler(Exception.class)
	public String common(Exception e) { //common() 메소드를 이용해서 Exception 타입으로 처리되는 모든 예외를 처리하도록 설정된다.
		log.info("common()......에러처리 부분...");
		log.info(e.toString());

		return "/error_common";
	}
}
