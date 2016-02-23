package com.mp.mpport.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mp.mpport.domain.Client;
import com.mp.mpport.service.HomeService;



@Controller
@RequestMapping
public class HomeController {
	
	@Autowired
	private HomeService homeService;
 
	@RequestMapping("/")
    public String list() {
        return "site/home";
    }
	@RequestMapping("/login")
	public String login() {
		return "site/login";
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }
	    return "redirect:/login?logout";
	}

	@RequestMapping(value="/transcribe/{clientSlug}", method = RequestMethod.GET)
	public String transcriptionPage (@PathVariable("clientSlug") String clientSlug, Model model) {
//	    Client currentClient = h;
	    model.addAttribute("apiLocation", homeService.getClientBySlug(clientSlug).getApiLocation());
	    //model.addAttribute("userKey", homeService.getUserKey(currentClient).getKey());
	    return "transcribe/list";
	}
	
	@ResponseBody
	@RequestMapping("/api/client/all")
	private List<Client> showClients(){
		return homeService.getUserClientList();
	}
}
