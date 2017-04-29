package com.jaldi.services.common;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ControllerAdvisor {

     @ExceptionHandler(NoHandlerFoundException.class)
     public String pageNotFound(Exception ex) {
        return "redirect:404";
    }

    @ExceptionHandler(RuntimeException.class)
     public String internalServerError(Exception ex) {
        return "redirect:500";
    }
}