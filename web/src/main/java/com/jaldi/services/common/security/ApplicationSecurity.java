package com.jaldi.services.common.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Order(SecurityProperties.ACCESS_OVERRIDE_ORDER)
public class ApplicationSecurity extends WebSecurityConfigurerAdapter {

	@Autowired
	DataSource dataSource;

	@Autowired
	private CustomAuthenticationProvider customAuthenticationProvider;

	@Autowired
	private JwtAuthenticationProvider jwtAuthenticationProvider;

	@Autowired
	private TokenAuthenticationService tokenAuthenticationService;

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.exceptionHandling().authenticationEntryPoint(ajaxAuthenticationEntryPoint());
		http.authorizeRequests()
				.antMatchers("/resources/**").permitAll()
				.antMatchers("/heartbeat").permitAll()
				.antMatchers("/getFile").permitAll()
				.antMatchers("/loginjwt").permitAll()
				.antMatchers("/", "/landing", "/404", "/500", "/signup", "/forgot", "/reset-password/**").permitAll()
				.antMatchers("/rest/mobile/sendVerification", "/rest/mobile/register").permitAll()
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
				.and().csrf().disable()
				.addFilterBefore(new JWTLoginFilter("/loginjwt", authenticationManager(), tokenAuthenticationService),
					UsernamePasswordAuthenticationFilter.class)
				.addFilterBefore(new JWTAuthenticationFilter(),
					UsernamePasswordAuthenticationFilter.class);
//				// And filter other requests to check the presence of JWT in header
	}

	@Override
	public void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(customAuthenticationProvider)
				.authenticationProvider(jwtAuthenticationProvider);
	}

	@Bean
	public AjaxAuthenticationEntryPoint ajaxAuthenticationEntryPoint() {
		AjaxAuthenticationEntryPoint ajaxAuthenticationEntryPoint = new AjaxAuthenticationEntryPoint("/login");
		return ajaxAuthenticationEntryPoint;
	}

}