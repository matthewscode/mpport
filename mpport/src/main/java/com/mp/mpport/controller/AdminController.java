package com.mp.mpport.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mp.mpport.domain.Client;
import com.mp.mpport.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@RequestMapping("/add-client")
    public String addClient(Model model) {
		Client newClient = new Client();
		model.addAttribute("newClient", newClient);
        return "site/admin/add-client";
    }
	
	@RequestMapping(value = "/add-client", method = RequestMethod.POST)
    public String addClientProcess(@ModelAttribute("newClient") Client newClient, Model model) {
		boolean result = adminService.addClient(newClient);
		if(result){
			model.addAttribute("success", "Successfully added Client");
		}else{
			model.addAttribute("fail", "Failed to add client");
		}
        return "redirect:add-client";
    }
	
	//TODO move to a post
	@ResponseBody
	@RequestMapping(value = "/add-key/{username}/{clientSlug}", method = RequestMethod.GET)
	public boolean addUserKey(@PathVariable("username") String username, @PathVariable("clientSlug") String clientSlug){
		return adminService.addUserKey(username, clientSlug);
	}
}
