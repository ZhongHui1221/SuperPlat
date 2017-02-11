package com.zheling.org.card.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zheling.base.controller.BaseController;

@Controller
@RequestMapping("/Correct")
public class CorrectController extends BaseController {

	@RequestMapping(value = "/toUnSubmit", method = RequestMethod.POST)
	public String toUnSubmit() {
		return "org/card/correct/un_submit";
	}

}