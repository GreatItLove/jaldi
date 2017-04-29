package com.jaldi.services.common.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import javax.sql.DataSource;

@Configuration
@Order(SecurityProperties.ACCESS_OVERRIDE_ORDER)
public class ApplicationSecurity extends WebSecurityConfigurerAdapter {

	@Autowired
	DataSource dataSource;

	@Autowired
	private CustomAuthenticationProvider customAuthenticationProvider;

	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.exceptionHandling().authenticationEntryPoint(ajaxAuthenticationEntryPoint());
		http.authorizeRequests()
				.antMatchers("/resources/**").permitAll()
				.antMatchers("/heartbeat").permitAll()
				.antMatchers("/getFile").permitAll()
				.antMatchers("/", "/coming-soon", "/404", "/500", "/signup", "/forgot", "/reset-password/**").permitAll()
				.anyRequest()
				.authenticated()
				.and()
				.formLogin()
					.loginPage("/login")
					.loginProcessingUrl("/login.do")
					.failureUrl("/login?error").permitAll()
					.defaultSuccessUrl("/portal")
					.usernameParameter("username")
					.passwordParameter("password")
				.and()
				.logout().permitAll()
//				.and().rememberMe().tokenRepository(persistentTokenRepository())
//				.tokenValiditySeconds(31536000)
				.and().csrf().disable();
	}

	@Override
	public void configure(AuthenticationManagerBuilder auth) throws Exception {
//		auth.userDetailsService(customUserDetailsService);
		auth.authenticationProvider(customAuthenticationProvider);
	}

	@Bean
	public PersistentTokenRepository persistentTokenRepository() {
		JdbcTokenRepositoryImpl db = new JdbcTokenRepositoryImpl();
		db.setDataSource(dataSource);
		return db;
	}

	@Bean
	public AjaxAuthenticationEntryPoint ajaxAuthenticationEntryPoint() {
		AjaxAuthenticationEntryPoint ajaxAuthenticationEntryPoint = new AjaxAuthenticationEntryPoint("/login");
		return ajaxAuthenticationEntryPoint;
	}

}