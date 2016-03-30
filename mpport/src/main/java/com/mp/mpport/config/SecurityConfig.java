package com.mp.mpport.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.expression.DefaultWebSecurityExpressionHandler;

@Configuration
@ComponentScan(basePackages = { "com.mp.mpport" })
@EnableWebSecurity
@EnableGlobalMethodSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	@Qualifier("userDetailsService")
	UserDetailsService userDetailsService;
	
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
    	auth.userDetailsService(userDetailsService);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	http
    	.authorizeRequests()
    	.antMatchers("/login**").permitAll()
    	.antMatchers("/resources/**").permitAll()
    	.antMatchers("/**").access("hasRole('ROLE_ADMIN')")
    	.and().formLogin().loginProcessingUrl("/j_spring_security_check")
    		.loginPage("/login").usernameParameter("username").passwordParameter("password")
    		.failureUrl("/login?error")
        .and().csrf().disable();
    }
    

    @Bean
    protected BCryptPasswordEncoder encoder() {
        BCryptPasswordEncoder enc = new BCryptPasswordEncoder(11);
        return enc;
    }

    
    @Bean
    protected DefaultWebSecurityExpressionHandler webSecurityExpressionHandler(){
        return new DefaultWebSecurityExpressionHandler();
    }
}