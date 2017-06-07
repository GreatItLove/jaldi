package com.jaldi.services;

import com.notnoop.apns.APNS;
import com.notnoop.apns.ApnsService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.io.Resource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import java.io.IOException;
import java.util.Locale;
import java.util.TimeZone;

@SpringBootApplication
@ComponentScan(basePackages = {"it.ozimov.springboot", "com.jaldi.services.controller", "com.jaldi.services.rest", "com.jaldi.services.common", "com.jaldi.services.dao"})
public class JaldiApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(JaldiApplication.class);
	}

	@Bean
	public LocaleResolver localeResolver() {
		SessionLocaleResolver slr = new SessionLocaleResolver();
		slr.setDefaultLocale(Locale.US); // Set default Locale as US
		return slr;
	}

	@Bean
	public ResourceBundleMessageSource messageSource() {
		ResourceBundleMessageSource source = new ResourceBundleMessageSource();
		source.setBasenames("i18n/messages");  // name of the resource bundle
		source.setUseCodeAsDefaultMessage(true);
		return source;
	}

	@Value("${apns.certificate.path}")
	private Resource certPath;

	@Value("${apns.certificate.password}")
	private String certPassword;

	@Value("${apns.production}")
	private String isProduction;

	@Bean
	public ApnsService apnsService() throws IOException {
		return APNS.newService()
				.withCert(certPath.getInputStream(), certPassword)
				.withAppleDestination(Boolean.parseBoolean(isProduction))
				.build();
	}

	public static void main(String[] args) {
		TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
		SpringApplication.run(JaldiApplication.class, args);
	}
}
