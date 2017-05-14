package com.jaldi.services.common.security;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class JWTAuthenticationFilter extends GenericFilterBean {

  @Override
  public void doFilter(ServletRequest request,
             ServletResponse response,
             FilterChain filterChain)
      throws IOException, ServletException {
    HttpServletRequest httpRequest = (HttpServletRequest) request;
    String token = httpRequest.getHeader(TokenAuthenticationService.HEADER_STRING);
    if(token != null && !token.isEmpty()) {
      PreAuthenticatedAuthenticationToken authentication = new PreAuthenticatedAuthenticationToken(token, null);
      SecurityContextHolder.getContext()
              .setAuthentication(authentication);
    }
    filterChain.doFilter(request,response);
  }
}