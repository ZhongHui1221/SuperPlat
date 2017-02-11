package com.zheling.sup.query.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zheling.base.controller.BaseController;
import com.zheling.sup.query.service.CzqkService;

@Controller
@RequestMapping("/Query/Zujieqk")
public class ZujieqkController extends BaseController {

	@Autowired
	private CzqkService czqkService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "sup/query/zujieqk/main";
	}

	@RequestMapping(value = "/zujiedsp", method = RequestMethod.GET)
	public String czdsp() {
		return "sup/query/zujieqk/zujiedsp";
	}

	@RequestMapping(value = "/zujiez", method = RequestMethod.GET)
	public String zujiez() {
		return "sup/query/zujieqk/zujiez";
	}

	@RequestMapping(value = "/zujiesh", method = RequestMethod.GET)
	public String zujiesh() {
		return "sup/query/zujieqk/zujiesh";
	}

}