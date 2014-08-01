package com.bajaj.org;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	
	@RequestMapping(value="/index.do")
	public String homePage(HttpServletRequest req, HttpServletResponse resp) {
		try {
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index";
	}
}
