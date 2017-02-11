package com.zheling.org.repair.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zheling.base.controller.BaseController;

@Controller
@RequestMapping("/Repair")
public class RepairController extends BaseController {

	@RequestMapping(value = "/toUnaudited", method = RequestMethod.POST)
	public String toUnaudited() {
		return "org/repair/unaudited";
	}

}